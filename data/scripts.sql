Select * From play_store_apps;

Select * From app_store_apps;

Select name, primary_genre, rating
From app_store_apps
Order By rating desc;

Select name, genres, rating
From play_store_apps
Where rating is not null
Order by rating desc;

--Top 10 "Play Store" genres by AVG rating....
Select distinct genres, round(avg(rating),2) as avg_rating
From play_store_apps
Where rating is not null
Group by genres
Order by avg_rating desc
Limit 10;

Select distinct money(price),
    category
From play_store_apps
Group by price, category
Order by money(price) desc;

Select distinct category, round(avg(rating),2) as rating
from play_store_apps
Where rating is not null
Group By category,rating
order by rating desc;