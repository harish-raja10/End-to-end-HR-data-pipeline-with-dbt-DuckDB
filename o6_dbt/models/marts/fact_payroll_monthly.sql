{{ config(materialized='table') }}

SELECT
  month,
  SUM(gross) AS gross_payroll,
  SUM(net) AS net_payroll
FROM {{ ref('stg_payroll') }}
GROUP BY month
