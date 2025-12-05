-- Q4: Gross transaction value of each store's first order
-- -------------------------------------------------------
-- Idea:
-- 1. Order each store's transactions by purchase_time.
-- 2. Use ROW_NUMBER to mark the first transaction per store.
-- 3. Select only rn = 1 and return the corresponding GTV.

WITH store_orders AS (
    SELECT
        store_id,
        purchase_time,
        gross_transaction_value,
        ROW_NUMBER() OVER (
            PARTITION BY store_id
            ORDER BY purchase_time
        ) AS rn
    FROM transactions
)
SELECT
    store_id,
    purchase_time AS first_order_time,
    gross_transaction_value AS first_order_gross_value
FROM store_orders
WHERE rn = 1
ORDER BY store_id;
