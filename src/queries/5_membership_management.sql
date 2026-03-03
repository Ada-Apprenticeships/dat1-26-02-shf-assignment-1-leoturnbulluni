.open fittrackpro.db
.mode column

-- 5.1 
SELECT m.member_id, m.first_name, m.last_name, ms.type AS membership_type, m.join_date
FROM members m
JOIN memberships ms ON ms.member_id = m.member_id
WHERE ms.status = 'Active';

-- 5.2 
SELECT ms.type AS membership_type,
	AVG(
        (julianday(a.check_out_time) - julianday(a.check_in_time)) -- using julian in order to use calculations
        * 1440 -- total minutes in a day
    ) AS avg_visit_duration_minutes
FROM attendance a
JOIN memberships ms ON ms.member_id = a.member_id
WHERE a.check_out_time IS NOT NULL -- sanitise by not allowing null checkout times
    AND date(a.check_in_time) BETWEEN ms.start_date AND ms.end_date
GROUP BY ms.type;

-- 5.3 
SELECT m.member_id, m.first_name, m.last_name, m.email, ms.end_date
FROM members m
JOIN memberships ms ON ms.member_id = m.member_id
WHERE ms.end_date BETWEEN '2025-01-01' AND '2025-12-31'; -- hardcoded dates instead of eg "+365 days" so that leap years do not cause issues in future