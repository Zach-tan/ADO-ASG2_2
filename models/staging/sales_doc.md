{% docs sales_doc %}

| Column                | Definition                                                                                                |
|-----------------------|-----------------------------------------------------------------------------------------------------------|
| CustomerID            | Unique Customer identifier (Primary Key)                                                                  |
| CompanyName   	    | Name of the customer’s company                                                                            |
| ContactName   	    | Name of the primary contact person                                                                        |
| ContactTitle  	    | Title of the primary contact person                                                                       |
| Address   	        | Customer’s address                                                                                        |
| City  	            | City where the customer is located                                                                        |
| Region	            | Region where the customer is located                                                                      |
| PostalCode    	    | Postal code of the customer’s location                                                                    |
| Country   	        | Country where the customer is located                                                                     |
| Phone	                | Customer’s phone number                                                                                   |
| Fax	                | Customer’s fax number                                                                                     |
| OrderID          	    | Unique Order identifier (Primary Key)                                                                     |
| EmployeeID        	| ID of the employee processing the order                                                                   |
| OrderDate        	    | Date when the order was placed                                                                            |
| RequiredDate      	| Date when the order is required                                                                           |
| ShippedDate   	    | Date when the order was shipped                                                                           |
| ShipVia   	        | ID of the shipping company used for the order                                                             |
| Freight         	    | Freight cost for shipping                                                                                 |
| ShipName  	        | Name of the person or company to whom the order should be shipped                                         |
| ShipAddress         	| Address to which the order should be shipped                                                              |
| ShipCity  	        | City to which the order should be shipped                                                                 |
| ShipRegion        	| Region to which the order should be shipped                                                               |
| ShipPostalCode    	| Postal code to which the order should be shipped                                                          |
| ShipCountry   	    | Country to which the order should be shipped                                                              |
| OrderDetailProductID	| Product identifier for the order detail                                                                   |
| SalesQuantity	        | Number of units being ordered                                                                             |
| OrderDetailUnitPrice	| Price per unit of the product at the time the order was placed (USD - discount not included)              |
| Discount	            | The discount percentage applied to the price per unit                                                     |
| ProductName	        | Name of the product                                                                                       |
| SupplierID	        | ID of the supplier                                                                                        |
| CategoryID	        | ID of the category the product belongs to                                                                 |
| QuantityPerUnit	    | Quantity of the product per unit                                                                          |
| ProductUnitPrice	    | Price per unit of the product (USD)                                                                       |
| UnitsInStock	        | Number of units in stock                                                                                  |
| UnitsOnOrder	        | Number of units on order                                                                                  |
| ReorderLevel	        | Minimum quantity that should trigger a reorder                                                            |
| Discontinued	        | Indicates with a 1 if the product has been discontinued                                                   |
| UnitCost	            | Cost per unit of the product                                                                              |
| SalesAmount	        | Total sales amount for the order (calculated as OrderDetailUnitPrice * SalesQuantity * (1 - Discount))    |
| CategoryName          | Name of the category of the product                                                                       |

{% enddocs %}