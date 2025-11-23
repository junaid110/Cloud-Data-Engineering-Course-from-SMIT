import streamlit as st
import pandas as pd
import matplotlib.pyplot as plt

st.set_page_config(page_title="Banggood Product Analysis", layout="wide")
st.title("📊 Banggood Product Data Analysis Dashboard")

uploaded_file = st.file_uploader("Upload banggood_products_cleaned.csv", type=["csv"])

if uploaded_file:
    df = pd.read_csv(uploaded_file)

    # Fix numeric columns
    df["Price_Clean"] = pd.to_numeric(df["Price_Clean"], errors="coerce")
    df["Reviews_Clean"] = pd.to_numeric(df["Reviews_Clean"], errors="coerce")
    df["Price_per_Review"] = pd.to_numeric(df["Price_per_Review"], errors="coerce")

    st.success("CSV Loaded Successfully!")
    st.dataframe(df.head())

    # ===============================
    #   GRAPH 1 - Average Price per Category
    # ===============================
    st.subheader("📌 Average Price per Category")

    avg_price = df.groupby("Category")["Price_Clean"].mean()

    fig1, ax1 = plt.subplots()
    ax1.bar(avg_price.index, avg_price.values)
    ax1.set_xlabel("Category")
    ax1.set_ylabel("Average Price")
    ax1.set_title("Average Price by Category")
    plt.xticks(rotation=45)
    st.pyplot(fig1)
    plt.close(fig1)

    # ===============================
    #   GRAPH 2 - Reviews vs Price/Review
    # ===============================
    st.subheader("📌 Reviews vs Price per Review")

    fig2, ax2 = plt.subplots()
    ax2.scatter(df["Reviews_Clean"], df["Price_per_Review"])
    ax2.set_xlabel("Reviews")
    ax2.set_ylabel("Price per Review")
    ax2.set_title("Correlation: Reviews vs Price Efficiency")
    st.pyplot(fig2)
    plt.close(fig2)

    # ===============================
    #   GRAPH 3 - Top 10 Reviewed Products
    # ===============================
    st.subheader("📌 Top 10 Most Reviewed Products")

    top_10 = df.sort_values(by="Reviews_Clean", ascending=False).head(10)

    fig3, ax3 = plt.subplots()
    ax3.barh(top_10["Name"], top_10["Reviews_Clean"])
    ax3.set_xlabel("Number of Reviews")
    ax3.set_ylabel("Product Name")
    ax3.set_title("Top 10 Most Reviewed Products")
    ax3.invert_yaxis()
    st.pyplot(fig3)
    plt.close(fig3)

else:
    st.warning("Please upload banggood_products_cleaned.csv to proceed.")


# ===============================
    #   GRAPH 4 - Stock Availability Distribution
    # ===============================
    st.subheader("📦 Stock Availability Distribution")

    fig4, ax4 = plt.subplots()
    ax4.hist(df["Stock Availabilty"], bins=15)
    ax4.set_xlabel("Stock Availability")
    ax4.set_ylabel("Number of Products")
    ax4.set_title("Distribution of Stock Availability")
    st.pyplot(fig4)
    plt.close(fig4)


# ===============================
    #   GRAPH 4 - Stock Availability Distribution
    # ===============================
    st.subheader("📦 Stock Availability Distribution")

    stock_values = df["Stock Availabilty"].dropna()

    fig4, ax4 = plt.subplots()
    ax4.hist(stock_values, bins=15)
    ax4.set_xlabel("Stock Availability")
    ax4.set_ylabel("Number of Products")
    ax4.set_title("Distribution of Stock Availability")
    st.pyplot(fig4)
    plt.close(fig4)
 
