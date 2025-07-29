#!/bin/bash
#
# MIT License
#
# Copyright (c) 2025 Daniel McLarty
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#

set -e

PROD_DIR="./prod"
PROD_ASSETS_DIR="$PROD_DIR/assets"
SRC_DIR="./src"
SRC_ASSETS_DIR="$SRC_DIR/assets"

# Remove prod directory if exists
if [ -d "$PROD_DIR" ]; then
  echo "Removing existing $PROD_DIR directory..."
  rm -rf "$PROD_DIR"
fi

# Create prod and prod/assets directories
mkdir -p "$PROD_ASSETS_DIR"

# Copy and rename .min.* files from src to prod (strip .min)
echo "Copying .min.* files from $SRC_DIR to $PROD_DIR (stripping .min)..."
shopt -s nullglob
for file in "$SRC_DIR"/*.min.*; do
  filename=$(basename "$file")
  # Remove .min before extension, e.g. script.min.js -> script.js
  newname=$(echo "$filename" | sed 's/\.min\(\.[^.]*\)$/\1/')
  cp "$file" "$PROD_DIR/$newname"
  echo "Copied $file -> $PROD_DIR/$newname"
done
shopt -u nullglob

# Copy all assets recursively from src/assets to prod/assets
if [ -d "$SRC_ASSETS_DIR" ]; then
  echo "Copying assets from $SRC_ASSETS_DIR to $PROD_ASSETS_DIR..."
  cp -r "$SRC_ASSETS_DIR/"* "$PROD_ASSETS_DIR/"
else
  echo "Warning: Assets directory not found: $SRC_ASSETS_DIR"
fi

# Copy robots.txt and sitemap.xml from src to prod if they exist
for file in robots.txt sitemap.xml; do
  src_file="$SRC_DIR/$file"
  if [ -f "$src_file" ]; then
    cp "$src_file" "$PROD_DIR/"
    echo "Copied $src_file -> $PROD_DIR/"
  else
    echo "Warning: $file not found in $SRC_DIR"
  fi
done

echo "Done."
