/*
==================================================================================
Customer Analysis
----------------------------------------------------------------------------------
This analysis aims to understand customer value and profitability over time, grouped 
by Segment and Category, to identify high-value customers, loyalty trends, and 
profitability patterns.
==================================================================================
*/

-- ==========================================
-- CUSTOMER PROFITABILITY & ENGAGEMENT METRICS
-- ==========================================
SELECT 
    CUSTOMER_ID, 
    SEGMENT, 
    CATEGORY,

    -- TIME-BASED BEHAVIOR
    MIN(ORDER_DATE) AS FIRST_ORDER,
    MAX(ORDER_DATE) AS LAST_ORDER,
    DATEDIFF(MONTH, MIN(ORDER_DATE), MAX(ORDER_DATE)) AS LIFESPAN,

    -- ORDER & VALUE METRICS
    COUNT(ORDER_ID) AS TOTAL_ORDERS,
    SUM(SALES) AS TOTAL_SALES,
    ROUND(AVG(SALES), 2) AS AVG_ORDER_VALUE,
    ROUND(SUM(PROFIT), 2) AS TOTAL_PROFIT,

    -- MONTHLY SPENDING BEHAVIOR
    CASE 
        WHEN DATEDIFF(MONTH, MIN(ORDER_DATE), MAX(ORDER_DATE)) = 0 
            THEN ROUND(SUM(SALES), 2)
        ELSE ROUND(SUM(SALES) * 1.0 / DATEDIFF(MONTH, MIN(ORDER_DATE), MAX(ORDER_DATE)), 2)
    END AS AVG_MONTHLY_SPEND,

    -- PROFITABILITY CLASSIFICATION
    CASE 
        WHEN SUM(PROFIT) > 0 THEN 'PROFITABLE'
        WHEN SUM(PROFIT) < 0 THEN 'UNPROFITABLE'
        ELSE 'BREAK-EVEN'
    END AS PROFITABILITY_STATUS

FROM SUPERSTORE
GROUP BY 
    CUSTOMER_ID, 
    SEGMENT, 
    CATEGORY

ORDER BY TOTAL_PROFIT;
