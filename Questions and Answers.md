Below are the questions that were asked during the 30 days challenges and the queries I wrote to answer them.

**DAY 1**

Using the Movie Data, write a query to show the titles and movies released in 2017 whose vote count is more than 15 and runtime is more than 100
```sql
SELECT original_title
FROM movie_data
WHERE YEAR(release_date) = 2017 AND vote_count > 15 AND runtime > 100; 
```

**DAY 2**

Using PIzza Data, Write a query to show how many pizzas were ordered
```sql
SELECT COUNT(*) AS total_pizzas_ordered
FROM customer_orders;
```

**DAY 3**

Using the pizza data, write a query to show How many successful orders were delivered by each runner.
```sql
SELECT runner_id, COUNT(runner_id) AS successful_orders
FROM runner_orders
WHERE pickup_time IS NOT NULL
GROUP BY runner_id;
```
-- OR
```sql
SELECT runner_id, COUNT(runner_id) AS successful_orders
FROM runner_orders
WHERE cancellation = ''
GROUP BY runner_id;
```

 **DAY 4**
 
Using the Movie Data, Write a query to show the top 10 movie titles whose language is English 
and French and the budget is more than 1,000,000
```sql
SELECT original_title
FROM movie_data
WHERE original_language IN ('en', 'fr') AND budget >1000000
LIMIT 10;
```

**DAY 5**

Using the Pizza Data, Write a query to show the number of each type of pizza that was delivered
```sql
USE pizzas;
SELECT p.pizza_name, COUNT(c.pizza_id)
FROM customer_orders c
INNER JOIN  pizza_names p ON p.pizza_id = c.pizza_id
WHERE c.order_id NOT IN (SELECT order_id FROM runner_orders WHERE cancellation != '')
GROUP BY 1;
```

**BONUS Question**

The Briggs company wants to ship some of their products to customers in selected cities but they want to know
the average days it will take to deliver those items to Dallas, Los Angeles, Seattle, and Madison. 
Using the sample superstore data, write a query to show the average delivery days to those cities. 
Only show the city and Average delivery days columns in your output.
```sql
USE movies;
SELECT city, ROUND(AVG(DATEDIFF(shipdate, orderdate)),1) AS Average_delivery_days
FROM superstore
WHERE city in ('Dallas', 'Los Angeles', 'Seattle', 'Madison')
GROUP BY city;
```

**DAY 8**

It's getting to the end of the year and The Briggs Company wants to reward the customer who made the highest sales ever. 
Using the Sample Superstore, write a query to help the company identify this customer and the category of business driving the sales.
Let your output show the customer Name, the category, and the total sales. Round the total sales to the nearest whole number.
```sql 
SELECT CustomerName, Category, ROUND(SUM(sales),0) AS total_sales
FROM superstore
WHERE CustomerName = 	(SELECT CustomerName 
			 FROM 	(SELECT CustomerName, SUM(sales) AS total_sales
				 FROM superstore
				 GROUP BY 1
				 ORDER BY 2 DESC
				 LIMIT 1) sub1)
GROUP BY 1, 2
ORDER BY 3 DESC
LIMIT 1;
```

**DAY 9**

The Briggs Company has 3 categories of business generating revenue for the company. 
They want to know which of them is driving the business. Write a query to show the total sales and percentage
contribution by each category. Show category, Total Sales, and Percentage Contribution columns in your output.
```sql
SELECT Category, 
ROUND(SUM(sales),0) AS Total_Sales, 
CONCAT(ROUND(SUM(sales)*100/(SELECT SUM(sales) FROM superstore),1),'%') AS Percentage_Contribution
FROM superstore
GROUP BY 1
ORDER BY 3 DESC;
```

**DAY 10**

After seeing the Sales by Category, the Briggs company became curious and wanted to dig deeper to see 
which subcategory is selling the most. They need the help of an analyst. Please help the company write a
 query to show the sub-category and the total sales of each sub-category. Let your query display only the
 Subcategory and the Total sales columns to see which product sells the most.
 ```sql
SELECT SubCategory, 
ROUND(SUM(sales),0) AS Total_Sales
FROM superstore
GROUP BY 1
ORDER BY 2 DESC;
```

**DAY 11**

