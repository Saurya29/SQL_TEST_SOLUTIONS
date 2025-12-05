-- Q1: Count of purchases per month (excluding refunded purchases)
-- --------------------------------------------------------------
-- Idea:
-- 1. Exclude refunded purchases (refund_item IS NOT NULL).
-- 2. Group by month of purchase_time.
-- 3. Count transactions in each month.

SELECT
    DATE_TRUNC('month', purchase_time) AS purchase_month,
    COUNT(*) AS purchase_count
FROM transactions
WHERE refund_item IS NULL
GROUP BY DATE_TRUNC('month', purchase_time)
ORDER BY purchase_month;
