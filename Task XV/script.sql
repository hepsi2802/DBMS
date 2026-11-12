CREATE DATABASE Ecommerce_Intelligence_V2;
USE Ecommerce_Intelligence_V2;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    city VARCHAR(50),
    registration_date DATE
);


CREATE TABLE categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(100) NOT NULL
);

CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    category_id INT,
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2),
    stock_quantity INT DEFAULT 0,
    FOREIGN KEY (category_id)
        REFERENCES categories(category_id)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATE,
    order_status VARCHAR(30),
    total_amount DECIMAL(10,2) DEFAULT 0,
    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price DECIMAL(10,2),
    subtotal DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    payment_date DATE,
    payment_amount DECIMAL(10,2),
    payment_method VARCHAR(30),
    payment_status VARCHAR(30),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

CREATE TABLE inventory_log (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    movement_type VARCHAR(30),
    quantity_changed INT,
    movement_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);



INSERT INTO customers
(customer_name, email, phone, city, registration_date)
VALUES
('Arun Kumar','arun@gmail.com','9876543210','Chennai','2026-01-10'),
('Priya Sharma','priya@gmail.com','9876543211','Coimbatore','2026-01-15'),
('Kavin Raj','kavin@gmail.com','9876543212','Madurai','2026-02-01'),
('Divya Sri','divya@gmail.com','9876543213','Chennai','2026-02-10'),
('Rahul Kumar','rahul@gmail.com','9876543214','Salem','2026-03-05');

INSERT INTO categories (category_name)
VALUES
('Electronics'),
('Accessories'),
('Fashion'),
('Home Appliances');

INSERT INTO products
(category_id, product_name, price, stock_quantity)
VALUES
(1,'Laptop',55000,20),
(1,'Smartphone',20000,30),
(2,'Headphones',1500,50),
(2,'Keyboard',2500,40),
(3,'Smart Watch',5000,25),
(4,'Mixer Grinder',3500,15),
(3,'Backpack',1200,35),
(1,'Tablet',18000,20);



DELIMITER //

CREATE TRIGGER check_product_stock
BEFORE INSERT ON order_items
FOR EACH ROW
BEGIN
    DECLARE available_stock INT;

    SELECT stock_quantity
    INTO available_stock
    FROM products
    WHERE product_id = NEW.product_id
    FOR UPDATE;

    IF NEW.quantity <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Quantity must be greater than zero';
    END IF;

    IF available_stock < NEW.quantity THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Insufficient product stock';
    END IF;
END//

CREATE TRIGGER update_product_stock
AFTER INSERT ON order_items
FOR EACH ROW
BEGIN
    UPDATE products
    SET stock_quantity = stock_quantity - NEW.quantity
    WHERE product_id = NEW.product_id;

    INSERT INTO inventory_log
    (product_id, movement_type, quantity_changed)
    VALUES
    (NEW.product_id, 'SALE', NEW.quantity);
END//

DELIMITER ;

DELIMITER //

CREATE PROCEDURE Create_Customer_Order(
    IN p_customer_id INT,
    IN p_product_id INT,
    IN p_quantity INT,
    IN p_payment_method VARCHAR(30)
)
BEGIN
    DECLARE v_order_id INT;
    DECLARE v_price DECIMAL(10,2);
    DECLARE v_total DECIMAL(10,2);

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    SELECT price INTO v_price
    FROM products
    WHERE product_id = p_product_id;

    SET v_total = v_price * p_quantity;

    INSERT INTO orders
    (customer_id, order_date, order_status, total_amount)
    VALUES
    (p_customer_id, CURDATE(), 'Confirmed', v_total);

    SET v_order_id = LAST_INSERT_ID();

    INSERT INTO order_items
    (order_id, product_id, quantity, unit_price, subtotal)
    VALUES
    (v_order_id, p_product_id, p_quantity, v_price, v_total);

    INSERT INTO payments
    (order_id, payment_date, payment_amount,
     payment_method, payment_status)
    VALUES
    (v_order_id, CURDATE(), v_total,
     p_payment_method, 'Paid');

    COMMIT;

    SELECT 'Order placed successfully' AS message,
           v_order_id AS order_id,
           v_total AS total_amount;
