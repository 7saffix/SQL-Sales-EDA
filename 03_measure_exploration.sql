/*
Measures Exploration (Key Metrics)

Purpose:
    - To calculate aggregated metrics (e.g., totals, averages) for quick insights.
    - To identify overall trends or spot anomalies.

SQL Functions Used:
    - COUNT(), SUM(), AVG()
*/


-- Find the Total Sales
SELECT SUM(sales_amount) AS total_revenue FROM sales;

-- Find how many items are sold
SELECT SUM(quantity) AS total_quantity FROM sales;

-- Find the average selling price
SELECT ROUND(AVG(price),2) AS total_revenue FROM sales;

-- Find the Total number of Orders
SELECT count(DISTINCT order_number) FROM sales;

-- Find the total number of products
SELECT count(product_name) FROM products;

-- Find the total number of customers
SELECT count(customer_key) as total_customers FROM customers;

-- Find the total number of customers that has placed an order
SELECT count(DISTINCT customer_key) AS total_active_customer from sales;

-- Generate a Report that shows all key metrics of the business
SELECT 'Total Sales' AS Measure_Name, SUM(sales_amount) AS Measure_Value FROM sales
UNION ALL
SELECT 'Total Quantity Sold' AS Measure_Name, SUM(quantity) AS Measure_Value FROM sales
UNION ALL
SELECT 'Average Price' AS Measure_Name, ROUND(AVG(price),2) AS Measure_Value FROM sales
UNION ALL
SELECT 'Total Order' AS Measure_Name, count(DISTINCT order_number) AS Measure_Value FROM sales
UNION ALL
SELECT 'Total Product' AS Measure_Name, count(product_name) AS Measure_Value FROM products
UNION ALL
SELECT 'Total User' AS Measure_Name, count(customer_key) AS Measure_Value FROM customers
UNION ALL
SELECT 'Total Customer' AS Measure_Name, count(DISTINCT customer_key) AS Measure_Value FROM sales;
