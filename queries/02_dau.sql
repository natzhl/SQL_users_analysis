-- DAU (daily active users)
-- Активный пользователь = пользователь, совершивший больше 1 события в день

SELECT
  DATE(created_at) AS date,
  COUNT(DISTINCT user_id) AS dau
FROM `bigquery-public-data.thelook_ecommerce.events`
GROUP BY date
ORDER BY date;
