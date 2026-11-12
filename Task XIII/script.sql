USE Join_Analysis_Final;

CREATE USER IF NOT EXISTS 'manager'@'localhost'
IDENTIFIED BY 'Manager@123';

CREATE USER IF NOT EXISTS 'analyst'@'localhost'
IDENTIFIED BY 'Analyst@123';

CREATE USER IF NOT EXISTS 'staff'@'localhost'
IDENTIFIED BY 'Staff@123';


CREATE ROLE IF NOT EXISTS 'manager_role';
CREATE ROLE IF NOT EXISTS 'analyst_role';
CREATE ROLE IF NOT EXISTS 'staff_role';

GRANT ALL PRIVILEGES
ON Join_Analysis_Final.*
TO 'manager_role';


GRANT SELECT
ON Join_Analysis_Final.*
TO 'analyst_role';


GRANT SELECT, INSERT, UPDATE
ON Join_Analysis_Final.ja_customers
TO 'staff_role';

GRANT SELECT, INSERT, UPDATE
ON Join_Analysis_Final.ja_orders
TO 'staff_role';

GRANT SELECT, INSERT
ON Join_Analysis_Final.ja_order_items
TO 'staff_role';

GRANT 'manager_role' TO 'manager'@'localhost';
GRANT 'analyst_role' TO 'analyst'@'localhost';
GRANT 'staff_role' TO 'staff'@'localhost';



SET DEFAULT ROLE 'manager_role'
TO 'manager'@'localhost';

SET DEFAULT ROLE 'analyst_role'
TO 'analyst'@'localhost';

SET DEFAULT ROLE 'staff_role'
TO 'staff'@'localhost';


SHOW GRANTS FOR 'manager'@'localhost';
SHOW GRANTS FOR 'analyst'@'localhost';
SHOW GRANTS FOR 'staff'@'localhost';


GRANT SELECT
ON Join_Analysis_Final.ja_payments
TO 'staff'@'localhost';

REVOKE SELECT
ON Join_Analysis_Final.ja_payments
FROM 'staff'@'localhost';

CREATE INDEX idx_customer_city
ON ja_customers(city);

CREATE INDEX idx_product_category
ON ja_products(category);

CREATE INDEX idx_customer_order_date
ON ja_orders(customer_id, order_date);

CREATE INDEX idx_item_product
ON ja_order_items(product_id);

CREATE INDEX idx_payment_status
ON ja_payments(payment_status);


SHOW INDEX FROM ja_customers;
SHOW INDEX FROM ja_products;
SHOW INDEX FROM ja_orders;
SHOW INDEX FROM ja_order_items;
SHOW INDEX FROM ja_payments;

ANALYZE TABLE ja_customers;
ANALYZE TABLE ja_products;
ANALYZE TABLE ja_orders;
ANALYZE TABLE ja_order_items;
ANALYZE TABLE ja_payments;

EXPLAIN
SELECT *
FROM ja_customers
WHERE city = 'Chennai';


EXPLAIN
SELECT *
FROM ja_products
WHERE category = 'Electronics';

EXPLAIN
SELECT *
FROM ja_orders
WHERE customer_id = 1
AND order_date >= '2026-01-01';

EXPLAIN
SELECT *
FROM ja_payments
WHERE payment_status = 'Paid';


EXPLAIN
SELECT
    p.product_name,
    SUM(oi.quantity) AS total_quantity,
    SUM(oi.quantity * p.price) AS total_sales
FROM ja_products p
JOIN ja_order_items oi
ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_sales DESC;


EXPLAIN
SELECT
    c.customer_name,
    COUNT(o.order_id) AS total_orders
FROM ja_customers c
LEFT JOIN ja_orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name;

SELECT
    TABLE_NAME,
    INDEX_NAME,
    COLUMN_NAME,
    NON_UNIQUE
FROM INFORMATION_SCHEMA.STATISTICS
WHERE TABLE_SCHEMA = 'Join_Analysis_Final'
ORDER BY TABLE_NAME, INDEX_NAME;




