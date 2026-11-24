#!/usr/bin/env bash
set -euo pipefail

# Target directory
DEST="ec2-user@openresty.org:/home/ec2-user/openresty.org/v2"
TEMPLATES_LUA="lua/openresty_org/templates.lua"

# Sources to sync (relative to the current directory)
SRCS=(
  posts-en.tsv
  posts-cn.tsv
  sitemap-en.xml
  sitemap-cn.xml
  init.sql
  html
  css
  js
  lua/openresty_org/i18n.lua
  "$TEMPLATES_LUA"
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

# An earlier failed build can leave a file that make considers up to date.
if [[ ! -s "$TEMPLATES_LUA" ]] \
  || ! "${LUAJIT:-luajit}" -b "$TEMPLATES_LUA" /dev/null; then
  echo 'Error: template validation failed. Check LuaJIT and rebuild with make -W templates/news-en.tt2 templates.' >&2
  exit 1
fi

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

  master_pid=$(cat /home/ec2-user/backup/etc/openresty/logs/nginx.pid)
  worker_pids() {
    pgrep -P "$master_pid" -f "^nginx: worker process[[:space:]]*$" || [ "$?" -eq 1 ]
  }

  old_workers=$(worker_pids)
  sudo kill -s SIGHUP "$master_pid"

  # Sending HUP succeeds even if init_by_lua later rejects the reload.
  for _ in $(seq 15); do
    sleep 1
    current_workers=$(worker_pids)
    for worker_pid in $current_workers; do
      if ! printf "%s\n" "$old_workers" | grep -Fxq "$worker_pid"; then
        exit 0
      fi
    done
  done

  echo "Error: OpenResty did not start a new worker after reload. Check logs/error.log under the OpenResty prefix." >&2
  exit 1
'

echo ">> Sync complete -> $DEST"
