-- 1. Categorize monthly row performance using conditional logic (CASE)
SELECT 
    month,
    region,
    category,
    sales_usd,
    CASE 
        WHEN sales_usd >= 350000 THEN 'High Performer'
        WHEN sales_usd BETWEEN 200000 AND 349999 THEN 'Average Performer'
        ELSE 'Low Performer'
    END AS performance_tier
FROM regional_sales;

-- 2. Calculate Month-over-Month (MoM) revenue growth across the company
WITH monthly_summary AS (
    SELECT 
        month,
        SUM(sales_usd) AS current_month_sales
    FROM regional_sales
    GROUP BY month
)
SELECT 
    month,
    current_month_sales,
    LAG(current_month_sales) OVER (ORDER BY month) AS previous_month_sales,
    ROUND(
        (current_month_sales - LAG(current_month_sales) OVER (ORDER BY month))
        / NULLIF(LAG(current_month_sales) OVER (ORDER BY month), 0) * 100, 
        2
    ) AS mom_growth_pct
FROM monthly_summary
ORDER BY month ASC;

-- 3. Rank categories within each region by total sales volume
WITH regional_category_sales AS (
    SELECT 
        region,
        category,
        SUM(sales_usd) AS category_revenue
    FROM regional_sales
    GROUP BY region, category
)
SELECT 
    region,
    category,
    category_revenue,
    DENSE_RANK() OVER (
        PARTITION BY region 
        ORDER BY category_revenue DESC
    ) AS category_rank_in_region
FROM regional_category_sales
ORDER BY region, category_rank_in_region;
