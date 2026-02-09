.open fittrackpro.db
.mode csv
.separator ","
.headers on

.import --skip 1 ../data/locations.csv locations
.import --skip 1 ../data/members.csv members
.import --skip 1 ../data/staff.csv staff
.import --skip 1 ../data/equipment.csv equipment
.import --skip 1 ../data/classes.csv classes
.import --skip 1 ../data/class_schedule.csv class_schedule
.import --skip 1 ../data/memberships.csv memberships
.import --skip 1 ../data/attendance.csv attendance
.import --skip 1 ../data/class_attendance.csv class_attendance
.import --skip 1 ../data/payments.csv payments
.import --skip 1 ../data/personal_training_sessions.csv personal_training_sessions
.import --skip 1 ../data/member_health_metrics.csv member_health_metrics
.import --skip 1 ../data/equipment_maintenance_log.csv equipment_maintenance_log

.mode column