SELECT
  main_category,
  AVG(rating) AS avg_rating,
  AVG(discount_pct) AS avg_discount,
  CORR(rating, discount_pct) AS discount_rating_correlation
FROM {{ ref('fct_product_performance') }}
GROUP BY 1