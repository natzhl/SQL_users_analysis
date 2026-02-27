-- Рассчитаем DAU / MAU Ratio чтобы посмотреть вовлечененность пользователей и регулярность посещения сайта

WITH daily AS (
  -- Уникальные пользователи в день
  SELECT
    DATE(created_at) AS day,
    COUNT(DISTINCT user_id) AS dau
  FROM `bigquery-public-data.thelook_ecommerce.events`
  GROUP BY day
),

monthly AS (
  -- Уникальные пользователи в месяц
  SELECT
    FORMAT_DATE('%Y-%m', DATE(created_at)) AS month,
    COUNT(DISTINCT user_id) AS mau
  FROM `bigquery-public-data.thelook_ecommerce.events`
  GROUP BY month
),

avg_daily AS (
  -- Средний DAU по месяцу
  SELECT
    FORMAT_DATE('%Y-%m', day) AS month,
    AVG(dau) AS avg_dau
  FROM daily
  GROUP BY month
)

-- DAU / MAU ratio
SELECT
  m.month,
  m.mau,
  ROUND(a.avg_dau,0) AS avg_dau,
  ROUND(SAFE_DIVIDE(a.avg_dau, m.mau),4) AS dau_mau_ratio
FROM monthly m
JOIN avg_daily a
  ON m.month = a.month
ORDER BY m.month;
