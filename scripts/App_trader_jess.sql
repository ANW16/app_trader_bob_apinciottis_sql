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
order by rating desc

select distinct name, rating, review_count, genres
from play_store_apps
where rating is not null and review_count>50
ORDER BY rating desc, review_count DESC;

/*most installs from play store*/
select a.name, rating, review_count
from play_store_apps
where rating is not NULL and review_count >50
order by rating DESC, review_count DESC

/*1st join on name*/
select a.name, a.rating as, p.rating, a.review_count, p.review_count
from app_store_apps as a
LEFT JOIN play_store_apps as p
on a.name = p.name


/*sanity check
select *
from app_store_apps
select *
from play_store_apps

select distinct(genres)
from play_store_apps

