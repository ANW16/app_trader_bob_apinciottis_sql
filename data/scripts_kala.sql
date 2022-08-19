SELECT *
FROM app_store_apps;

SELECT *
FROM play_store_apps;

-- FORMULA CHECKING FOR COMBINED REVIEW SCORE

SELECT DISTINCT name, a1.rating AS apple_rating, p1.rating AS google_rating, a1.content_rating AS apple_content_rating, p1.content_rating AS google_content_rating
    a1.primary_genre AS apple_genre, p1.genres AS google_genre,
    a1.review_count AS apple_reviewcount, p1.review_count AS google_reviewcount,
    a1.rating * CAST(a1.review_count AS int) AS apple_review_multiplier, p1.rating * p1.review_count AS google_review_mulitplier,
    CAST(a1.review_count AS int) + p1.review_count AS combined_reviewcount,  
   ROUND(((a1.rating * CAST(a1.review_count AS int)) + (p1.rating * p1.review_count))/(CAST(a1.review_count AS int) + p1.review_count),1) AS Combined_rating 
FROM app_store_apps as a1
    INNER JOIN play_store_apps as p1
    USING (name);

-- SIMPLIFIED CODE AFTER VERIFICATION FOR REVIEW SCORE

SELECT DISTINCT name,
    a1.primary_genre AS apple_genre, p1.genres AS google_genre,  
   ROUND(((a1.rating * CAST(a1.review_count AS int)) + (p1.rating * p1.review_count))/(CAST(a1.review_count AS int) + p1.review_count),1) AS Combined_rating 
FROM app_store_apps as a1
    INNER JOIN play_store_apps as p1
    USING (name);
    
-- FINDING LONGEVITY 

SELECT DISTINCT name,
    a1.primary_genre AS apple_genre, p1.genres AS google_genre,  
   ROUND(((a1.rating * CAST(a1.review_count AS int)) + (p1.rating * p1.review_count))/(CAST(a1.review_count AS int) + p1.review_count),1) AS Combined_rating,
  ROUND((ROUND(((a1.rating * CAST(a1.review_count AS int)) + (p1.rating * p1.review_count))/(CAST(a1.review_count AS int) + p1.review_count),1)/.5),1)+1 AS projected_lifespan_years
FROM app_store_apps as a1
    INNER JOIN play_store_apps as p1
    USING (name);

-- FINDING PRICE FORMATTED AS MONEY

SELECT DISTINCT name, 
    CAST(a1.price AS money) AS apple_price, 
    CAST(REPLACE(p1.price, '$','') AS money) AS google_price, 
    a1.content_rating AS apple_content_rating, 
    p1.content_rating AS google_content_rating,
    a1.primary_genre AS apple_genre, 
    p1.genres AS google_genre,  
   ROUND(((a1.rating * CAST(a1.review_count AS int)) + (p1.rating * p1.review_count))/(CAST(a1.review_count AS int) + p1.review_count),1) AS Combined_rating,
  ROUND((ROUND(((a1.rating * CAST(a1.review_count AS int)) + (p1.rating * p1.review_count))/(CAST(a1.review_count AS int) + p1.review_count),1)/.5),1)+1 AS projected_lifespan_years
FROM app_store_apps as a1
    INNER JOIN play_store_apps as p1
    USING (name)
    ORDER BY combined_rating DESC;

-- FINDING COST BASED ON PRICE
WITH apple_cost_table AS(
    SELECT DISTINCT name,
        CASE
        WHEN price <= 1
        THEN 10000
        ELSE price * 10000
        END AS apple_cost
        FROM app_store_apps),

    google_cost_table AS(
    SELECT DISTINCT name,
        CASE
        WHEN CAST(REPLACE(price, '$','') AS numeric) <= 1
        THEN 10000
        ELSE CAST(REPLACE(price, '$','') AS numeric) * 10000
        END AS google_cost
        FROM play_store_apps)

SELECT DISTINCT name,
    CAST(apple_cost AS money),
    CAST(google_cost AS money),
    CAST(a1.price AS money) AS apple_price, 
    CAST(REPLACE(p1.price, '$','') AS money) AS google_price, 
    a1.content_rating AS apple_content_rating, 
    p1.content_rating AS google_content_rating,
    a1.primary_genre AS apple_genre, 
    p1.genres AS google_genre,  
   ROUND(((a1.rating * CAST(a1.review_count AS int)) + (p1.rating * p1.review_count))/(CAST(a1.review_count AS int) + p1.review_count),1) AS Combined_rating,
  (ROUND((ROUND(((a1.rating * CAST(a1.review_count AS int)) + (p1.rating * p1.review_count))/(CAST(a1.review_count AS int) + p1.review_count),1)/.5),0)+1) AS projected_lifespan_years
FROM app_store_apps as a1
    INNER JOIN play_store_apps as p1
    USING (name)
    LEFT JOIN apple_cost_table
    USING (name)
    LEFT JOIN google_cost_table
    USING (name)
ORDER BY apple_price DESC;

--Finding ROI based on cost per month, revenue per month, longevity

WITH apple_cost_table AS(
    SELECT DISTINCT name,
        CASE
        WHEN price <= 1
        THEN 10000
        ELSE price * 10000
        END AS apple_cost
        FROM app_store_apps),

    google_cost_table AS(
    SELECT DISTINCT name,
        CASE
        WHEN CAST(REPLACE(price, '$','') AS numeric) <= 1
        THEN 10000
        ELSE CAST(REPLACE(price, '$','') AS numeric) * 10000
        END AS google_cost
        FROM play_store_apps)

SELECT DISTINCT name,
    CAST(apple_cost AS money),
    CAST(google_cost AS money),
    CAST(a1.price AS money) AS apple_price, 
    CAST(REPLACE(p1.price, '$','') AS money) AS google_price, 
    SUM()
    a1.content_rating AS apple_content_rating, 
    p1.content_rating AS google_content_rating,
    a1.primary_genre AS apple_genre, 
    p1.genres AS google_genre,  
   ROUND(((a1.rating * CAST(a1.review_count AS int)) + (p1.rating * p1.review_count))/(CAST(a1.review_count AS int) + p1.review_count),1) AS Combined_rating,
  (ROUND((ROUND(((a1.rating * CAST(a1.review_count AS int)) + (p1.rating * p1.review_count))/(CAST(a1.review_count AS int) + p1.review_count),1)/.5),0)+1) AS projected_lifespan_years
FROM app_store_apps as a1
    INNER JOIN play_store_apps as p1
    USING (name)
    LEFT JOIN apple_cost_table
    USING (name)
    LEFT JOIN google_cost_table
    USING (name)
ORDER BY apple_price DESC;