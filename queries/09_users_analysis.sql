-- средний возраст пользователей и разбивка по полу
SELECT 
  gender,
  AVG(age) AS avg_age,
  COUNT(*) AS users
FROM `bigquery-public-data.thelook_ecommerce.users`
GROUP BY gender;

-- топ 10 стран откуда пользователи
SELECT 
  country,
  COUNT(*) AS users
FROM `bigquery-public-data.thelook_ecommerce.users`
GROUP BY country
ORDER BY users DESC
LIMIT 10;

-- сколько заказов на пользователя
SELECT 
  user_id,
  COUNT(order_id) AS orders_count
FROM `bigquery-public-data.thelook_ecommerce.orders`
WHERE status = 'Complete'
GROUP BY user_id;

-- доля тех, кто совершил покупку среди всех пользователей
SELECT 
  COUNT(DISTINCT o.user_id) / COUNT(DISTINCT u.id) AS conversion_to_purchase
FROM `bigquery-public-data.thelook_ecommerce.users` u
LEFT JOIN `bigquery-public-data.thelook_ecommerce.orders` o
ON u.id = o.user_id
AND o.status = 'Complete';
