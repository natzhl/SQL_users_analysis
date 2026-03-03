-- посчитаем выручку и средний чек завершенных заказов
SELECT
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(oi.sale_price) AS total_revenue,
    AVG(oi.sale_price) AS avg_item_price,
    AVG(o.num_of_item) AS avg_items_per_order,
    SUM(oi.sale_price)/COUNT(DISTINCT o.order_id) AS avg_order_value
FROM `bigquery-public-data.thelook_ecommerce.orders` o
JOIN `bigquery-public-data.thelook_ecommerce.order_items` oi ON o.order_id = oi.order_id
WHERE o.status = 'Complete';




-- считаем метрики с группировкой по месяцам, чтобы посмотреть динамику
SELECT
    FORMAT_TIMESTAMP('%Y-%m', o.created_at) AS month,  -- группировка по год-месяц
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(oi.sale_price) AS total_revenue,
    AVG(oi.sale_price) AS avg_item_price,
    AVG(o.num_of_item) AS avg_items_per_order,
    SUM(oi.sale_price)/COUNT(DISTINCT o.order_id) AS avg_order_value
FROM `bigquery-public-data.thelook_ecommerce.orders` o
JOIN `bigquery-public-data.thelook_ecommerce.order_items` oi
  ON o.order_id = oi.order_id
WHERE o.status = 'Complete'
GROUP BY month
ORDER BY month;
