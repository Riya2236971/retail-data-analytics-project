CREATE DATABASE IF NOT EXISTS retail_project;
USE retail_project;

/* Which region generates highest revenue? */

SELECT Region , ROUND(SUM(Sales),2) AS Highest_revenue
FROM superstore_cleaned
GROUP BY Region 
ORDER BY Region DESC
LIMIT 1;

/* Which region has lowest profit margin? */

SELECT Region , ROUND(SUM(Profit),2) AS Lowest_Profit
FROM superstore_cleaned
group by Region
ORDER BY Region ASC 
LIMIT 1;

/* Which cities are loss-making? */
SELECT 
    city,
    SUM(profit) AS total_profit
FROM superstore_cleaned
GROUP BY city
HAVING total_profit < 0
ORDER BY total_profit ASC; 

/* Which cities show growth potential? */
SELECT 
    city,
    SUM(Sales) AS total_sales,
    ROUND(SUM(Profit),2) AS total_profit,
    ROUND((SUM(Profit)/SUM(Sales))*100,2) AS profit_margin
FROM superstore_cleaned
GROUP BY city
HAVING total_sales > 8000 
   AND profit_margin BETWEEN 5 AND 15
ORDER BY total_sales DESC;

/*Which category is most profitable?*/
SELECT category ,ROUND(SUM(Profit),2) AS total_Profit
FROM  superstore_cleaned
group by category
ORDER BY total_Profit desc
limit 1;

/* Does high discount reduce profit?*/
SELECT 
    CASE 
        WHEN discount = 0 THEN 'No Discount'
        WHEN discount <= 0.2 THEN 'Low Discount'
        WHEN discount <= 0.4 THEN 'Medium Discount'
        ELSE 'High Discount'
    END AS discount_level,
    AVG(profit) AS avg_profit
FROM superstore_cleaned
GROUP BY discount_level;

/*Where should the company open new stores?
SELECT city,ROUND(SUM(Sales),2) AS total_sales,ROUND(Sum(Profit),2)AS total_profit
FROM superstore_cleaned
group by city
ORDER BY total_profit DESC
LIMIT 5*/
SELECT city,
       ROUND(SUM(Sales),2) AS total_sales,
       ROUND(SUM(Profit),2) AS total_profit,
       ROUND((SUM(Profit)/SUM(Sales))*100,2) AS profit_margin
FROM superstore_cleaned
GROUP BY city
ORDER BY total_profit DESC
LIMIT 5;

/*Which region needs pricing optimization?*/
SELECT 
    Region,
    ROUND(SUM(Sales),2) AS total_sales,
    ROUND(SUM(Profit),2) AS total_profit,
    ROUND((SUM(Profit)/SUM(Sales))*100,2) AS profit_margin
FROM superstore_cleaned
GROUP BY Region
ORDER BY profit_margin ASC
LIMIT 1;

/*Which customer segment contributes most to profit?*/
SELECT segment , Round(SUM(Profit),2) AS total_profit
FROM superstore_cleaned
group by Segment
ORDER BY total_profit DESC
LIMIT 1;

/*Which sub-categories are causing maximum losses*/
SELECT `Sub-Category`,
       ROUND(SUM(Profit),2) AS total_profit
FROM superstore_cleaned
GROUP BY `Sub-Category`
ORDER BY total_profit ASC
LIMIT 5; 

/*Is the business growing year by year?*/
SELECT 
    YEAR(STR_TO_DATE(`Order Date`, '%m/%d/%Y')) AS yr,
    ROUND(SUM(Sales),2) AS total_sales,
    ROUND(SUM(Profit),2) AS total_profit
FROM superstore_cleaned
WHERE STR_TO_DATE(`Order Date`, '%m/%d/%Y') IS NOT NULL
GROUP BY YEAR(STR_TO_DATE(`Order Date`, '%m/%d/%Y'))
ORDER BY yr;

/*Top 20% Products Contributing 80% Revenue*/
SELECT 
    `Product Name`,
    ROUND(SUM(Sales),2) AS total_sales
FROM superstore_cleaned
GROUP BY `Product Name`
ORDER BY total_sales DESC
LIMIT 10;















