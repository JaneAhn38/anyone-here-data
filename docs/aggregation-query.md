INSERT INTO spot_presence (spot_id, active_user_count, calculated_at)
SELECT
    s.spot_id,
    COUNT(DISTINCT l.user_id) AS active_user_count, // 중복 제거 (한 명의 user가 위치 로그 여러 개 찍혀도 1명으로만 계산)
    NOW() AS calculated_at
FROM spots s
LEFT JOIN location_logs l
    ON l.logged_at >= NOW() - INTERVAL 10 MINUTE //최근 10분 필터링
   AND ST_Distance_Sphere( 
        POINT(l.longitude, l.latitude),
        POINT(s.longitude, s.latitude)
       ) <= s.radius_m // 거리 계산 (스팟 내에 user가 속해있는 지를 계산)
GROUP BY s.spot_id
ON DUPLICATE KEY UPDATE
    active_user_count = VALUES(active_user_count),
    calculated_at = VALUES(calculated_at);
