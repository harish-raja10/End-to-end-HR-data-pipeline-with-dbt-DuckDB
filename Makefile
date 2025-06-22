run_all:
	@echo "Step 1: Load CSVs into MySQL"
	python load_to_mysql.py
	@echo "Step 2: Ingest data into Parquet and DuckDB"
	python ingest.py
	@echo "Step 3: Run dbt models"
	cd o6_dbt && dbt run
	@echo "Step 4: Generate KPIs"
	python kpi.py --month 2024-05