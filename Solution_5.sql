-- Q5: Most popular item on buyers' first purchase
-- -----------------------------------------------
-- Idea:
-- 1. For each buyer_id, find their first purchase using ROW_NUMBER.
-- 2. From those first purchases, get the item_id.
-- 3. Join with items table to get item_name.
-- 4. Count how many buyers have each item_name as their first item.
-- 5. Return the item with the highest count.

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
