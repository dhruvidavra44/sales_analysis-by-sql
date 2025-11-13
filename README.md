# sales_analysis-by-sql
SQL-based analysis of sales data including data cleaning, exploration, and performance insights. Queries cover revenue trends, top products, regional performance, salesperson analysis, monthly summaries, and channel comparisons. A complete SQL script with key KPIs and analytics is included.


📊 Sales Data Analysis (SQL Project)

This project contains SQL scripts designed for analyzing sales data, performing business insights queries, using CTEs, stored procedures, and demonstrating transaction control operations in MySQL.

📁 Project Structure
1. sales data analysis.sql

This file contains analytical SQL queries performed on the sales_2023 dataset.
Key operations include: data cleaning, aggregation, window functions, trend analysis, and performance ranking. 

sales data analysis

2. TCL, Procedure_storage and CTE.sql

This file demonstrates advanced SQL concepts such as:

Transaction Control Language (TCL)

Savepoints and Rollbacks

Stored Procedures

Common Table Expressions (CTEs) and Ranking Functions


TCL, Procedure_storage and CTE

🚀 Features & Highlights
✅ Data Cleaning & Preparation

Column renaming (ï»¿Date → Date)

Viewing full dataset

Displaying unique product names

📈 Sales Insights & Analysis

Total records count

Total units sold

Revenue by product

Best salesperson by revenue

Average units sold per region

Sales by channel (Online vs Offline)

Revenue trends by date

Best-selling product per region

Highest revenue day per salesperson

Products contributing more than 20% of total revenue

Monthly sales summary

🔧 Procedures, CTEs & Window Functions

A stored procedure (GetRegionSales) returns total sales of a selected region

CTE ranking logic to identify Top 3 Products by Revenue

Window functions such as RANK() for salesperson and product performance ranking

🔐 Transaction Control Operations

Includes:

START TRANSACTION

SAVEPOINT creation

Conditional ROLLBACK

COMMIT statements

Useful for ensuring data integrity while testing updates.

🗂 Example Key Queries
🔹 Top Salesperson
select Salesperson, sum(Revenue) as Total_sales 
from Sales_2023
group by Salesperson
order by Total_sales desc
limit 1;

🔹 Stored Procedure to Get Region Sales
create procedure GetRegionSales(IN region_name varchar(50))
begin 
  select Region, sum(Revenue) as Total_units 
  from sales_2023
  where Region = region_name
  group by Region;
end;

🔹 Top 3 Products Using CTE
with RankedProducts as (
  select Product, sum(Revenue) as Total_Revenue,
         rank() over (order by sum(Revenue) desc) as rnk
  from sales_2023
  group by Product
)
select Product, Total_Revenue 
from RankedProducts 
where rnk <= 3;

🛠 Technologies Used

MySQL

SQL Window Functions

CTEs

Stored Procedures

TCL (Transaction Control Language)
