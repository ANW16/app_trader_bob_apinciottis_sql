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

SELECT COUNT(name), primary_genre, genres, category, install_count
FROM play_store_apps
INNER JOIN app_store_apps
USING (name)
GROUP BY primary_genre, genres, category, install_count
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
ORDER BY total_rating DESC, install_count DESC;

SELECT name, a.price AS apple_price, p.price AS google_price, a.review_count AS apple_review_count, p.review_count AS google_review_count, p.install_count, a.rating AS apple_rating, p.rating AS google_rating, (a.rating+p.rating) AS total_rating, a.content_rating AS apple_content, p.content_rating AS google_content
FROM app_store_apps AS a
INNER JOIN play_store_apps AS p
USING (name)
WHERE (a.rating+p.rating) >= 9 -- AND p.review_count > 1000
ORDER BY total_rating DESC, install_count DESC;

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
        CAST((((a.rating/.5+1)*12) +  (((ROUND(p.rating*2,0)/2)/.5+1)*12)) AS money) * 2000 AS total_revenue           
       FROM app_store_apps AS a
    INNER JOIN play_store_apps AS p
    USING (name)
WHERE a.price = 0.00 AND p.price = '0' 
GROUP BY name, a.rating, p.rating
ORDER BY total_months DESC)

SELECT name, ROUND(total_months/2,0) AS total_advertised_months, total_revenue, total_revenue-CAST(20000 AS money) AS total_profit, install_count
   FROM play_store_apps
   INNER JOIN dollars
   USING (name)
GROUP BY name, dollars.total_revenue, dollars.total_months, total_profit, play_store_apps.install_count
ORDER BY total_profit DESC, install_count DESC;

                   
WITH dollars AS
   (SELECT name, a.rating AS apple_rating, p.rating AS play_rating,
       '20000' AS purchase_cost, ((a.rating/.5+1)*12) AS apple_longevity_months, (((ROUND(p.rating*2,0)/2)/.5+1)*12) AS play_longevity_months,
       ((a.rating/.5+1)*12) +  (((ROUND(p.rating*2,0)/2)/.5+1)*12) AS total_months,
    CAST((((a.rating/.5+1)*12)*2000)AS money) AS apple_revenue,
    CAST(((((ROUND(p.rating*2,0)/2)/.5+1)*12)) AS money) * 2000 AS play_revenue
       -- CAST((((a.rating/.5+1)*12) +  (((ROUND(p.rating*2,0)/2)/.5+1)*12)) AS money) * 2000 AS total_revenue           
       FROM app_store_apps AS a
    INNER JOIN play_store_apps AS p
    USING (name)
WHERE a.price = 0.00 AND p.price = '0' 
GROUP BY name, a.rating, p.rating
ORDER BY total_months DESC)

SELECT name, ROUND(total_months/2,0) AS total_advertised_months, (apple_revenue+play_revenue)-CAST(purchase_cost AS money) AS total_profit, genres
                  -- total_revenue-CAST(20000 AS money) AS total_profit, 
                   install_count
   FROM play_store_apps
   INNER JOIN dollars
   USING (name)
GROUP BY name, total_advertised_months, total_profit, play_store_apps.install_count, genres
ORDER BY total_profit DESC, install_count DESC;
                   
SELECT name, a.primary_genre, p.category, p.genres, a.rating+p.rating AS total_rating
   FROM app_store_apps AS a
   INNER JOIN play_store_apps AS p
   USING (name)
WHERE a.price = 0.00 AND p.price = '0' 
GROUP BY name, primary_genre, category,genres, total_rating
ORDER BY total_rating DESC;


SELECT COUNT(name), category AS play_category, genres AS play_genres, primary_genre AS apple_genre, AVG(a.rating+p.rating) AS avg_rating
FROM play_store_apps AS p
INNER JOIN app_store_apps AS a
USING (name)
WHERE a.rating IS NOT NULL AND p.rating IS NOT NULL /* AND p.price = '0' AND a.price = 0.00 */
GROUP BY play_category, play_genres, apple_genre
HAVING COUNT(name) >= 10
ORDER BY avg_rating DESC, COUNT(name) DESC;
                   
                   
SELECT name, (a.rating+p.rating) AS total_rating, p.category AS play_category, p.genres AS play_genres, a.primary_genre AS apple_genre
FROM app_store_apps AS a
INNER JOIN play_store_apps AS p
USING (name)
WHERE a.primary_genre = 'Games' /* AND p.genres = 'Casual' */ AND a.rating IS NOT NULL AND p.rating IS NOT NULL AND p.price = '0' AND a.price = 0.00
GROUP BY name, play_category, play_genres, apple_genre, a.rating, p.rating
ORDER BY total_rating DESC;
                   
SELECT name, (a.rating+p.rating) AS total_rating, p.category AS play_category, p.genres AS play_genres, a.primary_genre AS apple_genre
FROM app_store_apps AS a
INNER JOIN play_store_apps AS p
USING (name)
WHERE p.category = 'FAMILY' AND p.genres = 'Casual' AND a.rating IS NOT NULL AND p.rating IS NOT NULL AND p.price = '0' AND a.price = 0.00
GROUP BY name, play_category, play_genres, apple_genre, a.rating, p.rating
ORDER BY total_rating DESC;
                   
