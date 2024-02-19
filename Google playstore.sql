--Identify the Null values-

SELECT *
FROM [Google play store analysis].[dbo].[googleplaystore]
WHERE App IS NULL
OR Category IS NULL
OR Rating IS NULL
OR Reviews IS NULL
OR Size IS NULL
OR Installs IS NULL
OR Type IS NULL
OR Price IS NULL
OR Content_Rating IS NULL
OR Genres IS NULL
OR Last_Updated IS NULL
OR Current_Ver IS NULL
OR Android_Ver IS NULL

--Removeing NULL values-

SELECT * 
DELETE FROM [Google play store analysis].[dbo].[googleplaystore]
WHERE App IS NULL
OR Category IS NULL
OR Rating IS NULL
OR Reviews IS NULL
OR Size IS NULL
OR Installs IS NULL
OR Type IS NULL
OR Price IS NULL
OR Content_Rating IS NULL
OR Genres IS NULL
OR Last_Updated IS NULL
OR Current_Ver IS NULL
OR Android_Ver IS NULL

--1) Overview of dataset-
--Provide the overview of dataset by how many total unique apps and categories in our dataset.

SELECT
COUNT(DISTINCT App) as Total_apps,
COUNT(DISTINCT Category) as Total_categories
FROM [Google play store analysis].[dbo].[googleplaystore]

--2) Explore app Categories and Counts-
--Retrieve the unique app categories and the count of apps in each category.

SELECT Top 10 Category,
COUNT(App) as Total_apps
FROM [Google play store analysis].[dbo].[googleplaystore]
GROUP BY Category
ORDER BY Total_apps DESC

--3) Top-Rated free apps-
--Indentify the top-rated free apps.

SELECT TOP 10 App, Category, Rating, Reviews
FROM [Google play store analysis].[dbo].[googleplaystore]
WHERE Type= 'Free' AND Rating<> 'NaN'
ORDER BY Rating DESC

--4) Most Reviewed apps-
--Find the apps with the highest number of reviews.

SELECT TOP 5 App, Category, Reviews
FROM [Google play store analysis].[dbo].[googleplaystore]
ORDER BY Reviews DESC

--5) Average Ratings by Category-
--Calculate the average rating for each app category.

SELECT TOP 10 Category,
AVG(TRY_CAST (Rating AS float)) As avg_rating
FROM [Google play store analysis].[dbo].[googleplaystore]
GROUP BY Category
ORDER BY avg_rating DESC

--6) Top Categories by Number of Installs-
--Indentify the app categories with the highest total number of installs.

SELECT TOP 10 Category,
SUM(CAST(REPLACE(SUBSTRING(Installs, 1, PATINDEX('%[^0-9]%', Installs + ' ') -1),',',' ') As int)) As Total_installs
FROM [Google play store analysis].[dbo].[googleplaystore] 
GROUP BY Category
ORDER BY Total_installs DESC

--7) Average Sentiment Polarity by App Category-
--Analyze the average sentiment polarity of user reviews for each app category.

SELECT TOP 10 Category,
AVG(TRY_CAST(Sentiment_Polarity AS float)) as avg_sentiment_polarity
FROM [Google play store analysis].[dbo].[googleplaystore] as gp
JOIN [Google play store analysis].[dbo].[googleplaystore_user_reviews] as gpu
ON gp.App= gpu.App
GROUP BY Category
ORDER BY avg_sentiment_polarity

--8) Sentiment Reviews by App Category-
-- Provide the distribution of sentiments across different app categories.

SELECT TOP 10 Category, Sentiment,
COUNT(*) As Total_sentiments
FROM [Google play store analysis].[dbo].[googleplaystore] as gp
JOIN [Google play store analysis].[dbo].[googleplaystore_user_reviews] as gpu
ON gp.App= gpu.App
WHERE Sentiment<> 'nan'
GROUP BY Category, Sentiment
ORDER BY Total_sentiments DESC

