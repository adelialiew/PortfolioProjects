# Superstore Business Analysis in SQL
This repository contains SQL scripts used to create aggregated datasets for performance, customer, and shipping delay analysis based on the Superstore dataset. The goal is to prepare the data for visualization and business insights generation in Tableau.

## Performance Analysis
This section focuses on evaluating sales and profitability performance across different product categories, customer segments, and regions. The aim is to build a comprehensive understanding of where the business is thriving and where improvements are needed.

**Key Performance Indicators (KPIs)**:

To build a foundational view of performance, I created key aggregated metrics grouped by Segment, Region, and Category:

- total_orders: Count of distinct orders placed. This measures transaction volume and activity intensity.
- total_sales: Total revenue generated. A primary measure of business size per group.
- total_units: Total quantity of items sold. Useful to understand product movement versus sales value.
- total_profit: Sum of profits after cost deductions. This indicates true earnings beyond just sales.
- avg_discount: Average discount rate applied per group, helping to identify segments heavily reliant on promotional pricing.
- profit_margin: Profitability efficiency ratio, calculated as SUM(PROFIT) / SUM(SALES), rounded to two decimal places.
- profitability_segment:Labeled as Profitable if profit margin > 0. Labeled as Unprofitable otherwise.

These aggregations serve as the foundation for key visuals such as scatter plots (sales vs. profit), performance dashboards, and profitability segmentation. By grouping data at these levels, the analysis uncovers patterns in which combinations of product categories and customer segments drive the highest (and lowest) margins. Furthermore, This binary segmentation enables quick identification of underperforming combinations of segments, regions, and product categories, making it easier to prioritize turnaround strategies.


## Time Analysis
This section evaluates sales trends over time to uncover key patterns, growth opportunities, and seasonality within the business. The goal is to understand not only how much sales are growing, but also where that growth is concentrated across segments and categories — and when specific segments peak in performance.

**Yearly Sales Trends:**
To assess long-term business performance, I aggregated and analyzed yearly sales by Segment and Category, creating the following key metrics.

- total_sales: Sum of sales revenue per segment-category combination each year.
- sales_pct: Percentage contribution of each segment-category to the total sales for its respective year, helping highlight dominant drivers of yearly revenue.
- yoy_sales_difference: Absolute change in sales compared to the previous year for each segment-category.
- yoy_sales_growth_rate: Year-over-year percentage growth, signaling acceleration or slowdown in performance.
- total_growth_pct: Cumulative growth percentage from the first to the last year available, offering a big picture view of segment/category evolution.
- cagr_pct: Compound Annual Growth Rate (CAGR), smoothing the growth path across multiple years to identify consistent winners.

These indicators allow clear identification of which segments and categories are growing steadily, stagnating, or declining — providing strategic insights into long-term portfolio management.

**Monthly Segment Seasonality:**
To uncover cyclical sales patterns and potential seasonal opportunities, I also aggregated monthly sales by Segment, generating:

- total_sales_by_segment: Total sales per segment each month.
- total_sales_per_month: Overall sales for each month across all segments.
- segment_sales_pct: Percentage contribution of each segment to total monthly sales, highlighting seasonal peaks and valleys for each customer group.

Organizing months in chronological order and analyzing the monthly contribution trends help reveal seasonal opportunities, such as peak seasons for different segments enabling better forecasting, inventory planning, and promotional targeting.

By layering both yearly and monthly trends together, the time analysis empowers a comprehensive understanding of sales momentum, seasonality, and segment dynamics over time critical for strategic decision making and growth optimization.


