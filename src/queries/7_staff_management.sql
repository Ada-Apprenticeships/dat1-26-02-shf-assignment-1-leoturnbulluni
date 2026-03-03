.open fittrackpro.db
.mode column

-- 7.1 
SELECT staff_id, first_name, last_name, position AS role
FROM staff
ORDER BY position, last_name; -- sort by position, then within position, by last name

-- 7.2 
SELECT s.staff_id AS trainer_id,
	s.first_name || ' ' || s.last_name AS trainer_name, -- combine first and last name using sqlite operator || and a blank space to separate names
	COUNT(pts.session_id) AS session_count
FROM staff s
JOIN personal_training_sessions pts ON pts.staff_id = s.staff_id
WHERE s.position = 'Trainer' -- only select from Trainers
	AND pts.session_date BETWEEN '2025-01-20' AND date('2025-01-20', '+30 days') -- using relative time for ease of change (eg if reusing query at a later date)
GROUP BY s.staff_id
HAVING session_count >= 1; -- don't show trainers with less than 1 session