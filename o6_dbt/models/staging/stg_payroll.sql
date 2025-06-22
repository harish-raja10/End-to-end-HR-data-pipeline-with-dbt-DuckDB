SELECT
  CAST(id AS INT) AS id,
  CAST(employee_id AS INT) AS employee_id,
  TRIM(month) AS month,
  CAST(gross AS DOUBLE) AS gross,
  CAST(net AS DOUBLE) AS net,
  CAST(tds AS DOUBLE) AS tds,
  CURRENT_TIMESTAMP AS loaded_at
FROM read_parquet('../lake/bronze/payroll/*/*.parquet')
WHERE id IS NOT NULL