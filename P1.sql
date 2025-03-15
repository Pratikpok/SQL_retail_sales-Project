-- Reatail sales project 

-- Create TABLE RETAIL SALES
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales(transactions_id INT PRIMARY KEY,
	sale_date DATE,
	sale_time TIME,
	customer_id INT,
	gender VARCHAR(15),
	age INT,
	category VARCHAR(15),
	quantiy INT,
	price_per_unit FLOAT ,
	cogs FLOAT,
	total_sale FLOAT
);

SELECT * FROM retail_sales limit 10;

SELECT COUNT(*) FROM retail_sales;

-- FINDING NULL values
SELECT * FROM retail_sales 
WHERE transactions_id IS NULL
OR sale_date IS NULL
OR
 sale_time IS NULL
OR
 customer_id IS NULL
OR
 gender IS NULL
OR
 age IS NULL
OR 
 category IS NULL
OR
 quantiy IS NULL
OR
 price_per_unit IS NULL
OR
 cogs IS NULL
OR
 total_sale IS NULL;
 
 -- DELETE ALL NULL VALUES 
 DELETE	FROM retail_sales
WHERE transactions_id IS NULL
OR sale_date IS NULL
OR
 sale_time IS NULL
OR
 customer_id IS NULL
OR
 gender IS NULL
OR
 age IS NULL
OR 
 category IS NULL
OR
 quantiy IS NULL
OR
 price_per_unit IS NULL
OR
 cogs IS NULL
OR
 total_sale IS NULL;
 
 -- DATA EXPLORATION
 -- HOW MANY SALES WE HAVE?
 SELECT COUNT(*) AS TOTAL_SALE FROM retail_sales;
 
 -- HOW MANY UNIQUE CUSTOMER WE HAVE?
 SELECT count(DISTINCT CUSTOMER_ID) FROM retail_sales;
 
  SELECT count(DISTINCT CATEGORY) FROM retail_sales;
  
  -- DATA ANALSIS & BUSINESS KEY PROBLEMS
 -- Q.1 Write a query to retrieve all colomns for sales made on 2022-11-05
 SELECT *
 FROM retail_sales
 WHERE sale_date = '2022-11-05';
 
 -- Q.2 Write a query to retrieve all transaction where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022.
SELECT *
FROM retail_sales
WHERE category = "Clothing"
  AND DATE_FORMAT(sale_date, '%Y-%m') = '2022-11'
  AND quantiy >= 4;
  
  -- Q.3 Calculate total sales for each category
  select category,
  count(*)as total_orders,
  sum(total_sale)AS Net_sale from retail_sales
  group by 1;
  
  -- Q.4 Find the averge age of customers who purchased items from the "Beauty" category.alter
  select 
	round(avg(age)) as avg_age
  from retail_sales
  where category="Beauty";
  
  -- Q.5 Find all transaction where total_sale is greater than 1000.
  select transactions_id
  from retail_sales
  where total_sale>'1000';
  
  -- Q.6 find total number of transactions (transaction_id) made by each gender and each category.
  select category,
		 gender,
         count(*) as total_trans
  from retail_sales
  group by category, gender
  order by 1; 
  
  -- Q.7 Calculate the avg sale for each month. find out best selling month for each year.
select * from(
 select year(sale_date),
  month(sale_date),
  avg(total_sale),
  rank() over(partition by year(sale_date) order by  avg(total_sale) desc) as rk
  from retail_sales
  group by 1,2
  )as t1
  where rk = 1 ;


-- Q.8 find the top 5 customers baased on the highest total sales.
select customer_id,
       sum(total_sale) as total_sale
from retail_sales
group by 1
order by 2 desc
limit 5;

-- Q.9 find the number of unique customers who purchased items from each category.
select category,
      count(distinct customer_id)
 from retail_sales
 group by 1 ;
 
 -- Q.10 create each shift and number of orders (eg. Morning <=12, Afternonn between 12&17, Evening>17)
 with hourly_sale as(
select *,
	case 
		when hour(sale_time)<12 then "Morning"
        when hour(sale_time) between 12 and 17 then "Afternoon"
        else "Evening"
	end as shift
from retail_sales
) 
select shift,
	    count(*) as total_orders
 from hourly_sale
group by shift
;

-- End of Project. 

