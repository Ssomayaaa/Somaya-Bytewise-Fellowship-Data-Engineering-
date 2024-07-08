create table cities ( city_id UUID primary key,
    name varchar(255),
    province varchar(255),
    country varchar(255),
    status varchar(50) check (status in('Active', 'Inactive') )
);
create table categories ( category_id UUID primary key,
    name varchar(255),
    status varchar(50) CHECK (status IN ('Active', 'Inactive')),
    description text
);
create table customers ( customer_id UUID primary key,
	name varchar(255),
	phone varchar(50),
	location varchar(255),
	status varchar(50) check(status in('Active', 'Inactive', 'Blocklisted'))
);

create table items (
    item_id UUID primary key,
    order_id UUID,
    product_id UUID,
    amount decimal(10, 2),
    status varchar(50) check (status in ('Pending', 'Shipped', 'Delivered')),
    item_timestamp timestamp
);

create table orders (
    order_id UUID primary key,
    customer_id UUID,
    status varchar(50) check (status in ('Pending', 'Completed', 'Cancelled')),
    order_timestamp timestamp,
    total_amount decimal(10, 2)
);



create table products (
    product_id UUID primary key,  
    name varchar(255) , 
	supplier_id UUID,
	category varchar(50) ,
  price decimal(10,2) ,   
  stock_available INT ,    
  status varchar(50) check (status in ('Active', 'Inactive', 'Out of Stock')),
	product_createtimestamp timestamp
);

create table suppliers ( supplier_id UUID primary key,
	name varchar(255),
	phone varchar(255),
	location varchar(255),
	status varchar(50) check(status in('Active', 'Inactive', 'Blocklisted')),
	category varchar(50)
);

/*Write a query to fetch all customer names and sort them alphabetically*/
select name from customers order by name ASC;

/*Write a query to fetch all product names and their prices, sorted by price from low to high*/
select product_id, price from products order by price ASC;

/*Write a query to fetch supplier names that start with the letter 'A' and sort them by their names*/
select name from suppliers where name like 'A%' order by name ASC;

/*Write a query to fetch all items and sort them by their status, placing NULL values first*/
select * from items order by status is null, status ASC;

/*Write a query to fetch all products, sort them first by category and then by price in descending order*/
select * from products order by category, price DESC;

/*Write a query to fetch all customer names and phone numbers, but sort them by the last four digits of their phone numbers in ascending order*/
select name, phone from customers order by substring(phone from length(phone) - 3 for 4);


