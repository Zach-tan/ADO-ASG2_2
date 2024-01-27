{{ config(materialized='view')}}

SELECT 
    -- Customer details
    c.CustomerID,
    c.CompanyName,
    c.ContactName,
    c.ContactTitle,
    c.Address,
    c.City,
    c.Region,
    c.PostalCode,
    c.Country,
    c.Phone,
    c.Fax,

    -- Order details
    o.OrderID,
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

    -- Order detail specifics
    od.ProductID,
    od.Quantity AS SalesQuantity,
    od.UnitPrice AS OrderDetailUnitPrice,
    od.Discount,
    od.UnitPrice * od.Quantity * (1 - od.Discount) AS SalesAmount,

    -- Product details
    p.ProductName,
    p.SupplierID,
    p.CategoryID,
    p.QuantityPerUnit,
    p.UnitPrice AS ProductUnitPrice,
    p.UnitsInStock,
    p.UnitsOnOrder,
    p.ReorderLevel,
    p.Discontinued,
    p.UnitCost,

    -- Category details
    cat.CategoryName
FROM {{ ref('raw_customer') }} c
LEFT JOIN {{ ref('raw_orders') }} o ON c.customerid = o.customerid
LEFT JOIN {{ ref('raw_order_detail') }} od ON o.orderid = od.orderid
LEFT JOIN {{ source('ADO', 'PRODUCT') }} p ON od.productid = p.productid
LEFT JOIN {{ ref('raw_category') }} cat ON p.CategoryID = cat.CategoryID