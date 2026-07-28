USE retail_db;
SELECT * FROM support_tickets;

SELECT issue_category,
ROUND(AVG(resolution_time_hours),2) AS avg_resolution_time,
ROUND(AVG(customer_satisfaction_score),2) AS avg_customer_satisfaction
FROM support_tickets
WHERE priority='High'
AND resolution_status='Closed'
GROUP BY issue_category
HAVING COUNT(*)>5;



WITH customer_count AS (
    SELECT
        preferred_channel,
        COUNT(*) AS total_registered_customers
    FROM customers
    GROUP BY preferred_channel
),

add_to_cart AS (
    SELECT
        c.preferred_channel,
        COUNT(*) AS total_add_to_cart
    FROM customers c
    LEFT JOIN interactions i
        ON c.customer_id = i.customer_id
    WHERE i.interaction_type = 'Add to Cart'
    GROUP BY c.preferred_channel
),

revenue AS (
    SELECT
        c.preferred_channel,
        SUM(t.price * t.quantity) AS total_revenue
    FROM customers c
    LEFT JOIN transactions t
        ON c.customer_id = t.customer_id
    GROUP BY c.preferred_channel
),

tickets AS (
    SELECT
        c.preferred_channel,
        COUNT(s.ticket_id) AS total_support_tickets
    FROM customers c
    LEFT JOIN support_tickets s
        ON c.customer_id = s.customer_id
    GROUP BY c.preferred_channel
)

SELECT
    cc.preferred_channel,
    cc.total_registered_customers,
    COALESCE(atc.total_add_to_cart,0) AS total_add_to_cart,
    COALESCE(r.total_revenue,0) AS total_revenue,
    COALESCE(t.total_support_tickets,0) AS total_support_tickets
FROM customer_count cc
LEFT JOIN add_to_cart atc
    ON cc.preferred_channel = atc.preferred_channel
LEFT JOIN revenue r
    ON cc.preferred_channel = r.preferred_channel
LEFT JOIN tickets t
    ON cc.preferred_channel = t.preferred_channel
ORDER BY total_revenue DESC;
