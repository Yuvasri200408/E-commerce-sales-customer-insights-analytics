use ecommerce;

-- E-COMMERCE SALES & CUSTOMER ANALYSIS
-- DATA VALIDATION
-- Check sample data
SELECT * FROM customers LIMIT 5;
SELECT * FROM orders LIMIT 5;
SELECT * FROM payments LIMIT 5;

-- Count records
SELECT COUNT(*) AS total_customers FROM customers;
SELECT COUNT(*) AS total_orders FROM orders;
SELECT COUNT(*) AS total_payments FROM payments;
--  BASIC JOIN (DATA INTEGRATION)
SELECT 
    c.customer_id,
    c.customer_unique_id,
    c.customer_state,
    o.order_id,
    o.order_purchase_timestamp,
    p.payment_value
FROM customers c
JOIN orders o 
    ON c.customer_id = o.customer_id
JOIN payments p 
    ON o.order_id = p.order_id
LIMIT 10;

-- BUSINESS METRICS

-- Total Revenue
SELECT SUM(payment_value) AS total_revenue
FROM payments;

-- Total Orders
SELECT COUNT(*) AS total_orders
FROM orders;

-- Average Order Value
SELECT AVG(payment_value) AS avg_order_value
FROM payments;



-- GEOGRAPHICAL ANALYSIS
-- Orders by State
SELECT 
    c.customer_state,
    COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o 
    ON c.customer_id = o.customer_id
GROUP BY c.customer_state
ORDER BY total_orders DESC;

-- Revenue by State
SELECT 
    c.customer_state,
    SUM(p.payment_value) AS revenue
FROM customers c
JOIN orders o 
    ON c.customer_id = o.customer_id
JOIN payments p 
    ON o.order_id = p.order_id
GROUP BY c.customer_state
ORDER BY revenue DESC;

-- TIME-BASED ANALYSIS
-- Monthly Revenue Trend
SELECT 
    DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS month,
    SUM(p.payment_value) AS revenue
FROM orders o
JOIN payments p 
    ON o.order_id = p.order_id
GROUP BY month
ORDER BY month;
--  CUSTOMER BEHAVIOR ANALYSIS
-- Orders per Customer
SELECT 
    c.customer_unique_id,
    COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o 
    ON c.customer_id = o.customer_id
GROUP BY c.customer_unique_id
ORDER BY total_orders DESC;

-- Top 10 Customers
SELECT 
    c.customer_unique_id,
    SUM(p.payment_value) AS total_spent
FROM customers c
JOIN orders o 
    ON c.customer_id = o.customer_id
JOIN payments p 
    ON o.order_id = p.order_id
GROUP BY c.customer_unique_id
ORDER BY total_spent DESC
LIMIT 10;

--  PAYMENT ANALYSIS
-- Payment Method Distribution
SELECT 
    payment_type,
    COUNT(*) AS total
FROM payments
GROUP BY payment_type
ORDER BY total DESC;

-- STEP 8: ORDER STATUS ANALYSIS
-- Order Status Breakdown
SELECT 
    order_status,
    COUNT(*) AS total
FROM orders
GROUP BY order_status;
