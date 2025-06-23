SELECT DISTINCT
  CAST(employee_id AS INT) AS employee_id,
  CAST(month || '-01' AS DATE) AS month,
  CAST(gross AS DOUBLE) AS gross,
  CAST(net AS DOUBLE) AS net,
  CAST(tds AS DOUBLE) AS tds,
  CURRENT_TIMESTAMP AS loaded_at
FROM read_parquet('../lake/bronze/payroll/*/*.parquet')
WHERE employee_id IS NOT NULL AND month IS NOT NULL