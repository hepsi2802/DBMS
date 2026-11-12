USE Join_Analysis_Final;
SELECT
    COUNT(DISTINCT o.order_id) AS total_orders,
    COUNT(DISTINCT o.customer_id) AS total_customers,
    SUM(oi.quantity) AS total_units_sold,
    SUM(oi.quantity * p.price) AS total_sales,
    AVG(oi.quantity * p.price) AS average_item_sales,
    MAX(oi.quantity * p.price) AS highest_item_sales,
    MIN(oi.quantity * p.price) AS lowest_item_sales
FROM ja_orders o
JOIN ja_order_items oi
    ON o.order_id = oi.order_id
JOIN ja_products p
    ON oi.product_id = p.product_id;

SELECT
    p.product_id,
    p.product_name,
    p.category,
    SUM(oi.quantity) AS units_sold,
    SUM(oi.quantity * p.price) AS total_revenue
FROM ja_products p
JOIN ja_order_items oi
    ON p.product_id = oi.product_id
GROUP BY
    p.product_id,
    p.product_name,
    p.category
ORDER BY total_revenue DESC;


SELECT
    c.customer_id,
    c.customer_name,
    COUNT(DISTINCT o.order_id) AS total_orders,
    COALESCE(SUM(oi.quantity), 0) AS total_products,
    COALESCE(SUM(oi.quantity * p.price), 0) AS total_purchase
FROM ja_customers c
LEFT JOIN ja_orders o
    ON c.customer_id = o.customer_id
LEFT JOIN ja_order_items oi
    ON o.order_id = oi.order_id
LEFT JOIN ja_products p
    ON oi.product_id = p.product_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_purchase DESC;


SELECT
    c.customer_name,
    SUM(oi.quantity * p.price) AS total_purchase,
    RANK() OVER (
        ORDER BY SUM(oi.quantity * p.price) DESC
    ) AS customer_rank
FROM ja_customers c
JOIN ja_orders o
    ON c.customer_id = o.customer_id
JOIN ja_order_items oi
    ON o.order_id = oi.order_id
JOIN ja_products p
    ON oi.product_id = p.product_id
GROUP BY c.customer_id, c.customer_name;


SELECT
    order_id,
    customer_id,
    order_date,
    ROW_NUMBER() OVER (
        PARTITION BY customer_id
        ORDER BY order_date DESC, order_id DESC
    ) AS order_number
FROM ja_orders;

SELECT
    c.customer_id,
    c.customer_name,
    COALESCE(SUM(oi.quantity * p.price), 0) AS total_purchase,

    CASE
        WHEN COALESCE(SUM(oi.quantity * p.price), 0) >= 30000
            THEN 'High Value Customer'

        WHEN COALESCE(SUM(oi.quantity * p.price), 0) >= 10000
            THEN 'Medium Value Customer'

        WHEN COALESCE(SUM(oi.quantity * p.price), 0) > 0
            THEN 'Low Value Customer'

        ELSE 'New / Inactive Customer'
    END AS customer_segment

FROM ja_customers c
LEFT JOIN ja_orders o
    ON c.customer_id = o.customer_id
LEFT JOIN ja_order_items oi
    ON o.order_id = oi.order_id
LEFT JOIN ja_products p
    ON oi.product_id = p.product_id

GROUP BY c.customer_id, c.customer_name
ORDER BY total_purchase DESC;


SELECT
    customer_segment,
    COUNT(*) AS number_of_customers,
    SUM(total_purchase) AS segment_revenue
FROM
(
    SELECT
        c.customer_id,
        COALESCE(SUM(oi.quantity * p.price), 0)
            AS total_purchase,

        CASE
            WHEN COALESCE(SUM(oi.quantity * p.price), 0) >= 30000
                THEN 'High Value Customer'
            WHEN COALESCE(SUM(oi.quantity * p.price), 0) >= 10000
                THEN 'Medium Value Customer'
            WHEN COALESCE(SUM(oi.quantity * p.price), 0) > 0
                THEN 'Low Value Customer'
            ELSE 'New / Inactive Customer'
        END AS customer_segment

    FROM ja_customers c
    LEFT JOIN ja_orders o
        ON c.customer_id = o.customer_id
    LEFT JOIN ja_order_items oi
        ON o.order_id = oi.order_id
    LEFT JOIN ja_products p
        ON oi.product_id = p.product_id

    GROUP BY c.customer_id
) AS customer_data

