---1]. KPIs ($818K revenue, 21K orders, $38.31 AOV) runs
SELECT
    ROUND(SUM(total_price)::numeric, 2) AS total_revenue,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND((SUM(total_price) / COUNT(DISTINCT order_id))::numeric, 2) AS avg_order_value
FROM pizza;


---2] run
    WITH r AS (
    SELECT pizza_name, pizza_category, SUM(total_price) AS revenue
    FROM pizza GROUP BY pizza_name, pizza_category),
	ranked as (
    SELECT *, DENSE_RANK() OVER (ORDER BY revenue DESC) AS rnk,
           100 * SUM(revenue) OVER (ORDER BY revenue DESC) / SUM(revenue) OVER () AS cumulative_pct
    FROM r
)
SELECT pizza_name, pizza_category, ROUND(revenue::numeric, 2) AS revenue,
       ROUND(cumulative_pct::numeric, 1) AS cumulative_pct
FROM ranked WHERE rnk <= 3 ORDER BY rnk;



--3] 3. Revenue share by size
SELECT pizza_size,
       ROUND((100 * SUM(total_price) / SUM(SUM(total_price)) OVER ())::numeric, 1) AS pct_of_revenue
FROM pizza GROUP BY pizza_size ORDER BY pct_of_revenue DESC;




---4] 4. Revenue by day of week
SELECT TRIM(TO_CHAR(TO_DATE(order_date, 'DD-MM-YYYY'), 'Day')) AS day_name,
       ROUND(SUM(total_price)::numeric, 2) AS revenue
FROM pizza
GROUP BY 1
ORDER BY revenue DESC;





select * from pizza
---5]5. Orders by hour
SELECT EXTRACT(HOUR FROM order_time::time) AS order_hour,
       COUNT(DISTINCT order_id) AS orders
FROM pizza
GROUP BY 1
ORDER BY order_hour;