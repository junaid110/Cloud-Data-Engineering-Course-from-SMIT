CREATE DATABASE BanggoodDB;


USE BanggoodDB;

CREATE TABLE BanggoodProducts (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    Category VARCHAR(100),
    Product NVARCHAR(MAX),
    Price_Clean FLOAT,
    Rating_Clean FLOAT,
    Reviews_Clean INT,
    Price_per_Review FLOAT,
    High_Rating_Flag BIT,
    Price_Category VARCHAR(50),
    URL NVARCHAR(MAX)
);

---Average Price per Category--
SELECT Category, AVG(Price_Clean) AS AvgPrice
FROM BanggoodProducts
GROUP BY Category;


-- Average Rating per Category--

SELECT Category, AVG(Rating_Clean) AS AvgRating
FROM BanggoodProducts
GROUP BY Category;

--Number of Products per Category--

SELECT Category, COUNT(*) AS ProductCount
FROM BanggoodProducts
GROUP BY Category;

--High Rating % per Category--
SELECT Category,
       (SUM(High_Rating_Flag) * 100.0 / COUNT(*)) AS HighRatingPercentage
FROM BanggoodProducts
GROUP BY Category;

-- Top 5 Reviewed Items per Category--

SELECT Category, Product, Reviews_Clean
FROM BanggoodProducts
QUALIFY ROW_NUMBER() OVER (PARTITION BY Category ORDER BY Reviews_Clean DESC) <= 5;
