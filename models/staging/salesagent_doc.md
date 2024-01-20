{% docs salesagent_doc %}

| Column                  | Definition                                       |
|-------------------------|--------------------------------------------------|
| OrderID                 | Unique Order identifier (Primary Key)            |
| CustomerID              | ID of the customer placing the order             |
| EmployeeID              | ID of the employee processing the order          |
| OrderDate               | Date when the order was placed                   |
| RequiredDate            | Date when the order is required                  |
| ShippedDate             | Date when the order was shipped                  |
| ShipVia                 | ID of the shipping company used for the order    |
| Freight                 | Freight cost for shipping                        |
| ShipName                | Name of the person or company to whom the order should be shipped |
| ShipAddress             | Address to which the order should be shipped     |
| ShipCity                | City to which the order should be shipped        |
| ShipRegion              | Region to which the order should be shipped      |
| ShipPostalCode          | Postal code to which the order should be shipped |
| ShipCountry             | Country to which the order should be shipped     |
| LastName                | Last name of the employee                        |
| FirstName               | First name of the employee                       |
| Title                   | Job title of the employee                        |
| TitleOfCourtesy         | Courtesy title for the employee                  |
| BirthDate               | Birthdate of the employee                        |
| HireDate                | Date when the employee was hired                 |
| Address                 | Employee's address                               |
| City                    | City where the employee is located               |
| Region                  | Region where the employee is located             |
| PostalCode              | Postal code of the employee's location           |
| Country                 | Country where the employee is located            |
| HomePhone               | Employee's home phone number                     |
| Extension               | Employee's phone extension                       |
| Photo                   | Employee's photo (binary data)                   |
| Notes                   | Additional notes about the employee              |
| ReportsTo               | ID of the employee's supervisor                  |
| PhotoPath               | File path to the employee's photo                |
| OrderDetailProductID    | Product identifier for the order detail          |
| OrderDetailUnitPrice    | Price per unit of the product at the time the order was placed (USD - discount not included) |
| OrderDetailQuantity     | Number of units being ordered                    |
| OrderDetailDiscount     | The discount percentage applied to the price per unit |
| EmployeeTerritoryID     | Territory identifier for the employee territory  |
| TerritoryDescription    | Description of the territory                     |
| RegionID                | Region identifier                                |
| RegionDescription       | Description of the region                        |
| TotalSalesAmount        | Total sales amount for the employee              |
| AvgOrderValue           | Average order value for the employee             |
| TopSalesAgent           | Categorization of the sales agent as 'Top Sales Agent' or 'Regular Sales Agent' |

{% enddocs %}