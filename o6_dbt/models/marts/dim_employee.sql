-- Get latest record per employee
{{ config(materialized='table') }}


SELECT
  id,
  first_name,
  last_name,
  join_date,
  dept,
  MAX(loaded_at) AS last_loaded
FROM {{ ref('stg_employees') }}
GROUP BY id, first_name, last_name, join_date, dept
