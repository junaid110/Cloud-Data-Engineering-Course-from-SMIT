import streamlit as st
import pandas as pd

st.title("CSV Upload Example")

# File uploader widget
uploaded_file = st.file_uploader("Choose a CSV file", type="csv")

if uploaded_file is not None:
    # Read CSV into Pandas DataFrame
    df = pd.read_csv(uploaded_file)
    
    # Show dataframe
    st.subheader("Data Preview")
    st.dataframe(df)
    
    # Show basic statistics
    st.subheader("Summary Statistics")
    st.write(df.describe())