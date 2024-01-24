{{ config (materialized='view')}}

SELECT
    -- Order Table Columns
    o.OrderID,
    o.OrderDate,
    o.RequiredDate,
    o.ShippedDate,

    -- Order Detail Table Columns
    od.UnitPrice AS OrderDetailUnitPrice,
    od.Quantity AS OrderDetailQuantity,
    od.Discount AS OrderDetailDiscount,

    -- Product Table Columns
    p.ProductID,
    p.ProductName,
    p.SupplierID,
    p.CategoryID,
    p.QuantityPerUnit,
    p.UnitPrice AS ProductUnitPrice,
    P.UnitsInStock,
    p.UnitsOnOrder,
    p.ReorderLevel,
    p.Discontinued,
    p.UnitCost AS ProductUnitCost,

    -- Suppplier Table Columns
    s.CompanyName,
    s.ContactName,
    s.ContactTitle,
    s.Address,
    s.City,
    s.Region,
    s.PostalCode,
    s.Country,
    s.Phone,
    s.Fax,
    s.HomePage,

    -- Category Table Columns
    c.CategoryName,
    c.Description
FROM
    {{ ref('raw_orders') }} o
LEFT JOIN
    {{ ref('raw_order_detail') }} od ON o.OrderID = od.OrderID
LEFT JOIN
    {{ source('ADO', 'PRODUCT') }} p ON od.ProductID = p.ProductID
LEFT JOIN
    {{ ref('raw_supplier') }} s ON p.SupplierID = s.SupplierID
LEFT JOIN
    {{ ref('raw_category') }} c ON p.CategoryID = c.CategoryID