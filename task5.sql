/*Write a query to retrieve all orders placed by customers, including customer details (name, phone), order details (order ID, timestamp), and item details (product, amount). */

select c.name AS customer_name,
    c.phone AS customer_phone,
    o.order_id,
    o.order_timestamp,
    i.product_id,
    p.name,
    i.amount from customers c JOIN orders o ON c.customer_id = o.customer_id
JOIN items i ON o.order_id = i.order_id JOIN products p ON i.product_id = p.product_id
order by c.customer_id, o.order_timestamp;

/*Write a query to fetch all products along with their suppliers' details (name, phone) and the corresponding category name.*/

select p.product_id,
	p.name AS product_name,
    p.price,
    s.name AS supplier_name,
    s.phone AS supplier_phone,
    c.name AS category_name from products p 
JOIN suppliers s ON p.supplier_id = s.supplier_id JOIN categories c ON p.category::UUID = c.category_id;

/*Write a query to retrieve details of all orders including the product name and amount ordered for each item.*/

select o.order_id,
    o.order_timestamp,
    p.name AS product_name,
    i.amount from orders o JOIN items i ON o.order_id = i.order_id
JOIN products p ON i.product_id = p.product_id;

/*Write a query to retrieve all suppliers along with the city and country where they are located, and the products they supply.*/

select s.name AS supplier_name,
    s.location AS suppliers_location,
    p.name AS product_name from suppliers s
JOIN products p ON s.supplier_id = p.supplier_id;

/*Write a query to fetch details of the most recent order (by timestamp) placed by each customer, including the product details for each item in the order.*/

WITH recent_orders AS (
    select o.customer_id,
        o.order_id,
        o.order_timestamp,
        RANK() OVER (PARTITION BY o.customer_id order by o.order_timestamp DESC) AS order_rank
	from orders o
)
select c.customer_id,
    c.phone AS customer_phone,
    ro.order_id,
    ro.order_timestamp,
    i.product_id,
    i.amount from recent_orders ro JOIN items i ON ro.order_id = i.order_id
	JOIN customers c ON ro.customer_id = c.customer_id
JOIN products p ON i.product_id = p.product_id where ro.order_rank = 1;





