/*select count(*) 
from app_store_apps
7197 */

/*select count(*) 
from play_store_apps
10840*/

/*2. Assumptions
find price of APP, 

*/
/*price of top ten most expensive*/
select name,price
from app_store_apps
order by price DESC
limit 10

select name, type, cast (price as money)
from play_store_apps
ORDER BY  price DESC
limit 10

/*highest rated*/
select name,rating, review_count, primary_genre
from app_store_apps
where review_count>50
order by rating desc, review_count desc

select distinct name, rating, review_count, genres
from play_store_apps
where rating is not null and review_count>50
ORDER BY rating desc, review_count DESC;

/*most installs from play store*/
select name, rating, review_count, genres
from play_store_apps
where rating is not NULL and review_count >50
order by rating DESC, review_count DESC

/*1st join on name*/
select distinct(a.name), a.rating as apple_rating, p.rating as google_rating, a.review_count as apple_review_count , 
p.review_count as google_review_count, a.primary_genre
from app_store_apps as a
LEFT JOIN play_store_apps as p
on a.name = p.name
where p.rating is not null
order by  google_rating desc,apple_rating DESC, google_review_count DESC


/*sanity check
select *
from app_store_apps
select *
from play_store_apps*/

select distinct(primary_genre), round(avg(rating))as avg_rating
from app_store_apps
group by primary_genre
order by avg_rating DESC

select distinct(genres), round(avg(rating)) as avg_rating
from play_store_apps
group by genres
--where avg_rating IS NOT NULL
order by avg_rating desc

select primary_genre, sum(review_count)as sum_review
from app_store_apps
group by primary_genre
order by sum_review desc



