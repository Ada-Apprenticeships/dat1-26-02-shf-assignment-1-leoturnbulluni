.open fittrackpro.db
.mode column

-- 8.1 
SELECT pts.session_id,
	m.first_name || ' ' || m.last_name AS member_name, -- combine member first and last name, with a blank space between
	pts.session_date,
	pts.start_time,
	pts.end_time
FROM personal_training_sessions pts
JOIN staff s ON s.staff_id = pts.staff_id --        combine with staff table (to find trainer name)
JOIN members m ON m.member_id = pts.member_id --    combine with members table (to access member names)
WHERE s.first_name = 'Ivy' AND s.last_name = 'Irwin';