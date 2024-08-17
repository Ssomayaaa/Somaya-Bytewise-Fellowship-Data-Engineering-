# Data Processing with PySpark
This project demonstrates how to use PySpark for data processing on a given dataset. 
The project involves several steps, including data loading, filtering, transformation, and saving the processed data to a file.
## Data Cleaning Requirements

### order_date (timestamp)
- **Modify**: Remove orders placed between 12 am and 5 am (inclusive); convert from timestamp to date.

### time_of_day (string)
- **New Column**: Contains (lower bound inclusive, upper bound exclusive):
  - `"morning"`: for orders placed between 5 am and 12 pm.
  - `"afternoon"`: for orders placed between 12 pm and 6 pm.
  - `"evening"`: for orders placed between 6 pm and 12 am.

### product (string)
- **Remove**: Rows containing "TV" as the company has stopped selling this product.
- **Ensure**: All values are lowercase.

### category (string)
- **Ensure**: All values are lowercase.

### purchase_state (string)
- **New Column**: Contains the state from which the purchase was made.
