CREATE VIEW product_catalog
AS
SELECT p.product_id,
       p.product_name,
	   p.model_year,
	   p.list_price,
	   c.category_id,
	   c.category_name,
	   b.brand_id,
	   b.brand_name,
	   s.quantity,
	   s.store_id
FROM [production].[products] p
INNER JOIN [production].[categories] c on p.category_id = c.category_id
INNER JOIN [production].[brands] b on p.brand_id = b.brand_id
INNER JOIN [production].[stocks] s on p.product_id = s.product_id;


select * from [dbo].[product_catalog];


-- Listing the Views---

SELECT name FROM sys.views;
SELECT * FROM sys.objects WHERE type = 'V';

-- Get Information--
SELECT * FROM sys.sql_modules;

-- DELETE VIEW--
DROP VIEW [dbo].[product_catalog]

--

