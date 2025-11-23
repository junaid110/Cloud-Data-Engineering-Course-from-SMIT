CREATE DATABASE MISC;

USE MISC;

DROP TABLE Lefttable;

CREATE TABLE Lefttable (
	Dated date,
	CountryID int,
	Units int
);

DROP TABLE Righttable;

CREATE TABLE Righttable (
	ID int,
	Country varchar(20)
);

-- DML Data Manipulation Language

INSERT INTO Lefttable (Dated,CountryID,Units)
VALUES('2020-01-01', 1, 40);

INSERT INTO Lefttable (Dated,CountryID,Units)
VALUES('2020-02-01', 1, 25);

INSERT INTO Lefttable (Dated,CountryID,Units)
VALUES('2020-03-01', 3, 30);

INSERT INTO Lefttable (Dated,CountryID,Units)
VALUES('2020-04-01', 2, 35);


INSERT INTO Righttable(ID,Country) VALUES
(3,'Panama'),
(4,'Spain');

-- Querying--

SELECT * FROM Lefttable;
SELECT * FROM Righttable;

SELECT * 
FROM Lefttable l
FULL JOIN Righttable r
ON l.CountryID = r.ID;

SELECT 
	r.ID,
	r.Country,
	l.Dated,
	l.Units
FROM Lefttable l
RIGHT JOIN Righttable r
ON l.CountryID = r.ID;

SELECT
	l.CountryID,
	l.Units,
	l.Dated,
	r.Country
FROM Lefttable l
LEFT JOIN Righttable r
ON l.CountryID = r.ID;

SELECT * 
FROM Lefttable AS l
INNER JOIN Righttable AS r
ON l.CountryID = r.ID;

-- Left Anti Join--

SELECT
	l.CountryID,
	l.Units,
	l.Dated,
	r.Country
FROM Lefttable l
LEFT JOIN Righttable r
ON l.CountryID = r.ID
WHERE r.ID IS NULL;

-- Right Anti Join--
SELECT
	l.CountryID,
	r.ID,
	l.Units,
	l.Dated,
	r.Country
FROM Lefttable l
RIGHT JOIN Righttable r
ON l.CountryID = r.ID
WHERE l.CountryID IS NULL;  -- Matching Null--



SELECT *
FROM Lefttable l
FULL OUTER JOIN Righttable r
ON l.CountryID = r.ID;

-- SQL Query Optimization
-- FROM/JOIN >> WHERE >> Group by >> Having >> SELECT >> DISTINICT >> ORDERBY >> lIMIT/OFFSET


-- Semi Join--
SELECT 
	l.Dated, 
	l.CountryID, 
	l.Units
FROM Lefttable AS l
WHERE EXISTS (
    SELECT 1
    FROM Righttable AS r
    WHERE l.CountryID = r.ID
);


SELECT *
FROM Lefttable l
CROSS JOIN Righttable r;

USE Bikestores
-- Self Join--

SELECT 
	e.first_name + ' ' + e.last_name as employee_name,
	m.first_name + ' ' + m.last_name as manager_name
FROM [sales].[staffs] e
INNER JOIN [sales].[staffs] m
ON e.staff_id = m.manager_id;

--Group By--

SELECT state,count(*) AS state_count
FROM sales.customers
GROUP BY state
HAVING count(*) > 1000;

-- GROUPING Sets

SELECT
    b.brand_name AS brand,
    c.category_name AS category,
    p.model_year,
    round(
        SUM (
            quantity * i.list_price * (1 - discount)
        ),
        0
    ) sales INTO sales.sales_summary
FROM
    sales.order_items i
INNER JOIN production.products p ON p.product_id = i.product_id
INNER JOIN production.brands b ON b.brand_id = p.brand_id
INNER JOIN production.categories c ON c.category_id = p.category_id
GROUP BY
    b.brand_name,
    c.category_name,
    p.model_year
ORDER BY
    b.brand_name,
    c.category_name,
    p.model_year;

--
SELECT
    brand,
    category,
    SUM (sales) brand_sales
FROM
    sales.sales_summary
GROUP BY
    brand,
    category
ORDER BY
    brand,
    category;

SELECT SUM(sales) as Total_Sales
FROM sales.sales_summary;



SELECT
    brand,
    category,
    SUM (sales) brand_sales
FROM
    sales.sales_summary
GROUP BY
	GROUPING SETS (
		(brand, category),
		(brand),
		(category),
		()
	)
ORDER BY
	brand,
	category;