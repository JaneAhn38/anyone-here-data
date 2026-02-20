-- 02_seed_sample_data.sql
-- anyoneheredb 샘플 데이터 적재 스크립트

USE anyoneheredb;

-- 외래키 제약 잠시 비활성화
SET FOREIGN_KEY_CHECKS = 0;

TRUNCATE TABLE location_logs;
TRUNCATE TABLE users;
TRUNCATE TABLE spots;

-- 다시 활성화
SET FOREIGN_KEY_CHECKS = 1;

-- spots.csv
LOAD DATA INFILE
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/AnyoneHere/sample-data/spots.csv'
INTO TABLE spots
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(spot_id, spot_name, latitude, longitude);

-- users.csv
LOAD DATA INFILE
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/AnyoneHere/sample-data/users.csv'
INTO TABLE users
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(user_id, email, created_at);

-- location_logs.csv
LOAD DATA INFILE
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/AnyoneHere/sample-data/location_logs.csv'
INTO TABLE location_logs
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@dummy_log_id, user_id, latitude, longitude, @logged_at_str)
SET logged_at = STR_TO_DATE(CONCAT(@logged_at_str, ':00'), '%Y-%m-%d %H:%i:%s');
