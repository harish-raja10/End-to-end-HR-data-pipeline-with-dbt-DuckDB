{{ config(materialized='incremental') }}

WITH base AS (
  SELECT
    employee_id,
    CAST(month || '-01' AS DATE) AS month,
    gross,
    net
  FROM {{ ref('stg_payroll') }}
  {% if is_incremental() %}
    WHERE CAST(month || '-01' AS DATE) > (SELECT MAX(month) FROM {{ this }})
  {% endif %}
)

SELECT
  employee_id,
  strftime('%Y-%m', month) AS month,
  SUM(gross) AS gross_payroll,
  SUM(net) AS net_payroll
FROM base
GROUP BY employee_id, strftime('%Y-%m', month)
