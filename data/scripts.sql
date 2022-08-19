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
Limit 10;

Select distinct money(price), install_count,
    category
From play_store_apps
Group by price, category,install_count
Order by money(price) desc;

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
    Case When Round(p.rating*2,0)/2 = '0' Then '1 year'
        When Round(p.rating*2,0)/2 = '0.5' Then '2 years'
        When Round(p.rating*2,0)/2 = '1.0' Then '3 years'
        When Round(p.rating*2,0)/2 = '1.5' Then '4 years'
        When Round(p.rating*2,0)/2 = '2.0' Then '5 years'
        When Round(p.rating*2,0)/2 = '2.5' Then '6 years'
        When Round(p.rating*2,0)/2 = '3.0' Then '7 years'
        When Round(p.rating*2,0)/2 = '3.5' Then '8 years'
        When Round(p.rating*2,0)/2 = '4.0' Then '9 years'
        When Round(p.rating*2,0)/2 = '4.5' Then '10 years'
        When Round(p.rating*2,0)/2 = '5.0' Then '10+ years'
        End as Playstore_Projected_Longevity,
 a.name, Round(a.rating*2,0)/2 as Apple_rating,   
    Case When Round(a.rating*2,0)/2 = '0' Then '1 year'
        When Round(a.rating*2,0)/2 = '0.5' Then '2 years'
        When Round(a.rating*2,0)/2 = '1.0' Then '3 years'
        When Round(a.rating*2,0)/2 = '1.5' Then '4 years'
        When Round(a.rating*2,0)/2 = '2.0' Then '5 years'
        When Round(a.rating*2,0)/2 = '2.5' Then '6 years'
        When Round(a.rating*2,0)/2 = '3.0' Then '7 years'
        When Round(a.rating*2,0)/2 = '3.5' Then '8 years'
        When Round(a.rating*2,0)/2 = '4.0' Then '9 years'
        When Round(a.rating*2,0)/2 = '4.5' Then '10 years'
        When Round(a.rating*2,0)/2 = '5.0' Then '10+ years'
        End as Apple_Projected_Longevity   
From play_store_apps as p
Join app_store_apps as a
Using (name)
Where p.rating >= '3.5'
    And a.rating >= '3.5'
Group by p.name,p.rating,a.name,a.rating
Order by p.name,a.name desc;
