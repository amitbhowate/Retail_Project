# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Database**: `Retail_db_1`


## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `Retail_db_1`.
- **Table Creation**: A table named `retail` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
CREATE DATABASE p1_retail_db;

CREATE TABLE retail_sales
(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,	
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT
);
```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

 select * from retail
      where transactions_id is null
       OR 
       sale_date is null
       or
       sale_time is null
       or
       customer_id is null
       or
       gender is null
       or 
       age is null
       or
       category is null
       or
       quantiy is null
       or
       price_per_unit is null
       or
       cogs is null
       or
       total_sale is null;



    Delete from retail  
      where transactions_id is null
       OR 
       sale_date is null
       or
       sale_time is null
       or
       customer_id is null
       or
       gender is null
       or 
       age is null
       or
       category is null
       or
      quantiy is null
      or
      price_per_unit is null
      or
      cogs is null
      or
      total_sale is null ;


select * from retail

 Data Exploration

cogs (cost of good sold)directly associated with purchase the goods or produce the goods
select count(*) from retail

select sum(total_sale),category from retail
group by category

select count(quantiy) from retail

select * from retail

select count(gender),gender from retail
group by gender      

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05**:
```sql
 SELECT *
 FROM retail
 WHERE sale_date = '2022-11-05';
```

2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022**:
```sql
   Select *  
   from  retail
   where to_char(sale_date,'YYYY-MM') = '2022-11' 
   and  category = 'Clothing' 
   and quantiy > 3
```

3. **Write a SQL query to calculate the total sales (total_sale) for each category.**:
```sql
   Select 
   category,
   sum(total_sale) as Total_Sale
   from retail
   group by category
```

4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:
```sql

     Select category,round(avg(age),2) as Avg_age 
     from retail
	 where  category = 'Beauty'
	 group by category

5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:
```sql
    Select * 
	from retail
	where total_sale > 1000
	
```

6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:
```sql
   Select 
   gender,
   category,
   count(transactions_id)as Total_number_transactions  
   from retail
   group  by gender,category
   order by gender desc
    
```

7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**:
```sql
    with CTE AS 
  (
      SELECT 
      round(avg(Total_sale),2) AS AVG_Sale,
      extract(month from sale_date) as months,
      extract(year from sale_date) as years,
      dense_rank()over(partition by extract(year from sale_date)order by avg(Total_sale) desc) as rnk
      FROM Retail
      group by 2,3
  )
  SELECT AVG_Sale,
         Months,
		 years,
		 rnk from CTE
	WHERE rnk = 1	 
```

8. **Write a SQL query to find the top 5 customers based on the highest total sales **:
```sql

   Select 
   customer_id,
   sum(total_sale) as Total_sale from retail
   group by customer_id
   order by total_sale desc
   limit 5
```

9. **Write a SQL query to find the number of unique customers who purchased items from each category.**:
```sql
        SELECT
		category,
		count(distinct(customer_id))  as unique_customer from retail
		group by category

```

10. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:
```sql
  Select count(*) as number_of_order,shift
  from 
  (select *,
          case 
		   when extract(hour from sale_time)<= 12 then 'Morning_shift'
           when extract(hour from sale_time) between 12 and 17  then 'Afternoon_shift'
           else 'Evening'
		   end as shift
		   from retail
   ) as table_A
   group by shift
```



