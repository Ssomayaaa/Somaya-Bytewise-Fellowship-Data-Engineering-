import pandas as pd
from sqlalchemy import create_engine
import urllib.parse

# Read and clean the CSV data
df = pd.read_csv("dataset.csv")

# Clean the data
df = df.dropna(subset=['order_id'])
df['order_id'] = df['order_id'].astype(int)
df = df[df['product_id'] != 0]
df['amount'] = df['amount'].apply(lambda x: min(x, 1500))
df = df.dropna(subset=['status'])
df = df.drop_duplicates()

# Print cleaned data for verification
print(df.head())
print(df.describe(include='all'))

DATABASE_TYPE = 'postgresql'
DATABASE = 'task6'
DBAPI = 'psycopg2'
HOST = 'localhost'
USER = 'postgres'
PORT = '5432'
PASSWORD = 'Somaya050'


encoded_password = urllib.parse.quote_plus(PASSWORD)

# Create the database engine
engine = create_engine(f'{DATABASE_TYPE}+{DBAPI}://{USER}:{encoded_password}@{HOST}:{PORT}/{DATABASE}')

# Save the cleaned data to PostgreSQL
df.to_sql('New_DataSet', engine, if_exists='replace', index=False)

print("Data is cleaned and transformed and is saved in PostgreSQL.")


