CREATE DATABASE IF NOT EXISTS join_Analysis_Final;
USE Join_Analysis_Final;

CREATE TABLE ja_customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    email VARCHAR(100),
    city VARCHAR(50)
);

CREATE TABLE ja_products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);



CREATE TABLE ja_orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    order_status VARCHAR(30),
    FOREIGN KEY (customer_id)
    REFERENCES ja_customers(customer_id)
);

CREATE TABLE ja_order_items (
    item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id)
    REFERENCES ja_orders(order_id),
    FOREIGN KEY (product_id)
    REFERENCES ja_products(product_id)
);



CREATE TABLE ja_payments (
    payment_id INT PRIMARY KEY,
    order_id INT,
    payment_date DATE,
    amount DECIMAL(10,2),
    payment_method VARCHAR(50),
    payment_status VARCHAR(30),
    FOREIGN KEY (order_id)
    REFERENCES ja_orders(order_id)
);


INSERT INTO ja_customers VALUES
(1, 'Arun', 'arun@gmail.com', 'Chennai'),
(2, 'Priya', 'priya@gmail.com', 'Coimbatore'),
(3, 'Kavin', 'kavin@gmail.com', 'Madurai'),
(4, 'Divya', 'divya@gmail.com', 'Chennai'),
(5, 'Rahul', 'rahul@gmail.com', 'Salem');

INSERT INTO ja_products VALUES
(101, 'Laptop', 'Electronics', 55000),
(102, 'Mobile', 'Electronics', 20000),
(103, 'Headphones', 'Accessories', 1500),
(104, 'Keyboard', 'Accessories', 2500),
(105, 'Smart Watch', 'Electronics', 5000);

INSERT INTO ja_orders VALUES
(1001, 1, '2026-10-01', 'Delivered'),
(1002, 2, '2026-10-03', 'Delivered'),
(1003, 1, '2026-10-05', 'Shipped'),
(1004, 3, '2026-10-08', 'Pending'),
(1005, 4, '2026-10-10', 'Delivered');

INSERT INTO ja_order_items VALUES
(1, 1001, 101, 1),
(2, 1001, 103, 2),
(3, 1002, 102, 1),
(4, 1003, 104, 2),
(5, 1004, 105, 1),
(6, 1005, 103, 1);

INSERT INTO ja_payments VALUES
(501, 1001, '2026-10-01', 58000, 'UPI', 'Paid'),
(502, 1002, '2026-10-03', 20000, 'Card', 'Paid'),
(503, 1003, '2026-10-05', 5000, 'UPI', 'Paid'),
(504, 1005, '2026-10-10', 1500, 'Cash', 'Paid');

SELECT * FROM ja_customers;

SELECT * FROM ja_products;

SELECT * FROM ja_orders;

SELECT * FROM ja_order_items;

SELECT * FROM ja_payments;

SELECT
    c.customer_name,
    o.order_id,
    p.product_name,
    oi.quantity,
    p.price,
    pay.payment_status
FROM ja_customers c
INNER JOIN ja_orders o
    ON c.customer_id = o.customer_id
INNER JOIN ja_order_items oi
    ON o.order_id = oi.order_id
INNER JOIN ja_products p
    ON oi.product_id = p.product_id
INNER JOIN ja_payments pay
    ON o.order_id = pay.order_id;


SELECT
    c.customer_id,
    c.customer_name,
    c.city,
    o.order_id,
    o.order_date,
    o.order_status
FROM ja_customers c
LEFT JOIN ja_orders o
    ON c.customer_id = o.customer_id;

SELECT
    o.order_id,
    o.order_date,
    c.customer_name,
    pay.payment_id,
    pay.amount,
    pay.payment_method,
    pay.payment_status
FROM ja_payments pay
RIGHT JOIN ja_orders o
    ON pay.order_id = o.order_id
LEFT JOIN ja_customers c
    ON o.customer_id = c.customer_id;

SELECT
    o.order_id,
    c.customer_name,
    c.email,
    c.city,
    o.order_date,
    p.product_name,
    p.category,
    oi.quantity,
    p.price,
    (oi.quantity * p.price) AS total_amount,
    o.order_status,
    pay.payment_method,
    pay.payment_status
FROM ja_orders o
INNER JOIN ja_customers c
    ON o.customer_id = c.customer_id
INNER JOIN ja_order_items oi
    ON o.order_id = oi.order_id
INNER JOIN ja_products p
    ON oi.product_id = p.product_id
LEFT JOIN ja_payments pay
    ON o.order_id = pay.order_id
ORDER BY o.order_id;

SELECT
    c.customer_id,
    c.customer_name,
    COUNT(DISTINCT o.order_id) AS total_orders,
    COALESCE(SUM(oi.quantity), 0) AS total_products,
    COALESCE(SUM(oi.quantity * p.price), 0) AS total_spending
FROM ja_customers c
LEFT JOIN ja_orders o
    ON c.customer_id = o.customer_id
LEFT JOIN ja_order_items oi
    ON o.order_id = oi.order_id
LEFT JOIN ja_products p
    ON oi.product_id = p.product_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_spending DESC;


SELECT
    c.customer_name,
    c.city,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(oi.quantity * p.price) AS total_sales
FROM ja_customers c
INNER JOIN ja_orders o
    ON c.customer_id = o.customer_id
INNER JOIN ja_order_items oi
    ON o.order_id = oi.order_id
INNER JOIN ja_products p
    ON oi.product_id = p.product_id
GROUP BY c.customer_id, c.customer_name, c.city;

SELECT
    p.product_name,
    p.category,
    SUM(oi.quantity) AS units_sold,
    SUM(oi.quantity * p.price) AS revenue
FROM ja_products p
INNER JOIN ja_order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name, p.category
ORDER BY revenue DESC;

SELECT
    payment_method,
    payment_status,
    COUNT(*) AS total_transactions,
    SUM(amount) AS total_amount
FROM ja_payments
GROUP BY payment_method, payment_status;

SELECT
    order_status,
    COUNT(*) AS total_orders
FROM ja_orders
GROUP BY order_status;

SELECT
    COUNT(DISTINCT o.order_id) AS total_orders,
    COUNT(DISTINCT o.customer_id) AS total_customers,
    SUM(oi.quantity) AS total_products_sold,
    SUM(oi.quantity * p.price) AS total_sales
FROM ja_orders o
INNER JOIN ja_order_items oi
    ON o.order_id = oi.order_id
INNER JOIN ja_products p
    ON oi.product_id = p.product_id;
    
    
USE Join_Analysis_Final;

-- 1. CUSTOMER TABLE
SELECT * FROM ja_customers;

-- 2. PRODUCT TABLE
SELECT * FROM ja_products;

-- 3. ORDER TABLE
SELECT * FROM ja_orders;

-- 4. ORDER ITEMS TABLE
SELECT * FROM ja_order_items;

-- 5. PAYMENT TABLE
SELECT * FROM ja_payments;
