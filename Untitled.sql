DROP TABLE IF EXISTS sales1;

CREATE TABLE sales1 (
            transactions_id INT PRIMARY KEY,
			sale_date DATE,
			sale_time TIME,
			customer_id INT,
			gender VARCHAR(20),
			age INT,
			category VARCHAR(20),
			quantiy INT,
			price_per_unit FLOAT,
			cogs FLOAT,
			total_sale FLOAT
);


select COUNT(*) from sales1;


 
select * from sales1;

---Data cleaning 

select * from sales1
  WHERE transactions_id IS Null
  OR 
  sale_date is Null
  OR 
   Sale_time is Null
  OR
  Customer_id is Null
  OR
  Gender is null
  OR
  age is null
  OR
   category is null
  OR
   quantiy is null
  OR
  price_per_unit is null
  OR
  cogs is null
  OR
  total_sale is null;
  
  --- delete columns with missing values--


DELETE FROM SALES1

WHERE transactions_id IS Null
  OR 
  sale_date is Null
  OR 
   Sale_time is Null
  OR
  Customer_id is Null
  OR
  Gender is null
  OR
  age is null
  OR
   category is null
  OR
   quantiy is null
  OR
  price_per_unit is null
  OR
  cogs is null
  OR
  total_sale is null;


 --DATA EXPLORATOIONS


 --HOW MANY SALES DO WE HAVE?


 SELECT COUNT(*) as Total_Sales from Sales1;

--HOW MANY uniquie customers DO WE HAVE?

SELECT COUNT(distinct customer_id) as Total customers from Sales1;

 --HOW MANY unique categories DO WE HAVE?

 SELECT distinct category  from Sales1;

 ---Main Data Analysis Business key problems and answers.



 
 1---Write sql query to retrieve all columns for sales made on '2022-11-05'

   SELECT * FROM SALES1 WHERE SALE_DATE ='2022-11-05'




 
 2---Write sql query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022.

SELECT *
FROM SALES1 WHERE CATEGORY = 'Clothing'  
AND To_CHAR(sale_date, 'yyyy-mm')= '2022-11'   
AND QUANTIY>=4
 
 3---Write sql query to calculate the total sales (total_sales) for each category.

SELECT 
CATEGORY,
SUM(TOTAL_SALE),
COUNT(*) AS TOTAL_ORDERS
FROM SALES1
GROUP BY 1


 
 4---Write sql query to find the average of customers who purchased iteams from the 'beauty' category.

SELECT 
  Round(Avg(age), 2) as Average_Age
   FROM SALES1
   WHERE CATEGORY = 'Beauty'


 
 5---Write sql query to find tarnsactions where the total_sales is greater than 1000.

     select * from sales1
	 where total_sale > 1000



 
 6---Write sql query to  find the total number of transactions 'transaction_id' made by each gender in each category.

Select 
	category,
	gender,
	count(*) as total_trans
	from sales1
	group by 
	category,
	gender
ORDER BY 1


 
 7---Write a sql query to calculate the average sale for each month. Find out best selling month in each year.
SELECT 
YEAR,
MONTH, 
AVERAGE_SALE 
FROM(

SELECT
    EXTRACT(YEAR FROM SALE_DATE) AS YEAR,
	EXTRACT(MONTH FROM SALE_DATE) AS MONTH,
	AVG(TOTAL_SALE) AS AVERAGE_SALE,
	Rank() OVER(partition by EXTRACT(YEAR FROM SALE_DATE) order by AVG(TOTAL_SALE) DESC ) AS RANK

FROM SALES1
GROUP BY 1, 2
)

WHERE RANK =1
--order by 1, 3 desc
 
 8---Write sql query to find the top 5 customers based on the highest total sales.
SELECT 
    CUSTOMER_ID,
	SUM(TOTAL_SALE) AS TOTAL_SALES
	FROM SALES1
	GROUP BY 1
    ORDER BY 2 DESC
	LIMIT 5




 
 9---Write sql query to find the number of unique customers who puchased items from each category.



 
SELECT
 CATEGORY,
 COUNT(DISTINCT CUSTOMER_ID) AS Unique_CUSTOMERS
 FROM SALES1
GROUP BY CATEGORY

 
 10---Write sql query to create each shift and number of orders (Example morning<=12, Afternoon between 12and 17, Evening>17)

select * from sales

with hourly_sales
as (
 SELECT *,
 CASE 
 WHEN EXTRACT(HOUR FROM SALE_TIME) < 12 THEN 'Morning'
 WHEN EXTRACT(HOUR FROM SALE_TIME) between 12 and 17 THEN 'Afternoon'
 ELSE 'Evening'
 END AS SHIFT
 from sales1)
 select 
 shift,
 count(transactions_id)
 from hourly_sales
 group by shift



---End of Project2
 