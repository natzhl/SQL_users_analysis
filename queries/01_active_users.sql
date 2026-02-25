-- MAU (monthly active users)
-- активные = те, которые совершили событие (event)
SELECT
  -- выбираем месяц и группируем события по месяцу
  FORMAT_DATE('%Y-%m', DATE(created_at)) AS month,
  -- считаем уникальных пользователей
  COUNT(DISTINCT user_id) AS active_users
FROM `bigquery-public-data.thelook_ecommerce.events`
GROUP BY month
ORDER BY month;
