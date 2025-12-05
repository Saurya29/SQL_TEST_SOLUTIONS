-- Q2: Stores with at least 5 orders in October 2020
-- -------------------------------------------------
-- Idea:
-- 1. Filter transactions for October 2020.
-- 2. Count number of orders per store.
-- 3. Keep only stores with count >= 5.
-- 4. Count how many such stores exist.

WITH store_october_orders AS (
    SELECT
        store_id,
        COUNT(*) AS order_count
    FROM transactions
    WHERE purchase_time >= DATE '2020-10-01'
      AND purchase_time <  DATE '2020-11-01'
    GROUP BY store_id
    HAVING COUNT(*) >= 5
)
SELECT COUNT(*) AS store_count_with_5plus_orders
FROM store_october_orders;
