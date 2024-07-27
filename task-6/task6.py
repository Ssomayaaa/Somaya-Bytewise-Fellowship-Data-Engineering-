import pandas as pd
import psycopg2
from psycopg2 import sql

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

conn = None
try:
    # Connect to the PostgreSQL server
    print('Connecting to the PostgreSQL database...')
    conn = psycopg2.connect(
        host='localhost',
        dbname='task6',
        user='postgres',
        password='Somaya050',
        port=5432
    )
    cur = conn.cursor()
    print('Connected to the PostgreSQL database')

    # Create table 
    create_table_query = '''
    CREATE TABLE clean_dataset (
        order_id INTEGER,
        product_id INTEGER,
        amount FLOAT,
        status VARCHAR(255)
    );
    '''
    cur.execute(create_table_query)

    # Insert cleaned data into the table
    for _, row in df.iterrows():
        insert_query = sql.SQL('''
            INSERT INTO clean_dataset (order_id, product_id, amount, status)
            VALUES (%s, %s, %s, %s)
        ''')
        cur.execute(insert_query, (row['order_id'], row['product_id'], row['amount'], row['status']))

    # Commit the transaction
    conn.commit()

    # Verify the inserted data
    cur.execute('SELECT * FROM clean_dataset LIMIT 5')
    print(cur.fetchall())

    # Close the cursor and connection
    cur.close()

except Exception as error:
    print(error)
finally:
    if conn is not None:
        conn.close()
        print('Database connection closed.')
