/*
Question 1: Total Orders Per Customer

Write a query to display the total number of orders placed by each customer, 
along with their name and the date they joined. Sort the results by the total number of orders in descending order.
*/



/*
Question 2: Rank Customers by Spending

For each customer, calculate their total spending (sum of the total amounts from the `Orders` table) 
and rank them by total spending within their respective country. 
Use a **window function** to rank the customers.
*/



SELECT c.customer_id, 
c.customer_name, 
c.join_date, 
COUNT(o.order_id) AS total 
FROM Customers c
LEFT JOIN Orders o ON c.customer_id=o.customer_id
GROUP BY c.customer_id, c.customer_name 
ORDER BY total DESC; 


SELECT c.customer_name,
c.country,
SUM(oi.quantity*oi.price) AS total, 
RANK() OVER(PARTITION BY c.country ORDER BY (SUM(oi.quantity*oi.price)) DESC) AS ranks
FROM Customers c 
JOIN Orders o ON c.customer_id=o.customer_id
JOIN OrderItems oi ON oi.order_id=o.order_id
GROUP BY c.country, c.customer_name
ORDER BY c.country, ranks;
