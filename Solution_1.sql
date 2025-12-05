-- Q1: Count of purchases per month (excluding refunded purchases)

Explanation

1.We only want successful purchases, so we remove rows where refund_item is not null (those were refunded).
2.Then we truncate purchase_time to the month (e.g., 2019-09-01, 2020-04-01), group by that month, and count how many transactions happened in each month.

SELECT
    DATE_TRUNC('month', purchase_time) AS purchase_month,
    COUNT(*) AS purchase_count
FROM transactions
WHERE refund_item IS NULL
GROUP BY DATE_TRUNC('month', purchase_time)
ORDER BY purchase_month;
