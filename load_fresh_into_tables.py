import snowflake.connector
import requests
from io import StringIO

# Snowflake connection parameters
snowflake_config = {
    "user": "ADOTeam42",
    "password": "ADOTeam42",
    "account": "LNWBDZC-RW87386",
    "warehouse": "ADOWAREHOUSE",
    "database": "RAW",
    "schema": "NWTSchema",
}

# Snowflake table name
table_name = "FRESH_ORDERS_TEST"

# Snowflake connection
conn = snowflake.connector.connect(
    user=snowflake_config["user"],
    password=snowflake_config["password"],
    account=snowflake_config["account"],
    warehouse=snowflake_config["warehouse"],
    database=snowflake_config["database"],
    schema=snowflake_config["schema"],
)

# Snowflake cursor
cursor = conn.cursor()

# Fetch data from the URL
url = 'https://raw.githubusercontent.com/just4jc/Northwind-Traders-Dataset/main/order_fresh.csv'
response = requests.get(url)
data = response.text

# Copy data from CSV string to table
copy_query = f"COPY INTO {table_name} FROM VALUES {data} FILE_FORMAT = (FORMAT_NAME = 'LOAD_FRESH')"
cursor.execute(copy_query)

# Commit the changes
conn.commit()

# Close the cursor and connection
cursor.close()
conn.close()
