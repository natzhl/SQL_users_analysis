-- в марте 2026 произошел сильный всплеск активности, поэтому посмотрим откуда мог придти трафик пользователей

WITH march_events AS (
  SELECT
    DATE(created_at) AS event_date,
    traffic_source,
    COUNT(*) AS events_count
  FROM bigquery-public-data.thelook_ecommerce.events
  WHERE EXTRACT(YEAR FROM created_at) = 2026
    AND EXTRACT(MONTH FROM created_at) = 3
  GROUP BY event_date, traffic_source
)
SELECT
  event_date,
  traffic_source,
  events_count
FROM march_events
ORDER BY event_date, events_count DESC;
