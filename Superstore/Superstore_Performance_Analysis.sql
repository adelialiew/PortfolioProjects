/*
==================================================================================
Superstore Performance Analysis
----------------------------------------------------------------------------------
Objective: Analyze core performance KPIs across Segment, Region, and Category
to identify profit drivers and potential drains in the business.
==================================================================================
*/

-- ==========================================
-- BASE TABLE 
-- ==========================================
WITH BASE_QUERY AS (
    SELECT 
        ORDER_ID,
        CUSTOMER_ID,
        SEGMENT,
        REGION,
        CATEGORY,
        SUB_CATEGORY,
        ORDER_DATE,
        SHIP_DATE,
        SALES,
        QUANTITY,
        DISCOUNT,
        PROFIT
    FROM SUPERSTORE
),

-- ==========================================
-- AGGREGATE PERFORMANCE BY GROUP
-- ==========================================
AGG_SUMMARY AS (
    SELECT
        SEGMENT,
        REGION,
        CATEGORY,

        -- KPIS
        COUNT(DISTINCT ORDER_ID) AS TOTAL_ORDERS,
        SUM(SALES) AS TOTAL_SALES,
        SUM(QUANTITY) AS TOTAL_UNITS,
        SUM(PROFIT) AS TOTAL_PROFIT,
        ROUND(AVG(DISCOUNT), 2) AS AVG_DISCOUNT,
        ROUND(SUM(PROFIT) / NULLIF(SUM(SALES), 0), 2) AS PROFIT_MARGIN,

        -- PROFITABILITY SEGMENTATION
        CASE 
            WHEN ROUND(SUM(PROFIT) / NULLIF(SUM(SALES), 0), 2) > 0 THEN 'PROFITABLE'
            ELSE 'UNPROFITABLE'
        END AS PROFITABILITY_SEGMENT
    FROM BASE_QUERY
    GROUP BY 
        SEGMENT,
        REGION,
        CATEGORY
)

-- ==========================================
-- FINAL OUTPUT: PERFORMANCE SUMMARY TABLE
-- ==========================================
SELECT *
FROM AGG_SUMMARY
ORDER BY PROFITABILITY_SEGMENT DESC, PROFIT_MARGIN DESC;
