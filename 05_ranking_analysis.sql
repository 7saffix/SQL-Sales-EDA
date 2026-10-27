/*

Ranking Analysis

Purpose:
    - To rank items (e.g., products, customers) based on performance or other metrics.
    - To identify top performers or laggards.

SQL Functions Used:
    - Clauses: GROUP BY, ORDER BY

*/

-- Which 5 products Generating the Highest Revenue?
SELECT 
p.product_name,
SUM(s.sales_amount) as product_revenue
FROM sales s
JOIN products p
ON s.product_key = p.product_key
GROUP BY product_name
ORDER BY product_revenue DESC
LIMIT 5;


-- What are the 5 worst-performing products in terms of sales?
SELECT 
p.product_name,
SUM(s.sales_amount) as product_revenue
FROM sales s
JOIN products p
ON s.product_key = p.product_key
GROUP BY product_name
ORDER BY product_revenue
LIMIT 5;

-- Find the top 10 customers who have generated the highest revenue
SELECT 
c.first_name,
c.customer_key,
SUM(s.sales_amount) as revenue_per_customer
FROM sales s
JOIN customers c
ON s.customer_key = c.customer_key
GROUP BY c.first_name,c.customer_key
ORDER BY revenue_per_customer DESC
LIMIT 10;

-- customers with the fewest orders placed
SELECT 
c.first_name,
c.customer_key,
COUNT(DISTINCT order_number) as fewest_orders
FROM sales s
JOIN customers c
ON s.customer_key = c.customer_key
GROUP BY c.first_name,c.customer_key
ORDER BY fewest_orders;


