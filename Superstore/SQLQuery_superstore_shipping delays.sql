/*
==================================================================================
Shipping Delays Analysis
----------------------------------------------------------------------------------
Objective: This analysis aims to evaluate shipping delays, the impact of shipping modes
on delays, and how different customer segments and regions contribute to overall delays.
By understanding these metrics, we can identify opportunities for improving shipping efficiency
and customer satisfaction.
==================================================================================
*/

-- ==========================================
-- BASE QUERY
-- ==========================================
WITH BASE_QUERY AS (
    SELECT
        CATEGORY,               
        SEGMENT,                
        ORDER_DATE,             
        SHIP_DATE,              
        DATEDIFF(DAY, ORDER_DATE, SHIP_DATE) AS SHIPPING_DELAY,  -- Days between order and shipping
        SHIP_MODE,              
        REGION                  
    FROM SUPERSTORE
)

-- ==========================================
-- Aggregate Shipping Delay Metrics
-- ==========================================
SELECT
    CATEGORY,                
    SEGMENT,                 
    REGION,                  
    SHIP_MODE,               

    COUNT(*) AS NUM_ORDERS,                     
    AVG(SHIPPING_DELAY) AS AVG_SHIPPING_DELAY,   
    ROUND(STDEV(SHIPPING_DELAY), 2) AS STDEV     
FROM BASE_QUERY
GROUP BY 
    CATEGORY,
    SEGMENT,
    REGION,
    SHIP_MODE
HAVING STDEV(SHIPPING_DELAY) IS NOT NULL 
ORDER BY STDEV DESC; 
