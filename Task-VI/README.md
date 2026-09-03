CREATE DATABASE review_rating_management;

USE review_rating_management;

CREATE TABLE Customer (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(100)
);

CREATE TABLE Product (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2)
);

CREATE TABLE Review (
    review_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    product_id INT,
    review_text VARCHAR(500),
    review_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);

CREATE TABLE Rating (
    rating_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    product_id INT,
    rating INT,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (product_id) REFERENCES Product(product_id),
    CHECK (rating BETWEEN 1 AND 5)
);

INSERT INTO Customer (customer_name, email)
VALUES
('Arun Kumar', 'arun@gmail.com'),
('Priya Sharma', 'priya@gmail.com'),
('Rahul Raj', 'rahul@gmail.com'),
('Divya Kumar', 'divya@gmail.com'),
('Karthik Raj', 'karthik@gmail.com');

INSERT INTO Product (product_name, price)
VALUES
('Laptop', 55000.00),
('Mobile Phone', 25000.00),
('Headphones', 2000.00),
('Keyboard', 1200.00),
('Smart Watch', 3500.00);

INSERT INTO Review (customer_id, product_id, review_text, review_date)
VALUES
(1, 1, 'Excellent laptop with good performance', '2026-09-01'),
(2, 2, 'Good phone with excellent camera', '2026-09-01'),
(3, 3, 'Sound quality is very good', '2026-09-02'),
(4, 4, 'Keyboard is comfortable to use', '2026-09-02'),
(5, 5, 'Good design and battery life', '2026-09-03'),
(1, 2, 'Good phone but battery can be better', '2026-09-03'),
(2, 1, 'Very fast and useful for work', '2026-09-04');

INSERT INTO Rating (customer_id, product_id, rating)
VALUES
(1, 1, 5),
(2, 2, 5),
(3, 3, 4),
(4, 4, 4),
(5, 5, 5),
(1, 2, 4),
(2, 1, 5);

SELECT * FROM Customer;

SELECT * FROM Product;

SELECT * FROM Review;

SELECT * FROM Rating;

SELECT
    c.customer_name,
    p.product_name,
    r.review_text,
    r.review_date
FROM Customer c
JOIN Review r
ON c.customer_id = r.customer_id
JOIN Product p
ON r.product_id = p.product_id;

SELECT
    p.product_name,
    AVG(r.rating) AS average_rating
FROM Product p
JOIN Rating r
ON p.product_id = r.product_id
GROUP BY p.product_id, p.product_name;

SELECT
    p.product_name,
    COUNT(r.rating_id) AS total_ratings,
    AVG(r.rating) AS average_rating
FROM Product p
JOIN Rating r
ON p.product_id = r.product_id
GROUP BY p.product_id, p.product_name;

SELECT
    p.product_name,
    AVG(r.rating) AS average_rating
FROM Product p
JOIN Rating r
ON p.product_id = r.product_id
GROUP BY p.product_id, p.product_name
HAVING AVG(r.rating) >= 4.5;

SELECT
    p.product_name,
    c.customer_name,
    r.rating
FROM Product p
JOIN Rating r
ON p.product_id = r.product_id
JOIN Customer c
ON r.customer_id = c.customer_id
ORDER BY p.product_name;

<img width="1600" height="851" alt="WhatsApp Image 2026-09-03 at 9 28 16 AM" src="https://github.com/user-attachments/assets/a068ea46-de77-4f01-b757-030d9d458818" />
<img width="1600" height="848" alt="WhatsApp Image 2026-09-03 at 9 28 39 AM" src="https://github.com/user-attachments/assets/2a4710e0-1edd-458b-9e67-e5d563edcce1" />
<img width="1600" height="847" alt="WhatsApp Image 2026-09-03 at 9 29 03 AM" src="https://github.com/user-attachments/assets/4869d602-dafb-4b60-8b37-2cd58124ef7d" />
<img width="1600" height="847" alt="WhatsApp Image 2026-09-03 at 9 29 23 AM" src="https://github.com/user-attachments/assets/2a09330b-b1f5-4029-87ff-9baf2d58535f" />
<img width="1600" height="848" alt="WhatsApp Image 2026-09-03 at 9 29 45 AM" src="https://github.com/user-attachments/assets/fed4ad28-330a-4cd0-8c1d-e4ef5ef5f05d" />

<img width="1600" height="847" alt="WhatsApp Image 2026-09-03 at 9 30 05 AM" src="https://github.com/user-attachments/assets/8eac9a23-a1de-4d8f-83d3-b1da43a54fdb" />

<img width="1600" height="848" alt="WhatsApp Image 2026-09-03 at 9 30 34 AM" src="https://github.com/user-attachments/assets/6bfad13e-fd09-4c59-967d-0f56411a0060" />


