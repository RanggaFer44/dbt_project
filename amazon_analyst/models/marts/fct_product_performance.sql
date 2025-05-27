SELECT
  product_id,
  product_name,
  main_category,
  actual_price,
  discounted_price,
  discount_pct,
  -- Cast rating to FLOAT before comparison
  CAST(rating AS FLOAT64) AS rating,
  rating_count,
  CASE 
    WHEN discount_pct > 0.5 THEN 'High Discount'
    ELSE 'Normal Discount' 
  END AS discount_strategy,
  -- Fixed comparison by ensuring numeric types
  CASE 
    WHEN CAST(rating AS FLOAT64) >= 4.0 THEN TRUE 
    ELSE FALSE 
  END AS is_high_rated
FROM {{ ref('stg_daset') }}