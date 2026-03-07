SELECT
    SUM(oi.sale_price) AS revenue,
    SUM(oi.sale_price * 0.6) AS cost,
    SUM(oi.sale_price * 0.4) AS gross_profit,
    SUM(oi.sale_price * 0.4) / SUM(oi.sale_price) AS margin
FROM `bigquery-public-data.thelook_ecommerce.order_items` oi
JOIN `bigquery-public-data.thelook_ecommerce.orders` o
ON oi.order_id = o.order_id
WHERE o.status = 'Complete'
