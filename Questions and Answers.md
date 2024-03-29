Below are the questions that were asked during the 30 days challenges and the queries I wrote to answer them.

### **DAY 1**

Using the Movie Data, write a query to show the titles and movies released in 2017 whose vote count is more than 15 and runtime is more than 100
```sql
SELECT original_title
FROM movie_data
WHERE YEAR(release_date) = 2017 AND vote_count > 15 AND runtime > 100; 
```
### **Output:**
|original_title|
|:---|
Girls Trip
Detroit
L'Amant double
Descendants 2
#

### **DAY 2**

Using PIzza Data, Write a query to show how many pizzas were ordered
```sql
SELECT COUNT(*) AS total_pizzas_ordered
FROM customer_orders;
```
### **Output:**
|total_pizzas_ordered|
|:---|
14

#

### **DAY 3**

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
### **Output:**
|runner_id 	|successful_orders
|:----		|---
|1		|4
2		|3
3		|1

#
### **DAY 4**
 
Using the Movie Data, Write a query to show the top 10 movie titles whose language is English 
and French and the budget is more than 1,000,000
```sql
SELECT original_title
FROM movie_data
WHERE original_language IN ('en', 'fr') AND budget >1000000
LIMIT 10;
```
### **Output:**
|original_title|
|:---		|
Toy Story
Jumanji
Waiting to Exhale
Heat
Sabrina
Sudden Death
GoldenEye
The American President
Nixon
Cutthroat Island
#

### **DAY 5**

Using the Pizza Data, Write a query to show the number of each type of pizza that was delivered
```sql
SELECT p.pizza_name, COUNT(c.pizza_id) AS no_of_pizza
FROM customer_orders c
INNER JOIN  pizza_names p ON p.pizza_id = c.pizza_id
WHERE c.order_id NOT IN (SELECT order_id FROM runner_orders WHERE cancellation != '')
GROUP BY 1;
```
### **Output:**

|pizza_name	|no_of_pizza|
|:---		|---
Meat Lovers	|9
Vegetarian	|3

#

### **BONUS Question**

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
### **Output:**
|city	|Average_delivery_days
|:---	|---
|Los Angeles	|4.0
Seattle		|4.0
Madison		|3.6
Dallas		|4.1

#

### **DAY 8**

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
### **Output:**
|CustomerName	|Category	|total_sales
|:---		|---		|---
Sean Miller	|Technology	|23482

#

### **DAY 9**

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
### **Output:**
|Category	|Total_Sales	|Percentage_Contribution
|:---		|----		|----
Technology	|836154	|36.4%
Furniture	|742000	|32.3%
Office Supplies	|719047	|31.3%

#

### **DAY 10**

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
### **Output:**
|SubCategory	|Total_Sales
|:---		|---
Phones	|330007
Chairs	|328449
Storage	|223844
Tables	|206966
Binders	|203413
Machines	|189239
Accessories	|167380
Copiers		|149528
Bookcases	|114880
Appliances	|107532
Furnishings	|91705
Paper		|78479
Supplies	|46674
Art		|27119
Envelopes	|16476
Labels	|12486
Fasteners	|3024

#

### **DAY 11**

Now that you've identified phones as the business driver in terms of revenue. The company wants to know the total phone sales by year to understand how each year performed. As the Analyst, please help them show the breakdown of total sales by year in descending order. Let your output show only the Total sales and Sales Year column.
```sql
SELECT YEAR(OrderDate) Year, 
ROUND(SUM(sales),0) AS Total_Phone_Sales
FROM superstore
WHERE SubCategory = 'Phones'
GROUP BY 1
ORDER BY 2 DESC;
```
### **Output:**
|Year	|Total_Phone_Sales
|:---	|----
2020	|105341
2019	|78962
2017	|77391
2018	|68314

#

### **DAY 12**

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
### **Output:**
|Segment	|Total_sales	|Profit	|Profit_margin
|:---		|---		|---	|---
Home Office	|429653	|60299		|14.03%
Corporate	|706146	|91979		|13.03%
Consumer	|1161401	|134119		|11.55%

#

### **Bonus Question**

Please use the Bonus table to write a query that returns only the meaningful reviews. 
Let your output return only the review column.
```sql
SELECT (Review)
FROM bonus_table
WHERE translation = '';
```
### **Output:**
|Review
|----
Good
Good
Excellent 
Bad
Fair
Excellent 
Good

#

### **DAY 15**

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
### **Output:**
|%_of_divorced_customers
|---
2.45

#
 
### **DAY 16**

Micro Bank wants to be sure they have enough data for this campaign and would like to see the total count of each job as 
contained in the dataset. Using the marketing data, write a query to show the count of each job, arrange the total count in Desc order.
```sql
SELECT 	job,
	COUNT(job) AS job_count
FROM marketingdata
GROUP BY job
ORDER BY job_count DESC; 
```
### **Output:**
|job	|job_count
|:--	|---
management	|2566
blue-collar	|1944
technician	|1823
admin.		|1334
services	|923
retired		|778
self-employed	|405
student		|360
unemployed	|357
entrepreneur	|328
housemaid	|274
unknown		|70

