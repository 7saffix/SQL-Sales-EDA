/*
Part-to-Whole Analysis

Purpose:
    - To find the proportion of each part relative to the whole.
    - To see which categories contribute the most to overall sales.

SQL Functions Used:
    - SUM(): Aggregates values per category.
    - Window Functions: SUM() OVER() for the overall total.

*/

-- Which categories contribute the most to overall sales?
WITH category_sales AS (
    SELECT
        p.category,
        SUM(s.sales_amount) AS total_sales
    FROM sales s
    JOIN products p
        ON p.product_key = s.product_key
    GROUP BY p.category
)
SELECT
    category,
    total_sales,
    SUM(total_sales) OVER()   AS overall_sales,

    ROUND(100 * (total_sales / SUM(total_sales) OVER()),2) AS percentage_of_total
FROM category_sales
ORDER BY total_sales DESC;


-- Which country contribute the most to overall sales?

WITH country_sales AS (
    SELECT 
        c.country, 
        SUM(s.sales_amount) AS total_sales
    FROM sales s
    JOIN customers c ON c.customer_key = s.customer_key
    GROUP BY c.country
)
SELECT 
    country, 
    total_sales, 
    SUM(total_sales) OVER() AS overall_sales, 
    ROUND(100 * (total_sales / NULLIF(SUM(total_sales) OVER(), 0)), 2) AS percentage_of_total
FROM country_sales
ORDER BY total_sales DESC;
