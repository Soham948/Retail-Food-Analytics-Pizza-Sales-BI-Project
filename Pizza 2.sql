--1]Second Highest Pizza Sale
SELECT
    pizza_name,
    SUM(total_price) AS total_revenue
FROM pizza
GROUP BY pizza_name
ORDER BY total_revenue DESC
LIMIT 1 OFFSET 1;

--2 Rank pizzas by revenue
SELECT
    pizza_name,
    SUM(total_price) AS total_revenue,
    DENSE_RANK() OVER (ORDER BY SUM(total_price) DESC) AS revenue_rank
FROM pizza
GROUP BY pizza_name;

--3]ROW_NUMBER() — Number the pizzas by revenue
SELECT
    pizza_name,
    SUM(total_price) AS total_revenue,
    ROW_NUMBER() OVER (ORDER BY SUM(total_price) DESC) AS row_number
FROM pizza
GROUP BY pizza_name;


--3] Rank Pizza With Each category
-- Window Function: Rank Pizzas Within Each Category

SELECT
    pizza_category,
    pizza_name,
    total_revenue,
    RANK() OVER (
        PARTITION BY pizza_category
        ORDER BY total_revenue DESC
    ) AS revenue_rank
FROM (
    SELECT
        pizza_category,
        pizza_name,
        SUM(total_price) AS total_revenue
    FROM pizza
    GROUP BY pizza_category, pizza_name
) AS pizza_sales
ORDER BY pizza_category, revenue_rank;


--4] Total Revenue BY Pizza
WITH pizza_revenue AS (
    SELECT
        pizza_name,
        SUM(total_price) AS total_revenue
    FROM pizza
    GROUP BY pizza_name
)

SELECT
    pizza_name,
    total_revenue
FROM pizza_revenue
ORDER BY total_revenue DESC;