#

### **DAY 17**

Just for clarity purposes, your company wants to see which education level got to the management job the most.
Using the marketing data, write a  query to show the education level that gets the management position the most. 
Let your output show the education, job and the counts of jobs columns.
```sql
SELECT education,
	job,
        COUNT(job) AS Job_count
FROM marketingdata
WHERE job ='management'
GROUP BY education, job
ORDER BY job_count DESC
LIMIT 1;
```
### **Output:**
|education	|job	|Job_count
|:---		|---	|---
tertiary	|management	|2178

#

### **DAY 18**

Write a query to show the average duration of customers' employment in management positions. 
The duration should be calculated in years.
```sql
SELECT ROUND(AVG(duration/52),2) AS Avg_Duration
FROM marketingdata
WHERE job ='management';
```
### **Output:**
|Avg_Duration
|:--
6.95

#

### **DAY 19**

What's the total number of customers that have housing, loan and are single?
```sql
SELECT 	housing,
	Loan,
        marital,
        COUNT(*) AS number_of_customers
FROM marketingdata
WHERE housing = 'yes'
AND loan = 'yes'
AND marital = 'single';
```
### **Output:**
|housing	|Loan	|marital	|number_of_customers
|:---		|---	|---		|---
yes		|yes	|single		|158

#

### **Bonus Question**

Using the Movie data, write a query to show the movie title with runtime of at least 250. Show the title and runtime columns in your output.
```sql
SELECT title, runtime 
FROM movie_data
WHERE runtime >= 250
ORDER BY runtime DESC;
```
### **Output:**
|title			|runtime
|:---			|--
Century of Birthing	|360
The Prisoner of If Castle	|270

#

### **DAY 22**

Using the Employee Table dataset, write a query to show all the employees' first name and last name 
and their respective salaries. Also, show the overall average salary of the company and calculate the 
difference between each employee's salary and the company's average salary.
```sql
-- Using Window function
SELECT 	first_name,
	last_name,
        salary,
	ROUND(AVG(salary) OVER(), 0) AS Company_Average,
        salary - (ROUND(AVG(salary) OVER(), 0)) AS Salary_difference
FROM employee_table;
```
```sql
-- CTE
WITH company_average AS
			(SELECT AVG(salary) AS company_average FROM employee_table)
SELECT 	E.first_name,
	E.last_name,
        E.salary,
        A.company_average,
        E.salary - A.company_average
FROM employee_table AS E
CROSS JOIN company_average AS A;
```
```sql
-- Subquery
SELECT 	first_name,
	last_name,
        salary,
        (SELECT AVG(salary) FROM employee_table)  AS company_average,
        salary -(SELECT AVG(salary) AS company_average FROM employee_table) AS salary_diff
FROM employee_table;
```
### **Output:**
|first_name	|last_name	|salary	|Company_Average	|Salary_difference
|:---		|---		|---	|---			|---
John	|Doe	|75000	|66150	|8850
Jane	|Smith	|65000	|66150	|-1150
Mike	|Johnson |60000	|66150	|-6150
Sarah	|Brown	|55000	|66150	|-11150
David	|Lee	|70000	|66150	|3850
Emily	|Wilson	|72000	|66150	|5850
Michael	|Garcia	|68000	|66150	|1850
Olivia	|Martinez |61000 |66150	|-5150
James	|Williams |59000 |66150	|-7150
Sophia	|Taylor	|72000	|66150	|5850
Daniel	|Miller	|75000	|66150	|8850
Ava	|Anderson |66000 |66150	|-150
William	|Moore	|62000	|66150	|-4150
Ella	|White	|58000	|66150	|-8150
Alexander |Lopez |71000	|66150	|4850
Mia	|Harris	|73000	|66150	|6850
Henry	|Clark	|67000	|66150	|850
Grace	|Lewis	|63000	|66150	|-3150
Liam	|Young	|57000	|66150	|-9150
Chloe	|Gonzalez |74000 |66150	|7850

#

### **DAY 23**

Using the Share Price dataset, write a query to show a table that displays the highest daily decrease and the highest daily increase in share price.
```sql
SELECT
     ROUND(MIN(close - open),2) AS highest_daily_decrease,
     ROUND(MAX(close - open),2) AS highest_daily_increase
FROM SharePrice;
```
### **Output:**
|highest_daily_decrease	|highest_daily_increase
|:---			|---
-35.26			|31.06

#

### **DAY 24**

