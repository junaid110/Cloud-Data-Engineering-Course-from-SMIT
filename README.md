
# 🪙 CoinMarketCap Web Scraper

A Python-based web scraping project that automatically extracts cryptocurrency data from CoinMarketCap and stores it in a SQL Server database for analysis.

## 📊 Project Overview

This project uses Selenium and BeautifulSoup to scrape real-time cryptocurrency market data from CoinMarketCap.com, including prices, market caps, trading volumes, and price changes. The data is then stored in a SQL Server database for further analysis and tracking.

## 🏗️ Architecture

```
CoinMarketCap.com (Data Source)
         ↓
Web Scraping Layer (Selenium + BeautifulSoup)
         ↓
Data Processing (Python/Jupyter)
         ↓
Database Storage (SQL Server)
```

## ✨ Features

- **Automated Web Scraping**: Uses Selenium WebDriver for dynamic content loading
- **Data Extraction**: Collects top 100 cryptocurrencies with comprehensive metrics
- **Database Integration**: Stores data in SQL Server with timestamp tracking
- **Auto-scrolling**: Implements smooth scrolling to load all table rows
- **Batch Processing**: Efficient data insertion using fast_executemany

## 📦 Data Collected

For each cryptocurrency, the scraper collects:

- Rank
- Name & Symbol
- Current Price
- 1-hour Price Change (%)
- 24-hour Price Change (%)
- 7-day Price Change (%)
- Market Capitalization
- 24-hour Trading Volume
- Circulating Supply
- Timestamp of data collection

## 🛠️ Technologies Used

- **Python 3.13.5**
- **Selenium 4.38.0** - Web browser automation
- **BeautifulSoup4** - HTML parsing
- **PyODBC 5.2.0** - SQL Server connectivity
- **Pandas** - Data manipulation
- **Jupyter Notebook** - Interactive development
- **SQL Server** - Database storage

## 📋 Prerequisites

- Python 3.x installed
- SQL Server (with ODBC Driver 17)
- Chrome browser
- ChromeDriver (compatible with your Chrome version)

## 🚀 Installation

1. **Clone the repository**
```bash
git clone https://github.com/yourusername/coinmarketcap-scraper.git
cd coinmarketcap-scraper
```

2. **Create a virtual environment**
```bash
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
```

3. **Install required packages**
```bash
pip install -r requirements.txt
```

4. **Set up the database**
```sql
-- Run the SQL script to create database and table
-- Execute Coinmarketcap.sql in SQL Server Management Studio
```

## 💻 Usage

### Running the Scraper

1. **Open Jupyter Notebook**
```bash
jupyter notebook
```

2. **Open the notebook file**
   - Navigate to `Coinmarket Cap using Jupyter.ipynb`

3. **Update database connection** (if needed)
```python
conn = pyodbc.connect(
    "DRIVER={ODBC Driver 17 for SQL Server};"
    "SERVER=YOUR_SERVER_NAME;"
    "DATABASE=coinmarketcap;"
    "Trusted_Connection=yes;"
)
```

4. **Run all cells** to execute the scraper

### Database Queries

Check collected data:
```sql
USE coinmarketcap;

-- Count total records
SELECT COUNT(*) FROM crypto_prices;

-- View latest 10 entries
SELECT TOP 10 * FROM crypto_prices ORDER BY id DESC;

-- View specific cryptocurrency
SELECT * FROM crypto_prices WHERE name LIKE '%Bitcoin%';
```

## 📁 Project Structure

```
coinmarketcap-scraper/
│
├── Coinmarket Cap using Jupyter.ipynb  # Main scraper notebook
├── Coinmarketcap.sql                   # Database setup script
├── requirements.txt                     # Python dependencies
├── README.md                           # Project documentation
│
├── data/                               # (Optional) Data exports
├── src/                                # (Optional) Modular scripts
└── venv/                               # Virtual environment
```

## 🔧 Configuration

### Selenium Options
The scraper uses these Chrome options:
- `--start-maximized`: Opens browser in fullscreen
- `--disable-gpu`: Disables GPU acceleration
- `--no-sandbox`: Bypasses OS security model

### Scroll Settings
```python
scroll_pause_time = 0.5  # Pause between scrolls (seconds)
scroll_step = 300        # Pixels per scroll step
```

## 📊 Database Schema

```sql
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
```

## ⚠️ Important Notes

- **Rate Limiting**: Be respectful of CoinMarketCap's servers; avoid excessive scraping
- **Terms of Service**: Ensure compliance with CoinMarketCap's ToS
- **Data Accuracy**: Prices and metrics are snapshots at scrape time
- **Browser Requirement**: Chrome browser must be installed
- **Driver Compatibility**: Ensure ChromeDriver matches your Chrome version

## 🐛 Troubleshooting

### Common Issues

**ChromeDriver Error**
```
Solution: Download matching ChromeDriver version from:
https://chromedriver.chromium.org/
```

**Database Connection Failed**
```
Solution: 
1. Verify SQL Server is running
2. Check ODBC Driver 17 is installed
3. Update connection string with correct server name
```

**No Data Scraped**
```
Solution:
1. Check internet connection
2. Verify CoinMarketCap.com is accessible
3. Increase scroll_pause_time if page loads slowly
```

## 🔮 Future Enhancements

- [ ] Add scheduling for automatic daily scraping
- [ ] Implement data visualization dashboard
- [ ] Add email notifications for price alerts
- [ ] Create REST API for data access
- [ ] Add support for historical data collection
- [ ] Implement error logging and monitoring
- [ ] Add data validation and cleaning

## 📝 License

This project is for educational purposes only. Please review and comply with CoinMarketCap's Terms of Service.

## 👤 Author

**Your Name**
- GitHub: https://github.com/junaid110
- LinkedIn: https://www.linkedin.com/in/syedjunaidabbas

## 🙏 Acknowledgments

- CoinMarketCap for providing cryptocurrency data
- Selenium and BeautifulSoup communities
- Python community for excellent libraries

## 📧 Contact

For questions or suggestions, please open an issue or contact me directly.

---

⭐ If you find this project useful, please consider giving it a star!
