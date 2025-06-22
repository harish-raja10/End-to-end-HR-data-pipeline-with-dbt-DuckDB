#  HR KPI Data Pipeline (MySQL → Parquet → dbt → DuckDB)

This project builds a complete analytics pipeline that:

1. Loads HR data from CSV into MySQL
2. Converts MySQL data into partitioned Parquet (Bronze layer)
3. Uses dbt to create Silver and Gold data models
4. Outputs business KPIs as JSON using DuckDB

## Technologies Used
- Python (Pandas, SQLAlchemy, DuckDB)
- Docker (for MySQL)
- dbt (1.10+ with DuckDB adapter)
- Parquet files as a modern data lake format

##  Folder Structure
```
dbt_challenge/
├── data/                 # Source CSVs
├── lake/                 # Bronze layer + DuckDB
├── o6_dbt/               # dbt project
├── load_to_mysql.py      # Step 1
├── ingest.py             # Step 2
├── kpi.py                # Step 4 (JSON output)
├── explore_duckdb.py     # Inspect DuckDB
├── Makefile              # Run the entire pipeline
└── README.md             # This doc
```
##  Data Flow Diagram
```text
[CSV Files] → MySQL → Python (Extract)
              ↓
         Parquet Files (Bronze)
              ↓
        dbt Models (Staging/Dim/Fact)
              ↓
     DuckDB Queries (Gold Layer)
              ↓
         KPI Output (JSON)
```


##  Setup Instructions

### 1. Start MySQL
```
docker compose up -d
```

### 2. Install dependencies
```bash
python -m venv .venv
source .venv/bin/activate     # or .venv\Scripts\activate on Windows
pip install -r requirements.txt
```

### 3. Setup dbt Profile (mandatory)
File: `C:/Users/<you>/.dbt/profiles.yml`
```yaml
o6_dbt:
  outputs:
    dev:
      type: duckdb
      path: C:/Users/<you>/.../dbt_challenge/lake/duckdb.db
      schema: main
  target: dev
```

##  Run the Entire Flow
```bash
make run_all
```

##  Sample KPI Output
```bash
python kpi.py --month 2024-03
```
```json
{
  "gross_payroll": 2487630.0,
  "net_payroll": 2263594.0,
  "tds_due": 224036.0,
  "active_employees": 88
}
```

---

##  Clean Up
```bash
docker compose down
rm -rf lake/
cd o6_dbt && dbt clean && cd ..
```

---

And yes its doneeee!!!!!!!!
```
