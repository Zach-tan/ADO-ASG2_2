{{ config (materialized='table')}}

SELECT * FROM {{ source('ADO', 'ORDERDETAIL') }}