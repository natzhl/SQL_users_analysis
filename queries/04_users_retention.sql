-- retention за первые 12 месяцев пользователя

WITH user_activity AS (
  -- объединяем пользователей и их события
  SELECT
    u.id AS user_id,
    DATE_TRUNC(DATE(u.created_at), MONTH) AS cohort_month,
    DATE_TRUNC(DATE(e.created_at), MONTH) AS activity_month
  FROM `bigquery-public-data.thelook_ecommerce.users` u
  JOIN `bigquery-public-data.thelook_ecommerce.events` e
    ON u.id = e.user_id
),

retention_calculation AS (
  -- считаем, через сколько месяцев пользователь вернулся
  SELECT
    cohort_month,
    DATE_DIFF(activity_month, cohort_month, MONTH) AS month_number,
    COUNT(DISTINCT user_id) AS active_users
  FROM user_activity
  WHERE DATE_DIFF(activity_month, cohort_month, MONTH) BETWEEN 0 AND 12
  GROUP BY 1,2
),

cohort_sizes AS (
  -- размер каждой когорты
  SELECT
    DATE_TRUNC(DATE(created_at), MONTH) AS cohort_month,
    COUNT(DISTINCT id) AS cohort_size
  FROM `bigquery-public-data.thelook_ecommerce.users`
  GROUP BY 1
)

-- расчет retention
SELECT
  r.cohort_month,
  r.month_number,
  r.active_users,
  c.cohort_size,
  ROUND(SAFE_DIVIDE(r.active_users, c.cohort_size), 4) AS retention_rate
FROM retention_calculation r
JOIN cohort_sizes c
  ON r.cohort_month = c.cohort_month
ORDER BY r.cohort_month, r.month_number;
