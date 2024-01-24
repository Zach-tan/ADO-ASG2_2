SELECT 
    --Order Table columns
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

    --Customer Table columns
    CompanyName,
    Contactname,
    ContactTitle,
    Address,
    City,
    Region,
    PostalCode,
    Country,
    Phone,
    Fax,

    --OrderDetail table columns
    OrderDetailProductID,
    OrderDetailUnitPrice,
    OrderDetailQuantity,
    OrderDetailDiscount,

    --Product table columns
    PRODUCTNAME,

    --Category table columns
    ProductCategoryName,
    ProductCategoryDescription,

    --Customer reporting columns
    NetSales,
    OrderStatus,
    ShipTime,
    AvgOrderValue,
    TotalOrdersbyCustomer,
    TotalQuantitySold
FROM 
    {{ ref('stg_customer_reporting') }}    