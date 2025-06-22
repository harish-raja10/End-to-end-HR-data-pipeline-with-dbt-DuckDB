import duckdb
import os

db_path = "lake/duckdb.db"
print("Using DB:", os.path.abspath(db_path))

con = duckdb.connect(db_path)

# Show all tables
tables = con.execute("SHOW TABLES").fetchall()
print("Tables in duckdb.db:")
for t in tables:
    print("-", t[0])