Now that you've identified phones as the business driver in terms of revenue. The company wants to know the total phone sales by year to understand how each year performed. As the Analyst, please help them show the breakdown of total sales by year in descending order. Let your output show only the Total sales and Sales Year column.
```sql
SELECT YEAR(OrderDate) Year, 
ROUND(SUM(sales),0) AS Total_Phone_Sales
FROM superstore
WHERE SubCategory = 'Phones'
GROUP BY 1
ORDER BY 2 DESC;
```

**DAY 12**

The Director of Analytics has requested a detailed analysis of the Briggs Company. 
To fulfill this request, he needs you to generate a table that displays the profit margin 
of each segment. The table should include the segments, total sales, total profit, and the profit margin. 
To ensure accuracy, the profit margin should be arranged in descending order.
```sql
SELECT 	Segment,
		ROUND(SUM(sales),0) AS Total_sales,
		ROUND(SUM(profit),0) AS Profit,
		CONCAT(ROUND(SUM(profit)*100/SUM(sales),2), '%') AS Profit_margin
FROM superstore
GROUP BY Segment
ORDER BY Profit_Margin DESC;
```

**Bonus Question**

Please use the Bonus table to write a query that returns only the meaningful reviews. 
Let your output return only the review column.
```sql
SELECT (Review)
FROM bonus_table
WHERE translation = '';
```

**DAY 15**

Your company started consulting for Micro bank who needs to analyze their marketing data to understand their customers better.
This will help them to plan their next marketing campaign. you are brought on board as the analyst for this job.
They have an offer for customers who are divorced but they need data to back up the campaign. Using the marketing data, 
write a query to show the percentage of customers who are divorced and have balances greater than 2000.
```sql
-- CTE
WITH divorced_customers AS (
				SELECT COUNT(marital) AS No_of_divorced
				FROM marketingdata
				WHERE marital = 'divorced' AND balance > 2000)
                
SELECT ROUND(No_of_divorced/(SELECT COUNT(*) FROM marketingdata)*100,2) AS '%_of_divorced_customers'
FROM divorced_customers;
```
 OR
 
```sql
-- Subquery
SELECT FORMAT(COUNT(marital)/(SELECT COUNT(*) FROM marketingdata)*100,2) AS '%_of_divorced_customers'
FROM marketingdata
WHERE marital = 'divorced' AND balance > 2000;
```
 
 -- DAY 16
 /* Micro Bank wants to be sure they have enough data for this campaign and would like to see the total count of each job as 
 contained in the dataset. Using the marketing data, write a query to show the count of each job, arrange the total count in Desc order.*/
SELECT 	job,
		COUNT(job) AS job_count
FROM marketingdata
GROUP BY job
ORDER BY job_count DESC; 


-- DAY 17
/* Just for clarity purposes, your company wants to see which education level got to the management job the most.
Using the marketing data, write a  query to show the education level that gets the management position the most. 
Let your output show the education, job and the counts of jobs columns.*/

SELECT education,
		job,
        COUNT(job) AS Job_count
FROM marketingdata
WHERE job ='management'
GROUP BY education, job
ORDER BY job_count DESC
LIMIT 1;

-- DAY 18
/* Write a query to show the average duration of customers' employment in management positions. 
The duration should be calculated in years. */
SELECT ROUND(AVG(duration/52),2) AS Avg_Duration
FROM marketingdata
WHERE job ='management';

-- DAY 19
/* What's the total number of customers that have housing, loan and are single? */
SELECT 	housing,
		Loan,
        marital,
        COUNT(*) AS number_of_customers
FROM marketingdata
WHERE housing = 'yes'
AND loan = 'yes'
AND marital = 'single';

-- Bonus Question
SELECT title, runtime 
FROM movie_data
WHERE runtime >= 250
ORDER BY runtime DESC;

SELECT * FROM employee_table;

-- DAY 22
/* Using the Employee Table dataset, write a query to show all the employees' first name and last name 
and their respective salaries. Also, show the overall average salary of the company and calculate the 
difference between each employee's salary and the company's average salary.*/
SELECT 	first_name,
		last_name,
        salary,
		ROUND(AVG(salary) OVER(), 0) AS Company_Average,
        salary - (ROUND(AVG(salary) OVER(), 0)) AS Salary_difference
FROM employee_table;

-- CTE
WITH company_average AS
			(SELECT AVG(salary) AS company_average
			FROM employee_table)
SELECT 	E.first_name,
		E.last_name,
        E.salary,
        A.company_average,
        E.salary - A.company_average
FROM employee_table AS E
CROSS JOIN company_average AS A;

