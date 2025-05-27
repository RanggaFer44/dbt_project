CREATE OR REPLACE MODEL `{{ target.dataset }}.review_sentiment`
OPTIONS(model_type='LOGISTIC_REG') AS
SELECT
  LOWER(review_title) AS text,
  -- Label positive sentiment manually
  CASE 
    WHEN review_title LIKE '%Good%' OR review_title LIKE '%Satisfied%' THEN 1
    ELSE 0 
  END AS label
FROM {{ source('amazons', 'first-dataset') }};