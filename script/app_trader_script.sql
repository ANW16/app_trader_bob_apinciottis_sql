-- App Store Table (Apple):
SELECT *
FROM app_store_apps;
-- 

-- Play Store Table (Google):
SELECT *
FROM play_store_apps;
-- 


-- Apps on both stores:
SELECT DISTINCT name
FROM play_store_apps as g1
INNER JOIN app_store_apps as a1 USING(name);
-- 328 apps between the two stores .

-- Top 10 apps based on rating:
SELECT name, ROUND(AVG((a1.rating+g1.rating)/2),2) AS avg_rating
FROM play_store_apps as g1
INNER JOIN app_store_apps as a1 USING(name)
GROUP BY name
ORDER BY avg_rating DESC
LIMIT 10;
-- PewDiePie's Tuber Simulator(4.90), ASOS(4.85), and The EO Bar(4.85) are the top 3 .

-- App genres ranked by average rating:
SELECT a1.primary_genre, ROUND(AVG((a1.rating+g1.rating)/2),2) AS avg_rating
FROM play_store_apps as g1
INNER JOIN app_store_apps as a1 USING(name)
GROUP BY a1.primary_genre
ORDER BY avg_rating DESC;
-- Top genres are Catalogs(4.55), Books(4.50), Health & Fitness(4.45), Games(4.38), and Productivity(4.32) .

-- Apps ranked by review count totals:
SELECT name, COALESCE(CAST(MAX(a1.review_count) AS int),0)+COALESCE(CAST(MAX(g1.review_count) AS int),0) as total_reviews
FROM play_store_apps as g1
INNER JOIN app_store_apps as a1 USING(name)
GROUP BY name
ORDER BY total_reviews DESC;
-- Facebook, WhatsApp, Insta, Clash of Clans, and Subway Surfers.

-- App life spans:
SELECT name, ROUND((AVG((a1.rating+g1.rating)/2)/.5))+1 as relevant_years
FROM play_store_apps as g1
INNER JOIN app_store_apps as a1 USING(name)
GROUP BY name
ORDER BY relevant_years DESC;
-- 