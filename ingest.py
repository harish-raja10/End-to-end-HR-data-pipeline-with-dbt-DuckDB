import pandas as pd
import duckdb
import os
from sqlalchemy import create_engine
from datetime import date

DB_URI = "mysql+pymysql://root:root@localhost:3307/o6_hr"
engine = create_engine(DB_URI)
today = str(date.today())

os.makedirs("lake/bronze/employees/" + today, exist_ok=True)
os.makedirs("lake/bronze/payroll/" + today, exist_ok=True)
os.makedirs("lake/bronze/leaves/" + today, exist_ok=True)

duckdb_conn = duckdb.connect("lake/duckdb.db")

for table in ["employees", "payroll", "leaves"]:
    df = pd.read_sql(f"SELECT * FROM {table}", engine)
    duckdb_conn.register(f"temp_{table}", df)
    duckdb_conn.execute(f"""
        COPY temp_{table} TO 'lake/bronze/{table}/{today}/data.parquet'
        (FORMAT PARQUET, OVERWRITE_OR_IGNORE TRUE)
    """)
    print(f"{table} exported")

duckdb_conn.close()
