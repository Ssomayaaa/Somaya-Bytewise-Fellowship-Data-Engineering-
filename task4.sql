
/*Write a query to calculate the percentage contribution of each item's amount to its order's total amount, grouped by order_id*/

select item_id, 
    order_id, 
    product_id, 
    amount,(amount / SUM(amount) over (PARTITION BY order_id)) * 100 AS percentage_contribution
from items;

/*Write a query to rank orders by their total amount within each customer, ordering them from highest to lowest total amount*/

select order_id, 
    customer_id, 
    total_amount,
    RANK() over (PARTITION BY customer_id order by total_amount DESC) AS order_rank
from orders;

/*Write a query to calculate the average price of products supplied by each supplier. Exclude suppliers who have no products in the result*/

select s.supplier_id,
    AVG(p.price) AS average_price
from suppliers s JOIN products p ON s.supplier_id = p.supplier_id
group by s.supplier_id
HAVING COUNT(p.product_id) > 0;

/*Write a query to count the number of products in each category. Include categories with zero products in the result set*/

select c.category_id,
    c.name,
COUNT(p.product_id) AS product_count from categories c LEFT JOIN 
products p ON c.category_id = category_id
group by c.category_id, c.name;

/*Write a query to retrieve the total amount spent by each customer, along with their name and phone number. Ensure customers with no orders also appear with a total amount of 0*/

select c.name,
    c.phone,
COALESCE(SUM(o.total_amount), 0) AS total_amount_spent from customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id group by c.customer_id, c.name, c.phone
ORDER BY total_amount_spent DESC;


