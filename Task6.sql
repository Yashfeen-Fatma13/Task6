drop database if exists mydb;
create database online_sales;
use online_sales;

CREATE TABLE orders (
  order_id INT PRIMARY KEY,
  order_date DATE,
  amount DECIMAL(10,2),
  product_id INT
);

insert into orders(order_id,order_date,amount,product_id)values
(101, '2024-01-15', 150.00, 1),
(102, '2024-01-20', 200.00, 2),
(103, '2024-02-10', 300.00, 1),
(104, '2024-02-25', 250.00, 3),
(105, '2024-03-05', 400.00, 2),
(106, '2024-03-20', 500.00, 2),
(107, '2024-03-25', 450.00, 3),
(108, '2024-04-01', 350.00, 1),
(109, '2024-04-10', 280.00, 2),
(110, '2024-04-20', 300.00, 3);

SELECT
  YEAR(order_date) AS order_year,
  MONTH(order_date) AS order_month,
  SUM(amount) AS total_revenue,
  COUNT(DISTINCT order_id) AS total_orders
FROM
  orders
GROUP BY
  YEAR(order_date),
  MONTH(order_date)
ORDER BY
  order_year,
  order_month;
  
  SELECT
  YEAR(order_date) AS order_year,
  MONTH(order_date) AS order_month,
  AVG(amount) AS avg_order_value
FROM
  orders
GROUP BY
  YEAR(order_date), MONTH(order_date)
ORDER BY
  order_year, order_month;
  
  SELECT
  product_id,
  COUNT(*) AS total_orders,
  SUM(amount) AS total_revenue
FROM
  orders
GROUP BY
  product_id;
  
  SELECT 
  current_month.order_month,
  current_month.total_revenue,
  LAG(current_month.total_revenue) OVER (ORDER BY current_month.order_month) AS previous_revenue,
  ROUND(
    (current_month.total_revenue - LAG(current_month.total_revenue) OVER (ORDER BY current_month.order_month)) 
    / LAG(current_month.total_revenue) OVER (ORDER BY current_month.order_month) * 100, 2
  ) AS revenue_growth_percent
FROM (
  SELECT 
    MONTH(order_date) AS order_month,
    SUM(amount) AS total_revenue
  FROM orders
  GROUP BY MONTH(order_date)
) AS current_month;

