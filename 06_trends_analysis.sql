/*

Change Over Time Analysis(Trends)
Purpose:
    - To track trends, growth, and changes in key metrics over time.
    - For time-series analysis and identifying seasonality.
    - To measure growth or decline over specific periods.

SQL Functions Used:
    - Aggregate Functions: SUM(), COUNT(), AVG()
===============================================================================
*/

-- Analyse sales performance over time
-- Yearly sales analysis
SELECT 
EXTRACT(YEAR FROM order_date) as revenue_year,
SUM(sales_amount) AS total_sales,
COUNT(DISTINCT customer_key) AS total_customer,
SUM(quantity) AS total_quantity_sold
from sales
WHERE order_date is NOT NULL
GROUP BY EXTRACT(YEAR FROM order_date)
ORDER BY EXTRACT(YEAR FROM order_date);



--Monthly sales analysis
SELECT 
date_trunc('month',order_date)::date as sales_month,
SUM(sales_amount) AS total_sales,
COUNT(DISTINCT customer_key) AS total_customer,
SUM(quantity) AS total_quantity_sold
from sales
WHERE order_date is NOT NULL
GROUP BY date_trunc('month',order_date)
ORDER BY sales_month;


--Quarterly sales analysis
SELECT
    DATE_TRUNC('quarter', order_date)::date AS sales_quarter,
    SUM(sales_amount) AS total_sales,
    COUNT(DISTINCT customer_key) AS total_customers,
    SUM(quantity) AS total_quantity_sold
FROM sales
WHERE order_date IS NOT NULL
GROUP BY DATE_TRUNC('quarter', order_date)
ORDER BY sales_quarter;


--Year-over-Year (YoY) sales growth — how much sales increased or decreased compared with the previous year.
WITH yearly_sales AS (
    SELECT
        EXTRACT(YEAR FROM order_date)::int AS sales_year,
        SUM(sales_amount) AS total_sales
    FROM sales
    WHERE order_date IS NOT NULL
    GROUP BY EXTRACT(YEAR FROM order_date)
)
SELECT
    sales_year,
    total_sales,
    LAG(total_sales) OVER (ORDER BY sales_year) AS previous_year_sales,
    ROUND(
        100.0 * (total_sales - LAG(total_sales) OVER (ORDER BY sales_year))
        / NULLIF(LAG(total_sales) OVER (ORDER BY sales_year), 0),
        2
    ) :: text || '%' AS yoy_growth_percentage
FROM yearly_sales
ORDER BY sales_year;


--running total sales over time
SELECT sales_year,
total_sales,
SUM(total_sales) OVER(ORDER BY sales_year) AS running_sales
FROM 
(SELECT 
EXTRACT(YEAR FROM order_date) AS sales_year,
SUM(sales_amount) AS total_sales
FROM sales
WHERE order_date IS NOT NULL
GROUP BY EXTRACT(YEAR FROM order_date))
ORDER BY sales_year;

/*
Cumulative Analysis

Purpose:
    - To calculate running totals or moving averages for key metrics.
    - To track performance over time cumulatively.
    - Useful for growth analysis or identifying long-term trends.

SQL Functions Used:
    - Window Functions: SUM() OVER(), AVG() OVER()

*/

--running total sales over time
SELECT sales_year,
total_sales,
SUM(total_sales) OVER(ORDER BY sales_year) AS running_sales
FROM 
(SELECT 
EXTRACT(YEAR FROM order_date) AS sales_year,
SUM(sales_amount) AS total_sales,
AVG(price)      AS avg_price
FROM sales
WHERE order_date IS NOT NULL
GROUP BY EXTRACT(YEAR FROM order_date))
ORDER BY sales_year;


