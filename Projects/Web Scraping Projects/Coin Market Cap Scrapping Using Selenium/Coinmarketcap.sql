CREATE DATABASE coinmarketcap;
GO

USE coinmarketcap;
GO

CREATE TABLE crypto_prices (
    id INT IDENTITY(1,1) PRIMARY KEY,
    rank VARCHAR(20),
    name VARCHAR(100),
    price VARCHAR(50),
    one_hour_change VARCHAR(20),
    twenty_four_hour_change VARCHAR(20),
    seven_day_change VARCHAR(20),
    market_cap VARCHAR(100),
    hr_volume VARCHAR(100),
    circulating_supply VARCHAR(100),
    scraped_at DATETIME DEFAULT GETDATE()
);








USE coinmarketcap;
SELECT COUNT(*) FROM crypto_prices;

SELECT TOP 10 * FROM crypto_prices ORDER BY id DESC;

