CREATE DATABASE SalesDB;
use SalesDB;
CREATE VIEW Total_Sales AS
SELECT 
    SUM(Total_sales) AS Total_Sales,
    SUM(Quantity) AS Total_Quantity,
    AVG(Total_sales) AS Avg_Sales,
    MIN(Total_sales) AS Min_Sales,
    MAX(Total_sales) AS Max_Sales
FROM orders_data;


-- Query the View---
-- Total Sales Data--
SELECT * FROM Total_Sales
--- Total Sales Data Region Wise--
SELECT * FROM [dbo].[view_total_sales_region] AS Total_Sales_Per_Region

select * from orders_data;

-- Top 10 Highest Grossing products
select top 10 Product_id, sum(Sale_price) as Sales
from orders_data
group by Product_id
order by Sales desc

-- Top 5 City Total Sales--

SELECT TOP 5 
    City,
    SUM(Total_sales) AS Total_Sales
FROM orders_data
GROUP BY City
ORDER BY Total_Sales DESC;

















