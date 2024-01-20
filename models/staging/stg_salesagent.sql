-- Create a staging table for sales agent analysis
{{ config (materialized='view')}}

WITH SalesSummary AS (
    SELECT
        e.EmployeeID,
        COUNT(DISTINCT od.OrderID) AS NumberOfOrders,
        SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS TotalSalesAmount
    FROM
        {{ ref('raw_employee') }} e
    LEFT JOIN
        {{ ref('raw_orders') }} o ON e.EmployeeID = o.EmployeeID
    LEFT JOIN
        {{ ref('raw_order_detail') }} od ON o.OrderID = od.OrderID
    GROUP BY
        e.EmployeeID
),
AverageOrderValue AS (
    SELECT
        e.EmployeeID,
        AVG(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS AvgOrderValue
    FROM
        {{ ref('raw_employee') }} e
    LEFT JOIN
        {{ ref('raw_orders') }} o ON e.EmployeeID = o.EmployeeID
    LEFT JOIN
        {{ ref('raw_order_detail') }} od ON o.OrderID = od.OrderID
    GROUP BY
        e.EmployeeID
),
TopSalesAgents AS (
    SELECT
        ss.EmployeeID,
        ss.TotalSalesAmount,
        ao.AvgOrderValue,
        CASE
            WHEN ss.TotalSalesAmount >= (SELECT MAX(TotalSalesAmount) FROM SalesSummary) THEN 'Top Sales Agent'
            ELSE 'Regular Sales Agent'
        END AS TopSalesAgent
    FROM
        SalesSummary ss
    LEFT JOIN
        AverageOrderValue ao ON ss.EmployeeID = ao.EmployeeID
)
SELECT
    -- Order Table Columns
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

    -- Employee Table Columns
    e.LastName,
    e.FirstName,
    e.Title,
    e.TitleOfCourtesy,
    e.BirthDate,
    e.HireDate,
    e.Address,
    e.City,
    e.Region,
    e.PostalCode,
    e.Country,
    e.HomePhone,
    e.Extension,
    e.Photo,
    e.Notes,
    e.ReportsTo,
    e.PhotoPath,

    -- Order Detail Table Columns
    od.ProductID AS OrderDetailProductID,
    od.UnitPrice AS OrderDetailUnitPrice,
    od.Quantity AS OrderDetailQuantity,
    od.Discount AS OrderDetailDiscount,

    -- Employee Territory Table Columns
    et.TerritoryID AS EmployeeTerritoryID,

    -- Territory Table Columns
    t.TerritoryDescription,

    -- Region Table Columns
    r.RegionID AS RegionID,
    r.RegionDescription,

    -- Sales Agent Analysis Columns
    ts.TotalSalesAmount,
    ts.AvgOrderValue,
    ts.TopSalesAgent
FROM
    {{ ref('raw_orders') }} o
LEFT JOIN
     {{ ref('raw_employee') }} e ON e.EmployeeID = o.EmployeeID
LEFT JOIN
    {{ ref('raw_order_detail') }} od ON o.OrderID = od.OrderID
LEFT JOIN
    {{ ref('raw_employee_territory') }} et ON e.EmployeeID = et.EmployeeID
LEFT JOIN
    {{ ref('raw_territory') }} t ON et.TerritoryID = t.TerritoryID
LEFT JOIN
    {{ ref('raw_region') }} r ON t.RegionID = r.RegionID
LEFT JOIN
    TopSalesAgents ts ON e.EmployeeID = ts.EmployeeID