-- Subquery
SELECT 	first_name,
		last_name,
        salary,
        (SELECT AVG(salary) FROM employee_table)  AS company_average,
        salary -(SELECT AVG(salary) AS company_average FROM employee_table) AS salary_diff
FROM employee_table;


-- DAY 23
/* Using the Share Price dataset, write a query to show a table that displays 
the highest daily decrease and the highest daily increase in share price. */

SELECT
     ROUND(MIN(close - open),2) AS highest_daily_decrease,
     ROUND(MAX(close - open),2) AS highest_daily_increase
FROM SharePrice;

SELECT * FROM shareprice;

-- DAY 24
/* Our client is planning their logistics for 2024, they want to know the average number of days it takes to 
ship to the top 10 states. Using the sample superstore dataset, write a query to show the state and the average 
number of days between the order date and the ship date to the top 10 states */

SELECT 	state, 
		FLOOR(AVG(DATEDIFF(shipdate, orderdate))) AS Average_delivery_days
FROM superstore
GROUP BY 1
ORDER BY 2
LIMIT 10;

SELECT *
FROM superstore;

SELECT 	state, 
		FORMAT(AVG(DATEDIFF(shipdate, orderdate)),1) AS Average_delivery_days
FROM superstore
GROUP BY 1
ORDER BY 2
LIMIT 10;
		
SELECT * FROM returns;

-- DAY 25
/* Your company received a lot of bad reviews about some of your products lately and the management wants 
to see which products they are and how many have been returned so far. Using the orders and returns table, 
write a query to see the top 5 most returned products from the company.*/

SELECT 	S.ProductName AS Product_Name, 
		S.ProductID AS ProductID, 
        COUNT(S.ProductName) AS Product_Count
FROM superstore AS S
INNER JOIN returns AS R
ON R.OrderID = S.OrderID
GROUP BY Product_Name, ProductID
ORDER BY Product_Count DESC, ProductID
LIMIT 5;
		
-- DAY 26
/* Using the employee table dataset, write a query to show the ratio of the analyst job title to the entire job titles.*/

WITH TotalJobCount AS(
		SELECT COUNT(job_title) AS AllJobCount
		FROM employee_table),
AnalystJobCount AS (
		SELECT COUNT(job_title) AS AnalystCount
		FROM employee_table
		WHERE job_title = 'Analyst')
SELECT 	AnalystCount,
		FORMAT((AnalystCount/AllJobCOUNT)*100,0) AS AnalystToTotalRatio
FROM TotalJobCount
CROSS JOIN AnalystJobCount;


WITH TotalJobCount AS(
		SELECT COUNT(job_title) AS AllJobCount
		FROM employee_table),
AnalystJobCount AS (
		SELECT COUNT(job_title) AS AnalystCount
		FROM employee_table
		WHERE job_title = 'Analyst')
SELECT 	AnalystCount,
		FORMAT((AnalystCount/AllJobCOUNT)*100,0) AS AnalystTotalRatio
FROM TotalJobCount, AnalystJobCount;

-- Using Subquery
SELECT * FROM employee_table;
SELECT 	COUNT(job_title) AS AnalystCount,
		FORMAT(COUNT(job_title)/(SELECT COUNT(job_title) FROM employee_table) *100,0) AS AnalystTotalRatio
FROM employee_table
WHERE job_title = 'Analyst';

-- BONUS 4
/* write a query to find 3rd highest sales from the sample superstore data*/

-- Using the Limit and offest method
SELECT (sales)
FROM superstore
ORDER BY sales DESC
LIMIT 1 OFFSET 2;

-- Using the Window function and Subquery
SELECT sales 
FROM  	(SELECT (sales), ROW_NUMBER() OVER(ORDER BY sales DESC) AS Row_numb
		FROM superstore) sub
WHERE Row_numb = 3;

-- DAY 29
/* Using the Employee dataset, please write a query to show the job title and department with the highest salary*/

SELECT 	job_title,
		department
FROM employee_table
WHERE salary = (SELECT MAX(salary) FROM employee_table)
GROUP BY 1,2;



-- DAY 30
/* Using the Employee dataset, write a query to determine the rank of employees based on their salaries in each department.
For each department, find the employee(s) with the highest salary and rank them in descending order. */

SELECT 	first_name,
		last_name,
        department,
		salary,
        DENSE_RANK() OVER(PARTITION BY DEPARTMENT ORDER BY SALARY DESC) AS department_salary_rank
FROM employee_table;



SELECT * FROM employee_table;
