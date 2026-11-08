/*

REPORT CREATION FOR CUSTOMER AND PRODUCT


Customer Report
Purpose:
    - This report consolidates key customer metrics and behaviors

Highlights:
    1. Gathers essential fields such as names, ages, and transaction details.
    2. Segments customers into categories (VIP, Regular, New) and age groups.
    3. Aggregates customer-level metrics:
       - total orders
       - total sales
       - total quantity purchased
       - total products
       - lifespan (in months)
    4. Calculates valuable KPIs:
        - recency (months since last order)
        - average order value
        - average monthly spend



Product Report
Purpose:
    - This report consolidates key product metrics and behaviors.

Highlights:
    1. Gathers essential fields such as product name, category, subcategory, and cost.
    2. Segments products by revenue to identify High-Performers, Mid-Range, or Low-Performers.
    3. Aggregates product-level metrics:
       - total orders
       - total sales
       - total quantity sold
       - lifespan (in months)
    4. Calculates valuable KPIs:
       - recency (months since last sale)
       - average order revenue (AOR)
       - average monthly revenue

*/





-- Create Report: customers

CREATE VIEW customers_report AS
WITH customer_segment AS ( 
    -- 1) Base Query: Retrieves core columns from source tables
    SELECT 
        s.order_number,
        s.product_key,
        s.order_date,
        s.sales_amount,
        s.quantity,
        c.customer_key,
        CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
        EXTRACT(YEAR FROM AGE(c.birthdate)) AS age,
        c.country,
        c.gender
    FROM sales s 
    JOIN customers c ON s.customer_key = c.customer_key
    WHERE s.order_date IS NOT NULL
),
customer_aggregations AS (
    -- 2) Customer Aggregations: Summarizes metrics at the customer level
    SELECT 
        customer_key,
        customer_name,
        age,
        COUNT(DISTINCT order_number) AS total_orders,
        SUM(sales_amount) AS total_sales,
        SUM(quantity) AS total_quantity,
        COUNT(DISTINCT product_key) AS total_product,
        MAX(order_date) AS last_order_date,
        (EXTRACT(YEAR FROM AGE(MAX(order_date), MIN(order_date))) * 12) + 
         EXTRACT(MONTH FROM AGE(MAX(order_date), MIN(order_date))) AS lifespan
    FROM customer_segment
    GROUP BY customer_key, customer_name, age
)
-- 3) Final Select: Computes Conditional Segments and KPIs 
SELECT 
    customer_key,
    customer_name,
    age,
        CASE 
        WHEN age IS NULL THEN 'n/a'
        WHEN age < 20 THEN 'Below 20'
        WHEN age BETWEEN 20 AND 29 THEN '20-29'
        WHEN age BETWEEN 30 AND 39 THEN '30-39'
        WHEN age BETWEEN 40 AND 49 THEN '40-49'
        ELSE 'Above 50'
    END AS age_range,

    CASE 
        WHEN lifespan >= 12 AND total_sales >= 5000 THEN 'VIP'
        WHEN lifespan >= 12 AND total_sales < 5000  THEN 'Regular'
        ELSE 'New'
    END AS customer_type,
    total_orders,
    total_sales,
    total_quantity,
    total_product,
    last_order_date,
    lifespan,
    CASE 
        WHEN total_orders = 0 THEN 0  
        ELSE total_sales /  total_orders
    END avg_order_value ,
     CASE 
        WHEN lifespan = 0 THEN total_sales  
        ELSE ROUND(total_sales /  lifespan)
    END avg_monthly_spend

FROM customer_aggregations;


SELECT * FROM customers_report;




-- Create Report : Products

CREATE VIEW products_report AS
-- 1) Base Query: Retrieves core columns from fact_sales and dim_products
WITH base_query AS(
SELECT 
s.order_number,
s.order_date,
s.sales_amount,
s.quantity,
p.product_key,
p.product_name,
p.category,
p.cost
FROM sales s
JOIN products p
ON s.product_key = p.product_key
WHERE order_date IS NOT NULL),
--2) Product Aggregations: Summarizes key metrics at the product level
product_aggregate AS(
SELECT 
product_key,
product_name,
category,
cost,
MAX(order_date) AS last_sale_date,
EXTRACT(YEAR FROM AGE(MAX(order_date),MIN(order_date))) * 12 + EXTRACT(MONTH FROM AGE(MAX(order_date),MIN(order_date))) AS lifespan,
COUNT(DISTINCT order_number) as total_order,
SUM(sales_amount) AS total_sales,
SUM(quantity) AS total_quantity,
ROUND(AVG(sales_amount),2) AS avg_selling_price
FROM base_query
GROUP BY product_key,product_name,category,cost)
--3) Final Query: Combines all product results into one output
SELECT
product_key,
product_name,
category,
cost,
last_sale_date,
lifespan,
CASE 
    WHEN total_sales >=50000 THEN 'High Performer'  
    WHEN total_sales >=10000 THEN 'Mid Range'  
    ELSE 'Low Range'
END AS product_performance,
total_order,
total_sales,
total_quantity,
avg_selling_price,
--avg order revenue
CASE 
    WHEN total_order = 0 THEN 0  
    ELSE  total_sales / total_order
END AS avg_order_revenue,
--avg monthly revenue
CASE 
    WHEN lifespan = 0 THEN total_sales
    ELSE  ROUND(total_sales / lifespan)
END AS avg_monthly_revenue
FROM product_aggregate;


SELECT * FROM products_report;