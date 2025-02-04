Create table Retail(transactions_id int primary key,	
sale_date date,
sale_time time,
customer_id	int,
gender varchar(30),
age int,
category varchar(50),
quantiy int,
price_per_unit	int,
cogs	float,
total_sale int
)



--Cleaning the data 

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
total_sale is null


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
total_sale is null


select * from retail

-- Data Exploration

--cogs (cost of good sold)directly associated with purchase the goods or produce the goods
select count(*) from retail

select sum(total_sale),category from retail
group by category

select count(quantiy) from retail

select * from retail

select count(gender),gender from retail
group by gender


-- Data Analysis & Business Key Problems & Answers

-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

Select * from retail

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
        Select * from retail
        where sale_date = '2022-11-05'

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022

   Select *  
   from  retail
   where to_char(sale_date,'YYYY-MM') = '2022-11' 
   and  category = 'Clothing' 
   and quantiy > 3

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

	 Select category,sum(total_sale) as Total_Sale
	 from retail
	 group by category

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.  

    Select * from retail

     select category,round(avg(age),2) as Avg_age 
     from retail
	 where  category = 'Beauty'
	 group by category
	 

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

    Select * 
	from retail
	where total_sale > 1000
	
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

   Select gender,
   category,
   count(transactions_id)as Total_number_transactions   from retail
   group  by gender,category
   order by gender desc
   
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year	

  with CTE AS 
  (
  SELECT round(avg(Total_sale),2) AS AVG_Sale,
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
		 

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 


  Select customer_id,sum(total_sale) as Total_sale from retail
  group by customer_id
  order by total_sale desc
  limit 5

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

select * from retail

	       select
			    category,
				count(distinct(customer_id))  as unique_customer from retail
		        group by category


''' Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12,
     Afternoon Between 12 & 17, Evening >17) '''
 select * from retail

  
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
   