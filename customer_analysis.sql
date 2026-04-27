-- FILL IN BLANK IN RETURN COLUM
UPDATE ecommerce_customer_raw
SET Returns = '0'
WHERE Returns = '';



-- 1. Customer Dimension
CREATE TABLE Customer (
    Customer_ID INT PRIMARY KEY,
    Customer_Name VARCHAR(255) NOT NULL,
    Age INT,
    Gender VARCHAR(50)
);

-- 2. Product Dimension (Product_ID is added for referrential purpose, AUTO_INCREMENT is used to assign the ID) 
CREATE TABLE Product (
    Product_ID INT AUTO_INCREMENT PRIMARY KEY, -- The database creates this for you!
    Product_Category VARCHAR(255),
    Product_Price FLOAT
);

-- 3. Order Table (Order_ID is added for referrential purpose, AUTO_INCREMENT is used to assign the ID) 
CREATE TABLE `Order` (
    Order_ID INT AUTO_INCREMENT PRIMARY KEY,
    Customer_ID INT,
    Purchase_Date DATETIME,
    Product_ID INT, -- Using the ID, not the Category Name
    Quantity INT,
    Total_Purchase_Amount FLOAT,
    Payment_Method VARCHAR(255),
    Returns INT,
    Churn INT,
    CONSTRAINT fk_customer FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID),
    CONSTRAINT fk_product FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID)
);

-- Input value from raw table into dimension & fact table

-- 1.Customer
INSERT INTO Customer (Customer_ID, Customer_Name, Age, Gender)
SELECT DISTINCT 
    `Customer ID`, 
    `Customer Name`, 
    `Customer Age`, 
    Gender
FROM ecommerce_customer_raw;

-- 2.Product
INSERT INTO Product(`Product_Category`,`Product_Price`)
SELECT DISTINCT 
     `Product Category`,
     `Product Price`
FROM ecommerce_customer_raw;

-- 3.Order
INSERT INTO `Order` (Customer_ID, Purchase_Date, Product_ID, Quantity, Total_Purchase_Amount, Payment_Method, Returns, Churn)
SELECT 
    r.`Customer ID`,
    r.`Purchase Date`,
    p.Product_ID,
    r.Quantity,
    r.`Total Purchase Amount`,
    r.`Payment Method`,
    r.Returns,
    r.Churn
FROM ecommerce_customer_raw r
JOIN Product p 
  ON r.`Product Category` = p.Product_Category 
  AND r.`Product Price` = p.Product_Price;
  
  -- CHECK NULL VALUE
  
  SELECT 
    COUNT(*) - COUNT(Customer_Name) AS Null_Names,
    COUNT(*) - COUNT(Age) AS Null_Ages,
	COUNT(*) - COUNT(Gender) AS Null_Gender
FROM Customer;

SELECT 
    COUNT(*) - COUNT(Customer_ID) AS Null_CustomerIDs,
    COUNT(*) - COUNT(Purchase_Date) AS Null_dates,
    COUNT(*) - COUNT(Product_ID) AS Null_ProductIDs,
	COUNT(*) - COUNT(Quantity) AS Null_quantity,
	COUNT(*) - COUNT(Total_Purchase_Amount) AS Null_totals,
    COUNT(*) - COUNT(Payment_Method) AS Null_methods,
    COUNT(*) - COUNT(`Returns`) AS Null_returns,
    COUNT(*) - COUNT(Churn) AS Null_churns
FROM `Order`;

SELECT 
	COUNT(*) - COUNT(Product_Category) AS Null_category,
	COUNT(*) - COUNT(Product_Price) AS Null_prices
FROM `Product`;

--
WITH customer_rank AS(
	 SELECT distinct c.Customer_ID, c.Customer_Name,
			SUM(Total_Purchase_Amount) as Revenue, 
			ROUND(
                  PERCENT_RANK() OVER (ORDER BY SUM(Total_Purchase_Amount) DESC) ,2) percentile_rank
     FROM Customer c
     JOIN `Order` o
     ON c.Customer_ID = o.Customer_ID
     GROUP BY c.customer_Name, c.Customer_ID)
	
SELECT *,
	CASE 
		WHEN percentile_rank <= 0.2 THEN 'High Value'
        WHEN percentile_rank <= 0.5 THEN 'Medium Value'
        ELSE 'Low Value'
	END AS Customer_segment 
FROM customer_rank;

WITH churn_customer AS (
    SELECT COUNT(DISTINCT Customer_ID) AS churn_cnt
    FROM `Order`
    WHERE Churn = 1
),
total_customer AS (
    SELECT COUNT(DISTINCT Customer_ID) AS total_cnt
    FROM `Order`
)

SELECT 
    churn_cnt / total_cnt AS churn_rate
FROM churn_customer, total_customer;

WITH return_order AS(
	SELECT COUNT(DISTINCT `ORDER_ID`) AS return_count
	FROM `Order`
    WHERE `Returns` = '1'),

order_count AS (
	SELECT COUNT(DISTINCT `ORDER_ID`) AS order_count
    FROM `Order`)
    
SELECT return_count /order_count AS return_rate
FROM return_order,order_count



	





     