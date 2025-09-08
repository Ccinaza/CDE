#!/usr/bin/env bash
set -euo pipefail

# Logging helpers
info(){ echo -e "\n[INFO] $*"; }
err(){ echo -e "\n[ERROR] $*" >&2; exit 1; }

# Directories & file paths
RAW_DIR="./raw"
TRANS_DIR="./Transformed"
GOLD_DIR="./Gold"
RAW_FILE="$RAW_DIR/data.csv"
OUT_FILE="$TRANS_DIR/2023_year_finance.csv"
GOLD_FILE="$GOLD_DIR/2023_year_finance.csv"

# Ensure link to the dataset is set to the env before running
if [ -z "$DATA_URL" ]; then
  echo "Error: DATA_URL is not set. Run 'export DATA_URL=https://www.stats.govt.nz/assets/Uploads/Annual-enterprise-survey/Annual-enterprise-survey-2023-financial-year-provisional/Download-data/annual-enterprise-survey-2023-financial-year-provisional.csv' first."
  exit 1
fi


# Extraction
info "Step 1: Extract - creating raw folder and downloading CSV..."
mkdir -p "$RAW_DIR"
curl -L "$DATA_URL" -o "$RAW_FILE" || err "Download failed!"

if [[ -f "$RAW_FILE" ]]; then
  info "$RAW_FILE downloaded successfully into $RAW_DIR"
else
  err "Download missing!"
fi


# Transformation
info "Step 2: Transform - renaming Variable_code -> variable_code and selecting columns..."
mkdir -p "$TRANS_DIR"

awk -F',' '
  BEGIN{OFS=","}
  NR==1{
    for(i=1;i<=NF;i++){
      gsub(/\r/,"",$i)    # remove CR if any
      if($i=="Variable_code") $i="variable_code"
      header[i]=$i
      h[$i]=i
    }
    print "Year","Value","Units","variable_code"
    next
  }
  {
    printf "%s,%s,%s,%s\n", $(h["Year"]), $(h["Value"]), $(h["Units"]), $(h["variable_code"])
  }
' "$RAW_FILE" > "$OUT_FILE" || err "Transform failed."

if [[ -s "$OUT_FILE" ]]; then
  info "Transformed file created: $OUT_FILE"
else
  err "Transformed file is empty or missing."
fi


# Load
info "Step 3: Load - copying transformed file into Gold directory..."
mkdir -p "$GOLD_DIR"

cp "$OUT_FILE" "$GOLD_FILE" || err "Copy to Gold failed."

if [[ -f "$GOLD_FILE" ]]; then
  info "$GOLD_FILE successfully loaded into $GOLD_DIR"
else
  err "Load step failed."
fi

info "ETL pipeline finished successfully"

