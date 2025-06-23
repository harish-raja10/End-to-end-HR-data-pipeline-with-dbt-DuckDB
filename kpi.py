import duckdb
import argparse
import json

# Parse CLI argument
parser = argparse.ArgumentParser()
parser.add_argument('--month', required=True, help='Month in YYYY-MM format')
args = parser.parse_args()

# Format for LIKE pattern
month_pattern = args.month + '%'

import os
print("Using DB file:", os.path.abspath("lake/duckdb.db"))

con = duckdb.connect("lake/duckdb.db")


payroll_q = f"""
SELECT 
    SUM(gross_payroll) AS gross_payroll,
    SUM(net_payroll) AS net_payroll
FROM main.fact_payroll_monthly
WHERE month LIKE '{month_pattern}'
"""

tds_q = f"""
SELECT 
    SUM(tds_due) AS tds_due
FROM main.fact_tds_obligation
WHERE strftime('%Y-%m', month) = '{args.month}'
"""

emp_q = f"""
SELECT 
    COUNT(*) AS active_employees
FROM main.dim_employee
WHERE join_date <= last_day(DATE '{args.month}-01')
"""


gross, net = con.execute(payroll_q).fetchone()
tds_due = con.execute(tds_q).fetchone()[0]
active_employees = con.execute(emp_q).fetchone()[0]


result = {
    "gross_payroll": gross or 0,
    "net_payroll": net or 0,
    "tds_due": tds_due or 0,
    "active_employees": active_employees or 0
}

print(json.dumps(result, indent=2))
