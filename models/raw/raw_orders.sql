{{ config(materialized='incremental', unique_key='ORDERID') }}

SELECT *
FROM {{ source('ADO', 'FRESH_ORDERS') }}
{% if is_incremental() %}
WHERE CAST(ORDERID AS BIGINT) > (SELECT MAX(CAST(ORDERID AS BIGINT))  FROM {{this}})
{% endif %}
