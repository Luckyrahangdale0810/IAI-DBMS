USE retail_db;
SELECT
    full_name,
    email,
    city,
    preferred_channel
FROM customers
WHERE state IN ('California', 'Texas')
AND registration_date > '2023-01-01'
ORDER BY full_name ASC;

SELECT
    c.customer_id,
    c.full_name,
    c.email,
    ROUND(SUM(t.price * t.quantity), 2) AS total_spent,
    COUNT(t.transaction_id) AS total_transactions
FROM customers c
JOIN transactions t
    ON c.customer_id = t.customer_id
WHERE t.store_location = 'Online'
GROUP BY
    c.customer_id,
    c.full_name,
    c.email
HAVING
    SUM(t.price * t.quantity) > 1000
    AND COUNT(t.transaction_id) >= 3
ORDER BY
    total_spent DESC;
    
SELECT * FROM support_tickets;

SELECT * FROM support_tickets;

SELECT issue_category,
AVG(resolution_time_hours),
AVG(customer_satisfaction_score)
FROM support_tickets
WHERE priority='High'
AND resolution_status='Closed'
GROUP BY issue_category;
WHERE priority='High'
AND resolution_status='Closed';

SELECT
issue_category,
ROUND(AVG(resolution_time_hours),2) AS avg_resolution_time,
ROUND(AVG(customer_satisfaction_score),2) AS avg_customer_satisfaction
FROM support_tickets
WHERE priority='High'
AND resolution_status='Closed'
GROUP BY issue_category;

SELECT
    issue_category,
    ROUND(AVG(resolution_time_hours), 2) AS avg_resolution_time,
    ROUND(AVG(customer_satisfaction_score), 2) AS avg_customer_satisfaction
FROM support_tickets
WHERE priority = 'High'
  AND resolution_status = 'Closed'
GROUP BY issue_category
HAVING COUNT(*) > 5;
