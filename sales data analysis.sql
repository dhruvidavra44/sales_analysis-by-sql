use mnp;

alter table sales_2023 rename  column `ï»¿Date` to Date;
# Show all data from the table
select * from sales_2023;

# Show unique products
select distinct Product from sales_2023;

# Count how many records are in the dataset
select count(*) as Total_records from sales_2023;

# Find total units sold
select sum(units_sold) as Total_unots_sold from sales_2023;

#Show sales entries from the North region
select * from sales_2023 where Region = 'North';

# Find total revenue by product
select Product, sum(Revenue) as Total_revenue from sales_2023
group by Product
order by Total_revenue desc;

# Find the top salesperson by total revenue
select Salesperson, sum(Revenue) as Total_sales from Sales_2023
group by Salesperson
order by Total_sales desc
limit 1;

# Find average units sold per region
select Region, avg(Units_sold) as avg_units from sales_2023
group by sales_2023;

#Count sales based on channel (online vs offline).
select Channel, COUNT(*) as total_sales
from sales_2023
group by  Channel;

#Revenue trend by date.
select date, sum(revenue) as revenue_per_day
from sales_2023
group by date order by date;

#Identify the best-selling product per region.
select region, product, sum(units_sold) as total_units
from sales_2023
group by region, product
order by region, total_units desc;

#Find the highest revenue day for each salesperson
SELECT Salesperson, Date, total_revenue
FROM (
    SELECT 
        Salesperson,
        Date,
        SUM(Revenue) AS total_revenue,
        RANK() OVER (PARTITION BY Salesperson ORDER BY SUM(Revenue) DESC) AS rnk
    FROM sales_2023
    GROUP BY Salesperson, Date
) ranked_data
WHERE rnk = 1;

#Show products contributing more than 20% of total revenue.
select Product,
       SUM(Revenue) as product_revenue,
       (SUM(Revenue) / (select SUM(Revenue) from sales_2023)) * 100 as percentage_share
from sales_2023
group by Product
having percentage_share > 20;

#Rank salespersons by revenue (using window functions).
select Salesperson, 
       SUM(Revenue) as total_revenue,
       rank() over (order by SUM(Revenue) desc) as sales_rank
from sales_2023
group by Salesperson;

#Monthly sales summary (requires correct Date formatting).
select DATE_FORMAT(Date, '%Y-%m') as month,
       SUM(Units_Sold) as total_units,
       SUM(Revenue) as total_revenue
from sales_2023
group by month
order by month;

