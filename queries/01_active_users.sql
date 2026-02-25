SELECT
  FORMAT_DATE('%Y-%m', DATE(created_at)) AS month,
  COUNT(DISTINCT user_id) AS active_users
FROM `bigquery-public-data.thelook_ecommerce.events`
GROUP BY month
ORDER BY month;
