/*
Performance Analysis (Year-over-Year, Month-over-Month)

Purpose:
    - To measure the performance of products, customers, or regions over time.
    - For benchmarking and identifying high-performing entities.
    - To track yearly trends and growth.

SQL Functions Used:
    - LAG(): Accesses data from previous rows.
    - CASE: Defines conditional logic for trend analysis.
*/

/* Analyze the yearly performance of products by comparing their sales
to the previous year's sales */

WITH yearly_product_sales AS(SELECT
p.product_key,p.product_name,p.category,
EXTRACT(YEAR FROM s.order_date) as sales_year,
SUM(s.sales_amount) as current_sales
FROM sales s
JOIN products p
ON s.product_key = p.product_key
WHERE order_date IS NOT NUll
GROUP BY p.product_key,p.product_name,p.category,EXTRACT(YEAR FROM s.order_date))

SELECT 
product_key,product_name,sales_year,current_sales,
LAG(current_sales) OVER(PARTITION BY product_key ORDER BY sales_year) as prev_year_sales,

(100 * (current_sales - LAG(current_sales) OVER(PARTITION BY product_key ORDER BY sales_year))/
NULLIF(LAG(current_sales) OVER(PARTITION BY product_key ORDER BY sales_year),0))
as YOY_growth,
CASE 
    WHEN LAG(current_sales) OVER(PARTITION BY product_key ORDER BY sales_year) IS NULL THEN 'No Previous Data'

    WHEN current_sales - LAG(current_sales) OVER(PARTITION BY product_key ORDER BY sales_year) > 0 THEN 'Increase'

    WHEN current_sales - LAG(current_sales) OVER(PARTITION BY product_key ORDER BY sales_year) < 0 THEN 'Decrease'

    ELSE 'No Change' 
END as growth_flag

FROM yearly_product_sales
ORDER BY product_name,sales_year;


--High performing product (Top 10)
WITH product_sales AS(SELECT
p.product_key,p.product_name,p.category,
SUM(s.sales_amount) as total_sales
FROM sales s
JOIN products p
ON s.product_key = p.product_key
WHERE order_date IS NOT NUll
GROUP BY p.product_key,p.product_name,p.category)
SELECT * FROM product_sales
ORDER BY total_sales DESC
LIMIT 10

--Low performing product
WITH product_sales AS(SELECT
p.product_key,p.product_name,p.category,
SUM(s.sales_amount) as total_sales
FROM sales s
JOIN products p
ON s.product_key = p.product_key
WHERE order_date IS NOT NUll
GROUP BY p.product_key,p.product_name,p.category)
SELECT * FROM product_sales
ORDER BY total_sales
LIMIT 10

--revenue ranking of every product
WITH product_revenue AS (
    SELECT
        p.product_key,
        p.product_name,
        p.category,
        SUM(s.sales_amount) AS total_revenue
    FROM sales s
    JOIN products p
        ON s.product_key = p.product_key
    GROUP BY
        p.product_key,
        p.product_name,
        p.category
)
SELECT
    product_key,
    product_name,
    category,
    total_revenue,
    DENSE_RANK() OVER (
        ORDER BY total_revenue DESC
    ) AS product_rank
FROM product_revenue
ORDER BY product_rank;

/* Analyze the yearly performance of Category by comparing their sales
to the previous year's sales */

WITH yearly_category_sales AS(SELECT
p.category,
EXTRACT(YEAR FROM s.order_date) as sales_year,
SUM(s.sales_amount) as current_sales
FROM sales s
JOIN products p
ON s.product_key = p.product_key
WHERE order_date IS NOT NUll
GROUP BY p.category,EXTRACT(YEAR FROM s.order_date))
SELECT 
category,sales_year,current_sales,
(100 * (current_sales - lag(current_sales) over(partition by category order by sales_year)) /
lag(current_sales) over(partition by category order by sales_year)) as growth_rate
FROM yearly_category_sales
ORDER BY category,sales_year;
