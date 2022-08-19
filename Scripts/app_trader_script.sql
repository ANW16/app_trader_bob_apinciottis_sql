SELECT *
FROM app_store_apps;

SELECT *
FROM play_store_apps;

SELECT *
FROM play_store_apps
LEFT JOIN app_store_apps
USING (name);

SELECT COUNT(name), price
FROM app_store_apps
GROUP BY price
ORDER BY COUNT(name) DESC;

SELECT name, price 
FROM play_store_apps
ORDER BY price DESC;

SELECT type, COUNT(name)
FROM play_store_apps
GROUP BY type
ORDER BY COUNT(name) DESC;

SELECT genres, category, type, COUNT(name)
FROM play_store_apps
GROUP BY genres, category, type
ORDER BY COUNT(name) DESC;

SELECT primary_genre, COUNT(name)
FROM app_store_apps
GROUP BY primary_genre
ORDER BY COUNT(name) DESC;

SELECT name, price, CAST(review_count AS int), rating, content_rating, primary_genre
FROM app_store_apps
ORDER BY review_count DESC;

SELECT name, category, rating, review_count, install_count, type, price, content_rating, genres
FROM play_store_apps
WHERE review_count > 1000
ORDER BY rating DESC;

SELECT a.name, a.price, a. review_count, a.rating, p.name, p.rating, p.review_count, p.install_count, p.price
FROM app_store_apps AS a
LEFT JOIN play_store_apps AS p
USING (name)
WHERE p.review_count > 1000 
    AND a.rating >= 4
    AND p.rating >= 4
ORDER BY p.install_count DESC;

SELECT COUNT(name), genres, install_count
FROM play_store_apps
GROUP BY genres, install_count
ORDER BY COUNT(name) DESC;

SELECT COUNT(name), a.content_rating AS app_rating, p.content_rating AS play_rating
FROM app_store_apps AS a
LEFT JOIN play_store_apps AS p
USING (name)
GROUP BY a.content_rating, p.content_rating
ORDER BY COUNT(name) DESC;

SELECT name, a.price AS apple_price, p.price AS google_price, a.review_count AS apple_review_count, p.review_count AS google_review_count, p.install_count, a.rating AS apple_rating, p.rating AS google_rating, (a.rating+p.rating) AS total_rating, a.content_rating AS apple_content, p.content_rating AS google_content
FROM app_store_apps AS a
LEFT JOIN play_store_apps AS p
USING (name)
WHERE p.install_count IS NOT NULL AND a.rating >= 4.5 AND p.rating >= 4.5
ORDER BY total_rating DESC;

SELECT DISTINCT name, a.price AS apple_price, p.price AS google_price, a.review_count AS apple_review_count, p.review_count AS google_review_count, p.install_count, a.rating AS apple_rating, p.rating AS google_rating, (a.rating+p.rating) AS total_rating, a.content_rating AS apple_content, p.content_rating AS google_content
FROM app_store_apps AS a
INNER JOIN play_store_apps AS p
USING (name)
WHERE (a.rating+p.rating) >= 8.8 AND a.price = 0.00 AND p.price = '0'
ORDER BY total_rating DESC;

SELECT name, a.price AS apple_price, p.price AS google_price, a.review_count AS apple_review_count, p.review_count AS google_review_count, p.install_count, a.rating AS apple_rating, p.rating AS google_rating, (a.rating+p.rating) AS total_rating, a.content_rating AS apple_content, p.content_rating AS google_content
FROM app_store_apps AS a
LEFT JOIN play_store_apps AS p
USING (name)
WHERE (a.rating+p.rating) >= 9 -- AND p.review_count > 1000
ORDER BY total_rating DESC;

WITH profit AS 
    (SELECT name, 
     ROUND((4000*
            ((
                (a.rating/.5)+1)+(
                    (p.rating/.5)+1)*12))-20000,2) AS expected_profit 
    FROM app_store_apps AS a
    INNER JOIN play_store_apps AS p
    USING (name)
WHERE a.price = 0.00 AND p.price = '0' 
GROUP BY name, a.rating, p.rating
ORDER BY expected_profit DESC;

 /* names AS 
    (SELECT name
    FROM app_store_apps
    INNER JOIN play_store_apps) */
    
SELECT DISTINCT name, 
        expected_profit
FROM app_store_apps
INNER JOIN profit
USING (name)
ORDER BY expected_profit DESC;
     
SELECT name, ROUND(rating 
     FROM app_store_apps
     ORDER BY rating DESC;
                   
                   
SELECT name, a.rating AS apple_rating, p.rating AS play_rating, 
     ROUND((4000*((((ROUND(a.rating*2,0)/2)/.5)+1)+(((ROUND(p.rating*2,0)/2)/.5)+1)*12))-20000,2) AS expected_profit 
    FROM app_store_apps AS a
    INNER JOIN play_store_apps AS p
    USING (name)
WHERE a.price = 0.00 AND p.price = '0' 
GROUP BY name, a.rating, p.rating
ORDER BY expected_profit DESC;                   ROUND(p.rating*2,0)/2

WITH dollars AS
   (SELECT name, a.rating AS apple_rating, p.rating AS play_rating,
       '20000' AS purchase_cost, ((a.rating/.5+1)*12) AS apple_longevity_months, (((ROUND(p.rating*2,0)/2)/.5+1)*12) AS play_longevity_months,
       ((a.rating/.5+1)*12) +  (((ROUND(p.rating*2,0)/2)/.5+1)*12) AS total_months,
        CAST((((a.rating/.5+1)*12) +  (((ROUND(p.rating*2,0)/2)/.5+1)*12)) AS money) * 4000 AS total_revenue           
       FROM app_store_apps AS a
    INNER JOIN play_store_apps AS p
    USING (name)
WHERE a.price = 0.00 AND p.price = '0' 
GROUP BY name, a.rating, p.rating
ORDER BY total_months DESC)

SELECT name, ROUND(total_months,0) AS total_longevity_months, total_revenue, total_revenue-CAST(20000 AS money) AS total_profit
   FROM play_store_apps
   INNER JOIN dollars
   USING (name)
GROUP BY name, dollars.total_revenue, dollars.total_months, total_profit
ORDER BY total_profit DESC;