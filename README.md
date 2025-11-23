Banggood Product Data Pipeline & Analysis

Project Architecture

<img width="3000" height="1800" alt="stock_availability_distribution" src="https://github.com/user-attachments/assets/92c980f2-5ef0-4fdb-b643-39c93817195a" />


Project Overview

This repository houses a Python project designed for automated product data extraction from the Banggood website and subsequent interactive analysis using a Streamlit web interface.

The core logic, developed within Project.ipynb, leverages Selenium and webdriver-manager for robust data collection from Banggood.com, pandas for cleaning and structuring the data, and Streamlit for creating a compelling, user-friendly application to interact with the results.

It's structured into key phases:

Data Extraction: Automated web scraping of Banggood product data.

Data Processing: Cleaning and transformation.

Application Interface: Interactive display and filtering via Streamlit.

✨ Features

Banggood Data Extraction: Uses Selenium to reliably navigate, interact with, and extract product data (e.g., pricing, reviews, details) from the Banggood e-commerce website.

Browser Agnostic: Utilizes webdriver-manager to handle necessary browser drivers automatically.

Interactive Dashboard: A Streamlit interface allows users to filter, visualize, and analyze the extracted data in real-time.

Jupyter Integration: The main logic is contained within a Jupyter Notebook for easy, cell-by-cell development and inspection.

🛠️ Tech Stack

Component

Technology

Role

Language

Python (3.9+)

Core programming language

Scraping

Selenium

Browser automation and data extraction

Driver Mgt

webdriver-manager

Automatic management of browser drivers

Data Handling

Pandas

Data processing, analysis, and structuring

Web App

Streamlit

Rapid creation of the interactive web application

Development

Jupyter Notebook

Iterative development and code execution
