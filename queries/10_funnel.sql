WITH funnel_steps AS (
  SELECT 
    user_id,
    MIN(CASE WHEN event_type = 'home' THEN created_at END) AS home_time,
    MIN(CASE WHEN event_type = 'product' THEN created_at END) AS product_time,
    MIN(CASE WHEN event_type = 'cart' THEN created_at END) AS cart_time,
    MIN(CASE WHEN event_type = 'purchase' THEN created_at END) AS purchase_time
  FROM `bigquery-public-data.thelook_ecommerce.events`
  GROUP BY user_id
)

SELECT 
  COUNTIF(home_time IS NOT NULL) AS step_1_home,

  COUNTIF(
    home_time IS NOT NULL 
    AND product_time IS NOT NULL 
    AND product_time > home_time
  ) AS step_2_product,

  COUNTIF(
    home_time IS NOT NULL 
    AND product_time IS NOT NULL 
    AND cart_time IS NOT NULL 
    AND product_time > home_time
    AND cart_time > product_time
  ) AS step_3_cart,

  COUNTIF(
    home_time IS NOT NULL 
    AND product_time IS NOT NULL 
    AND cart_time IS NOT NULL 
    AND purchase_time IS NOT NULL
    AND product_time > home_time
    AND cart_time > product_time
    AND purchase_time > cart_time
  ) AS step_4_purchase

FROM funnel_steps;
