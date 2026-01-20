import pandas as pd
from scraper import scrape_coinmarketcap
import os

def main():
    data = scrape_coinmarketcap()

    os.makedirs("data", exist_ok=True)

    df = pd.DataFrame(data)
    df.to_csv("data/coinmarketcap.csv", index=False)

    print("Pipeline completed")
    print("CSV saved at: data/coinmarketcap.csv")

if __name__ == "__main__":
    main()

