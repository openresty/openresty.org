#!/usr/bin/env bash
#
# png2webp.sh — Convert all PNG files in the current directory and its
#               subdirectories to WebP, and update references in Markdown files.
#
# Conversion parameters: cwebp -near_lossless 60
#
# Usage:
#   ./png2webp.sh            Run normally
#   ./png2webp.sh --dry-run  Only print the actions to be performed, make no changes
#   ./png2webp.sh --keep-png Keep the original PNG files after conversion
#
set -euo pipefail

DRY_RUN=0
KEEP_PNG=0

for arg in "$@"; do
    case "$arg" in
        --dry-run) DRY_RUN=1 ;;
        --keep-png) KEEP_PNG=1 ;;
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
# Step 1: Convert all PNG to WebP
#######################################
converted=0
failed=0

# Use -print0 / read -d '' to safely handle paths containing spaces
while IFS= read -r -d '' png; do
    webp="${png%.*}.webp"

    if [ -f "$webp" ]; then
        echo "Skip (already exists): $webp"
        continue
    fi

    echo "Convert: $png -> $webp"
    if [ "$DRY_RUN" -eq 1 ]; then
        converted=$((converted + 1))
        continue
    fi

    if cwebp -near_lossless 60 -quiet "$png" -o "$webp"; then
        converted=$((converted + 1))
        if [ "$KEEP_PNG" -eq 0 ]; then
            rm -f "$png"
        fi
    else
        echo "Failed: $png" >&2
        failed=$((failed + 1))
        rm -f "$webp"  # Clean up any incomplete file that may have been produced
    fi
done < <(find "$ROOT_DIR" -type f -iname '*.png' -print0)

echo "----------------------------------------"
echo "Conversion done: $converted succeeded, $failed failed"

#######################################
# Step 2: Update .png references in Markdown to .webp
#######################################
echo "----------------------------------------"
echo "Updating Markdown references..."

updated=0

while IFS= read -r -d '' md; do
    # Only process files that contain .png references
    if grep -qi '\.png' "$md"; then
        echo "Update references: $md"
        if [ "$DRY_RUN" -eq 1 ]; then
            # Show the lines that would be changed
            grep -niI '\.png' "$md" | sed 's/^/    /'
            updated=$((updated + 1))
            continue
        fi
        # Replace .png / .PNG with .webp (extension only, case-insensitive)
        sed -i -E 's/\.png/\.webp/Ig' "$md"
        updated=$((updated + 1))
    fi
done < <(find "$ROOT_DIR" -type f -iname '*.md' -print0)

echo "----------------------------------------"
echo "Markdown update done: $updated files processed"
echo "All done."
