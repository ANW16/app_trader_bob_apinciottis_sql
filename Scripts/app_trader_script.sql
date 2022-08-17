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

SELECT name, a.price AS apple_price, p.price AS google_price, a.review_count AS apple_review_count, p.review_count AS google_review_count, p.install_count, a.rating AS apple_rating, p.rating AS google_rating, (a.rating+p.rating) AS total_rating, a.content_rating AS apple_content, p.content_rating AS google_content
FROM app_store_apps AS a
LEFT JOIN play_store_apps AS p
USING (name)
WHERE a.rating >= 4.5 AND p.rating >= 4.5 AND a.price = 0.00 AND p.price = '0'
ORDER BY total_rating DESC;



