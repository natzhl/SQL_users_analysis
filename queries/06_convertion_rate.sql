-- считаем конверсию (пользователи с заказом / общее кол-во активных пользователей)

-- пользователи с заказом по месяцам
WITH monthly_orders AS (
    SELECT DISTINCT user_id, FORMAT_TIMESTAMP('%Y-%m', created_at) AS month
    FROM `bigquery-public-data.thelook_ecommerce.orders`
    WHERE status = 'Complete'
),
-- активные пользователи за месяц
monthly_users AS (
    SELECT DISTINCT user_id, FORMAT_TIMESTAMP('%Y-%m', created_at) AS month
    FROM `bigquery-public-data.thelook_ecommerce.orders`
)
SELECT
    mu.month,
    COUNT(DISTINCT mo.user_id) * 1.0 / COUNT(DISTINCT mu.user_id) AS conversion_rate
FROM monthly_users mu
LEFT JOIN monthly_orders mo
  ON mu.user_id = mo.user_id AND mu.month = mo.month
GROUP BY mu.month
ORDER BY mu.month;
