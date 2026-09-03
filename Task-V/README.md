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

<img width="1600" height="852" alt="WhatsApp Image 2026-09-03 at 9 05 57 AM" src="https://github.com/user-attachments/assets/14f44d85-4b43-4b0e-a9d4-ab5ec45a7a65" />
<img width="1600" height="851" alt="WhatsApp Image 2026-09-03 at 9 06 18 AM" src="https://github.com/user-attachments/assets/d9a56153-7e85-4ed8-ab08-58bb880c2b8e" />

<img width="1600" height="851" alt="WhatsApp Image 2026-09-03 at 9 06 52 AM" src="https://github.com/user-attachments/assets/353e4ebb-8aa4-4511-9687-a61ad86bffbb" />
<img width="1600" height="848" alt="WhatsApp Image 2026-09-03 at 9 07 12 AM" src="https://github.com/user-attachments/assets/99bb3332-b892-41d0-88b8-918ca13344be" />

<img width="1600" height="848" alt="WhatsApp Image 2026-09-03 at 9 07 30 AM" src="https://github.com/user-attachments/assets/4b0220a2-7345-4309-9b4c-4f7d6121fdbf" />
<img width="1600" height="848" alt="WhatsApp Image 2026-09-03 at 9 08 00 AM" src="https://github.com/user-attachments/assets/dc6ffa00-ce24-4e3c-932f-63ca897770ec" />
