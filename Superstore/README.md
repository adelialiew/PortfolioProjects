# Superstore Business Analysis in SQL
This repository contains SQL scripts used to create aggregated datasets for performance, customer, and shipping delay analysis based on the Superstore dataset. The goal is to prepare the data for visualization and business insights generation in Tableau.

## Introduction to the Data set
The dataset used for this project is based on the widely recognized "Superstore" dataset, originally provided by Tableau.
It contains detailed information on products, sales, customers, shipping logistics, and profitability metrics across various segments and regions.

Although the data is based on a fictional retail company, it is structured to closely mirror real world business operations, allowing for meaningful analysis and strategic insights.
This dataset is commonly used in the data analytics community to practice and demonstrate skills in business intelligence, customer segmentation, operational performance evaluation, and profitability analysis.

In this project, the Superstore data serves as a foundation to explore real world business questions, design actionable KPIs, and create dynamic visual storytelling through SQL queries and Tableau dashboards.

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

These indicators allow clear identification of which segments and categories are growing steadily, stagnating, or declining.

**Monthly Segment Seasonality:**
To uncover cyclical sales patterns and potential seasonal opportunities, I also aggregated monthly sales by Segment, generating:

- total_sales_by_segment: Total sales per segment each month.
- total_sales_per_month: Overall sales for each month across all segments.
- segment_sales_pct: Percentage contribution of each segment to total monthly sales, highlighting seasonal peaks and valleys for each customer group.

Organizing months in chronological order and analyzing the monthly contribution trends help reveal seasonal opportunities, such as peak seasons for different segments enabling better forecasting, inventory planning, and promotional targeting.

By layering both yearly and monthly trends together, the time analysis empowers a comprehensive understanding of sales momentum, seasonality, and segment dynamics over time critical for strategic decision making and growth optimization.


## Customer Analysis
This section explores customer behavior and profitability patterns by Segment and Category. The goal is to highlight high-value customers, understand loyalty trends, and uncover how customer profitability evolves over time.

**Key Customer Metrics:**
To create a detailed view of customer performance, I developed metrics focused on lifecycle, value contribution, and profitability:

- first_order: The date of the customer's first purchase. A starting point to assess customer tenure.
- last_order: The most recent purchase date. Helps to determine activity recency.
- lifespan: The number of months between the first and last purchase, providing a measure of engagement duration.
- total_orders: The number of orders placed by a customer. Indicates activity frequency.
- total_sales: The cumulative revenue generated by a customer, essential for evaluating customer value.
- avg_order_value: Average sales per order, useful for understanding purchase behavior and ticket size.
- total_profit: The customer's total contribution to company profit, showing true financial impact.
- avg_monthly_spend: Average spending per month over their lifespan, giving insight into consistent engagement versus one-off spikes.
- profitability_status: A classification of each customer as Profitable, Unprofitable, or Break-Even based on total profit.

These insights lay the foundation for customer segmentation strategies, loyalty analysis, and tailored marketing initiatives. Identifying which customer groups generate sustained profit versus one-time spikes enables better resource allocation and retention strategies. Moreover, evaluating customer lifespan and monthly spend helps prioritize nurturing high-potential customers while addressing segments that may be declining in value.

This section focuses on understanding shipping delays across different customer segments, regions, and shipping modes. The goal is to spot patterns that may impact customer satisfaction and operational efficiency.

**Key Shipping Metrics:**
To break down shipping performance, I structured the analysis around a few essential measures:

- shipping_delay: The number of days between the order date and the ship date. A direct measure of service responsiveness.
- num_orders: The count of orders within each group, helping to contextualize the delay data based on volume.
- avg_shipping_delay: The average number of days it takes for an order to be shipped after purchase, revealing overall service efficiency.
- stdev: The standard deviation of shipping delays, highlighting consistency (or inconsistency) within each segment.

By examining these metrics across Category, Segment, Region, and Ship Mode, we can uncover where delays are more frequent or volatile. Shipping modes that show high variability or longer delays can be flagged for operational review. Similarly, understanding which customer groups are most impacted by delays can guide customer communication strategies or service guarantees. Ultimately, this analysis helps prioritize improvements in logistics processes, customer communication, and strategic partnerships with shipping carriers, all aimed at enhancing the customer experience.

## Data visualization
Each analysis section above is complemented by an interactive Tableau dashboard. These dashboards bring the data to life, allowing for dynamic exploration of performance, customer behavior, time trends, and operational efficiency.

Performance Analysis Dashboard: Visualizes profitability drivers, sales vs. profit scatter plots, and profitability segmentation across segments, regions, and categories.

Time Analysis Dashboard: Displays yearly growth trends, category and segment-level CAGR, total growth over time, and monthly seasonality patterns.

Customer Analysis Dashboard: Highlights customer profitability distribution, lifespan patterns, spending behaviors, and customer-level profit vs. sales comparisons.

Shipping Delays Dashboard: Illustrates shipping delay trends across ship modes, average delay comparisons, and variability in shipping performance.

You can view the full dashboards [here](https://public.tableau.com/app/profile/adelia.liew/vizzes).

These visualizations are designed to expand on the insights uncovered through SQL, creating a full journey from data preparation to storytelling and business decision support.
