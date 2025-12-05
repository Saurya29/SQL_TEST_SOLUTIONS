-- Q6: Refund processing flag (<= 72 hours)
Explanation
  
We use a CASE expression:

1.If refund_item is null → no refund, so we simply label 'NOT_REFUNDED'.Otherwise, we compute the time difference in hours.

2.If ≤ 72, refund is eligible → 'PROCESS_REFUND'.

3.If > 72, it is outside the allowed window → 'EXCEEDS_WINDOW'.

SELECT
    t.*,
    CASE
        WHEN refund_item IS NULL THEN
            'NOT_REFUNDED'
        WHEN EXTRACT(EPOCH FROM (refund_time - purchase_time)) / 3600.0 <= 72
            THEN 'PROCESS_REFUND'
        ELSE
            'EXCEEDS_WINDOW'
    END AS refund_process_flag
FROM transactions t
ORDER BY purchase_time;
