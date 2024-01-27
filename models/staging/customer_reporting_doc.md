{% docs customer_reporting_doc %}

| Column                  | Definition                                       |
|-------------------------|--------------------------------------------------|
| OrderID                 | Unique Order identifier (Primary Key)            |
| CustomerID    	      | Unique Customer identifier         		         |
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
| CompanyName   	      | Name of the customer's company		             |                  
| ContactName   	      | Name of the primary contact person		         |                      
| ContactTitle  	      | Title of the primary contact person		         |                     
| Address       	      | Customer's address				                 |                              
| City          	      | City where the customer is located		         |              
| Region        	      | Region where the customer is located	         |            
| PostalCode    	      | Postal code of the customer's location	         |          
| Country       	      | Country where the customer is located	         |           
| Phone         	      | Customer's phone number			                 |                        
| Fax           	      | Customer's fax number			                 |                           
| OrderDetailProductID    | Product identifier for the order detail          |
| OrderDetailUnitPrice    | Price per unit of the product at the time the order was placed (USD - discount not included) |
| OrderDetailQuantity     | Number of units being ordered                    |
| OrderDetailDiscount     | The discount percentage applied to the price per unit |
| ProductName		      | Specific name of the product		             |
| ProductCategoryName	  | Name of the product category		             |
| ProductCategoryDescription | Description of the product category	         |
| NetSales		          | Calculated by (revenue - discount)		         |
| OrderStatus 		      | States whether the order is 'Pending','Shipped' or 'Delivered' |
| AvgOrderValue		      | Average order value per order		             |		
| TotalOrdersbyCustomer	  | Displays total customer orders		             |
| TotalQuantitySold	      | Quantity of product sold			             |

{% enddocs %}