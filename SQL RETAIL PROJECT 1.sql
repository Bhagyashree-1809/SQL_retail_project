DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales (
transactions_id INT PRIMARY KEY,
sale_date DATE,
sale_time TIME,
customer_id INT ,
gender VARCHAR(15),
age INT	,
category VARCHAR(15),
quantity INT,	
price_per_unit FLOAT	,
cogs FLOAT,	
total_sale FLOAT

);
SELECT * FROM retail_sales
limit 10;

SELECT COUNT(*)
FROM retail_sales;

-- DATA CLEANING
-- TO CHECK FOR THE NULL VALUES IN EACH COLUMN

 SELECT * FROM retail_sales
WHERE 
   transactions_id IS NULL
   OR
   sale_date IS NULL
   OR
   sale_time IS NULL
   OR
   gender IS NULL
   OR
   category IS NULL
   OR
   quantity IS NULL
   OR
   cogs IS NULL
   OR
   total_sale IS NULL;

-- TO DELETE THE NULL VALUE ROWS
  
DELETE FROM retail_sales
WHERE 
   transactions_id IS NULL
   OR
   sale_date IS NULL
   OR
   sale_time IS NULL
   OR
   gender IS NULL
   OR
   category IS NULL
   OR
   quantity IS NULL
   OR
   cogs IS NULL
   OR
   total_sale IS NULL;

-- DATA EXPLORATION

-- HOW MANY SALES WE HAVE 
SELECT COUNT (*) AS total_sale FROM retail_sales;

-- HOW MANY UNIQUE CUSTOMERS WE HAVE
SELECT COUNT (DISTINCT customer_id) AS total_sale FROM retail_sales;

--HOW MANY UNIQUE CATEGORY WE HAVE
SELECT COUNT (DISTINCT category) AS total_sale FROM retail_sales;
SELECT  DISTINCT category FROM retail_sales;

-- DATA ANALYSIS AND BUSINESS KEY PROBLEMS AND ANSWERS

-- Q1) WRITE A SQL QUERY TO RETRIEVE ALL COLUMNS FOR SALES MADE ON '2022-11-05'.
   SELECT *
   FROM retail_sales
   WHERE sale_date = '2022-11-05';

-- Q2) WRITE A SQL QUERY TO RETRIEVE ALL TRANSACTIONS WHERE THE CATEGORY IS CLOTHING AND THE QUANTITY SOLD IS
    -- MORE THAN 4 IN THE MONTH OF NOV-2022.
	SELECT *
	FROM retail_sales
	WHERE 
	category='Clothing'
	AND
	TO_CHAR(sale_date,'yyyy-mm')='2022-11'
	AND
	quantity>=4

-- Q3) WRITE A SQL QUERY TO CALCULATE THE TOTAL SALES (total_sale) FOR EACH CATEGORY.
    SELECT   
	  category,
	  SUM(total_sale)as net_sale,
	  COUNT(*) as total_orders
	FROM retail_sales
	GROUP BY 1

-- Q4) WRITE A SQL QUERY TO FIND THE AVERAGE AGE OF CUSTOMERS WHO PURCHASED ITEMS FROM THE BEAUTY CATEGORY
    SELECT 
	ROUND(AVG(age),2) as avg_age
	FROM retail_sales
	WHERE category='Beauty'
	    
-- Q5) WRITE A SQL QUERY TO FIND ALL TRANSACTIONS WHERE THE Total_sale IS GREATER THAN 1000.
     SELECT 
	 transactions_id,
	 customer_id,
	 total_sale
	 FROM retail_sales
	 WHERE total_sale>1000

-- Q6)WRITE A SQL QUERY TO FIND TOTAL NUMBER OF TRANSACTIONS (transactions_id) MADE BY EACH GENDER IN EACH CATEGORY.
    SELECT
	gender,
	category,
	COUNT(*) as total_trans
	FROM retail_sales
	GROUP BY category,gender
	ORDER BY 1

-- Q7) WRITE A SQL QUERY TO CALCULATE THE AVERAGE SALE FOR EACH MONTH. FIND OUT THE BEST SELLING MONTH IN EACH YEAR.
    SELECT
	YEAR,
	MONTH,
	avg_sale
	FROM
	(
	SELECT 
	EXTRACT(YEAR FROM sale_date)as year,
	EXTRACT(MONTH FROM sale_date)as month,
	AVG(total_sale)as avg_sale,
	RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date)ORDER BY AVG(total_sale)DESC)AS rank
	FROM retail_sales
	GROUP BY 1,2
	) as t1
	WHERE rank = 1

-- Q8) WRITE A SQL QUERY TO FIND THE TOP 5 CUSTOMERS BASED ON THE HIGHEST TOTAL SALES.
   SELECT 
       customer_id,
	   SUM(total_sale)as total_sales
	   FROM retail_sales
	   GROUP BY 1
	   ORDER BY 2 DESC
	   LIMIT 5

-- Q9) WRITE A SQL QUERY TO FIND THE NUMBER OF UNIQUE CUSTOMERS WHO PURCHASED ITEMS FROM EACH CATEGORY
    SELECT 
	category,
	COUNT(DISTINCT customer_id)as cnt_unique_cs
	FROM retail_sales
	GROUP BY category

-- Q10) WRITE A SQL QUERY TO CREATE EACH SHIFT AND NUMBER OF ORDERS 
-- EXAMPLE: MORNING<=12 , AFTERNOON BETWEEN 12 & 17, EVENING >17
   WITH hourly_sale
   AS
   (
   SELECT *,
   CASE 
   WHEN EXTRACT (HOUR FROM sale_time)< 12 THEN 'Morning'
   WHEN EXTRACT (HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
   ELSE 'Evening'
   END as shift
   FROM retail_sales
   )
   SELECT 
   shift,
   COUNT(*) as total_orders
   FROM hourly_sale
   GROUP BY shift

-- END OF PROJECT





   
