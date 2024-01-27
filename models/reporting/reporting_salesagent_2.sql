SELECT
    -- Order Detail Table Columns
    OrderID,
    OrderDetailProductID,
    OrderDetailUnitPrice,
    OrderDetailQuantity,
    OrderDetailDiscount,
    
    -- Order Table Columns
    OrderCustomerID,
    OrderEmployeeID,
    OrderOrderDate,
    OrderRequiredDate,
    OrderShippedDate,
    OrderShipVia,
    OrderFreight,
    OrderShipName,
    OrderShipAddress,
    OrderShipCity,
    OrderShipRegion,
    OrderShipPostalCode,
    OrderShipCountry,
    
    -- Employee Table Columns
    EmployeeLastName,
    EmployeeFirstName,
    EmployeeTitle,
    EmployeeTitleOfCourtesy,
    EmployeeBirthDate,
    EmployeeHireDate,
    EmployeeAddress,
    EmployeeCity,
    EmployeeRegion,
    EmployeePostalCode,
    EmployeeCountry,
    EmployeeHomePhone,
    EmployeeExtension,
    EmployeePhoto,
    EmployeeNotes,
    EmployeeReportsTo,
    EmployeePhotoPath,
    
    -- Product Table Columns
    ProductUnitCost,
    ProductProductName,
    ProductSupplierID,
    ProductCategoryID,
    ProductQuantityPerUnit,
    ProductUnitPrice,
    ProductUnitsInStock,
    ProductUnitsOnOrder,
    ProductReorderLevel,
    ProductDiscontinued,
    
    -- Employee Territory Table Columns
    EmployeeTerritoryID,
    
    -- Territory Table Columns
    TerritoryDescription,
    
    -- Region Table Columns
    RegionID,
    RegionDescription,
    
    -- Sales Agent Analysis Columns
    SalesTotalSalesAmount,
    SalesAvgOrderValue,
    SalesTopSalesAgent,
    TotalProfit
FROM
    {{ ref('stg_salesagent_2') }}