create Type status_enum as ENUM('Cancelled', 'Returned', 'Shipped', 'Pending', 'Delivered');

create table public."DataSet"( item_id UUID PRIMARY KEY,
    order_id INT,
    product_id INT,
    amount NUMERIC(10, 2),
    status status_enum,
    item_timestamp TIMESTAMP,
    location VARCHAR(255),
    customer_name VARCHAR(255),
    customer_phone VARCHAR(50),
    country VARCHAR(100),
    description TEXT)

select * from public."DataSet";

-- can also be directly imported --
copy public."DataSet" from 'C:\Users\hp\Downloads\dataset.csv' DELIMITER ',' CSV HEADER ;