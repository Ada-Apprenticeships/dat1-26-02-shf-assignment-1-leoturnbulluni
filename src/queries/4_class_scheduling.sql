.open fittrackpro.db
.mode column

-- 4.1 
SELECT c.class_id, c.name AS class_name,
    s.first_name || ' ' || s.last_name AS instructor_name -- combine first and last name using sqlite || with a space between
FROM classes c
JOIN class_schedule cs ON cs.class_id = c.class_id -- link classes to their respective schedules...
JOIN staff s ON s.staff_id = cs.staff_id;          -- ...and respective staff

-- 4.2 
SELECT cs.schedule_id, c.name, cs.start_time, cs.end_time,
	(c.capacity - IFNULL(reg.registered_count, 0)) AS available_spots
	-- IFNULL ensures that if the registered count is unset, 0 is a faalback
FROM class_schedule cs
JOIN classes c ON c.class_id = cs.class_id
LEFT JOIN ( -- left join needed otherwise empty classes would not show
	SELECT schedule_id, COUNT(*) AS registered_count
	FROM class_attendance
	WHERE attendance_status IN ('Registered', 'Attended')
	GROUP BY schedule_id
) reg ON reg.schedule_id = cs.schedule_id
WHERE date(cs.start_time) = '2025-02-01';

-- 4.3 
INSERT INTO class_attendance (schedule_id, member_id, attendance_status)
VALUES (
	(   -- finds the correct schedule_id from the parametres
        SELECT schedule_id
        FROM class_schedule
        WHERE class_id = 1
        AND date(start_time) = '2025-02-01'
        LIMIT 1
    ),
	11,
	'Registered'
);

-- 4.4 
DELETE FROM class_attendance
WHERE schedule_id = 7 AND member_id = 3;

-- 4.5 
SELECT c.class_id, c.name AS class_name,
    COUNT(ca.class_attendance_id) AS registration_count
FROM classes c
JOIN class_schedule cs ON cs.class_id = c.class_id
JOIN class_attendance ca ON ca.schedule_id = cs.schedule_id AND ca.attendance_status = 'Registered'
GROUP BY c.class_id
ORDER BY registration_count DESC -- order from 'most popular' to 'least popular' by reg count
LIMIT 3;

-- 4.6 
SELECT AVG(count) AS average_classes_per_member
FROM ( -- no WHERE, use a custom datsaet directly in the FROM
	SELECT member_id, COUNT(*) AS count
	FROM class_attendance
	WHERE attendance_status IN ('Registered', 'Attended') -- registered OR attended - both count
	GROUP BY member_id
);
