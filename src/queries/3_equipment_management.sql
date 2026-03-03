.open fittrackpro.db
.mode column

-- 3.1 
SELECT equipment_id, name, next_maintenance_date
FROM equipment
WHERE next_maintenance_date BETWEEN '2025-01-01' AND date('2025-01-01', '+30 days'); -- calculating end programatically to avoid errors

-- 3.2 
SELECT type AS equipment_type, COUNT(*) AS count
FROM equipment
GROUP BY type;

-- 3.3 
SELECT type AS equipment_type,
	AVG(julianday('now') - julianday(purchase_date)) AS avg_age_days -- using julianday to allow calculations
FROM equipment
GROUP BY type;
