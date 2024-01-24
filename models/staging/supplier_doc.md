{% docs supplier_doc %}

| Column                  | Definition                                       |
|-------------------------|--------------------------------------------------|
| OrderID                 | Unique Order identifier (Primary Key)            |
| OrderDate               | Date when the order was placed                   |
| RequiredDate            | Date when the order is required                  |
| ShippedDate             | Date when the order was shipped                  |
| OrderDetailUnitPrice    | Price per unit of the product at the time the order was placed (USD - discount not included) |
| OrderDetailQuantity     | Number of units being ordered                    |
| OrderDetailDiscount     | The discount percentage applied to the price per unit |
| ProductID               | Unique Product identifier (Primary Key)          |
| ProductName             | Name of the product                              |
| SupplierID              | ID of the supplier (Foreign Key)                 |
| CategoryID              | ID of the category (Foreign Key) the product belongs to |
| QuantityPerUnit         | Quantity of the product per unit                 |
| ProductUnitPrice        | Price per unit of the product (USD)              |
| UnitsInStock            | Number of units in stock                         |
| UnitsOnOrder            | Number of units on order                         |
| ReorderLevel            | Minimum quantity that should trigger a reorder   |
| Discontinued            | Indicates with a 1 if the product has been discontinued |
| CompanyName             | Name of the supplier's company                   |
| ContactName             | Name of the contact person                       |
| ContactTitle            | Title of the contact person                      |
| Address                 | Supplier's address                               |
| City                    | City where the supplier is located               |
| Region                  | Region where the supplier is located             |
| PostalCode              | Postal code of the supplier's location           |
| Country                 | Country where the supplier is located            |
| Phone                   | Supplier's phone number                          |
| Fax                     | Supplier's fax number                            |
| HomePage                | Supplier's homepage URL                          |
| CategoryName            | Name of the category                             |
| Description             | Description of the category                      |

{% enddocs %}