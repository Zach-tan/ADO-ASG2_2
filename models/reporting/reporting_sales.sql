-- sales_overview.sql

SELECT 
    o.OrderDate,
    p.ProductName,
    od.Quantity,
    od.UnitPrice,
    (od.Quantity * od.UnitPrice) AS SalesAmount
FROM 
    {{ ref('raw_orders') }} o
JOIN 
    {{ ref('raw_order_detail') }} od ON o.OrderID = od.OrderID
JOIN 
    {{ source('ADO', 'PRODUCT') }} p ON od.ProductID = p.ProductID
ORDER BY 
    o.OrderDate