-- Database Creation
create database zepto_db;
use zepto_db;
select * from zepto_data
limit 10;
-- SQL ANALYSIS
-- TOTAL SALES REVENUE BY DAY NAME
select dayname(order_date) as day_name, round(sum(revenue),2) as total_revenue
from zepto_data
group by day_name
order by total_revenue desc;
-- TOTAL SALES REVENUE BY HOUR
select hour(order_date) as hour_name, round(sum(revenue),2) as total_revenue
from zepto_data
group by hour_name
order by total_revenue desc;
-- TOP 5 PRODUCT CATEGORIES BY REVENUE
select category, round(sum(revenue),2) as total_revenue from zepto_data
group by category
order by total_revenue desc
limit 5;
-- MOST POPULAR BRANDS BY REVENUE
select brand,round(sum(revenue),2) as total_revenue from zepto_data
group by brand
order by total_revenue desc;
-- TOP 10 BEST SELLING PRODUCTS
select product_name, sum(quantity) as quantity_sold from zepto_data
group by product_name
order by quantity_sold desc
limit 10;
-- TOP PRODUCTS BY REVENUE
select product_name, round(sum(revenue),2) as total_revenue from zepto_data
group by product_name
order by total_revenue desc;
-- REVENUE CONTRIBUTION BY STORE
select store_id, round(sum(revenue),2) as total_revenue from zepto_data
group by store_id
order by total_revenue desc;
-- PERCENTAGE OF LATE DELIVERIES
select 
   round(
      sum(case  when delivery_status = "Late" then 1 else 0 end)/count(*)
        ,2) as late_delivery_percentage
from zepto_data;
-- AVERAGE DELIVERY DISTANCE PER STORE
select store_id, round(avg(distance_km),2) as avg_distance from zepto_data
group by store_id;
-- TOP DELIVERY PARTNERS
select delivery_partner, count(order_id) as total_deliveries from zepto_data
group by delivery_partner
order by total_deliveries desc; 
-- ON-TIME DELIVERY PERCENTAGE BY PARTNER
select delivery_partner,
       round(
       sum(case when delivery_status='On-Time' then 1 else 0 end)/count(*)
       ,2) as on_time_percentage
from zepto_data
group by delivery_partner;
-- PRODUCTS BELOW REORDER LEVEL
select product_name, stock_level, reorder_level from zepto_data
where stock_level < reorder_level;
-- INVENTORY VS SALES TREND
select date(order_date) as order_day, sum(quantity) as total_quantity_sold, 
avg(stock_level) as avg_stock_level 
from zepto_data
group by order_day
order by order_day;
-- RETURN RATE ANALYSIS
select category, round(avg(return_flag)*100,2) as return_percentage from zepto_data
group by category
order by return_percentage desc;

