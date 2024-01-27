-- sales_overview.sql

SELECT 
    *
FROM 
    {{ ref('stg_sales') }} 
ORDER BY 
    OrderDate