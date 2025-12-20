SELECT
     CASE order_status
	 WHEN 1 THEN  'Pending'
	 WHEN 2 THEN  'Processing'
	 WHEN 3 THEN  'Rejected'
	 WHEN 4 THEN  'Completed'
	 END AS modified_or_status,
	 count(*) AS or_status_count

FROM [sales].[orders]
GROUP BY 
     CASE order_status
	 WHEN 1 THEN  'Pending'
	 WHEN 2 THEN  'Processing'
	 WHEN 3 THEN  'Rejected'
	 WHEN 4 THEN  'Completed'
	 END;


select o.order_id,
	SUM( quantity* list_price) as order_value,
	CASE
	WHEN SUM (quantity* list_price) <= 500 THEN 'Very Low'
	WHEN SUM (quantity* list_price) > 500 AND SUM (quantity* list_price) <= 1000 THEN 'Low'
    WHEN SUM(quantity * list_price) > 1000 AND  SUM(quantity * list_price) <= 5000 THEN 'Medium'
    WHEN SUM(quantity * list_price) > 5000 AND  SUM(quantity * list_price) <= 10000 THEN 'High'
    WHEN SUM(quantity * list_price) > 10000 THEN 'Very High'
    END order_priority
from [sales].[orders] o
INNER JOIN [sales].[order_items] i ON i.order_id = o.order_id
GROUP BY 
	o.order_id;


--Coalesce--

SELECT COALESCE('Hi', NULL);

SELECT first_name, 
       last_name, 
	   COALESCE(phone, 'N/A') as phone
from [sales].[customers];



-- Null If---
-- lhs != rhs (lhs)
-- lhs == rhs (null)

Select NULLIF (10,20);
Select NULLIF (10,10);
select NULLIF ('hi', 'hello');


-- Handling Duplicates--

DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (
    id INT IDENTITY(1, 1), 
    a  INT, 
    b  INT, 
    PRIMARY KEY(id)
);

INSERT INTO t1(a,b)
VALUES(1,1),(1,2),(1,3),(2,1),(1,2),(1,3),(2,1),(2,2);

select a,
       b,
	   count(*) AS Records_Counts
FROM t1
GROUP BY a,b
HAVING count(*) > 1;
--
WITH cte_duplicates AS (
SELECT id,a,b,
	ROW_NUMBER() OVER (
		PARTITION BY a,b
		ORDER BY a,b
	) AS RN
FROM t1
)
SELECT id,a,b FROM cte_duplicates
WHERE RN=1;

--2nd Approach
SELECT 
    MIN(id) AS id,
    a,
    b
FROM t1
GROUP BY a, b;





