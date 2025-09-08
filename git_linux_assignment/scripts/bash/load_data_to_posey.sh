#!/usr/bin/env bash
set -euo pipefail

DB_NAME="posey"
USER_NAME="$USER"  # or replace with your postgres username
CSV_DIR="./posey_data"   # folder where you keep all CSVs

echo "[INFO] Loading CSV files into PostgreSQL database: $DB_NAME"

# Create DB if not exists
createdb "$DB_NAME" || echo "[INFO] Database $DB_NAME already exists."

# Loop over each CSV file in the folder
for file in "$CSV_DIR"/*.csv; do
  [[ -e "$file" ]] || continue  # skip if no CSV
  table_name=$(basename "$file" .csv)  # filename becomes table name

  echo "[INFO] Creating table $table_name and loading $file..."

  # Read header and generate CREATE TABLE dynamically (all columns TEXT)
  header=$(head -n 1 "$file")
  cols=$(echo "$header" | awk -F',' '{for(i=1;i<=NF;i++) printf "%s TEXT%s", $i, (i<NF?",":"")}')
  
  # Create table
  psql -d "$DB_NAME" -c "DROP TABLE IF EXISTS $table_name;"
  psql -d "$DB_NAME" -c "CREATE TABLE $table_name ($cols);"

  # Load data
  echo "[INFO] Copying data from $file into $table_name..."
  psql -d "$DB_NAME" -c "\copy $table_name FROM '$file' WITH CSV HEADER;"

  echo "[INFO] Loaded $file into $table_name ✅"
done

echo "[INFO] All CSVs loaded successfully."
