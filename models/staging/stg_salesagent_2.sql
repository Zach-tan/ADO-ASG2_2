-- Create a staging table for sales agent analysis
{{ config(materialized='view') }}

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
),
OrderProfits AS (
    SELECT
        od.OrderID,
        od.ProductID,
        od.Quantity,
        p.UnitCost,  -- Assuming UnitCost is available in the Product table
        (od.UnitPrice - p.UnitCost) * od.Quantity AS ProfitPerProduct
    FROM
        {{ ref('raw_order_detail') }} od
    LEFT JOIN
        {{ source('ADO', 'PRODUCT') }} p ON od.ProductID = p.ProductID
)
SELECT
    -- Order Detail Table Columns
    od.OrderID,
    od.ProductID AS OrderDetailProductID,
    od.UnitPrice AS OrderDetailUnitPrice,
    od.Quantity AS OrderDetailQuantity,
    od.Discount AS OrderDetailDiscount,

    -- Order Table Columns
    o.CustomerID AS OrderCustomerID,
    o.EmployeeID AS OrderEmployeeID,
    o.OrderDate AS OrderOrderDate,
    o.RequiredDate AS OrderRequiredDate,
    o.ShippedDate AS OrderShippedDate,
    o.ShipVia AS OrderShipVia,
    o.Freight AS OrderFreight,
    o.ShipName AS OrderShipName,
    o.ShipAddress AS OrderShipAddress,
    o.ShipCity AS OrderShipCity,
    o.ShipRegion AS OrderShipRegion,
    o.ShipPostalCode AS OrderShipPostalCode,
    o.ShipCountry AS OrderShipCountry,

    -- Employee Table Columns
    e.LastName AS EmployeeLastName,
    e.FirstName AS EmployeeFirstName,
    e.Title AS EmployeeTitle,
    e.TitleOfCourtesy AS EmployeeTitleOfCourtesy,
    e.BirthDate AS EmployeeBirthDate,
    e.HireDate AS EmployeeHireDate,
    e.Address AS EmployeeAddress,
    e.City AS EmployeeCity,
    e.Region AS EmployeeRegion,
    e.PostalCode AS EmployeePostalCode,
    e.Country AS EmployeeCountry,
    e.HomePhone AS EmployeeHomePhone,
    e.Extension AS EmployeeExtension,
    e.Photo AS EmployeePhoto,
    e.Notes AS EmployeeNotes,
    e.ReportsTo AS EmployeeReportsTo,
    e.PhotoPath AS EmployeePhotoPath,

    -- Product Table Columns
    p.UnitCost AS ProductUnitCost,
    p.ProductName AS ProductProductName,
    p.SupplierID AS ProductSupplierID,
    p.CategoryID AS ProductCategoryID,
    p.QuantityPerUnit AS ProductQuantityPerUnit,
    p.UnitPrice AS ProductUnitPrice,
    p.UnitsInStock AS ProductUnitsInStock,
    p.UnitsOnOrder AS ProductUnitsOnOrder,
    p.ReorderLevel AS ProductReorderLevel,
    p.Discontinued AS ProductDiscontinued,

    -- Employee Territory Table Columns
    et.TerritoryID AS EmployeeTerritoryID,

    -- Territory Table Columns
    t.TerritoryDescription AS TerritoryDescription,

    -- Region Table Columns
    r.RegionID AS RegionID,
    r.RegionDescription AS RegionDescription,

    -- Sales Agent Analysis Columns
    ts.TotalSalesAmount AS SalesTotalSalesAmount,
    ts.AvgOrderValue AS SalesAvgOrderValue,
    ts.TopSalesAgent AS SalesTopSalesAgent,
    SUM(op.ProfitPerProduct) AS TotalProfit
FROM
    {{ ref('raw_order_detail') }} od
LEFT JOIN
    {{ ref('raw_orders') }} o ON od.OrderID = o.OrderID
LEFT JOIN
    {{ ref('raw_employee') }} e ON o.EmployeeID = e.EmployeeID
LEFT JOIN
    {{ source('ADO', 'PRODUCT') }} p ON od.ProductID = p.ProductID
LEFT JOIN
    OrderProfits op ON od.OrderID = op.OrderID AND od.ProductID = op.ProductID
LEFT JOIN
    {{ ref('raw_employee_territory') }} et ON o.EmployeeID = et.EmployeeID
LEFT JOIN
    {{ ref('raw_territory') }} t ON et.TerritoryID = t.TerritoryID
LEFT JOIN
    {{ ref('raw_region') }} r ON t.RegionID = r.RegionID
LEFT JOIN
    TopSalesAgents ts ON o.EmployeeID = ts.EmployeeID
GROUP BY
    -- Include all non-aggregated columns in the GROUP BY clause
    od.OrderID,
    od.ProductID,
    od.UnitPrice,
    od.Quantity,
    od.Discount,
    p.UnitCost,
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
    p.ProductName,
    p.SupplierID,
    p.CategoryID,
    p.QuantityPerUnit,
    p.UnitPrice,
    p.UnitsInStock,
    p.UnitsOnOrder,
    p.ReorderLevel,
    p.Discontinued,
    et.TerritoryID,
    t.TerritoryDescription,
    r.RegionID,
    r.RegionDescription,
    ts.TotalSalesAmount,
    ts.AvgOrderValue,
    ts.TopSalesAgent
