import pyodbc
from config import DB_CONFIG

def get_connection():
    conn_str = (
        f"DRIVER={{{DB_CONFIG['driver']}}};"
        f"SERVER={DB_CONFIG['server']};"
        f"DATABASE={DB_CONFIG['database']};"
        f"Trusted_Connection={DB_CONFIG['trusted_connection']};"
    )
    return pyodbc.connect(conn_str)

def insert_crypto_data(data):
    conn = get_connection()
    cursor = conn.cursor()
    cursor.fast_executemany = True

    query = """
    INSERT INTO crypto_prices (
        rank, name, price, one_hour_change,
        twenty_four_hour_change, seven_day_change,
        market_cap, hr_volume, circulating_supply
    )
    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
    """

    cursor.executemany(query, data)
    conn.commit()
    cursor.close()
    conn.close()
