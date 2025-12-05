-- Q3: Shortest interval from purchase to refund (in minutes) per store

EXPLANATION:
We only care about rows where a refund exists (refund_item IS NOT NULL).
The time difference is refund_time - purchase_time. Using EXTRACT gives seconds; dividing by 60 converts to minutes.
MIN over each store_id gives the shortest refund interval for that store.
    
SELECT
    store_id,
    MIN(EXTRACT(EPOCH FROM (refund_time - purchase_time)) / 60.0)
        AS min_refund_interval_minutes
FROM transactions
WHERE refund_item IS NOT NULL
GROUP BY store_id
ORDER BY store_id;
