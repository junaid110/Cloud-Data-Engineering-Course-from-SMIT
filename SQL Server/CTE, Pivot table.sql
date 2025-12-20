--- Common Table Expression--
-- Clean & Readable Code--
-- Re-usability

--WITH expression_name[(column_name [,...])]
--AS
--    (CTE_definition)
--SQL_statement;


WITH tables_data
AS(

   select * from sales.customers
)
select * from tables_data;

select 
       sf.first_name + ' ' + sf.last_name  as staff_name,
	   SUM((ot.quantity * ot.list_price)*(1- ot.discount)) as sales
from sales.staffs as sf
inner join sales.orders o on o.staff_id = sf.staff_id
inner join sales.order_items ot on ot.order_id = o.order_id
group by sf.first_name + ' ' + sf.last_name

select * from sales.order_items;


WITH sales_cte AS (
    SELECT 
        sf.first_name + ' ' + sf.last_name AS staff_name,
        SUM((ot.quantity * ot.list_price) * (1 - ot.discount)) AS total_sales,
		YEAR(o.order_date) as Order_Year
    FROM sales.staffs AS sf
    INNER JOIN sales.orders o 
        ON o.staff_id = sf.staff_id
    INNER JOIN sales.order_items ot 
        ON ot.order_id = o.order_id
    GROUP BY sf.first_name + ' ' + sf.last_name,
	YEAR (o.order_date)
)
SELECT *
FROM sales_cte
WHERE order_year = 2016;


WITH cte_sales AS (
    SELECT 
        staff_id, 
        COUNT(*) order_count  
    FROM
        sales.orders
    WHERE 
        YEAR(order_date) = 2018
    GROUP BY
        staff_id

)
SELECT
    AVG(order_count) average_orders_by_staff
FROM 
    cte_sales;



--c--

WITH cte_category_counts (
    category_id, 
    category_name, 
    product_count
)
AS (
    SELECT 
        c.category_id, 
        c.category_name, 
        COUNT(p.product_id)
    FROM 
        production.products p
        INNER JOIN production.categories c 
            ON c.category_id = p.category_id
    GROUP BY 
        c.category_id, 
        c.category_name
),
cte_category_sales(category_id, sales) AS (
    SELECT    
        p.category_id, 
        SUM(i.quantity * i.list_price * (1 - i.discount))
    FROM    
        sales.order_items i
        INNER JOIN production.products p 
            ON p.product_id = i.product_id
        INNER JOIN sales.orders o 
            ON o.order_id = i.order_id
    WHERE order_status = 4 -- completed
    GROUP BY 
        p.category_id
) 

SELECT 
    c.category_id, 
    c.category_name, 
    c.product_count, 
    s.sales
FROM
    cte_category_counts c
    INNER JOIN cte_category_sales s 
        ON s.category_id = c.category_id
ORDER BY 
    c.category_name;


-- Pivot---

SELECT * FROM   
(
    SELECT 
        category_name, 
        product_id,
        model_year
    FROM 
        production.products p
        INNER JOIN production.categories c 
            ON c.category_id = p.category_id
) t 
PIVOT(
    COUNT(product_id) 
    FOR category_name IN (
        [Children Bicycles], 
        [Comfort Bicycles], 
        [Cruisers Bicycles], 
        [Cyclocross Bicycles], 
        [Electric Bikes], 
        [Mountain Bikes], 
        [Road Bikes])
) AS pivot_table;



