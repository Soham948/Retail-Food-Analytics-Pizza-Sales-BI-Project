select*from pizza


---1]Total Revenue
select sum(total_price) from pizza


---2] Average Order Value
select sum(total_price)/count(DISTINCT order_id) as avg_order_value from pizza


---3]Total pizza solds
select sum(quantity)as total_pizza_sold from pizza

---4]Total orders placed
select count(distinct(order_id)) AS total_orders_placed from pizza

---5]Average pizza per order
select sum(quantity)/count(distinct order_id) as average_pizza_order from pizza


---6]Daily trend of total _orders
SELECT TO_CHAR(order_date,'Month') AS order_day, COUNT(DISTINCT order_id) AS total_orders 
FROM pizza
GROUP BY TO_CHAR(order_date)


---7]Monthly trend of the order
select DATENAME(order_date,'Month') as month_name,
count(DISTINCT order_id) as total_orders from pizza
group by DATENAME(order_date,'Month') order by MIN(order_date)



---B. Monthly Trend for Orders
SELECT TO_CHAR(order_date,'MONTH') as Month_Name,count(DISTINCTborder_id) as TO_CHAR
from pizza
group by(Month,order_date)



---- % of Sales by Pizza Category
SELECT 
    pizza_category, 
    CAST(SUM(total_price) AS DECIMAL(10,2)) AS total_revenue,
    CAST(SUM(total_price) * 100.0 / (SELECT SUM(total_price) FROM pizza) AS DECIMAL(10,2)) AS pct
FROM pizza
GROUP BY pizza_category;


----% of Sales by Pizza Size


SELECT 
    pizza_size, 
    CAST(SUM(total_price) AS DECIMAL(10,2)) AS total_revenue,
    CAST(SUM(total_price) * 100.0 / (SELECT SUM(total_price) FROM pizza) AS DECIMAL(10,2)) AS pct
FROM pizza
GROUP BY pizza_size
ORDER BY pizza_size;


-----Total Pizzas Sold by Pizza Category
SELECT 
    pizza_category, 
    SUM(quantity) AS total_quantity_sold
FROM pizza
WHERE EXTRACT(MONTH FROM order_date) = 2
GROUP BY pizza_category
ORDER BY total_quantity_sold DESC;

-----Top 5 Pizzas by Revenue
SELECT 
    pizza_name, 
    SUM(total_price) AS total_revenue
FROM pizza
GROUP BY pizza_name
ORDER BY total_revenue DESC
LIMIT 5;



------Bottom 5 Pizzas by Revenue

SELECT 
    pizza_name, 
    SUM(total_price) AS total_revenue
FROM pizza
GROUP BY pizza_name
ORDER BY total_revenue ASC
LIMIT 5;

------Top 5 Pizzas by Quantity

SELECT 
    pizza_name, 
    SUM(quantity) AS total_pizza_sold
FROM pizza
GROUP BY pizza_name
ORDER BY total_pizza_sold DESC
LIMIT 5;

-----Bottom 5 Pizzas by Quantity

SELECT 
    pizza_name, 
    SUM(quantity) AS total_pizza_sold
FROM pizza
GROUP BY pizza_name
ORDER BY total_pizza_sold ASC
LIMIT 5;


















