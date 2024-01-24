SELECT
    -- Order Table Columns
    OrderID,
    OrderDate,
    RequiredDate,
    ShippedDate,

    -- Order Detail Table Columns
    OrderDetailUnitPrice,
    OrderDetailQuantity,
    OrderDetailDiscount,

    -- Product Table Columns
    ProductID,
    ProductName,
    SupplierID,
    CategoryID,
    QuantityPerUnit,
    ProductUnitPrice,
    UnitsInStock,
    UnitsOnOrder,
    ReorderLevel,
    Discontinued,
    ProductUnitCost,

    -- Supplier Table Columns
    CompanyName,
    ContactName,
    ContactTitle,
    Address,
    City,
    Region,
    PostalCode,
    Country,
    Phone,
    Fax,
    HomePage,

    -- Category Table Columns
    CategoryName,
    Description
FROM
    {{ ref('stg_supplier') }}
