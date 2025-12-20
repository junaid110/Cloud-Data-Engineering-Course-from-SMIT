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
-- lhs == rhs (lhs)
-- lhs != rhs (null)