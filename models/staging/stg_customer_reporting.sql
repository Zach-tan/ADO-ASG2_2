--Create staging table for customer reporting
{{ config (materialized='view')}}

WITH OrderSummary AS (
    SELECT
        o.OrderID,
        SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS NetSales,
        SUM(od.UnitPrice * od.Quantity * od.Discount) AS DiscountAmount
    FROM
        {{ ref('raw_orders') }}  o
    LEFT JOIN
        {{ ref('raw_order_detail') }}  od ON o.OrderID = od.OrderID
    GROUP BY
        o.OrderID, o.ShippedDate
), 
CustomerOrderStatus AS (
    SELECT
        c.CustomerID,
        c.contactname,
        o.orderid,
        CASE
            WHEN o.ShippedDate IS NULL THEN 'Pending'
            WHEN o.ShippedDate IS NOT NULL AND o.ShippedDate < CURRENT_DATE() THEN 'Shipped'
            ELSE 'Delivered'
        END AS OrderStatus,
        DATEDIFF(day, o.ORDERDATE, o.shippeddate) AS ShipTime
    FROM
        {{ ref('raw_orders') }} o
    LEFT JOIN
        {{ ref('raw_customer') }} c ON c.CustomerID = o.CustomerID
),
CustomerOrderDetails AS (
    SELECT
        o.CustomerID,
        c.contactname,
        AVG(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS AvgOrderValue,
        SUM(od.UnitPrice * od.Quantity) AS GrossSales,
        COUNT(od.orderid) AS TotalOrders
    FROM
        {{ ref('raw_orders') }} o 
    LEFT JOIN
        {{ ref('raw_customer') }} c ON c.CustomerID = o.CustomerID
    LEFT JOIN
        {{ ref('raw_order_detail') }}  od ON o.OrderID = od.OrderID
    GROUP BY
        o.CustomerID,c.contactname
),
ProductSummary AS (
    SELECT
        od.ProductID,
        p.PRODUCTNAME,
        AVG(CAST(ROUND(od.UnitPrice * od.Quantity * (1 - od.Discount), 2) AS DECIMAL(10,2))) AS RoundedAvgDiscountedPrice,
        SUM(od.Quantity) AS TotalQuantitySold
    FROM
        {{ ref('raw_order_detail') }} od
    LEFT JOIN 
        {{ source('ADO', 'PRODUCT') }} p ON od.productid = p.PRODUCTID
    GROUP BY
        od.ProductID,p.productname
)

-- Use the ProductSummaryCTE in subsequent queries


SELECT 
    --Order Table columns
    o.OrderID,
    o.CustomerID,
    o.EmployeeID,
    o.OrderDate,
    o.RequiredDate,
    o.ShippedDate,
    o.ShipVia,
    o.Freight,
    o.ShipName,
    o.ShipAddress,
    o.ShipCity,
    o.ShipRegion,
    o.ShipPostalCode,
    o.ShipCountry,

    --Customer Table columns
    c.CompanyName,
    c.Contactname,
    c.ContactTitle,
    c.Address,
    c.City,
    c.Region,
    c.PostalCode,
    c.Country,
    c.Phone,
    c.Fax,

    --OrderDetail table columns
    od.ProductID AS OrderDetailProductID,
    od.UnitPrice AS OrderDetailUnitPrice,
    od.Quantity AS OrderDetailQuantity,
    od.Discount AS OrderDetailDiscount,

    --Product table columns
    p.PRODUCTNAME,

    --Category table columns
    cat.CategoryName AS ProductCategoryName,
    cat.Description AS ProductCategoryDescription,

    --Customer reporting columns
    os.NetSales,
    cos.OrderStatus,
    cos.ShipTime,
    cod.AvgOrderValue,
    cod.TotalOrders AS TotalOrdersbyCustomer,
    ps.TotalQuantitySold
FROM 
    {{ ref('raw_orders') }} o 
LEFT JOIN
    {{ ref('raw_customer') }} c ON c.customerid = o.customerid
LEFT JOIN
    {{ ref('raw_order_detail') }} od ON o.orderid = od.orderid
LEFT JOIN 
    {{ source('ADO', 'PRODUCT') }} p ON od.productid = p.productid
LEFT JOIN
    {{ ref('raw_category') }} cat ON p.categoryid = cat.categoryid
LEFT JOIN
    OrderSummary os ON o.orderid = os.orderid
LEFT JOIN 
    CustomerOrderStatus cos ON c.customerid = cos.customerid
LEFT JOIN
    CustomerOrderDetails cod ON c.contactname = cod.contactname
LEFT JOIN 
    ProductSummary ps ON p.productname = ps.productname
GROUP BY
    o.OrderID,
    o.CustomerID,
    o.EmployeeID,
    o.OrderDate,
    o.RequiredDate,
    o.ShippedDate,
    o.ShipVia,
    o.Freight,
    o.ShipName,
    o.ShipAddress,
    o.ShipCity,
    o.ShipRegion,
    o.ShipPostalCode,
    o.ShipCountry,
    c.CompanyName,
    c.Contactname,
    c.ContactTitle,
    c.Address,
    c.City,
    c.Region,
    c.PostalCode,
    c.Country,
    c.Phone,
    c.Fax,
    od.ProductID,
    od.UnitPrice,
    od.Quantity,
    od.Discount,
    p.PRODUCTNAME,
    cat.CategoryName,
    cat.Description,
    os.NetSales,
    cos.OrderStatus,
    cos.ShipTime,
    cod.AvgOrderValue,
    cod.TotalOrders,
    ps.TotalQuantitySold    



