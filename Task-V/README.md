CREATE DATABASE payment_management;

USE payment_management;

CREATE TABLE Customer (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    phone VARCHAR(15)
);

CREATE TABLE Payment (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    payment_mode VARCHAR(50),
    payment_date DATE,
    amount DECIMAL(10,2),
    status VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

INSERT INTO Customer (customer_name, email, phone)
VALUES
('Arun Kumar', 'arun@gmail.com', '9876543210'),
('Priya Sharma', 'priya@gmail.com', '9876543211'),
('Rahul Raj', 'rahul@gmail.com', '9876543212'),
('Divya Kumar', 'divya@gmail.com', '9876543213'),
('Karthik Raj', 'karthik@gmail.com', '9876543214');

INSERT INTO Payment (customer_id, payment_mode, payment_date, amount, status)
VALUES
(1, 'UPI', '2026-09-01', 2500.00, 'Successful'),
(2, 'Credit Card', '2026-09-01', 4500.00, 'Successful'),
(3, 'Debit Card', '2026-09-02', 1800.00, 'Failed'),
(4, 'UPI', '2026-09-02', 3200.00, 'Successful'),
(5, 'Cash', '2026-09-03', 1500.00, 'Successful'),
(1, 'Credit Card', '2026-09-03', 5000.00, 'Failed'),
(2, 'UPI', '2026-09-04', 2200.00, 'Successful'),
(3, 'Debit Card', '2026-09-04', 3500.00, 'Successful');

SELECT * FROM Customer;

SELECT * FROM Payment;

UPDATE Payment
SET status = 'Successful'
WHERE payment_id = 3;

SELECT * FROM Payment
WHERE status = 'Successful';

SELECT * FROM Payment
WHERE status = 'Failed';

SELECT
    c.customer_id,
    c.customer_name,
    c.email,
    c.phone,
    p.payment_id,
    p.payment_mode,
    p.payment_date,
    p.amount,
    p.status
FROM Customer c
JOIN Payment p
ON c.customer_id = p.customer_id;

SELECT
    payment_mode,
    COUNT(*) AS total_transactions
FROM Payment
GROUP BY payment_mode;

SELECT
    payment_mode,
    COUNT(*) AS successful_transactions
FROM Payment
WHERE status = 'Successful'
GROUP BY payment_mode;

SELECT
    payment_mode,
    COUNT(*) AS failed_transactions
FROM Payment
WHERE status = 'Failed'
GROUP BY payment_mode;

SELECT
    status,
    COUNT(*) AS total_transactions,
    SUM(amount) AS total_amount
FROM Payment
GROUP BY status;

SELECT
    c.customer_name,
    COUNT(p.payment_id) AS total_payments,
    SUM(p.amount) AS total_amount
FROM Customer c
JOIN Payment p
ON c.customer_id = p.customer_id
GROUP BY c.customer_id, c.customer_name;

<img width="1600" height="852" alt="WhatsApp Image 2026-09-03 at 9 05 57 AM" src="https://github.com/user-attachments/assets/8edab3da-7eae-43b4-beb8-52a41f0bb5a6" />

<img width="1600" height="848" alt="WhatsApp Image 2026-09-03 at 9 07 30 AM" src="https://github.com/user-attachments/assets/9607ce3e-50de-4f37-811d-6a91bb67c6e7" />
<img width="1600" height="848" alt="WhatsApp Image 2026-09-03 at 9 07 12 AM" src="https://github.com/user-attachments/assets/c4b8834e-69df-4b38-a6df-07a77cd22474" />

<img width="1600" height="851" alt="WhatsApp Image 2026-09-03 at 9 06 18 AM" src="https://github.com/user-attachments/assets/ec6629b4-c42a-4562-96d1-21e90ee19300" />
<img width="1600" height="851" alt="WhatsApp Image 2026-09-03 at 9 06 52 AM" src="https://github.com/user-attachments/assets/9deff0a5-494c-4ad7-ac06-28b5e083bd6c" />
<img width="1600" height="852" alt="WhatsApp Image 2026-09-03 at 9 05 57 AM" src="https://github.com/user-attachments/assets/7a46472f-0368-4682-9f43-4152965fdb3a" />




