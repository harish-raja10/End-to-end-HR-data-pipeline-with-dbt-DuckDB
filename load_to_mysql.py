import pandas as pd
from sqlalchemy import create_engine, text

# Database config
DB_URI = "mysql+pymysql://root:root@localhost:3307/o6_hr"

# File paths
EMPLOYEES_CSV = "data/employees.csv"
PAYROLL_CSV = "data/payroll.csv"
LEAVES_CSV = "data/leaves.csv"

# Create connection to MySQL
engine = create_engine(DB_URI)

# Create DB and tables if they don't exist
with engine.connect() as conn:
    conn.execute(text("CREATE DATABASE IF NOT EXISTS o6_hr"))
    conn.execute(text("USE o6_hr"))
    
    conn.execute(text("""
        CREATE TABLE IF NOT EXISTS employees (
            id INT,
            first_name VARCHAR(50),
            last_name VARCHAR(50),
            join_date DATE,
            dept VARCHAR(50)
        )
    """))

    conn.execute(text("""
        CREATE TABLE IF NOT EXISTS payroll (
            id INT,
            employee_id INT,
            month DATE,
            gross DOUBLE,
            net DOUBLE,
            tds DOUBLE
        )
    """))

    conn.execute(text("""
        CREATE TABLE IF NOT EXISTS leaves (
            id INT,
            employee_id INT,
            date DATE,
            type VARCHAR(50)
        )
    """))

# Load CSVs using pandas
print("Loading employees.csv...")
employees_df = pd.read_csv(EMPLOYEES_CSV)
employees_df.to_sql('employees', con=engine, if_exists='replace', index=False)

print("Loading payroll.csv...")
payroll_df = pd.read_csv(PAYROLL_CSV)
payroll_df.to_sql('payroll', con=engine, if_exists='replace', index=False)

print("Loading leaves.csv...")
leaves_df = pd.read_csv(LEAVES_CSV)
leaves_df.to_sql('leaves', con=engine, if_exists='replace', index=False)

print("All CSVs loaded into MySQL successfully.")
