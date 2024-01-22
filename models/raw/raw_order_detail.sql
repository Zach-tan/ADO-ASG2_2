{{ config(materialized='incremental') }}

SELECT src.*
FROM {{ source('ADO', 'FRESH_ORDERDETAIL') }} AS src
LEFT JOIN {{ this }} AS dest
ON src.ORDERID = dest.ORDERID AND src.PRODUCTID = dest.PRODUCTID
{% if is_incremental() %}
WHERE dest.ORDERID IS NULL AND dest.PRODUCTID IS NULL
{% endif %}