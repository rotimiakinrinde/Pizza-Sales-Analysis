create table pizzadata(
	pizza_id int,
	order_id int,
	pizza_name_id varchar(30),
	quantity int,
	order_date date,
	order_time time,
	unit_price numeric,
	total_price numeric,
	pizza_size varchar (5),
	pizza_category varchar (20),
	pizza_ingredients varchar (150),
	pizza_name varchar(50)
);

SELECT *
FROM pizzadata;



-- 1. What is the total revenue?
SELECT 
	ROUND(SUM("total_price"),2) AS Total_Revenue
FROM pizzadata;

SELECT *
FROM
	pizzadata
WHERE 
	"pizza_id" = 48620;

-- 2. What is the average order value?
SELECT 
	ROUND(SUM("total_price") / COUNT(DISTINCT "order_id"),2) AS Avg_Order_Value
FROM 
	pizzadata;

-- 3. What is the sum of quanties of Pizza Sold?
SELECT 
	SUM("quantity") AS Total_Pizza_Sold
FROM 
	pizzadata;

-- What is the total number of Orders Placed?
SELECT 
	COUNT(DISTINCT "order_id") AS Total_Orders
FROM
	pizzadata;

-- What is the average number of pizzas sold per order?
SELECT 
	ROUND(
		CAST
			(SUM("quantity") AS DECIMAL(10,2)) /
		CAST
			(COUNT(DISTINCT "order_id") AS DECIMAL(10,2)), 2) AS Avg_Pizza_Per_Order
FROM 
	pizzadata;

-- CHARTS REQUIREMENT

-- What is the Daily Trend for Total Orders?
SELECT 
    TO_CHAR("order_date", 'Day') AS Order_Day, 
    COUNT(DISTINCT "order_id") AS Total_Orders
FROM 
    pizzadata
GROUP BY 
    TO_CHAR("order_date", 'Day')
ORDER BY
	COUNT(DISTINCT "order_id") DESC;

-- What is the Monthly Trend of Total Orders?
SELECT  
    TO_CHAR("order_date", 'Month') AS Order_Month, 
    COUNT(DISTINCT "order_id") AS Total_Orders
FROM 
    pizzadata
GROUP BY  
    TO_CHAR("order_date", 'Month')
ORDER BY
	COUNT(DISTINCT "order_id") DESC;

-- What is the Percentage sales by pizza category?
SELECT 
    pizza_category, 
    ROUND(SUM(total_price), 2) AS Total_Sales, 
    ROUND(SUM(total_price) * 100.0 / (SELECT SUM(total_price) FROM pizzadata), 2) AS Percentage_of_Sales
FROM 
    pizzadata
GROUP BY 
    pizza_category;

-- What is the Percentage sales by pizza category for the month of January?
SELECT 
    "pizza_category", 
    ROUND(SUM("total_price"), 2) AS Total_Sales, 
    ROUND(SUM("total_price") * 100.0 / (SELECT SUM("total_price") FROM pizzadata WHERE EXTRACT(MONTH FROM "order_date") = 1), 2) AS Percentage_of_Sales
FROM 
    pizzadata
WHERE 
    EXTRACT(MONTH FROM "order_date") = 1
GROUP BY 
    "pizza_category";

-- What is the percentage of sales by Pizza Size?
SELECT 
    pizza_size,
    ROUND(SUM(total_price), 2) AS Total_Sales,
    ROUND(SUM(total_price) * 100.0 / (SELECT SUM(total_price) FROM pizzadata WHERE EXTRACT(QUARTER FROM order_date) = 1), 2) AS Percentage_Total_Sales
FROM 
    pizzadata
WHERE 
    EXTRACT(QUARTER FROM order_date) = 1
GROUP BY 
    pizza_size
ORDER BY 
    Percentage_Total_Sales DESC;


-- What is the Total Pizzas sold by Pizza Category?
SELECT 
	"pizza_name_id"
	"pizza_category", 
	SUM("quantity") AS Total_Quantity_Sales
FROM 
	pizzadata
GROUP BY 
	"pizza_category"
ORDER BY
	Total_Quantity_Sales DESC;

-- What is the top 5 best sellers by Revenue, Total Quantity and Total Orders?
-- Ai. Top 5 pizza by Revenue
SELECT 
	"pizza_name",
	SUM("total_price") AS Total_Revenue
FROM
	pizzadata
GROUP BY
	"pizza_name"
ORDER BY
	Total_Revenue DESC
LIMIT 
	5;

-- Bottom 5 Pizza by Revenue
SELECT 
	"pizza_name",
	SUM("total_price") AS Total_Revenue
FROM
	pizzadata
GROUP BY
	"pizza_name"
ORDER BY
	Total_Revenue ASC
LIMIT 5;


-- Top 5 Pizzas by Quantity
SELECT 
	"pizza_name",
	SUM("quantity") AS Total_Quantity
FROM
	pizzadata
GROUP BY
	"pizza_name"
ORDER BY
	SUM("quantity") DESC
LIMIT 
	5;

-- Bottom 5 Pizzas by Quantity
SELECT 
	"pizza_name",
	SUM("quantity") AS Total_Quantity
FROM
	pizzadata
GROUP BY
	"pizza_name"
ORDER BY
	SUM("quantity") ASC
LIMIT 
	5;

-- Top 5 Pizzas by Orders
SELECT 
	"pizza_name",
	COUNT(DISTINCT "order_id") AS Total_Orders
FROM
	pizzadata
GROUP BY
	"pizza_name"
ORDER BY
	Total_Orders DESC
LIMIT 
	5;


-- Bottom 5 Pizzas by Orders
SELECT 
	"pizza_name",
	COUNT(DISTINCT "order_id") AS Total_Orders
FROM
	pizzadata
GROUP BY
	"pizza_name"
ORDER BY
	Total_Orders ASC
LIMIT 
	5;

	



