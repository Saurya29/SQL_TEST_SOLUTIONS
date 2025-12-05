-- Q4: Gross transaction value of each store's first order
Explanation

1.For each store, we sort all transactions by their purchase_time.
ROW_NUMBER() assigns 1 to the earliest transaction for that store.
Picking WHERE rn = 1 gives us one row per store, containing both the timestamp and gross_transaction_value of that first order.
    

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
