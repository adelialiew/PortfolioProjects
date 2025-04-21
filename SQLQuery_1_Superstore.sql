/*select *
FROM Superstore

SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Superstore';


-- To convert the dates: 
ALTER TABLE Superstore
ALTER COLUMN Order_Date DATE
ALTER COLUMN Ship_Date DATE;

*/


WITH base_query AS (
SELECT 
    Order_ID,
    Customer_ID,
    Segment,
    Region,
    Category,
    Sub_Category,
    Sales,
    Quantity,
    Discount,
    Profit,
    Order_Date,
    Ship_Date
FROM Superstore
),

-- 2)Aggregate: Basic KPIs By Segment + Region + Category
--  analyze money-makers vs. money-drainers.

agg_summary as(
SELECT
    Segment,
    Region,
    Category,

    -- Total Metrics
    COUNT(DISTINCT Order_ID) as total_orders,
    SUM(Sales) as total_sales,
    SUM(Quantity) as total_units,
    SUM(Profit) as total_profit,

    -- Calculations
    ROUND(SUM(Sales) / SUM(Quantity),2) AS Avg_Price_Per_Unit,
    ROUND(AVG(Profit),2) as Avg_profit,
    ROUND(AVG(Discount),2) as Avg_discount,
    --ROUND(SUM(Discount) / NULLIF(SUM(Sales), 0), 2) AS Discount_To_Sales_Ratio,
    --Profit per dollar, should i add percentage?
    
    ROUND(SUM(Profit)/NULLIF(SUM(Sales), 0), 2) as Profit_margin,

    -- Customer Profit Segmentation
    CASE 
        WHEN ROUND(SUM(Profit)/NULLIF(SUM(Sales), 0), 2) > 0 THEN 'Profitable'
        ELSE 'Unprofitable'
    END Profit_segment
FROM base_query
GROUP BY 
    Segment,
    Region,
    Category
),


quartiles AS (
    SELECT *,
        --Part to whole
        ROUND((CAST(total_sales AS FLOAT)/SUM(total_sales)over()) * 100,2) as perecentage_of_total,

        -- Rank quartiles, higher is better
        NTILE(4) OVER (ORDER BY profit_margin) AS rank_profit_margin,
        NTILE(4) OVER (ORDER BY avg_profit) AS rank_avg_profit,
        NTILE(4) OVER (ORDER BY avg_price_per_unit) AS rank_price,
        
        -- Lower discount is better, so we reverse the ranking
        NTILE(4) OVER (ORDER BY avg_discount DESC) AS rank_discount

    FROM agg_summary
),

final_scored AS (
    SELECT *,
        -- Adjust weights here (they must add up to 1)
        (rank_profit_margin * 0.4) +
        (rank_avg_profit * 0.3) +
        (rank_price * 0.15) +
        (rank_discount * 0.15) AS market_fit_score
    FROM quartiles
)

SELECT *
FROM final_scored
ORDER BY Profit_segment,market_fit_score DESC;