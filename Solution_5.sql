-- Q5: Most popular item on buyers' first purchase
Explanation

We identify each buyer’s first ever purchase with ROW_NUMBER().
Then we use item_id from that first purchase to join with the items table and fetch item_name.
We group by item_name and count how many times it appears as a first purchase item.
Sorting in descending order of count and taking LIMIT 1 gives the most popular first-purchase item name.


WITH buyer_first_purchase AS (
    SELECT
        buyer_id,
        item_id,
        ROW_NUMBER() OVER (
            PARTITION BY buyer_id
            ORDER BY purchase_time
        ) AS rn
    FROM transactions
)
SELECT
    i.item_name,
    COUNT(*) AS times_as_first_item
FROM buyer_first_purchase bfp
JOIN items i
  ON bfp.item_id = i.item_id
WHERE bfp.rn = 1       -- only first purchase per buyer
GROUP BY i.item_name
ORDER BY times_as_first_item DESC, i.item_name
LIMIT 1;
