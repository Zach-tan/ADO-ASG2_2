SELECT
    -- Order Table Columns
    OrderID,
    CustomerID,
    EmployeeID,
    OrderDate,
    RequiredDate,
    ShippedDate,
    ShipVia,
    Freight,
    ShipName,
    ShipAddress,
    ShipCity,
    ShipRegion,
    ShipPostalCode,
    ShipCountry,

    -- Employee Table Columns
    LastName,
    FirstName,
    Title,
    TitleOfCourtesy,
    BirthDate,
    HireDate,
    Address,
    City,
    Region,
    PostalCode,
    Country,
    HomePhone,
    Extension,
    Photo,
    Notes,
    ReportsTo,
    PhotoPath,

    -- Order Detail Table Columns
    OrderDetailProductID,
    OrderDetailUnitPrice,
    OrderDetailQuantity,
    OrderDetailDiscount,

    -- Employee Territory Table Columns
    EmployeeTerritoryID,

    -- Territory Table Columns
    TerritoryDescription,

    -- Region Table Columns
    RegionID,
    RegionDescription,

    -- Sales Agent Analysis Columns
    TotalSalesAmount,
    AvgOrderValue,
    TopSalesAgent
FROM
    {{ ref('stg_salesagent') }}