-- Q8: Second transaction time per buyer (no MIN/MAX)

Explanation

We avoid MIN/MAX completely and rely on ROW_NUMBER().
For each buyer_id, we order transactions chronologically by purchase_time.
The row with rn = 2 is exactly the second transaction for that buyer.
This works regardless of how many total transactions there are per buyer.

WITH ordered_tx AS (
    SELECT
        buyer_id,
        purchase_time,
        store_id,
        item_id,
        gross_transaction_value,
        ROW_NUMBER() OVER (
            PARTITION BY buyer_id
            ORDER BY purchase_time
        ) AS rn
    FROM transactions
)
SELECT
    buyer_id,
    purchase_time AS second_transaction_time,
    store_id,
    item_id,
    gross_transaction_value
FROM ordered_tx
WHERE rn = 2
ORDER BY buyer_id;