GROUP BY customer_segment;


SELECT
    c.customer_id,
    c.customer_name,
    c.city,

    COUNT(DISTINCT o.order_id) AS purchase_frequency,

    COALESCE(SUM(oi.quantity), 0) AS total_quantity,

    COALESCE(SUM(oi.quantity * p.price), 0)
        AS monetary_value,

    COALESCE(AVG(oi.quantity * p.price), 0)
        AS average_item_value,

    MAX(o.order_date) AS last_purchase_date,

    COALESCE(
        DATEDIFF(CURRENT_DATE, DATE(MAX(o.order_date))),
        -1
    ) AS recency_days

FROM ja_customers c
LEFT JOIN ja_orders o
    ON c.customer_id = o.customer_id
LEFT JOIN ja_order_items oi
    ON o.order_id = oi.order_id
LEFT JOIN ja_products p
    ON oi.product_id = p.product_id

GROUP BY
    c.customer_id,
    c.customer_name,
    c.city

ORDER BY c.customer_id;


DROP TABLE IF EXISTS ai_customer_dataset;

CREATE TABLE ai_customer_dataset AS

SELECT
    c.customer_id,
    c.customer_name,
    c.city,

    COUNT(DISTINCT o.order_id) AS purchase_frequency,

    COALESCE(SUM(oi.quantity), 0) AS total_quantity,

    COALESCE(SUM(oi.quantity * p.price), 0)
        AS monetary_value,

    COALESCE(AVG(oi.quantity * p.price), 0)
        AS average_item_value,

    MAX(o.order_date) AS last_purchase_date,

    COALESCE(
        DATEDIFF(CURRENT_DATE, DATE(MAX(o.order_date))),
        -1
    ) AS recency_days,

    CASE
        WHEN COALESCE(SUM(oi.quantity * p.price), 0) >= 30000
            THEN 3
        WHEN COALESCE(SUM(oi.quantity * p.price), 0) >= 10000
            THEN 2
        WHEN COALESCE(SUM(oi.quantity * p.price), 0) > 0
            THEN 1
        ELSE 0
    END AS customer_segment_code

FROM ja_customers c
LEFT JOIN ja_orders o
    ON c.customer_id = o.customer_id
LEFT JOIN ja_order_items oi
    ON o.order_id = oi.order_id
LEFT JOIN ja_products p
    ON oi.product_id = p.product_id

GROUP BY
    c.customer_id,
    c.customer_name,
    c.city;

SELECT * FROM ai_customer_dataset;

SELECT
    p.product_id,
    p.product_name,
    p.category,
    p.price,
    p.stock,

    COALESCE(SUM(oi.quantity), 0) AS total_units_sold,

    COALESCE(SUM(oi.quantity * p.price), 0)
        AS product_revenue,

    CASE
        WHEN COALESCE(SUM(oi.quantity), 0) >= 3
            THEN 'High Demand'
        WHEN COALESCE(SUM(oi.quantity), 0) >= 1
            THEN 'Medium Demand'
        ELSE 'No Sales'
    END AS demand_category

FROM ja_products p
LEFT JOIN ja_order_items oi
    ON p.product_id = oi.product_id

GROUP BY
    p.product_id,
    p.product_name,
    p.category,
    p.price,
    p.stock;


SELECT
    payment_method,
    payment_status,
    COUNT(*) AS total_transactions,
    SUM(amount) AS total_amount
FROM ja_payments
GROUP BY payment_method, payment_status;

SELECT
    COUNT(*) AS total_customers,
    SUM(purchase_frequency) AS total_customer_orders,
    SUM(total_quantity) AS total_quantity_sold,
    SUM(monetary_value) AS total_revenue,
    AVG(monetary_value) AS average_customer_value
FROM ai_customer_dataset;
