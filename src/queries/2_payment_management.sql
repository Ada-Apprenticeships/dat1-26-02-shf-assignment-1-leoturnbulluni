.open fittrackpro.db
.mode column

-- 2.1 
INSERT INTO payments (member_id, amount, payment_date, payment_method, payment_type)
VALUES (11, 50.00, datetime('now'), 'Credit Card', 'Monthly membership fee');

-- 2.2 
SELECT strftime('%Y-%m', payment_date) AS month,
	SUM(amount) AS total_revenue
FROM payments
WHERE payment_type LIKE '%membership fee' -- deliberately use wildcard, to match 'Monthly' and potential 'Yearly' etc
	AND payment_date BETWEEN '2024-11-01' AND '2025-02-28 23:59:59'
GROUP BY month
ORDER BY month; -- group & sort by month in output

-- 2.3 
SELECT payment_id, amount, payment_date, payment_method
FROM payments
WHERE payment_type = 'Day pass'; -- match exact format
