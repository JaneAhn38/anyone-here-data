-- 04_create_view_spot_status.sql
USE anyoneheredb;

CREATE OR REPLACE VIEW v_spot_status AS
SELECT
    s.spot_id,
    s.spot_name,
    s.latitude,
    s.longitude,
    s.radius_m,
    p.active_user_count,
    p.calculated_at
FROM spots s
LEFT JOIN spot_presence p
  ON p.spot_id = s.spot_id
  AND p.calculated_at = (
      SELECT MAX(p2.calculated_at)
      FROM spot_presence p2
      WHERE p2.spot_id = s.spot_id
  );
