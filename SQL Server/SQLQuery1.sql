-- Querying Data--
-- full qualified naming

SELECT * FROM [sales].[customers];

SELECT first_name, last_name FROM [sales].[customers];

-- Conditions (WHERE)--

SELECT * FROM [sales].[customers] WHERE state = 'NY';
SELECT * FROM [sales].[customers] WHERE customer_id > 100;
SELECT * FROM [sales].[customers] WHERE state != 'NY';  --Except Newyork--

-- Operators (AND, OR, NOT, BETWEEN)--

SELECT * FROM [sales].[customers] WHERE state = 'NY' AND customer_id > 100;
SELECT * FROM [sales].[customers] WHERE phone IS NOT NULL;
SELECT * FROM [sales].[customers] WHERE customer_id BETWEEN 101 AND 155;
SELECT * FROM [sales].[customers] WHERE last_name = 'Bates' OR first_name = 'Marget';

-- Like ( with, wildcard)--
-- % : Represents  Zero, one or multiple characters.
-- underscore: Reprsenets a single character.
-- [] Brackets: Reprsents any single character within the specified range or sequence.
-- [^] (caret within brackets): Represents any single characer not with in specified range,
SELECT * FROM [sales].[customers] WHERE first_name LIKE 'Aa%on%';
SELECT * FROM [sales].[customers] WHERE first_name LIKE '[^A-C]%';
SELECT * FROM [sales].[customers] WHERE first_name LIKE 'M[a,e,i]%';

-- Concatenation and ALIAS

SELECT CONCAT(first_name,' ',last_name) AS full_name
FROM [sales].[customers];

SELECT first_name+' '+last_name AS full_name, *
FROM [sales].[customers];

-- Sorting (ORDER BY, ASC/DESC)--
SELECT * FROM [sales].[customers] ORDER BY first_name;
SELECT * FROM [sales].[customers] ORDER BY first_name, state;
SELECT * FROM [sales].[customers] ORDER BY state, first_name;

SELECT * 
FROM [sales].[customers] 
ORDER BY state DESC, first_name ASC;

SELECT * 
FROM [sales].[customers] 
ORDER BY state DESC, first_name DESC;

-- Limiting (TOP, OFFSET/FETCH) 
-- OFfSET worked only with ORDER BY
-- OFFSET offset_row_count {ROw: ROws}
-- FETCH {First/Next] fetchrow count {ROw: ROws} only

SELECT TOP(15)* 
FROM [sales].[customers];

SELECT TOP(15) customer_id, first_name, phone, email 
FROM [sales].[customers] WHERE phone IS NOT NULL AND customer_id > 100;

SELECT *
FROM [sales].[customers]
ORDER BY first_name
OFFSET 5 ROWS          -- starting ki 5 chor kr baqi ki 10 liyao--
FETCH  NEXT 10 ROWS ONLY;


SELECT
    product_name,
    list_price
FROM
    production.products
ORDER BY
    list_price,
    product_name
	OFFSET 10 ROWS
	FETCH NEXT 10 ROWS ONLY;


-- Joins---