SELECT name, (a.rating+p.rating) AS total_rating, p.category AS play_category, p.genres AS play_genres, a.primary_genre AS apple_genre
FROM app_store_apps AS a
INNER JOIN play_store_apps AS p
USING (name)
WHERE p.category = 'PRODUCTIVITY' AND p.genres = 'Productivity' AND a.rating IS NOT NULL AND p.rating IS NOT NULL AND p.price = '0' AND a.price = 0.00
GROUP BY name, play_category, play_genres, apple_genre, a.rating, p.rating
ORDER BY total_rating DESC;                  
                   
SELECT name, (a.rating+p.rating) AS total_rating, p.category AS play_category, p.genres AS play_genres, a.primary_genre AS apple_genre
FROM app_store_apps AS a
INNER JOIN play_store_apps AS p
USING (name)
WHERE p.category = 'COMMUNICATION' AND p.genres = 'Communication' /* AND a.primary_genre = 'Social Networking' */ AND a.rating IS NOT NULL AND p.rating IS NOT NULL AND p.price = '0' AND a.price = 0.00
GROUP BY name, play_category, play_genres, apple_genre, a.rating, p.rating
ORDER BY total_rating DESC;  
                   
SELECT name, (a.rating+p.rating) AS total_rating, p.category AS play_category, p.genres AS play_genres, a.primary_genre AS apple_genre
FROM app_store_apps AS a
INNER JOIN play_store_apps AS p
USING (name)
WHERE p.category = 'FOOD_AND_DRINK' AND p.genres = 'Food & Drink' AND a.primary_genre = 'Food & Drink' AND a.rating IS NOT NULL AND p.rating IS NOT NULL AND p.price = '0' AND a.price = 0.00
GROUP BY name, play_category, play_genres, apple_genre, a.rating, p.rating
ORDER BY total_rating DESC; 
                   
SELECT name, (a.rating+p.rating) AS total_rating, p.category AS play_category, p.genres AS play_genres, a.primary_genre AS apple_genre
FROM app_store_apps AS a
INNER JOIN play_store_apps AS p
USING (name)
WHERE p.category = 'NEWS_AND_MAGAZINES' AND p.genres = 'News & Magazines' AND a.primary_genre = 'News' AND a.rating IS NOT NULL AND p.rating IS NOT NULL AND p.price = '0' AND a.price = 0.00
GROUP BY name, play_category, play_genres, apple_genre, a.rating, p.rating
ORDER BY total_rating DESC;
                   
SELECT name, (a.rating+p.rating) AS total_rating, p.category AS play_category, p.genres AS play_genres, a.primary_genre AS apple_genre
FROM app_store_apps AS a
INNER JOIN play_store_apps AS p
USING (name)
WHERE p.category = 'ENTERTAINMENT' AND p.genres = 'Entertainment' AND a.primary_genre = 'Entertainment' AND a.rating IS NOT NULL AND p.rating IS NOT NULL AND p.price = '0' AND a.price = 0.00
GROUP BY name, play_category, play_genres, apple_genre, a.rating, p.rating
ORDER BY total_rating DESC;
                   
SELECT name, (a.rating+p.rating) AS total_rating, p.category AS play_category, p.genres AS play_genres, a.primary_genre AS apple_genre
FROM app_store_apps AS a
INNER JOIN play_store_apps AS p
USING (name)
WHERE p.category = 'SPORTS' AND p.genres = 'Sports' AND a.primary_genre = 'Sports' AND a.rating IS NOT NULL AND p.rating IS NOT NULL AND p.price = '0' AND a.price = 0.00
GROUP BY name, play_category, play_genres, apple_genre, a.rating, p.rating
ORDER BY total_rating DESC;
                   
SELECT name, (a.rating+p.rating) AS total_rating, p.category AS play_category, p.genres AS play_genres, a.primary_genre AS apple_genre
FROM app_store_apps AS a
INNER JOIN play_store_apps AS p
USING (name)
WHERE p.category = 'TRAVEL_AND_LOCAL' AND p.genres = 'Travel & Local' AND a.primary_genre = 'Travel' AND a.rating IS NOT NULL AND p.rating IS NOT NULL AND p.price = '0' AND a.price = 0.00
GROUP BY name, play_category, play_genres, apple_genre, a.rating, p.rating
ORDER BY total_rating DESC;
                   
WITH dollars AS
   (SELECT name, ROUND(((a.rating+p.rating)/2)*2,0)/2 AS rounded_rating, ((((ROUND(((a.rating+p.rating)/2)*2,0)/2)/.5+1)/2)*12)*2 AS advertising_months       
   FROM app_store_apps AS a
    INNER JOIN play_store_apps AS p
    USING (name)
WHERE a.price = 0.00 AND p.price = '0' 
GROUP BY name, a.rating, p.rating
ORDER BY advertising_months DESC)

SELECT name, rounded_rating, ROUND(advertising_months,0) AS total_advertised_months, CAST(advertising_months*4000 AS money) total_revenue, CAST(advertising_months*4000 AS money)-CAST(20000 AS money) AS total_profit, install_count
   FROM play_store_apps
   INNER JOIN dollars
   USING (name)
GROUP BY name, rounded_rating, total_revenue, dollars.advertising_months, total_profit, play_store_apps.install_count
ORDER BY total_profit DESC, install_count DESC;