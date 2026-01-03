--Q1. List top 5 customers by total order amount.--
--Retrieve the top 5 customers who have spent the most across all sales orders. 
-- Show CustomerID, CustomerName, and TotalSpent.
select  Top 5 c.CustomerID, c.Name, SUM(s.TotalAmount) AS TotalSpent
from [dbo].[Customer] as c
INNER JOIN [dbo].[SalesOrder] as s ON c.CustomerID = s.CustomerID
GROUP BY c.CustomerID, c.Name
ORDER BY TotalSpent DESC;

--Q2. Find the number of products supplied by each supplier.
--Display SupplierID, SupplierName, and ProductCount. 
--Only include suppliers that have more than 10 products.

select s.SupplierID, s.Name, SUM(pod.productID) as ProductCount
FROM [dbo].[Supplier] as s
INNER JOIN [dbo].[PurchaseOrder] as p ON s.SupplierID = p.SupplierID
INNER JOIN [dbo].[PurchaseOrderDetail] as pod ON p.OrderID = pod.OrderID
GROUP BY s.SupplierID, s.Name
HAVING count(DISTINCT pod.ProductID) >10;


--Q3. Identify products that have been ordered but never returned.
--Show ProductID, ProductName, and total order quantity.

SELECT
    p.ProductID, p.Name AS ProductName, SUM(s.Quantity) AS TotalOrderQuantity
FROM Product p
JOIN SalesOrderDetail s ON p.ProductID = s.ProductID
LEFT JOIN ReturnDetail r ON p.ProductID = r.ProductID
WHERE r.ProductID IS NULL
GROUP BY
    p.ProductID, p.Name;

--Q4. For each category, find the most expensive product.
--Display CategoryID, CategoryName, ProductName, and Price. 
--Use a subquery to get the max price per category.

SELECT
    c.CategoryID,c.Name AS CategoryName,p.Name AS ProductName, p.Price
FROM Category c
JOIN Product p
    ON c.CategoryID = p.CategoryID
WHERE p.Price = (
    SELECT MAX(p2.Price)
    FROM Product p2
    WHERE p2.CategoryID = c.CategoryID
);

--Q5. List all sales orders with customer name, product name, category, and supplier.
--For each sales order, 
--display:OrderID, CustomerName, ProductName, CategoryName, SupplierName, and Quantity.

select s.OrderID, c.Name AS CustomerName, sod.Quantity,pd.Name AS ProductName ,pd.CategoryID,
cat.Name,sup.Name AS SupplierName
FROM
[dbo].[Customer] as c
JOIN [dbo].[SalesOrder] as s ON c.CustomerID = s.CustomerID
JOIN [dbo].[SalesOrderDetail] as sod ON sod.OrderID = sod.OrderID
JOIN [dbo].[Product] as pd ON pd.ProductID = sod.ProductID
JOIN Category as cat ON cat.CategoryID = pd.CategoryID
JOIN [dbo].[PurchaseOrderDetail] as pod ON pod.ProductID = pd.ProductID
JOIN [dbo].[PurchaseOrder] as po ON po.OrderID = pod.OrderID
JOIN [dbo].[Supplier] as sup ON sup.SupplierID = po.SupplierID
GROUP BY s.OrderID



SELECT 
    s.OrderID,c.Name AS CustomerName,pd.Name AS ProductName,cat.Name AS CategoryName,
    sup.Name AS SupplierName,sod.Quantity
FROM [dbo].[Customer] AS c JOIN [dbo].[SalesOrder] AS s ON c.CustomerID = s.CustomerID
JOIN [dbo].[SalesOrderDetail] AS sod ON sod.OrderID = s.OrderID
JOIN [dbo].[Product] AS pd ON pd.ProductID = sod.ProductID
JOIN [dbo].[Category] AS cat ON cat.CategoryID = pd.CategoryID
JOIN [dbo].[PurchaseOrderDetail] AS pod ON pod.ProductID = pd.ProductID
JOIN [dbo].[PurchaseOrder] AS po ON po.OrderID = pod.OrderID
JOIN [dbo].[Supplier] AS sup ON sup.SupplierID = po.SupplierID
ORDER BY s.OrderID;


