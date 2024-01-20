{{ config (materialized='table')}}

SELECT * FROM {{ source('ADO', 'TERRITORY') }}