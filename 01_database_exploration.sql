/*
Database Exploration

Purpose:
    - To explore the structure of the database, including the list of tables and their schemas.
    - To inspect the columns for specific tables.
*/


SELECT * FROM information_schema.tables
WHERE table_schema = 'public';


-- Retrieve all columns for a specific table
SELECT * FROM information_schema.columns
WHERE table_name='customers';
SELECT * FROM information_schema.columns
WHERE table_name='product';
SELECT * FROM information_schema.columns
WHERE table_name='sales';



/*
Inspect all table
Purpose: Understand the columns, data types as represented by the results and the information each table contains.
*/
SELECT * FROM customers LIMIT 10;
SELECT * FROM products LIMIT 10;
SELECT * FROM sales LIMIT 10;