--Q6. Find all shipments with details of warehouse, manager, and products shipped.
--Display:ShipmentID, WarehouseName, ManagerName, ProductName, QuantityShipped, and TrackingNumber.

SELECT 
    s.ShipmentID,
    l.Name AS WarehouseName,
    e.Name AS ManagerName,
    p.Name AS ProductName,
    sd.Quantity AS QuantityShipped,
    s.TrackingNumber
FROM shipment s
JOIN warehouse w ON s.WarehouseID = w.WarehouseID
JOIN location l ON w.LocationID = l.LocationID
JOIN employee e ON w.ManagerID = e.EmployeeID
JOIN shipmentdetail sd ON s.ShipmentID = sd.ShipmentID
JOIN product p ON sd.ProductID = p.ProductID
ORDER BY s.ShipmentID;


--Q7. Find the top 3 highest-value orders per customer using RANK(). 
--Display CustomerID, CustomerName, OrderID, and TotalAmount.

WITH RankedOrders AS (
    SELECT Top 3
        c.CustomerID, 
        c.Name AS CustomerName, 
        s.OrderID, 
        s.TotalAmount,
        RANK() OVER (PARTITION BY c.CustomerID ORDER BY s.TotalAmount DESC) AS OrderRank
    FROM [dbo].[Customer] AS c
    JOIN [dbo].[SalesOrder] AS s ON c.CustomerID = s.CustomerID
)
SELECT CustomerID, CustomerName, OrderID, TotalAmount
FROM RankedOrders
WHERE OrderRank <= 3
ORDER BY CustomerID, OrderRank;

-- Q8. For each product, show its sales history with the previous and next sales quantities (based on order date). 
--Display ProductID, ProductName, OrderID, OrderDate, Quantity, PrevQuantity, and NextQuantity.

SELECT 
    p.ProductID,p.Name AS ProductName,s.OrderID,s.OrderDate,sd.Quantity,
    LAG(sd.Quantity) OVER (PARTITION BY p.ProductID ORDER BY s.OrderDate) AS PrevQuantity,
    LEAD(sd.Quantity) OVER (PARTITION BY p.ProductID ORDER BY s.OrderDate) AS NextQuantity
FROM [dbo].[Product] AS p
JOIN [dbo].[SalesOrderDetail] AS sd ON p.ProductID = sd.ProductID
JOIN [dbo].[SalesOrder] AS s ON sd.OrderID = s.OrderID
ORDER BY p.ProductID, s.OrderDate;


--Q9. Create a view named vw_CustomerOrderSummary that shows for each customer:
--CustomerID, CustomerName, TotalOrders, TotalAmountSpent, and LastOrderDate.
CREATE VIEW vw_CustomerOrderSummary AS
SELECT c.CustomerID,c.Name AS CustomerName,
    COUNT(s.OrderID) AS TotalOrders,
    SUM(s.TotalAmount) AS TotalAmountSpent,
    MAX(s.OrderDate) AS LastOrderDate
FROM [dbo].[Customer] AS c
LEFT JOIN [dbo].[SalesOrder] AS s ON c.CustomerID = s.CustomerID
GROUP BY c.CustomerID, c.Name;

select * from [dbo].[vw_CustomerOrderSummary]

--Q10. Write a stored procedure sp_GetSupplierSales that takes a SupplierID 
--as input and returns the total sales amount for all products supplied by that supplier.

CREATE PROCEDURE sp_GetSupplierSales
    @SupplierID INT
AS
BEGIN
    SELECT 
        s.SupplierID,
        s.Name AS SupplierName,
        SUM(sod.Quantity * sod.UnitPrice) AS TotalSalesAmount
    FROM [dbo].[Supplier] AS s
    JOIN [dbo].[Product] AS p ON s.SupplierID = p.SupplierID
    JOIN [dbo].[SalesOrderDetail] AS sod ON p.ProductID = sod.ProductID
    WHERE s.SupplierID = @SupplierID
    GROUP BY s.SupplierID, s.Name;
END;


