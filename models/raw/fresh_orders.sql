{{ config (materialized='table')}}

SELECT *
from {{ source('ADO', 'FRESH_ORDERS') }}
