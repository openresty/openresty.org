#!/usr/bin/env bash
set -euo pipefail

# Target directory
DEST="ec2-user@openresty.org:/home/ec2-user/openresty.org/v2"

# Sources to sync (relative to the current directory)
SRCS=(
  posts-en.tsv
  posts-cn.tsv
  init.sql
  html
  css
  js
  lua/openresty_org/i18n.lua
  lua/openresty_org/templates.lua
)

# Dry-run support:  ./sync.sh -n   preview what would sync, without writing
DRY_RUN=""
if [[ "${1:-}" == "-n" || "${1:-}" == "--dry-run" ]]; then
  DRY_RUN="--dry-run"
  echo ">> DRY RUN: preview only, nothing will be written"
fi

# Generate deployable artifacts locally. The production host does not need
# Node.js, Pandoc, or the other site build dependencies.
make all gendata sitemap

# Verify all sources exist before syncing, so nothing is silently skipped
for s in "${SRCS[@]}"; do
  if [[ ! -e "$s" ]]; then
    echo "Error: source not found: $s" >&2
    exit 1
  fi
done

# Pull source changes before rsync updates tracked generated files. Otherwise
# those local modifications can cause git pull to refuse the deployment.
if [[ -z "$DRY_RUN" ]]; then
  ssh ec2-user@openresty.org '
    set -eu
    cd /home/ec2-user/openresty.org/v2
    git pull --ff-only
  '
fi

rsync -avR $DRY_RUN "${SRCS[@]}" "$DEST/"

if [[ -n "$DRY_RUN" ]]; then
  echo ">> Dry run complete -> $DEST"
  exit 0
fi

ssh ec2-user@openresty.org '
  set -eu
  cd /home/ec2-user/openresty.org/v2
  psql -Uopenresty openresty_org -v "ON_ERROR_STOP=1" -f init.sql
  sudo /usr/local/openresty/nginx/sbin/nginx \
    -p /home/ec2-user/backup/etc/openresty/ \
    -c /home/ec2-user/backup/etc/openresty/conf/nginx.conf \
    -t
  sudo kill -s SIGHUP "$(cat /home/ec2-user/backup/etc/openresty/logs/nginx.pid)"
'

echo ">> Sync complete -> $DEST"
