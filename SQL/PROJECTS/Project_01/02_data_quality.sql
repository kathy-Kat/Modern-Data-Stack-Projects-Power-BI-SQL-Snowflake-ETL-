-- 1. Check for missing (NULL) values in essential columns
SELECT 
    COUNT(*) - COUNT(month) AS null_months,
    COUNT(*) - COUNT(region) AS null_regions,
    COUNT(*) - COUNT(category) AS null_categories,
    COUNT(*) - COUNT(sales_usd) AS null_sales,
    COUNT(*) - COUNT(csat_score) AS null_csat
FROM regional_sales;

-- 2. Detect invalid or suspicious business values (negative numbers or zero sales)
SELECT * 
FROM regional_sales 
WHERE sales_usd <= 0 
   OR cost_usd <= 0 
   OR units_sold <= 0;

-- 3. Verify CSAT scores stay within the standard range (1.0 to 5.0)
SELECT * 
FROM regional_sales 
WHERE csat_score < 1.0 
   OR csat_score > 5.0;

-- 4. Check for potential duplicate entries (same month, region, and category)
SELECT 
    month, 
    region, 
    category, 
    COUNT(*) AS match_count
FROM regional_sales
GROUP BY month, region, category
HAVING COUNT(*) > 1;
