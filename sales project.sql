----SQL Retail Sales Analysis

create table sales ( transactions_id INT Primary Key,
                    sale_date Date,
                    sale_time Time,
					customer_id INT,
					gender VARCHAR(25),
					age INT,
					category VARCHAR(25),
					quantiy INT,
					price_per_unit FLOAT,
					cogs FLOAT,
					total_sale FLOAT
					
					);

SELECT * FROM SALES LIMIT 10 ;

SELECT 
COUNT(*) FROM SALES ;

-----DATA Cleaning


SELECT * FROM SALES;
--HOW TO CHECK NULL VALUES
SELECT * FROM SALES where transactions_id is null;
SELECT * FROM SALES where sale_date is null;
--How to check it at once

SELECT * FROM SALES 
where 
transactions_id is null
OR
sale_date is null
OR
sale_time is null
OR
customer_id is null
OR
gender is null
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
Total_sale is null;

----How to Delete Null values

Delete from sales
where 
transactions_id is null
OR
sale_date is null
OR
sale_time is null
OR
customer_id is null
OR
gender is null
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
Total_sale is null;

----------DATA Exploration

How  many sales we have?

select count(*) as total_sales from Sales;

------How many customers do we have?

select count(customer_id) as total_sales from Sales;

------Maybe one customer has purchased many than one time, so we need to add  distinct to give as the exact unique customers.

select count(Distinct customer_id) as total_sales from Sales;

--How many categories do we have
select count(Distinct category) as total_sales from Sales;

-----To see the distinct list of categories, we use this
select Distinct category from Sales;

-----Data Analyis-----

----Qn.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05:

  select * 
  from sales 
  where sale_date = '2022-11-05';

----QN2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:


SELECT *
FROM sales
WHERE 
    category = 'Clothing'
    AND 
    TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
    AND
    quantiy >= 4


----QN3 Write a SQL query to calculate the total sales (total_sale) for each category.

SELECT 
    category,
    SUM(total_sale) as net_sale,
    COUNT(*) as total_orders
FROM sales
GROUP BY 1


--QN4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

SELECT
    ROUND(AVG(age), 2) as avg_age
FROM sales
WHERE category = 'Beauty'


---QN5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

  select *
  from sales
  where total_sale > 1000;
-----QN6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:

SELECT 
    category,
    gender,
    COUNT(*) as total_trans
FROM sales
GROUP 
    BY 
    category,
    gender
ORDER BY 1

---QN7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:
SELECT 
       year,
       month,
    avg_sale
FROM 
(    
SELECT 
    EXTRACT(YEAR FROM sale_date) as year,
    EXTRACT(MONTH FROM sale_date) as month,
    AVG(total_sale) as avg_sale,
    RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
FROM sales
GROUP BY 1, 2
) as t1
WHERE rank = 1

----**QN8 Write a SQL query to find the top 5 customers based on the highest total sales **:
SELECT 
    customer_id,
    SUM(total_sale) as total_sales
FROM sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5

---QN9 Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT 
    category,    
    COUNT(DISTINCT customer_id) as cnt_unique_cs
FROM sales
GROUP BY category

--QN 10 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)

WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM sales
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift