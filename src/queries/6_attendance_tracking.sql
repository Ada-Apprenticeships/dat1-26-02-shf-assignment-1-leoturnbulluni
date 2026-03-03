.open fittrackpro.db
.mode column

-- 6.1 
INSERT INTO attendance (member_id, location_id, check_in_time)
VALUES (7, 1, '2025-02-14 16:30:00');

-- 6.2 
SELECT date(check_in_time) AS visit_date,
	time(check_in_time) AS check_in_time, -- time function casts the check_in_time so we can use 'order by' on it later
	time(check_out_time) AS check_out_time
FROM attendance
WHERE member_id = 5
ORDER BY check_in_time;

-- 6.3 
SELECT CASE strftime('%w', check_in_time) -- identify the day of a week, in numerical form
        -- run a sqlite match/case (when/then) to convert formatted day into plaintext
		WHEN '0' THEN 'Sunday'
		WHEN '1' THEN 'Monday'
		WHEN '2' THEN 'Tuesday'
		WHEN '3' THEN 'Wednesday'
		WHEN '4' THEN 'Thursday'
		WHEN '5' THEN 'Friday'
		WHEN '6' THEN 'Saturday'
	END AS day_of_week,
	COUNT(*) AS visit_count -- count instances of each day
FROM attendance
GROUP BY day_of_week
ORDER BY visit_count DESC
LIMIT 1; -- only show the top (busiest) day

-- 6.4 
SELECT l.name AS location_name, AVG(daily.count) AS avg_daily_attendance
FROM (
	SELECT location_id, date(check_in_time) AS day, COUNT(*) AS count
	FROM attendance
	GROUP BY location_id, day -- find all location_ids so that the average daily attendance can be calculated for each
) AS daily
JOIN locations l ON l.location_id = daily.location_id
GROUP BY l.location_id;
