
-- 1. Summarize revenue, cost, profit, and units sold by region
SELECT 
    region,
    SUM(sales_usd) AS total_revenue,
    SUM(cost_usd) AS total_cost,
    SUM(sales_usd - cost_usd) AS total_profit,
    SUM(units_sold) AS total_units
FROM regional_sales
GROUP BY region
ORDER BY total_revenue DESC;

-- 2. Analyze average CSAT score and return rate by category
SELECT 
    category,
    ROUND(AVG(csat_score)::numeric, 2) AS avg_csat,
    ROUND(AVG(return_rate_pct * 100)::numeric, 2) AS avg_return_rate_pct
FROM regional_sales
GROUP BY category
ORDER BY avg_csat DESC;

-- 3. Track overall monthly sales trends over time
SELECT 
    month,
    SUM(sales_usd) AS monthly_revenue,
    SUM(units_sold) AS monthly_units
FROM regional_sales
GROUP BY month
ORDER BY month ASC;

-- 4. Revenue breakdown by primary customer feedback tag
SELECT 
    primary_feedback_tag,
    COUNT(*) AS total_occurrences,
    SUM(sales_usd) AS total_impacted_revenue
FROM regional_sales
GROUP BY primary_feedback_tag
ORDER BY total_occurrences DESC;
