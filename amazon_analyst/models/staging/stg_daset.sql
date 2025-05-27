SELECT
  product_id,
  product_name,
  -- Clean category hierarchy (extract main category)
  SPLIT(REGEXP_REPLACE(category, '&+', '&'), '|')[SAFE_OFFSET(0)] AS main_category,
  -- Convert prices to numeric (remove currency symbols)
  CASE
    WHEN discounted_price IS NOT NULL THEN 
      CAST(REGEXP_REPLACE(CAST(discounted_price AS STRING), '[^0-9]', '') AS INT64)
    ELSE NULL
  END AS discounted_price,
  CASE
    WHEN actual_price IS NOT NULL THEN 
      CAST(REGEXP_REPLACE(CAST(actual_price AS STRING), '[^0-9]', '') AS INT64)
    ELSE NULL
  END AS actual_price,
  -- Fix decimal separator in discount (replace comma with dot)
  CASE
    WHEN discount_percentage IS NOT NULL THEN 
      CAST(REPLACE(CAST(discount_percentage AS STRING), ',', '.') AS FLOAT64)
    ELSE NULL
  END AS discount_pct,
  rating,
  -- Remove commas from rating count
  CASE
    WHEN rating_count IS NOT NULL THEN 
      CAST(REPLACE(CAST(rating_count AS STRING), ',', '') AS INT64)
    ELSE NULL
  END AS rating_count
FROM {{ source('amazons', 'first-dataset') }}