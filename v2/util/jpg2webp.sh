#!/usr/bin/env bash
#
# jpg2webp.sh — Convert all JPG/JPEG files in the current directory and its
#               subdirectories to WebP, and update references in Markdown files.
#
# Conversion parameters: cwebp -q 80
#
# Usage:
#   ./jpg2webp.sh            Run normally
#   ./jpg2webp.sh --dry-run  Only print the actions to be performed, make no changes
#   ./jpg2webp.sh --keep-jpg Keep the original JPG files after conversion
#
set -euo pipefail

DRY_RUN=0
KEEP_JPG=0

for arg in "$@"; do
    case "$arg" in
        --dry-run) DRY_RUN=1 ;;
        --keep-jpg) KEEP_JPG=1 ;;
        -h|--help)
            sed -n '2,14p' "$0"
            exit 0
            ;;
        *)
            echo "Unknown argument: $arg" >&2
            exit 1
            ;;
    esac
done

# Dependency check
command -v cwebp >/dev/null 2>&1 || { echo "Error: cwebp not found, please install libwebp first." >&2; exit 1; }

ROOT_DIR="$(pwd)"
echo "Working directory: $ROOT_DIR"
[ "$DRY_RUN" -eq 1 ] && echo "*** DRY-RUN mode: no files will be modified ***"

#######################################
# Step 1: Convert all JPG/JPEG to WebP
#######################################
converted=0
failed=0

# Use -print0 / read -d '' to safely handle paths containing spaces
while IFS= read -r -d '' jpg; do
    # Strip the extension (.jpg/.jpeg, case-insensitive)
    webp="${jpg%.*}.webp"

    if [ -f "$webp" ]; then
        echo "Skip (already exists): $webp"
        continue
    fi

    echo "Convert: $jpg -> $webp"
    if [ "$DRY_RUN" -eq 1 ]; then
        converted=$((converted + 1))
        continue
    fi

    if cwebp -q 80 -quiet "$jpg" -o "$webp"; then
        converted=$((converted + 1))
        if [ "$KEEP_JPG" -eq 0 ]; then
            rm -f "$jpg"
        fi
    else
        echo "Failed: $jpg" >&2
        failed=$((failed + 1))
        rm -f "$webp"  # Clean up any incomplete file that may have been produced
    fi
done < <(find "$ROOT_DIR" -type f \( -iname '*.jpg' -o -iname '*.jpeg' \) -print0)

echo "----------------------------------------"
echo "Conversion done: $converted succeeded, $failed failed"

#######################################
# Step 2: Update .jpg/.jpeg references in Markdown to .webp
#######################################
echo "----------------------------------------"
echo "Updating Markdown references..."

updated=0

while IFS= read -r -d '' md; do
    # Only process files that contain .jpg/.jpeg references
    if grep -qiE '\.jpe?g' "$md"; then
        echo "Update references: $md"
        if [ "$DRY_RUN" -eq 1 ]; then
            # Show the lines that would be changed
            grep -niIE '\.jpe?g' "$md" | sed 's/^/    /'
            updated=$((updated + 1))
            continue
        fi
        # Replace .jpg / .jpeg with .webp (extension only, case-insensitive)
        sed -i -E 's/\.jpe?g/\.webp/Ig' "$md"
        updated=$((updated + 1))
    fi
done < <(find "$ROOT_DIR" -type f -iname '*.md' -print0)

echo "----------------------------------------"
echo "Markdown update done: $updated files processed"
echo "All done."
