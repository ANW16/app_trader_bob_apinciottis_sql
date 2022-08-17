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

select name, rating, review_count, genres
from play_store_apps
where rating is not null and review_count>50
ORDER BY rating DESC

/*most installs from play store*/
select name,genres, cast (install_count as numeric)
from play_store_apps
order by install_count DESC

/*sanity check
select *
from app_store_apps
select *
from play_store_apps

select distinct(genres)
from play_store_apps

