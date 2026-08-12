SELECT version();

-- Generate table
SELECT *
FROM regional_sales;

-- Revenue made by each Region
SELECT region, SUM(sales_usd) AS total_sales
FROM regional_sales
GROUP BY region;

-- Revenue made by each category
SELECT category, SUM(sales_usd) AS total_sales
FROM regional_sales
GROUP BY category; 

-- 1. Preview the first 10 rows of the table
SELECT * 
FROM regional_sales 
LIMIT 10;

-- 2. Count total records in the dataset
SELECT COUNT(*) AS total_rows 
FROM regional_sales;

-- 3. List all distinct regions and product categories
SELECT DISTINCT region 
FROM regional_sales 
ORDER BY region;

SELECT DISTINCT category 
FROM regional_sales 
ORDER BY category;

-- 4. Find the date range covered in the dataset
SELECT 
    MIN(month) AS earliest_month, 
    MAX(month) AS latest_month 
FROM regional_sales;
