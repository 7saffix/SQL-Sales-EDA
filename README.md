# Sales Performance Analysis & Business Reporting

Project Overview

This project focuses on analyzing sales data to evaluate business performance, understand customer purchasing behavior, and identify product and revenue trends.

Using sales, customer, and product datasets, the project follows an end-to-end analytical workflow, including data exploration, SQL-based analysis, business reporting, and interactive dashboard development.

PostgreSQL is used to perform the data analysis and generate customer and product reporting views. The project will also incorporate a Power BI or Excel dashboard to present key performance indicators, trends, and business insights in an interactive and accessible format.

The objective is to turn raw business data into meaningful insights that can help stakeholders understand performance and make informed decisions.

## Business Objectives

- Explore and understand the structure of a relational sales database.
- Analyze overall sales performance and trends over time.
- Identify top-performing products and product categories.
- Evaluate product performance across different years.
- Understand customer purchasing behavior and segment customers.
- Analyze the contribution of different product categories and countries to total revenue.
- Create reusable customer and product reporting views with business KPIs.

## Dataset Overview

The project uses three datasets:

| Dataset | Description |
|---|---|
| `sales` | Transaction-level information, including order dates, customers, products, quantities, and sales amounts. |
| `customers` | Customer information, including names, country, gender, and birthdate. |
| `products` | Product information, including product names, categories, subcategories, and costs. |

### Dataset Statistics

| Metric | Value |
|---|---:|
| Total sales records | 60,398 |
| Unique customers | 18,484 |
| Unique products | 295 |
| Countries represented | 6 |
| Total recorded sales | 29,356,250 |
| Sales date range | December 29, 2010 – January 28, 2014 |

## Tools & Technologies

- **Database:** PostgreSQL
- **Query Language:** SQL
- **Version Control:** Git & GitHub


## Key Analysis Performed

### 1. Sales Trend Analysis
- Analyzed sales performance across yearly, quarterly, and monthly periods.
- Used `EXTRACT()` and `DATE_TRUNC()` to aggregate sales over time.
- Applied `LAG()` to compare sales with previous periods and calculate year-over-year growth.

### 2. Cumulative Sales Analysis
- Calculated running total sales using window functions.
- Examined how sales accumulated over time.

### 3. Product & Category Performance
- Compared product sales across different years.
- Identified high-performing and low-performing products based on revenue.
- Used `LAG()` to evaluate year-over-year product and category performance.
- Applied `DENSE_RANK()` to rank products based on revenue.

### 4. Part-to-Whole Analysis
- Calculated the percentage contribution of each product category to total sales.
- Evaluated the contribution of different countries to overall sales.
- Used window functions to calculate revenue distribution.

### 5. Customer & Product Segmentation
- Grouped customers based on purchasing behavior, total sales, and customer lifespan.
- Classified customers into VIP, Regular, and New segments using defined business rules.
- Categorized products into High Performer, Mid Range, and Low Range based on revenue thresholds.

## Key Findings

The analysis of 60,398 sales records revealed several business patterns:

- **Overall Sales:** Total recorded sales amounted to 29.36 million across the analyzed period.
- **Annual Performance:** 2013 generated the highest annual sales, reaching 16.34 million.
- **Category Contribution:** Bikes accounted for 96.46% of total sales, indicating a strong concentration of revenue within this category.
- **Top-Performing Product:** Mountain-200 Black-46 generated 1.37 million in sales, contributing approximately 4.68% of total revenue.
- **Customer Distribution:** The USA represented 31.21% of the customer base, making it the largest customer market among the six countries analyzed.


## Customer & Product Reporting

To consolidate the analysis into reusable reporting outputs, I created two SQL views.

### Customer Report — `customers_report`

Provides a customer-level overview with:

- Customer name and age
- Age group classification
- Customer segmentation (VIP, Regular, New)
- Total orders
- Total sales
- Total quantity purchased
- Number of distinct products purchased
- Customer lifespan in months
- Last order date
- Average order value
- Average monthly spend

### Product Report — `products_report`

Provides a product-level overview with:

- Product name, category, and cost
- Product performance classification
- Total orders
- Total sales
- Total quantity sold
- Product lifespan in months
- Last sale date
- Average selling price
- Average order revenue
- Average monthly revenue

These views provide structured datasets for further business analysis and reporting.

## Project Outcome

This project provided practical experience in applying PostgreSQL to business-oriented data analysis. It demonstrates the ability to explore relational datasets, analyze sales trends, evaluate product and customer performance, apply segmentation techniques, and create reusable reporting views.

The resulting analysis provides a foundation for understanding business performance and supporting data-driven decisions.


## Project Status

**In Progress**

The SQL-based sales analysis and reporting phase has been completed. Future development will focus on building an interactive dashboard using Power BI or Excel to visualize key performance indicators, sales trends, customer behavior, and product performance.

The project will be further enhanced with visual insights and business recommendations to provide a more complete view of sales performance and support data-driven decision-making.

## Author

**Shah Aziz Chowdhury Safi**