END//

DELIMITER ;

CALL Create_Customer_Order(1,1,1,'UPI');
CALL Create_Customer_Order(2,2,2,'Card');
CALL Create_Customer_Order(3,3,2,'UPI');
CALL Create_Customer_Order(4,5,1,'Cash');
CALL Create_Customer_Order(1,4,1,'Card');


CREATE VIEW order_report AS
SELECT
    o.order_id,
    c.customer_name,
    p.product_name,
    oi.quantity,
    oi.unit_price,
    oi.subtotal,
    o.order_date,
    o.order_status
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id;


CREATE VIEW customer_sales_report AS
SELECT
    c.customer_id,
    c.customer_name,
    COUNT(DISTINCT o.order_id) AS total_orders,
    COALESCE(SUM(oi.subtotal),0) AS total_spending
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
LEFT JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_id, c.customer_name;

CREATE VIEW product_sales_report AS
SELECT
    p.product_id,
    p.product_name,
    SUM(oi.quantity) AS units_sold,
    SUM(oi.subtotal) AS revenue
FROM products p
LEFT JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name;

CREATE INDEX idx_customer_city
ON customers(city);

CREATE INDEX idx_product_name
ON products(product_name);

CREATE INDEX idx_order_date
ON orders(order_date);

CREATE INDEX idx_order_customer
ON orders(customer_id);

CREATE INDEX idx_payment_status
ON payments(payment_status);

SELECT * FROM customers;


SELECT * FROM products;


SELECT * FROM orders;

SELECT *
FROM products
WHERE price > 5000;

SELECT SUM(payment_amount) AS total_sales
FROM payments
WHERE payment_status = 'Paid';


SELECT AVG(price) AS average_price
FROM products;


SELECT *
FROM customer_sales_report
ORDER BY total_spending DESC
LIMIT 1;

SELECT *
FROM product_sales_report
ORDER BY units_sold DESC
LIMIT 1;

SELECT *
FROM products
WHERE product_id NOT IN (
    SELECT product_id FROM order_items
);

SELECT *
FROM customer_sales_report
WHERE total_spending > (
    SELECT AVG(total_spending)
    FROM customer_sales_report
);

SELECT
    c.category_name,
    SUM(oi.subtotal) AS category_revenue
FROM categories c
JOIN products p ON c.category_id = p.category_id
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY c.category_name;

SELECT
    customer_name,
    total_spending,
    RANK() OVER (ORDER BY total_spending DESC) AS customer_rank
FROM customer_sales_report;

SELECT
    product_name,
    stock_quantity,
    CASE
        WHEN stock_quantity < 10 THEN 'Low Stock'
        WHEN stock_quantity <= 30 THEN 'Medium Stock'
        ELSE 'High Stock'
    END AS stock_status
FROM products;

SELECT
    payment_method,
    COUNT(*) AS payment_count,
    SUM(payment_amount) AS total_amount
FROM payments
GROUP BY payment_method;

SELECT
    p.product_name,
    i.movement_type,
    i.quantity_changed,
    i.movement_date
FROM inventory_log i
JOIN products p ON i.product_id = p.product_id;

SELECT * FROM order_report;
SELECT * FROM customer_sales_report;
SELECT * FROM product_sales_report;

ANALYZE TABLE customers;
ANALYZE TABLE products;
ANALYZE TABLE orders;
ANALYZE TABLE order_items;
ANALYZE TABLE payments;

EXPLAIN
SELECT *
FROM orders
WHERE customer_id = 1;

SELECT
    (SELECT COUNT(*) FROM customers) AS total_customers,
    (SELECT COUNT(*) FROM products) AS total_products,
    (SELECT COUNT(*) FROM orders) AS total_orders,
    (SELECT SUM(payment_amount) FROM payments
     WHERE payment_status = 'Paid') AS total_revenue;
