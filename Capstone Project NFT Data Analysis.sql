create database crypto;
select *from pricedata;

/* Calculate How many sales occured during january 1st, 2018 to December 31st 2021 */

select count(*) from pricedata
where event_date > '2018-01-01' and event_date < '31-12-2021';

/* Return the top 5 most expensive transactions (by USD price) for this data set. Return the name, ETH price, and USD price, as well as the date.*/

select name, eth_price, usd_price from pricedata
order by usd_price Desc	
limit 5;

/* Return a table with a row for each transaction with an event column, a USD price column, and a moving average of USD price that averages the last 50 transactions.*/
select name, usd_price, 
avg(usd_price)  over(order by event_date Rows between 49 preceding and current row)
from pricedata	;

/* Return all the NFT names and their average sale price in USD. Sort descending. Name the average column as average_price.*/

select name, avg(usd_price) as average_price from pricedata
group by name
order by average_price 
desc;

/* Return each day of the week and the number of sales that occurred on that day of the week, as well as the average price in ETH. Order by the count of transactions in ascending order. */
SELECT 
    DAYNAME(event_date) AS DayOfWeek,
    SUM(eth_price) AS total_sales,
    AVG(eth_price) AS average_price,
    name,
    COUNT(*) AS num_sales
FROM 
    pricedata
GROUP BY 
    DAYNAME(event_date), name
ORDER BY 
    num_sales ASC;
/* Construct a column that describes each sale and is called summary. The sentence should include who sold the NFT name, who bought the NFT, who sold the NFT, the date, and what price it was sold for in USD rounded to the nearest thousandth.
 Here’s an example summary:
 “CryptoPunk #1139 was sold for $194000 to 0x91338ccfb8c0adb7756034a82008531d7713009d from 0x1593110441ab4c5f2c133f21b0743b2b43e297cb on 2022-01-14 */
 
 select concat( name, "was sold for " , usd_price , "to" , buyer_address , "from" , seller_address, "On", event_date )
 as sumary
 from pricedata;
 
 
 /* Create a view called “1919_purchases” and contains any sales where “0x1919db36ca2fa2e15f9000fd9cdc2edcf863e685” was the buyer */
 
 create view 1919_purchases As
 select * from pricedata
 where buyer_address = "0x1919db36ca2fa2e15f9000fd9cdc2edcf863e685";
 
 
 /*Create a histogram of ETH price ranges. Round to the nearest hundred value. 
*/

 select eth_price , 
 count(*) as count 	,
 rpad("*" , count(*), "*") as bar 	
 from pricedata
 group by eth_price;
 
 /* Return a unioned query that contains the highest price each NFT was bought for and a new column called status saying “highest” with a query that has the lowest price each NFT was bought for and the status column saying “lowest”. The table should have a name column, a price column called price, and a status column. Order the result set by the name of the NFT, and the status, in ascending order. */
 
 /*  Query for fethcing highest price */
 
 select name , 
 max(usd_price) as price ,
 "highest" as status
 from pricedata
 group by name
 
 union 
 
 /* Query for fethcing the lowest pricce */
 
 select name, 
 min(usd_price) as price, 
 "lowest" as status
 from pricedata
 group by name 
 order by name, status ASC;
 
 
 /* What NFT sold the most each month / year combination? Also, what was the name and the price in USD? Order in chronological format. */


SELECT 
    MONTH(event_date) AS month,
    YEAR(event_date) AS year,
    name,
    usd_price
FROM 
    pricedata
JOIN (
    SELECT 
        MONTH(event_date) AS month,
        YEAR(event_date) AS year
    FROM 
        pricedata
    GROUP BY 
        MONTH(event_date), YEAR(event_date)
    ORDER BY 
        COUNT(*) DESC
    LIMIT 1
) AS max_month_year
ON 
    MONTH(pricedata.event_date) = max_month_year.month
    AND YEAR(pricedata.event_date) = max_month_year.year;
    
    
    /* Return the total volume (sum of all sales), round to the nearest hundred on a monthly basis (month/year).*/
    
select month(event_date), year(event_date),
round(sum(usd_price), -2) as total_sales
from pricedata
group by
year(event_date), month(event_date); 

/* Count how many transactions the wallet "0x1919db36ca2fa2e15f9000fd9cdc2edcf863e685"had over this time period */


select count(*) 
from pricedata
where buyer_address = "0x1919db36ca2fa2e15f9000fd9cdc2edcf863e685" or seller_address = "0x1919db36ca2fa2e15f9000fd9cdc2edcf863e685"
and 
 event_date > '2018-01-01' and event_date < '31-12-2021';
 
 
 /*
 Create an “estimated average value calculator” that has a representative price of the collection every day based off of these criteria:
 - Exclude all daily outlier sales where the purchase price is below 10% of the daily average price
 - Take the daily average of remaining transactions
 a) First create a query that will be used as a subquery. Select the event date, the USD price, and the average USD price for each day using a window function. Save it as a temporary table.
 b) Use the table you created in Part A to filter out rows where the USD prices is below 10% of the daily average and return a new estimated value which is just the daily average of the filtered data. */
 
 
 create temporary table temp1 as 
 select event_date, usd_price, avg(usd_price) over (partition by date(event_date)) as daily_avg
 from pricedata;
 
 select* from temp1;
 
 select event_date, 
 avg(usd_price) as avg_value
 from temp1
 where usd_price >= 0.1* (select daily_avg from temp1)
 group by event_date;
 
 
 
 

