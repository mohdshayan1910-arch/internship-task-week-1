-- Database Creation
CREATE DATABASE internship;

-- using Created Database 
USE internship;
  
-- Table Creation
CREATE TABLE sales(
	order_id VARCHAR(50),
	order_date DATE,
	customer_name VARCHAR(50),
	region VARCHAR(50),
	category VARCHAR(50),
	sub_category VARCHAR(50),
	sales DECIMAL(10,2),
	quantity INT,
	discount DECIMAL(10,2),
	profit DECIMAL(10,2)
);

-- Used for the date format of dd/mm/yyyy
SET DATEFORMAT dmy;

-- Initialization of Table "sales"
BULK INSERT sales
FROM "C:\Users\Urooj\Desktop\Internship\Task 1\Excel\cleaned_sales_data.csv"
WITH(
    FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);

-- Total Sales by Region
SELECT
	region,
	SUM(sales) as total_sales
FROM dbo.sales
GROUP BY region

-- TOP 5 Profitable Product
SELECT TOP 5
	sub_category,
	SUM(sales) as total_sales
FROM dbo.sales
GROUP BY sub_category
ORDER BY SUM(sales) DESC

-- Monthly Sales Trend
SELECT 
	MONTH(order_date) as month,
	SUM(sales) as total_sales
FROM dbo.sales
GROUP BY MONTH(order_date)
ORDER BY MONTH(order_date)

-- Highest Discount Impact
SELECT 
	discount,
	AVG(profit) as total_profit
FROM sales
GROUP BY discount
ORDER BY AVG(profit) DESC
