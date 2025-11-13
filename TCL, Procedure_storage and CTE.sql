use mnp;

# Use a savepoint during an update.
start transaction;
set sql_safe_updates = 0;
update sales_2023
set  Revenue = Revenue +100
where Region = 'North';

savepoint before_south_update;

update sales_2023
set Revenue = Revenue + 200
where Region = 'South';

rollback to before_south_update;

commit;

# Create a procedure that takes region as input and returns total sales.

delimiter $$

create procedure GetRegionSales(IN region_name varchar(50))
begin 
  select Region, sum(Revenue) as Total_units from sales_2023
  where Region = region_name
  group by Region;
  End $$
delimiter ;

# Find top 3 products by total revenue using CTE and ranking

with RankedProducts as (
 select Product,sum(Revenue) as Total_Revenue,
 rank() over (order by sum(Revenue) desc) as rnk
 from sales_2023
 group by Product)
 select Product, Total_Revenue from RankedProducts Where rnk<=3;
)


