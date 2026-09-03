CREATE DATABASE order_management;

USE order_management;

CREATE TABLE Customer (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    phone VARCHAR(15)
);

CREATE TABLE Product (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2)
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

CREATE TABLE Order_Details (
    order_detail_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);

INSERT INTO Customer (customer_name, email, phone)
VALUES
('Hepsi', 'hepsi@gmail.com', '9876543210'),
('Daniel', 'danny@gmail.com', '9876543211'),
('Alax', 'alax@gmail.com', '9876543212'),
('Devi', 'devi@gmail.com', '9876543213');

INSERT INTO Product (product_name, price)
VALUES
('Laptop', 55000.00),
('Mobile Phone', 25000.00),
('Keyboard', 1200.00),
('Mouse', 800.00),
('Headphones', 2000.00);

INSERT INTO Orders (customer_id, order_date)
VALUES
(1, '2026-08-01'),
(2, '2026-08-02'),
(3, '2026-08-03'),
(1, '2026-08-05');

INSERT INTO Order_Details (order_id, product_id, quantity, total_amount)
VALUES
(1, 1, 1, 55000.00),
(1, 4, 2, 1600.00),
(2, 2, 1, 25000.00),
(2, 5, 1, 2000.00),
(3, 3, 2, 2400.00),
(4, 2, 1, 25000.00);

SELECT * FROM Customer;

SELECT * FROM Product;

SELECT * FROM Orders;

SELECT * FROM Order_Details;

UPDATE Orders
SET order_date = '2026-08-06'
WHERE order_id = 4;

UPDATE Order_Details
SET quantity = 2,
    total_amount = 50000.00
WHERE order_detail_id = 6;

SELECT
    c.customer_id,
    c.customer_name,
    c.email,
    c.phone,
    o.order_id,
    o.order_date,
    p.product_id,
    p.product_name,
    p.price,
    od.quantity,
    od.total_amount
FROM Customer c
JOIN Orders o
ON c.customer_id = o.customer_id
JOIN Order_Details od
ON o.order_id = od.order_id
JOIN Product p
ON od.product_id = p.product_id;

SELECT
    c.customer_name,
    o.order_id,
    o.order_date,
    p.product_name,
    od.quantity,
    od.total_amount
FROM Customer c
JOIN Orders o
ON c.customer_id = o.customer_id
JOIN Order_Details od
ON o.order_id = od.order_id
JOIN Product p
ON od.product_id = p.product_id
ORDER BY c.customer_name;

SELECT
    c.customer_name,
    COUNT(o.order_id) AS total_orders,
    SUM(od.total_amount) AS total_spent
FROM Customer c
JOIN Orders o
ON c.customer_id = o.customer_id
JOIN Order_Details od
ON o.order_id = od.order_id
GROUP BY c.customer_id, c.customer_name;

<img width="1600" height="851" alt="WhatsApp Image 2026-09-02 at 9 25 42 PM" src="https://github.com/user-attachments/assets/229326fe-5f55-43b3-8ead-732ac78d296b" />
<img width="1600" height="847" alt="WhatsApp Image 2026-09-02 at 9 25 59 PM" src="https://github.com/user-attachments/assets/4bd5df35-02eb-492d-9ee7-fa387ecaf586" />
<img width="1600" height="847" alt="WhatsApp Image 2026-09-02 at 9 26 18 PM" src="https://github.com/user-attachments/assets/52e1843c-4a31-46df-8c14-21b4817e15d6" />
<img width="1600" height="849" alt="WhatsApp Image 2026-09-02 at 9 26 35 PM" src="https://github.com/user-attachments/assets/8197da56-55ca-401a-95cc-68e27a12aaf1" />
<img width="1600" height="847" alt="WhatsApp Image 2026-09-02 at 9 26 52 PM" src="https://github.com/user-attachments/assets/1d841bbe-daad-452a-9d3c-19e44eaf681d" />
<img width="1600" height="851" alt="WhatsApp Image 2026-09-02 at 9 27 43 PM" src="https://github.com/user-attachments/assets/78f2f650-0ce7-4884-be49-75638b6c432f" />





