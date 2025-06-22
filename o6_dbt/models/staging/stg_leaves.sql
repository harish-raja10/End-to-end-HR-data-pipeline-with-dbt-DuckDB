SELECT
  CAST(id AS INT) AS id,
  TRIM(first_name) AS first_name,
  TRIM(last_name) AS last_name,
  CAST(join_date AS DATE) AS join_date,
  TRIM(dept) AS dept,
  CURRENT_TIMESTAMP AS loaded_at
FROM read_parquet('../lake/bronze/employees/*/*.parquet')
WHERE id IS NOT NULL