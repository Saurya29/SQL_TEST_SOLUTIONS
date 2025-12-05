
-- Q7: Second purchase per buyer (ignoring refunds)

Explanation

We ignore refunded rows by filtering on refund_item IS NULL.
For each buyer_id, we sort all their remaining transactions by purchase_time and number them with ROW_NUMBER().
The row where rn = 2 is that buyer’s second successful purchase.
In the given data, only buyer 3 has at least two such purchases, so only buyer 3’s second purchase appears.

WITH buyer_purchases AS (
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
    WHERE refund_item IS NULL
)
SELECT
    buyer_id,
    purchase_time AS second_purchase_time,
    store_id,
    item_id,
    gross_transaction_value
FROM buyer_purchases
WHERE rn = 2
ORDER BY buyer_id;
