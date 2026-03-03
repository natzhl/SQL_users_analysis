-- топ 10 товаров по выручке за каждый месяц

WITH monthly_product_revenue AS (
    SELECT
        FORMAT_TIMESTAMP('%Y-%m', o.created_at) AS month,
        oi.product_id,
        p.name,
        SUM(oi.sale_price) AS revenue
    FROM `bigquery-public-data.thelook_ecommerce.order_items` oi
    JOIN `bigquery-public-data.thelook_ecommerce.orders` o
      ON oi.order_id = o.order_id
    LEFT JOIN `bigquery-public-data.thelook_ecommerce.products` p
      ON oi.product_id = p.id
    WHERE o.status = 'Complete'
    GROUP BY month, oi.product_id, p.name
),
ranked_products AS (
    SELECT
        month,
        product_id,
        name,
        revenue,
        ROW_NUMBER() OVER (PARTITION BY month ORDER BY revenue DESC) AS rank
    FROM monthly_product_revenue
)
SELECT
    month,
    product_id,
    name,
    revenue,
    rank
FROM ranked_products
WHERE rank <= 10
ORDER BY month, rank;
