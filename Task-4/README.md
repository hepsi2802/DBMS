CREATE DATABASE supermarket_management;

USE supermarket_management;



CREATE TABLE Category (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(100) NOT NULL
);



CREATE TABLE Product (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100) NOT NULL,
    category_id INT,
    price DECIMAL(10,2),
    stock INT,
    FOREIGN KEY (category_id) REFERENCES Category(category_id)
);



INSERT INTO Category (category_name)
VALUES
('Fruits'),
('Vegetables'),
('Dairy'),
('Beverages'),
('Snacks');



INSERT INTO Product (product_name, category_id, price, stock)
VALUES
('Apple', 1, 120.00, 50),
('Banana', 1, 60.00, 80),
('Tomato', 2, 40.00, 100),
('Potato', 2, 35.00, 120),
('Milk', 3, 55.00, 60),
('Cheese', 3, 250.00, 25),
('Coca Cola', 4, 45.00, 40),
('Orange Juice', 4, 100.00, 30),
('Potato Chips', 5, 50.00, 70),
('Biscuits', 5, 30.00, 90);



SELECT * FROM Category;


-- Display Products
SELECT * FROM Product;



UPDATE Product
SET price = 130.00
WHERE product_name = 'Apple';



SELECT * FROM Product
WHERE product_name = 'Apple';



DELETE FROM Product
WHERE product_name = 'Biscuits';



SELECT * FROM Product;



SELECT 
    c.category_name,
    p.product_name,
    p.price,
    p.stock
FROM Category c
JOIN Product p
ON c.category_id = p.category_id
ORDER BY c.category_name;



SELECT 
    c.category_name,
    COUNT(p.product_id) AS total_products
FROM Category c
LEFT JOIN Product p
ON c.category_id = p.category_id
GROUP BY c.category_id, c.category_name;



SELECT 
    c.category_name,
    SUM(p.stock) AS total_stock
FROM Category c
JOIN Product p
ON c.category_id = p.category_id
GROUP BY c.category_id, c.category_name;



SELECT 
    c.category_name,
    AVG(p.price) AS average_price
FROM Category c
JOIN Product p
ON c.category_id = p.category_id
GROUP BY c.category_id, c.category_name;

<img width="1600" height="847" alt="WhatsApp Image 2026-09-02 at 2 19 54 PM" src="https://github.com/user-attachments/assets/5139d01c-eb17-4309-b3b0-1133bdbdcd6f" />
<img width="1600" height="848" alt="WhatsApp Image 2026-09-02 at 2 19 31 PM" src="https://github.com/user-attachments/assets/2755e97f-510e-4dde-b3a5-8585b2e39a71" />
<img width="1600" height="848" alt="WhatsApp Image 2026-09-02 at 2 19 12 PM" src="https://github.com/user-attachments/assets/9e024ca9-a5c4-4202-bb86-9ac21abcc9a4" />
<img width="1600" height="851" alt="WhatsApp Image 2026-09-02 at 2 18 55 PM" src="https://github.com/user-attachments/assets/51c6d0f2-db33-4feb-af27-40f13593eed8" />
<img width="1600" height="827" alt="WhatsApp Image 2026-09-02 at 2 17 41 PM" src="https://github.com/user-attachments/assets/985dc221-e3c9-4fe6-beb0-37164d4f17a0" />
<img width="1600" height="852" alt="WhatsApp Image 2026-09-02 at 2 17 07 PM" src="https://github.com/user-attachments/assets/044b96c5-6658-4b01-8e6e-4c3128f2d48e" />
<img width="1600" height="847" alt="WhatsApp Image 2026-09-02 at 2 16 35 PM" src="https://github.com/user-attachments/assets/0e1984d1-8782-439f-b8ba-4ae51fc2648a" />
<img width="1600" height="848" alt="WhatsApp Image 2026-09-02 at 2 16 11 PM" src="https://github.com/user-attachments/assets/6e90eccc-dbc7-43cc-8246-3f5f048c3e38" />
<img width="1600" height="847" alt="WhatsApp Image 2026-09-02 at 2 20 15 PM" src="https://github.com/user-attachments/assets/c7b1e348-55c7-427e-a583-06b9ecd534f3" />







