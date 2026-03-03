.open fittrackpro.db
.mode column

-- 1.1
SELECT member_id, first_name, last_name, email, join_date
FROM members;

-- 1.2
UPDATE members
SET phone_number = '07000 100005',
	email = 'emily.jones.updated@newemail.com'
WHERE member_id = 5;

-- 1.3
SELECT COUNT(*) AS total_members
FROM members;

-- 1.4
SELECT m.member_id, m.first_name, m.last_name, COUNT(ca.class_attendance_id) AS registration_count
FROM members m
JOIN class_attendance ca ON ca.member_id = m.member_id -- linking member and registration details
GROUP BY m.member_id
ORDER BY registration_count DESC -- sort by highest to lowest
LIMIT 1;

-- 1.5
SELECT m.member_id, m.first_name, m.last_name, COUNT(ca.class_attendance_id) AS registration_count
FROM members m
LEFT JOIN class_attendance ca ON ca.member_id = m.member_id
GROUP BY m.member_id
ORDER BY registration_count ASC, m.member_id ASC -- find the lowest amount of registrations
LIMIT 1;

-- 1.6

SELECT COUNT(*) AS Count
FROM (
	SELECT member_id
	FROM class_attendance
	WHERE attendance_status = 'Attended'
	GROUP BY member_id
	HAVING COUNT(*) >= 2 -- only where there are 2+ registerations for a user
);