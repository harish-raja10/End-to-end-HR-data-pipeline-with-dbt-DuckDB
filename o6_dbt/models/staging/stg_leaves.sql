SELECT DISTINCT
  CAST(employee_id AS INT) AS employee_id,
  CAST(date AS DATE) AS date,
  TRIM(type) AS type,
  CURRENT_TIMESTAMP AS loaded_at
FROM read_parquet('../lake/bronze/leaves/*/*.parquet')
WHERE employee_id IS NOT NULL AND date IS NOT NULL