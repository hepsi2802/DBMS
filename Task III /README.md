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
('Arun Kumar', 'arun@gmail.com', '9876543210'),
('Priya Sharma', 'priya@gmail.com', '9876543211'),
('Rahul Raj', 'rahul@gmail.com', '9876543212'),
('Divya Kumar', 'divya@gmail.com', '9876543213');

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


<img width="1600" height="848" alt="WhatsApp Image 2026-09-02 at 9 02 10 PM" src="https://github.com/user-attachments/assets/39453431-0af3-4652-ad08-06f0f566d649" />
<img width="1600" height="848" alt="WhatsApp Image 2026-09-02 at 9 03 32 PM" src="https://github.com/user-attachments/assets/e5c1c18e-1ecc-4fa3-8a52-6f874a4d173e" />
<img width="1600" height="851" alt="WhatsApp Image 2026-09-02 at 9 02 37 PM" src="https://github.com/user-attachments/assets/c57a0f6b-c025-4a29-97bc-535033c63336" />
<img width="1600" height="851" alt="WhatsApp Image 2026-09-02 at 9 04 07 PM" src="https://github.com/user-attachments/assets/9c53b145-e020-4e17-ae11-b898031b98cb" />
<img width="1600" height="852" alt="WhatsApp Image 2026-09-02 at 9 04 41 PM" src="https://github.com/user-attachments/assets/bd213fa2-bfa9-493f-a3a0-6c97df809d0d" />
<img width="1600" height="849" alt="WhatsApp Image 2026-09-02 at 9 05 34 PM" src="https://github.com/user-attachments/assets/d17dc382-2598-4c54-9c6e-9392b804b8b8" />
<img width="1600" height="851" alt="WhatsApp Image 2026-09-02 at 9 06 08 PM" src="https://github.com/user-attachments/assets/de4263b6-a038-4553-b441-2247a6fb463a" />
<img width="1600" height="852" alt="WhatsApp Image 2026-09-02 at 9 06 35 PM" src="https://github.com/user-attachments/assets/2c2825aa-7d9c-4c52-be49-d347c93efd70" />









