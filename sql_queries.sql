-- Check the number of customers for each campaign
SELECT
    cc.campaign_id,
    c.campaign_name,
    COUNT(cc.customer_id) AS number_of_customers
FROM
    customer_campaigns cc
JOIN
    campaigns c ON cc.campaign_id = c.campaign_id
GROUP BY
    cc.campaign_id, c.campaign_name
ORDER BY
    cc.campaign_id;


-- Total number of transactions and total sales for each campaign
SELECT
    t.campaign_id,
    c.campaign_name,
    COUNT(t.transaction_id) AS number_of_transactions,
    SUM(t.amount) AS total_revenue
FROM
    transactions t
JOIN
    campaigns c ON t.campaign_id = c.campaign_id
GROUP BY
    t.campaign_id, c.campaign_name
ORDER BY
    t.campaign_id;


-- Average spending per customer for each campaign
SELECT
    cc.campaign_id,
    c.campaign_name,
    AVG(t.amount) AS avg_spent_per_customer
FROM
    customer_campaigns cc
JOIN
    transactions t ON cc.customer_id = t.customer_id
JOIN
    campaigns c ON cc.campaign_id = c.campaign_id
GROUP BY
    cc.campaign_id, c.campaign_name
ORDER BY
    cc.campaign_id;


-- Conversion rate (percentage of customers who made a purchase after receiving the campaign)
SELECT
    cc.campaign_id,
    c.campaign_name,
    COUNT(DISTINCT CASE WHEN t.transaction_id IS NOT NULL THEN cc.customer_id END) * 1.0 / COUNT(DISTINCT cc.customer_id) AS conversion_rate
FROM
    customer_campaigns cc
LEFT JOIN
    transactions t ON cc.customer_id = t.customer_id
JOIN
    campaigns c ON cc.campaign_id = c.campaign_id
GROUP BY
    cc.campaign_id, c.campaign_name
ORDER BY
    cc.campaign_id;


-- Quick summary: Number of customers, transactions, sales, and purchase rate
SELECT
    cc.campaign_id,
    c.campaign_name,
    COUNT(DISTINCT cc.customer_id) AS customers_assigned,
    COUNT(t.transaction_id) AS transactions_made,
    COALESCE(SUM(t.amount), 0) AS total_sales,
    ROUND(
        COUNT(DISTINCT CASE WHEN t.transaction_id IS NOT NULL THEN cc.customer_id END) * 100.0 / COUNT(DISTINCT cc.customer_id),
        2
    ) AS conversion_rate_percent
FROM
    customer_campaigns cc
LEFT JOIN
    transactions t ON cc.customer_id = t.customer_id
JOIN
    campaigns c ON cc.campaign_id = c.campaign_id
GROUP BY
    cc.campaign_id, c.campaign_name
ORDER BY
    cc.campaign_id;










