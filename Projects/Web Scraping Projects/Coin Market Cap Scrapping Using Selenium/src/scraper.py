from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from bs4 import BeautifulSoup
import time
from config import URL

def scrape_coinmarketcap():
    options = Options()
    options.add_argument("--start-maximized")
    options.add_argument("--disable-gpu")
    options.add_argument("--no-sandbox")

    driver = webdriver.Chrome(options=options)
    driver.get(URL)
    time.sleep(3)

    scroll_pause_time = 0.5
    scroll_step = 300
    last_height = driver.execute_script("return document.body.scrollHeight")

    while True:
        for i in range(0, last_height, scroll_step):
            driver.execute_script(f"window.scrollTo(0, {i});")
            time.sleep(scroll_pause_time)

        new_height = driver.execute_script("return document.body.scrollHeight")
        if new_height == last_height:
            break
        last_height = new_height

    soup = BeautifulSoup(driver.page_source, "html.parser")
    driver.quit()

    table = soup.find("table", {"class": "cmc-table"})
    rows = table.find_all("tr")

    crypto_data = []
    for row in rows[1:]:
        cols = row.find_all("td")
        if len(cols) >= 10:
            crypto_data.append([
                cols[1].text.strip(),
                cols[2].text.strip(),
                cols[3].text.strip(),
                cols[4].text.strip(),
                cols[5].text.strip(),
                cols[6].text.strip(),
                cols[7].text.strip(),
                cols[8].text.strip(),
                cols[9].text.strip()
            ])

    return crypto_data

def scrape_coinmarketcap():
    data = []

    # ... scraping logic ...
    # data.append({...})

    print(f"Fetched {len(data)} rows")
    return data
