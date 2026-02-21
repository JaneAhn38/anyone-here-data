-- 03_compute_spot_presence.sql
USE anyoneheredb;

TRUNCATE TABLE spot_presence;

INSERT INTO spot_presence (spot_id, active_user_count, calculated_at)
SELECT
    s.spot_id,
    COUNT(DISTINCT l.user_id) AS active_user_count,
    NOW() AS calculated_at
FROM spots s
JOIN location_logs l
  ON ST_Distance_Sphere(
       POINT(s.longitude, s.latitude),
       POINT(l.longitude, l.latitude)
     ) <= s.radius_m
-- 시간 조건 제거: 샘플 데이터 전체를 기준으로 집계
GROUP BY s.spot_id;
