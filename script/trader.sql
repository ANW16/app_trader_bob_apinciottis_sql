select name, a.review_count as app_review, p.review_count as play_review, a.rating as a_rating, p.rating as p_rating, genres, primary_genre, p.price as play_price, a.price as a_price
from play_store_apps as p
inner join app_store_apps as a
using(name)
where p.rating >= 4.5
and a.rating >= 4.5
and p.review_count > 25000
order by p.rating desc, a.rating desc
limit 25;
-- 20 of the top 25 rated games are free to play on both apps

select genres, category, avg(rating) as avg_rating
from play_store_apps
where rating is not null
group by genres, category
order by avg_rating desc;
--6 of the top 10 rated play store apps are in the family category, some type of game

select primary_genre, avg(rating) as avg_rating
from app_store_apps
where rating is not null
group by primary_genre
order by avg_rating desc;
/* "Productivity"	4.0056179775280899
"Music"	3.9782608695652174
"Photo & Video"	3.8008595988538682
"Business"	3.7456140350877193
"Health & Fitness"	3.7000000000000000 */

select content_rating, cast(avg(a.rating) as numeric) as a_rating
from app_store_apps as a
group by content_rating
order by a_rating desc;
/* "9+"	3.7695035460992908
   "4+"	3.5701556508008121
  "12+"	3.5666666666666667
  "17+"	2.7604501607717042 */
select content_rating, avg(rating) as avg_rating
from play_store_apps
group by content_rating
order by avg_rating desc;
/* "Adults only 18+" 4.3000000000000000
  "Everyone 10+" 4.2571788413098237
  "Teen" 4.2334870848708487
  "Everyone" 4.1863746630727763
  "Mature 17+" 4.1234273318872017
  "Unrated"	4.1000000000000000 */



