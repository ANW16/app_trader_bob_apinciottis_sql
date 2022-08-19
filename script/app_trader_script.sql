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
-- Facebook, WhatsApp, Insta, Clash of Clans, and Subway Surfers .

-- App life spans(months):
SELECT name, (ROUND((AVG((a1.rating+g1.rating)/2)/.5))+1)*12 as relevant_months
FROM play_store_apps as g1
INNER JOIN app_store_apps as a1 USING(name)
GROUP BY name
ORDER BY relevant_months DESC;
-- There are eight apps with a life span of 11 years/132 months .

-- App purchase cost:
WITH prices as 
   (SELECT DISTINCT name,
    CASE 
        WHEN money(g1.price) = money(0) THEN money(1)
        ELSE money(g1.price) 
    END as google_price, 
    CASE 
        WHEN money(a1.price) = money(0) THEN money(1)
        ELSE money(a1.price) 
    END as apple_price
    FROM play_store_apps as g1
    INNER JOIN app_store_apps as a1 USING(name))
SELECT DISTINCT name, ((apple_price + google_price) * 10000) as purchase_price
FROM play_store_apps as g1
INNER JOIN app_store_apps as a1 USING(name)
INNER JOIN prices as p1 USING(name)
ORDER BY purchase_price DESC;
-- 

-- Advertsing cost for each app:
SELECT name, money(((ROUND((AVG((a1.rating+g1.rating)/2)/.5))+1)*12)*1000) as ad_cost
FROM play_store_apps as g1
INNER JOIN app_store_apps as a1 USING(name)
GROUP BY name
ORDER BY ad_cost DESC;
--

-- Potential revenue of app:
SELECT name, money(((ROUND((AVG((a1.rating+g1.rating)/2)/.5))+1)*12)*5000) as revenue
FROM play_store_apps as g1
INNER JOIN app_store_apps as a1 USING(name)
GROUP BY name
ORDER BY revenue DESC;
-- 

-- Net profit for each app:
WITH purchase_price AS
   (SELECT DISTINCT name,
    CASE 
        WHEN money(g1.price) = money(0) THEN money(1)
        ELSE money(g1.price) 
    END as google_purchase_price, 
    CASE 
        WHEN money(a1.price) = money(0) THEN money(1)
        ELSE money(a1.price) 
    END as apple_purchase_price
    FROM play_store_apps as g1
    INNER JOIN app_store_apps as a1 USING(name)),
    
advertising_cost AS
   (SELECT name, money(((ROUND((AVG((a1.rating+g1.rating)/2)/.5))+1)*12)*1000) as ad_cost
    FROM play_store_apps as g1
    INNER JOIN app_store_apps as a1 USING(name)
    GROUP BY name
    ORDER BY ad_cost DESC),
    
revenue AS
   (SELECT name, money(((ROUND((AVG((a1.rating+g1.rating)/2)/.5))+1)*12)*5000) as revenue
    FROM play_store_apps as g1
    INNER JOIN app_store_apps as a1 USING(name)
    GROUP BY name
    ORDER BY revenue DESC)

SELECT name, 
money(r1.revenue - (((p1.apple_purchase_price + p1.google_purchase_price) * 10000) + a2.ad_cost)) AS profit
FROM play_store_apps as g1
INNER JOIN app_store_apps as a1 USING(name)
INNER JOIN purchase_price as p1 USING(name)
INNER JOIN advertising_cost as a2 USING(name)
INNER JOIN revenue as r1 USING(name)
GROUP BY name, r1.revenue, p1.apple_purchase_price, p1.google_purchase_price, a2.ad_cost
ORDER BY profit DESC;