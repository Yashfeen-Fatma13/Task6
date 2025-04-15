
Task 6: Sales Trend Analysis Using Aggregations

Objective: To analyze monthly revenue and order volume from an orders dataset using SQL aggregations.


---

Step 1: Selected the Database

Before creating any tables, I encountered an error:

> Error Code: 1046. No database selected



To resolve this, I selected the working database using the USE command:

USE online_sales;

This step ensured that all subsequent operations were directed to the correct database.


---

Step 2: Created the Orders Table

I created a table named orders to store order-related information. The table structure included:

CREATE TABLE orders (
  order_id INT PRIMARY KEY,
  order_date DATE,
  amount DECIMAL(10,2),
  product_id INT
);

order_id serves as the primary key

order_date stores the date of each order

amount captures the revenue from each order

product_id identifies the product sold



---

Step 3: Inserted Sample Data

Next, I inserted sample data into the orders table to simulate real-world transactions across different months and products:

INSERT INTO orders (order_id, order_date, amount, product_id) VALUES
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

This dataset spans four months and includes various products and transaction amounts.


---

Step 4: Performed Monthly Revenue and Order Volume Analysis

To analyze the sales trend, I used the YEAR() and MONTH() functions along with aggregation functions like SUM() and COUNT():

SELECT
  YEAR(order_date) AS order_year,
  MONTH(order_date) AS order_month,
  SUM(amount) AS total_revenue,
  COUNT(DISTINCT order_id) AS total_orders
FROM
  orders
GROUP BY
  YEAR(order_date), MONTH(order_date)
ORDER BY
  order_year, order_month;

This query allowed me to:

Group data by year and month

Calculate total revenue per month

Count the number of distinct orders placed each month

Identify trends and seasonal sales patterns



---

Step 5: Explored Additional Insights

After the main analysis, I explored other useful operations on the dataset, such as:

a) Top Selling Products by Revenue

SELECT product_id, SUM(amount) AS total_revenue
FROM orders
GROUP BY product_id
ORDER BY total_revenue DESC
LIMIT 5;

b) Average Order Value Per Month

SELECT YEAR(order_date) AS order_year, MONTH(order_date) AS order_month, AVG(amount) AS avg_order_value
FROM orders
GROUP BY YEAR(order_date), MONTH(order_date);

c) Orders and Revenue by Product

SELECT product_id, COUNT(*) AS total_orders, SUM(amount) AS total_revenue
FROM orders
GROUP BY product_id;

d) Monthly Revenue Growth (MySQL 8+)

SELECT 
  current_month.order_month,
  current_month.total_revenue,
  LAG(current_month.total_revenue) OVER (ORDER BY current_month.order_month) AS previous_revenue,
  ROUND(
    (current_month.total_revenue - LAG(current_month.total_revenue) OVER (ORDER BY current_month.order_month)) 
    / LAG(current_month.total_revenue) OVER (ORDER BY current_month.order_month) * 100, 2
  ) AS revenue_growth_percent
FROM (
  SELECT MONTH(order_date) AS order_month, SUM(amount) AS total_revenue
  FROM orders
  GROUP BY MONTH(order_date)
) AS current_month;


---

Conclusion

Through this task, I successfully built a sample sales database, performed data insertions, and applied various aggregation techniques in SQL to derive key business insights. This included analyzing trends in monthly revenue and order volume, identifying top products, calculating average order values, and examining growth patterns.

This foundational analysis could now be extended into visual dashboards using tools like Power BI or used for more complex analytical scenarios involving customers, regions, and profit tracking.
