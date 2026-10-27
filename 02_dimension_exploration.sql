/*

Dimensions Exploration

Purpose:
    - To explore the structure of dimension tables.

Date Range Exploration
Purpose:
    - To determine the temporal boundaries of key data points.
    - To understand the range of historical data.    

SQL Functions Used:
    - DISTINCT
    - ORDER BY
    - MIN(), MAX(), AGE()

*/


-- Retrieve a list of unique countries from which customers originate
SELECT DISTINCT country FROM customers;

-- Retrieve a list of unique categories, subcategories, and products
SELECT DISTINCT category,subcategory,product_name FROM products
ORDER BY 1;

-- Determine the first and last order date and the total duration
SELECT 
 MIN(order_date) AS first_order,
 MAX(order_date) AS last_order,
 AGE(MAX(order_date), MIN(order_date)) AS order_range_in_year
FROM sales;