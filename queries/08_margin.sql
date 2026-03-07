-- считаем маржинальность (доходность бизнеса)
SELECT
    SUM(oi.sale_price) AS revenue,
    SUM(oi.sale_price * 0.6) AS cost,
    SUM(oi.sale_price * 0.4) AS gross_profit,
    SUM(oi.sale_price * 0.4) / SUM(oi.sale_price) AS margin
FROM `bigquery-public-data.thelook_ecommerce.order_items` oi
JOIN `bigquery-public-data.thelook_ecommerce.orders` o
ON oi.order_id = o.order_id
WHERE o.status = 'Complete'

-- маржинальность по товарам (топ 20 самых прибыльных товаров)
SELECT
    oi.product_id,
    SUM(oi.sale_price) AS revenue,
    SUM(oi.sale_price * 0.4) AS profit,
    SUM(oi.sale_price * 0.4) / SUM(oi.sale_price) AS margin
FROM `bigquery-public-data.thelook_ecommerce.order_items` oi
JOIN `bigquery-public-data.thelook_ecommerce.orders` o
ON oi.order_id = o.order_id
WHERE o.status = 'Complete'
GROUP BY oi.product_id
ORDER BY profit DESC
LIMIT 20

-- маржинальность по месяцам
SELECT
    FORMAT_TIMESTAMP('%Y-%m', o.created_at) AS month,
    SUM(oi.sale_price) AS revenue,
    SUM(oi.sale_price * 0.4) AS profit,
    SUM(oi.sale_price * 0.4) / SUM(oi.sale_price) AS margin
FROM `bigquery-public-data.thelook_ecommerce.order_items` oi
JOIN `bigquery-public-data.thelook_ecommerce.orders` o
ON oi.order_id = o.order_id
WHERE o.status = 'Complete'
GROUP BY month
ORDER BY month
