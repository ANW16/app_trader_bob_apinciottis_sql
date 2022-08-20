Select * From play_store_apps as p
Join app_store_apps as a
Using (name);

Select * From app_store_apps;

Select name, primary_genre, rating
From app_store_apps
Order By rating desc;

Select name, genres, rating
From play_store_apps
Where rating is not null
Order by rating desc;

--Top 10 "Play Store" genres by AVG rating....
Select distinct genres, round(avg(rating),2) as avg_rating, install_count
From play_store_apps
Where rating is not null
Group by genres, install_count
Order by avg_rating desc
Limit 10;

--Top 10 "Apple Store" genres by AVG rating....
Select distinct primary_genre, round(avg(rating),2) as avg_rating, review_count
From app_store_apps
Where rating is not null
Group by primary_genre, review_count
Order by avg_rating desc
LImit 10;
--top genres by install/review count and price.....
Select genres as Playstore_genres, money(p.price), p.install_count, primary_genre as Google_genres, money(a.price), a.review_count
From play_store_apps as p
Join app_store_apps as a
Using(name)
Order by install_count desc, review_count desc;



Select distinct category, round(avg(rating),2) as rating
from play_store_apps
Where rating is not null
Group By category,rating
order by rating desc;

Select p.name, p.price as Playstore_price, Round(p.rating*2,0)/2, a.name, a.price as Apple_price, Round(a.rating*2,0)/2
From app_store_apps as a
Left Join play_store_apps as p
Using (name)
Where p.name = a.name
Order By p.name,a.name desc;

-- Projected Longevity(Apps in both stores AND apps with rating >= 3.5 in both stores)

Select distinct p.name, round(p.rating*2,0)/2 as Playstore_rating, 
    Case When Round(p.rating*2,0)/2 = '0' Then '12mo'
        When Round(p.rating*2,0)/2 = '0.5' Then '24mo'
        When Round(p.rating*2,0)/2 = '1.0' Then '36mo'
        When Round(p.rating*2,0)/2 = '1.5' Then '48mo'
        When Round(p.rating*2,0)/2 = '2.0' Then '60mo'
        When Round(p.rating*2,0)/2 = '2.5' Then '72mo'
        When Round(p.rating*2,0)/2 = '3.0' Then '84mo'
        When Round(p.rating*2,0)/2 = '3.5' Then '96mo'
        When Round(p.rating*2,0)/2 = '4.0' Then '108mo'
        When Round(p.rating*2,0)/2 = '4.5' Then '120mo'
        When Round(p.rating*2,0)/2 = '5.0' Then '132mo'
        End as Playstore_Projected_Longevity,
 a.name, Round(a.rating*2,0)/2 as Apple_rating,   
    Case When Round(a.rating*2,0)/2 = '0' Then '12mo'
        When Round(a.rating*2,0)/2 = '0.5' Then '24mo'
        When Round(a.rating*2,0)/2 = '1.0' Then '36mo'
        When Round(a.rating*2,0)/2 = '1.5' Then '48mo'
        When Round(a.rating*2,0)/2 = '2.0' Then '60mo'
        When Round(a.rating*2,0)/2 = '2.5' Then '72mo'
        When Round(a.rating*2,0)/2 = '3.0' Then '84mo'
        When Round(a.rating*2,0)/2 = '3.5' Then '96mo'
        When Round(a.rating*2,0)/2 = '4.0' Then '108mo'
        When Round(a.rating*2,0)/2 = '4.5' Then '120mos'
        When Round(a.rating*2,0)/2 = '5.0' Then '132mo'
        End as Apple_Projected_Longevity,
    avg(p.rating+a.rating) as avg_combined_rating
From play_store_apps as p
Join app_store_apps as a
Using (name)
Where p.rating >= '3.5'
    And a.rating >= '3.5'
Group by p.name,p.rating,a.name,a.rating
Order by  avg_combined_rating desc;

--Top 10 apps w/ content_rating by avg_combined_rating
Select a.name,
    
    p.name,
    p.content_rating,
    avg(a.rating+p.rating) as avg_combined_rating
From app_store_apps as a
Join play_store_apps as p
Using(name)
Group By a.name, a.content_rating, p.name, p.content_rating
Order by avg_combined_rating desc
Limit 10;

Select a.content_rating,
    p.content_rating,
    avg(a.rating+p.rating) as avg_combined_rating
From app_store_apps as a
Join play_store_apps as p
Using(name)
Group By a.content_rating, p.content_rating
Order By avg_combined_rating desc;


Select a.name,
    p.name,
    avg(a.rating+p.rating) as avg_combined_rating,
       Case When a.content_rating =  '4+' Then 'Everyone'
       When a.content_rating = '9+' Then 'Everyone'
        When p.content_rating = 'Everyone' Then 'Everyone'
        When p.content_rating = 'Everyone+' Then 'Everyone'
        End As content_rating
From app_store_apps as a
Join play_store_apps as p
Using (name)
Group by a.name,p.name,a.content_rating,p.content_rating
Order By avg_combined_rating desc;

Select distinct a.content_rating as Apple_content_rating,
       p.content_rating as Google_content_rating,
     count(p.content_rating) + count(a.content_rating) as Combined_content_count
From app_store_apps as a
Join play_store_apps as p
Using (name)
Group by distinct a.content_rating , p.content_rating ;


Select *