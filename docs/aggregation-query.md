## Spot Active User Aggregation Query

- 최근 10분 내 위치 로그 기준
- 스팟 반경 내 사용자 수 집계
- 동일 user는 1명으로 계산
- spot_presence 테이블에 upsert


```sql
INSERT INTO spot_presence (spot_id, active_user_count, calculated_at)
SELECT 
    s.spot_id,
    COUNT(DISTINCT l.user_id) AS active_user_count,  -- 한 유저가 여러 번 찍어도 1명으로 계산
    NOW() AS calculated_at                           -- 집계 수행 시각
FROM spots s
LEFT JOIN location_logs l
    ON ST_Distance_Sphere(
        POINT(l.longitude, l.latitude),
        POINT(s.longitude, s.latitude)
    ) <= s.radius_m                                  -- 스팟 반경 내 위치만
    AND l.logged_at >= NOW() - INTERVAL 10 MINUTE    -- 최근 10분 로그만
GROUP BY s.spot_id
ON DUPLICATE KEY UPDATE
    active_user_count = VALUES(active_user_count),
    calculated_at = VALUES(calculated_at);
```
