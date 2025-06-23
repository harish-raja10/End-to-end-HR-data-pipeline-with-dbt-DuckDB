SELECT
  CAST(id AS INT) AS id,
  CAST(employee_id AS INT) AS employee_id,
  CAST(date AS DATE) AS date,
  TRIM(type) AS type,
  CURRENT_TIMESTAMP AS loaded_at
FROM read_parquet('../lake/bronze/leaves/*/*.parquet')
WHERE id IS NOT NULL
