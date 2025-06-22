{{ config(materialized='table') }}

SELECT
  month,
  SUM(tds) AS tds_due
FROM {{ ref('stg_payroll') }}
GROUP BY month
