CREATE DATABASE seller_inventory_management;

USE seller_inventory_management;

CREATE TABLE Seller (
    seller_id INT PRIMARY KEY AUTO_INCREMENT,
    seller_name VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    phone VARCHAR(15)
);

CREATE TABLE Product (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2)
);

CREATE TABLE Inventory (
    inventory_id INT PRIMARY KEY AUTO_INCREMENT,
    seller_id INT,
    product_id INT,
    stock INT NOT NULL,
    status VARCHAR(20),
    FOREIGN KEY (seller_id) REFERENCES Seller(seller_id),
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);

INSERT INTO Seller (seller_name, email, phone)
VALUES
('Ravi Kumar', 'ravi@gmail.com', '9876543210'),
('Priya Sharma', 'priya@gmail.com', '9876543211'),
('Arun Kumar', 'arun@gmail.com', '9876543212'),
('Divya Raj', 'divya@gmail.com', '9876543213');

INSERT INTO Product (product_name, price)
VALUES
('Laptop', 55000.00),
('Mobile Phone', 25000.00),
('Keyboard', 1200.00),
('Headphones', 2000.00),
('Mouse', 800.00),
('Monitor', 15000.00);

INSERT INTO Inventory (seller_id, product_id, stock, status)
VALUES
(1, 1, 10, 'Available'),
(1, 3, 25, 'Available'),
(2, 2, 0, 'Unavailable'),
(2, 4, 15, 'Available'),
(3, 5, 30, 'Available'),
(3, 6, 0, 'Unavailable'),
(4, 2, 12, 'Available');

SELECT * FROM Seller;

SELECT * FROM Product;

SELECT * FROM Inventory;

UPDATE Inventory
SET stock = 20,
    status = 'Available'
WHERE product_id = 1;

SELECT * FROM Inventory
WHERE product_id = 1;

SELECT 
    p.product_name,
    i.stock,
    i.status
FROM Product p
JOIN Inventory i
ON p.product_id = i.product_id
WHERE i.status = 'Available';

SELECT 
    p.product_name,
    i.stock,
    i.status
FROM Product p
JOIN Inventory i
ON p.product_id = i.product_id
WHERE i.status = 'Unavailable';

SELECT 
    s.seller_name,
    p.product_name,
    p.price,
    i.stock,
    i.status
FROM Seller s
JOIN Inventory i
ON s.seller_id = i.seller_id
JOIN Product p
ON i.product_id = p.product_id;

SELECT 
    p.product_name,
    SUM(i.stock) AS total_stock,
    CASE
        WHEN SUM(i.stock) > 0 THEN 'Available'
        ELSE 'Unavailable'
    END AS inventory_status
FROM Product p
LEFT JOIN Inventory i
ON p.product_id = i.product_id
GROUP BY p.product_id, p.product_name;

SELECT 
    s.seller_name,
    COUNT(i.product_id) AS total_products,
    SUM(i.stock) AS total_stock
FROM Seller s
LEFT JOIN Inventory i
ON s.seller_id = i.seller_id
GROUP BY s.seller_id, s.seller_name;

<img width="1600" height="848" alt="WhatsApp Image 2026-09-02 at 9 02 10 PM" src="https://github.com/user-attachments/assets/39453431-0af3-4652-ad08-06f0f566d649" />
<img width="1600" height="848" alt="WhatsApp Image 2026-09-02 at 9 03 32 PM" src="https://github.com/user-attachments/assets/e5c1c18e-1ecc-4fa3-8a52-6f874a4d173e" />
<img width="1600" height="851" alt="WhatsApp Image 2026-09-02 at 9 02 37 PM" src="https://github.com/user-attachments/assets/c57a0f6b-c025-4a29-97bc-535033c63336" />
<img width="1600" height="851" alt="WhatsApp Image 2026-09-02 at 9 04 07 PM" src="https://github.com/user-attachments/assets/9c53b145-e020-4e17-ae11-b898031b98cb" />
<img width="1600" height="852" alt="WhatsApp Image 2026-09-02 at 9 04 41 PM" src="https://github.com/user-attachments/assets/bd213fa2-bfa9-493f-a3a0-6c97df809d0d" />
<img width="1600" height="849" alt="WhatsApp Image 2026-09-02 at 9 05 34 PM" src="https://github.com/user-attachments/assets/d17dc382-2598-4c54-9c6e-9392b804b8b8" />
<img width="1600" height="851" alt="WhatsApp Image 2026-09-02 at 9 06 08 PM" src="https://github.com/user-attachments/assets/de4263b6-a038-4553-b441-2247a6fb463a" />
<img width="1600" height="852" alt="WhatsApp Image 2026-09-02 at 9 06 35 PM" src="https://github.com/user-attachments/assets/2c2825aa-7d9c-4c52-be49-d347c93efd70" />