Our client is planning their logistics for 2024, they want to know the average number of days it takes to 
ship to the top 10 states. Using the sample superstore dataset, write a query to show the state and the average 
number of days between the order date and the ship date to the top 10 states.
```sql
SELECT 	state, 
	FORMAT(AVG(DATEDIFF(shipdate, orderdate)),1) AS Average_delivery_days
FROM superstore
GROUP BY 1
ORDER BY 2
LIMIT 10;
SELECT 	state, 
```
### **Output:**
|state		|Average_delivery_days
|:--- 		|---
North Dakota	|2.9
Louisiana	|3.0
West Virginia	|3.0
Rhode Island	|3.3
Ohio		|3.5
Nebraska	|3.5
Connecticut	|3.6
South Carolina	|3.6
New Hampshire	|3.7
Colorado	|3.7

#

### **DAY 25**

Your company received a lot of bad reviews about some of your products lately and the management wants 
to see which products they are and how many have been returned so far. Using the orders and returns table, 
write a query to see the top 5 most returned products from the company.
```sql
SELECT 	S.ProductName AS Product_Name, 
	S.ProductID AS ProductID, 
        COUNT(S.ProductName) AS Product_Count
FROM superstore AS S
INNER JOIN returns AS R
ON R.OrderID = S.OrderID
GROUP BY Product_Name, ProductID
ORDER BY Product_Count DESC, ProductID
LIMIT 5;
```
### **Output:**
|Product_Name				|ProductID		|Product_Count
|:----					|----			|----
Global Leather Task Chair, Black	|FUR-CH-10003061	|20
Advantus Push Pins			|OFF-FA-10000304	|20
Global Troy Executive Leather Low-Back Tilter	|FUR-CH-10001215	|19
Global Wood Trimmed Manager's Task Chair, Khaki	|FUR-CH-10003774	|17
Ibico Standard Transparent Covers	|OFF-BI-10002852	|17


#
  
### **DAY 26**

Using the employee table dataset, write a query to show the ratio of the analyst job title to the entire job titles.
```sql
-- Using CTE
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
```
OR
```sql
-- Using Subquery
SELECT 	COUNT(job_title) AS AnalystCount,
	FORMAT(COUNT(job_title)/(SELECT COUNT(job_title) FROM employee_table) *100,0) AS AnalystTotalRatio
FROM employee_table
WHERE job_title = 'Analyst';
```
### **Output:**
|AnalystCount	|AnalystToTotalRatio
|:----		|---
4		|20

#

### **BONUS Question**

write a query to find 3rd highest sales from the sample superstore data
```sql
-- Using the Limit and offest method
SELECT (sales)
FROM superstore
ORDER BY sales DESC
LIMIT 1 OFFSET 2;
```
```sql
-- Using the Window function and Subquery
SELECT sales 
FROM  	(SELECT (sales), ROW_NUMBER() OVER(ORDER BY sales DESC) AS Row_numb
	 FROM superstore) sub
WHERE Row_numb = 3;
```
### **Output:**
|sales
|:---
13999.96

#

### **DAY 29**

Using the Employee dataset, please write a query to show the job title and department with the highest salary.
```sql
SELECT 	job_title,
	department
FROM employee_table
WHERE salary = (SELECT MAX(salary) FROM employee_table)
GROUP BY 1,2;
```
### **Output:**
|job_title	|department
|:---		|---
Manager		|HR

#

### **DAY 30**

Using the Employee dataset, write a query to determine the rank of employees based on their salaries in each department.
For each department, find the employee(s) with the highest salary and rank them in descending order.
```sql
SELECT 	first_name,
	last_name,
        department,
	salary,
        DENSE_RANK() OVER(PARTITION BY DEPARTMENT ORDER BY SALARY DESC) AS department_salary_rank
FROM employee_table;
```
### **Output:**
|first_name		|last_name	|department	|salary		|department_salary_rank
|:---			|----		|----		|---		|----
Grace			|Lewis		|Creative	|63000		|1
William			|Moore		|Creative	|62000		|2
Olivia			|Martinez	|Creative	|61000		|3
Mike			|Johnson	|Creative	|60000		|4
Chloe			|Gonzalez	|Engineering	|74000		|1
Sophia			|Taylor		|Engineering	|72000		|2
Alexander		|Lopez		|Engineering	|71000		|3
David			|Lee		|Engineering	|70000		|4
Michael			|Garcia		|Engineering	|68000		|5
Henry			|Clark		|Engineering	|67000		|6
Ava			|Anderson	|Engineering	|66000		|7
Jane			|Smith		|Engineering	|65000		|8
James			|Williams	|Finance	|59000		|1
Ella			|White		|Finance	|58000		|2
Liam			|Young		|Finance	|57000		|3
Sarah			|Brown		|Finance	|55000		|4
John			|Doe		|HR		|75000		|1
Daniel			|Miller		|HR		|75000		|1
Mia			|Harris		|HR		|73000		|2
Emily			|Wilson		|HR		|72000		|3
