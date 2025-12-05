-- Q3: Shortest interval from purchase to refund (in minutes) per store
-- -------------------------------------------------------------------
-- Idea:
-- 1. Consider only refunded transactions (refund_item IS NOT NULL).
-- 2. Compute difference between refund_time and purchase_time in minutes.
-- 3. For each store_id, keep the MIN of this difference.

SELECT
    store_id,
    MIN(EXTRACT(EPOCH FROM (refund_time - purchase_time)) / 60.0)
        AS min_refund_interval_minutes
FROM transactions
WHERE refund_item IS NOT NULL
GROUP BY store_id
ORDER BY store_id;
