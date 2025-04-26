# Superstore Business Analysis in SQL
This repository contains SQL scripts used to create aggregated datasets for performance, customer, and shipping delay analysis based on the Superstore dataset. The goal is to prepare the data for visualization and business insights generation in Tableau.

# Performance Analysis
This section focuses on evaluating sales and profitability performance across different product categories, customer segments, and regions. The aim is to build a comprehensive understanding of where the business is thriving and where improvements are needed.

## Key Performance Indicators (KPIs)
To build a foundational view of performance, I created key aggregated metrics grouped by Segment, Region, and Category:

- total_orders: Count of distinct orders placed. This measures transaction volume and activity intensity.
- total_sales: Total revenue generated. A primary measure of business size per group.
- total_units: Total quantity of items sold. Useful to understand product movement versus sales value.
- total_profit: Sum of profits after cost deductions. This indicates true earnings beyond just sales.
- avg_discount: Average discount rate applied per group, helping to identify segments heavily reliant on promotional pricing.
- profit_margin: Profitability efficiency ratio, calculated as SUM(PROFIT) / SUM(SALES), rounded to two decimal places.

These aggregations serve as the foundation for key visuals such as scatter plots (sales vs. profit), performance dashboards, and profitability segmentation. By grouping data at these levels, the analysis uncovers patterns in which combinations of product categories and customer segments drive the highest (and lowest) margins.


