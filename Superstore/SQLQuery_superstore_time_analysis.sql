/*
==================================================================================
Superstore Yearly Sales Analysis
==================================================================================
This analysis aims to understand sales trends over time in order to uncover key patterns 
and insights. This includes identifying the primary drivers of growth each year, 
pinpointing which segments and categories are experiencing growth or stagnation, 
and determining if there are seasonalpatterns that can be leveraged for 
strategic advantage.
    
Structure:
    - Yearly trends: high-level growth and contribution by Segment + Category
    - Monthly trends: seasonality by Segment
==================================================================================
*/

-- ==========================================
-- YEARLY SALES BASE TABLE
-- ==========================================
WITH YEARLY_SALES AS (
    SELECT
        YEAR(ORDER_DATE) AS ORDER_YEAR,
        SEGMENT,
        CATEGORY,
        SUM(SALES) AS TOTAL_SALES
    FROM SUPERSTORE
    GROUP BY 
        YEAR(ORDER_DATE),
        SEGMENT, 
        CATEGORY
),

-- ==========================================
-- RANKED SALES WITH GROWTH METRICS
-- ==========================================
RANKED_SALES AS (
    SELECT 
        *,
        FIRST_VALUE(TOTAL_SALES) OVER (
            PARTITION BY SEGMENT, CATEGORY 
            ORDER BY ORDER_YEAR
        ) AS FIRST_YEAR_SALES,

        LAST_VALUE(TOTAL_SALES) OVER (
            PARTITION BY SEGMENT, CATEGORY 
            ORDER BY ORDER_YEAR 
            ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
        ) AS LAST_YEAR_SALES,

        MAX(ORDER_YEAR) OVER (PARTITION BY SEGMENT, CATEGORY) - 
        MIN(ORDER_YEAR) OVER (PARTITION BY SEGMENT, CATEGORY) AS NUM_YEARS
    FROM YEARLY_SALES
)

-- ==========================================
-- FINAL OUTPUT: YEARLY SALES TRENDS
-- ==========================================
SELECT
    ORDER_YEAR,
    SEGMENT,
    CATEGORY,
    TOTAL_SALES,

    -- CONTRIBUTION TO THAT YEAR’S TOTAL SALES
    ROUND(
        TOTAL_SALES * 100.0 / 
        SUM(TOTAL_SALES) OVER (PARTITION BY ORDER_YEAR), 2
    ) AS SALES_PCT,

    -- YEAR-OVER-YEAR SALES DIFFERENCE
    TOTAL_SALES - LAG(TOTAL_SALES) OVER (
        PARTITION BY SEGMENT, CATEGORY 
        ORDER BY ORDER_YEAR
    ) AS YOY_SALES_DIFFERENCE,

    -- YOY SALES GROWTH RATE (%)
    ROUND(
        (TOTAL_SALES - LAG(TOTAL_SALES) OVER (PARTITION BY SEGMENT, CATEGORY ORDER BY ORDER_YEAR)) / 
        NULLIF(LAG(TOTAL_SALES) OVER (PARTITION BY SEGMENT, CATEGORY ORDER BY ORDER_YEAR), 0) * 100, 2
    ) AS YOY_SALES_GROWTH_RATE,

    -- TOTAL GROWTH OVER ENTIRE PERIOD
    CASE 
        WHEN FIRST_YEAR_SALES IS NULL THEN NULL
        ELSE ROUND(
            (LAST_YEAR_SALES - FIRST_YEAR_SALES) / NULLIF(FIRST_YEAR_SALES, 0) * 100, 2
        )
    END AS TOTAL_GROWTH_PCT,

    -- COMPOUND ANNUAL GROWTH RATE (CAGR)
    CASE 
        WHEN FIRST_YEAR_SALES IS NULL OR NUM_YEARS = 0 THEN NULL
        ELSE ROUND(
            POWER(LAST_YEAR_SALES / NULLIF(FIRST_YEAR_SALES, 0), 1.0 / NUM_YEARS) - 1, 4
        ) * 100
    END AS CAGR_PCT

FROM RANKED_SALES
ORDER BY ORDER_YEAR, SEGMENT, CATEGORY;


/*
==================================================================================
Superstore Monthly Segment Sales Analysis
----------------------------------------------------------------------------------
Analyze monthly sales performance by segment and determine the contribution of each segment
to total monthly sales, while identifying potential seasonal patterns.
==================================================================================
*/

-- ==========================================
-- BASE QUERY - Extract monthly sales by segment
-- ==========================================
WITH MONTHLY_SEGMENT_SALES AS (
    SELECT
        -- Extract Month name 
        DATENAME(MONTH, ORDER_DATE) AS ORDER_MONTH,  -- This gives the full month name
        SEGMENT,
        SUM(SALES) AS TOTAL_SALES_BY_SEGMENT
    FROM SUPERSTORE
    GROUP BY 
        DATENAME(MONTH, ORDER_DATE),  -- Month name
        SEGMENT
)

-- ==========================================
-- Monthly Sales Contribution & Analysis
-- ==========================================
SELECT 
    ORDER_MONTH,
    SEGMENT,
    TOTAL_SALES_BY_SEGMENT,

    -- Total sales for the month (used for calculating percentage contribution)
    SUM(TOTAL_SALES_BY_SEGMENT) OVER (PARTITION BY ORDER_MONTH) AS TOTAL_SALES_PER_MONTH,

    -- Sales contribution by segment (in percentage)
    ROUND(
        TOTAL_SALES_BY_SEGMENT * 100.0 / 
        SUM(TOTAL_SALES_BY_SEGMENT) OVER (PARTITION BY ORDER_MONTH), 2
    ) AS SEGMENT_SALES_PCT

FROM MONTHLY_SEGMENT_SALES

ORDER BY 
    -- Ensure months are ordered correctly
    CASE 
        WHEN ORDER_MONTH = 'January' THEN 1
        WHEN ORDER_MONTH = 'February' THEN 2
        WHEN ORDER_MONTH = 'March' THEN 3
        WHEN ORDER_MONTH = 'April' THEN 4
        WHEN ORDER_MONTH = 'May' THEN 5
        WHEN ORDER_MONTH = 'June' THEN 6
        WHEN ORDER_MONTH = 'July' THEN 7
        WHEN ORDER_MONTH = 'August' THEN 8
        WHEN ORDER_MONTH = 'September' THEN 9
        WHEN ORDER_MONTH = 'October' THEN 10
        WHEN ORDER_MONTH = 'November' THEN 11
        WHEN ORDER_MONTH = 'December' THEN 12
        ELSE 13 -- For error handling
    END,
    SEGMENT;
