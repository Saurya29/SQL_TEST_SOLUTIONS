-- Q2: Stores with at least 5 orders in October 2020
Explanation

1.We isolate October 2020 using a date range [2020-10-01, 2020-11-01).
2.For each store_id, we count the number of transactions in that month.
3.Using HAVING COUNT(*) >= 5, we keep only those stores with at least 5 orders, and finally count how many such stores exist.

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
