# CDE Git & Linux Assignment

This assignment involves building Bash scripts for an ETL process, moving CSV/JSON files, loading data into a PostgreSQL database, and querying the Parch & Posey dataset for market analysis. All work is managed using Git and GitHub with a pull request workflow to protect the main branch.

---

## Assignment Overview
You have been hired as a new Data Engineer at **CoreDataEngineers**. Your manager has tasked you with building scripts and SQL queries to manage the company’s data infrastructure.  

The assignment is split into the following parts:

1. **Creating a Bash script for an ETL process (Extract, Transform, Load) using a CSV file.**
2. **Scheduling the ETL script to run daily at 12:00 AM via cron.**
3. **Writing a Bash script to move CSV and JSON files to a json_and_CSV folder.**
4. **Loading Parch & Posey CSV data into a PostgreSQL database named posey.**
5. **Writing SQL scripts to answer four analytical questions about the Parch & Posey dataset.**
6. **Documenting all work in this README.**
4. **Parch & Posey Data Analysis with PostgreSQL + SQL**

Additionally, you are required to document all work, push scripts to GitHub (without CSV files), and provide an ETL pipeline architecture diagram.

---

## Repository Structure

- git_linux_assignment/
  - scripts/
    - bash/
      - etl_script.sh: Performs ETL process (download CSV, transform columns, load to Gold).
      - move_files.sh: Moves CSV/JSON files to json_and_CSV folder.
      - load_to_db.sh: Loads Parch & Posey CSVs into PostgreSQL.
    - sql/
      - question_1.sql: Finds order IDs with gloss_qty or poster_qty > 4000.
      - question_2.sql: Lists orders with standard_qty = 0 and gloss_qty or poster_qty > 1000.
      - question_3.sql: Finds company names starting with 'C' or 'W' with specific contact criteria.
      - question_4.sql: Shows region, sales rep, and account names, sorted alphabetically.
    - etl.png: Architectural diagram of the ETL pipeline.
    - README.md: This file, documenting the assignment.
    - .gitignore: Excludes CSVs and other large files.

---

## Setup Instructions

1. **Prerequisites:**
- Linux environment (e.g., Ubuntu).
- Install tools: sudo apt update && sudo apt install wget postgresql git.
- Start PostgreSQL: sudo service postgresql start.


2. **Clone Repository:**
```bash
git clone https://github.com/your-username/your-repo-name.git
cd your-repo-name/git_linux_assignment
```

3. **Create Directories:**
```bash mkdir -p raw Transformed Gold json_and_CSV posey_data```

4. **Download Parch & Posey CSVs:**
- Obtain CSVs from the provided link or a public source (e.g., Mode Analytics Parch & Posey dataset).
- Save to posey_data/ folder (do not push to GitHub).

5. **Set Up PostgreSQL:**
- Create database: ```bash sudo -u postgres psql -c "CREATE DATABASE posey;"```

---

## ETL Pipeline Diagram

- **Location:** diagram.png
- **Description:** The ETL pipeline diagram illustrates the flow:
- **Extract:** Download CSV to raw folder.
- **Transform:** Rename column and select fields, save to Transformed/2023_year_finance.csv.
- **Load:** Copy to Gold folder.


*View:(Note: Diagram will be uploaded in a future commit.)*

---

## ETL Process

#### **Bash Script: `etl_script.sh`**
- **Location:** `scripts/bash/etl_script.sh`
- **Purpose:** Downloads a CSV (Extract), renames Variable_code to variable_code and selects columns year, Value, Units, variable_code (Transform), and copies to Gold folder (Load).
- **Run:**
```bash
export DATA_URL="https://your-csv-link.csv"  # Replace with actual URL
chmod +x scripts/bash/etl_script.sh          # make script executable
./scripts/bash/etl_script.sh.                # run script
```
- **Output:** Confirms file saved in raw, Transformed, and Gold folders.

#### **Cron Scheduling**
- **Purpose:** Runs `etl_script.sh` daily at 12:00 AM.
- **Setup:**
```bash
crontab -e
```
- **Add line:**
```bash
0 0 * * * /full/path/to/Scripts/bash/etl_script.sh
```
- **Verify:** `crontab -l` to check the job is scheduled.

---

## Move CSV/JSON Files

#### **Bash Script: `move_files.sh`**

- **Location:** `scripts/bash/move_files.sh`
- **Purpose:** Moves all .csv and .json files from the current directory to json_and_CSV.
- **Run:**
```bash
chmod +x scripts/bash/move_files.sh
./scripts/bash/move_files.sh
```
- **Output:** Confirms files moved to json_and_CSV.

---

## PostgreSQL Data Loading

#### **Bash Script: `load_data_to_posey.sh`**

- **Location:** `scripts/bash/load_to_db.sh`
- **Purpose:** Loads Parch & Posey CSVs from `posey_data/` into the `posey` database in PostgreSQL.
- **Run:**
```bash
chmod +x scripts/bash/load_to_db.sh
./scripts/bash/load_to_db.sh
```
- **Output:** Confirms each CSV is loaded into its respective table.

#### **SQL Queries for Parch & Posey Analysis**

The following SQL scripts answer questions posed by manager Ayoola to analyze competitor Parch & Posey for market diversification. Scripts are in `scripts/sql/`.

- `question_1.sql`:

- **Question: Find order IDs where gloss_qty or poster_qty is greater than 4000.**
- **Run:**
```bash
psql -d posey -f scripts/sql/question_1.sql
```
- **Output:**
```text
order_id 
----------
 362
 731
 1191
 1913
 1939
 3778
 3858
 3963
```

- `question_2.sql`:

- **Question: List orders where standard_qty is zero and gloss_qty or poster_qty is over 1000.**
- **Run:** 
```bash
psql -d posey -f scripts/sql/question_2.sql
```
- **Output:** This query returned 0 rows


- **`question_3.sql`:**

- **Question: Find company names starting with 'C' or 'W', where primary contact contains 'ana' or 'Ana' but not 'eana'.**
- **Run:** 
```bash
psql -d posey -f scripts/sql/question_3.sql
```
- **Output:**
```text
 company_name 
--------------
 CVS Health
 Comcast
(2 rows)
```


- **`question_4.sql:`**

- **Question: Show region, sales rep, and account names, sorted alphabetically by account name.**
- **Run:** 
```bash
psql -d posey -f Scripts/sql/region_rep_accounts.sql
```
- **Output:** 
```text
 region   |       sales_rep       |            account_name             
-----------+-----------------------+-------------------------------------
 Northeast | Sibyl Lauria          | 3M
 Southeast | Earlie Schleusner     | ADP
 Southeast | Moon Torian           | AECOM
 Southeast | Calvin Ollison        | AES
 Northeast | Elba Felder           | AIG
 Northeast | Necole Victory        | AT&T
 Midwest   | Julie Starr           | AbbVie
 Midwest   | Chau Rowles           | Abbott Laboratories
 West      | Marquetta Laycock     | Advance Auto Parts
 Northeast | Renetta Carew         | Aetna
 Midwest   | Cliff Meints          | Aflac
 West      | Georgianna Chisholm   | Air Products & Chemicals
 Midwest   | Chau Rowles           | Alcoa
```

---

