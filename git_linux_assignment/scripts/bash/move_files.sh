#!/usr/bin/env bash
set -euo pipefail  

SRC_DIR="${1:-.}"                # default to current directory if not provided  
DEST_DIR="${2:-./json_and_CSV}"  

mkdir -p "$DEST_DIR"  
shopt -s nullglob  

moved=0  
for f in "$SRC_DIR"/*.csv "$SRC_DIR"/*.json; do  
  [[ -e "$f" ]] || continue  
  mv "$f" "$DEST_DIR"/  
  echo "[INFO] moved $(basename "$f") to $DEST_DIR"  
  moved=1  
done  

if [[ $moved -eq 0 ]]; then  
  echo "[INFO] no CSV or JSON files found in $SRC_DIR"  
fi
