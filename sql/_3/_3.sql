USE classicmodels;
-- missing values
SELECT * FROM customers;
SELECT customerNumber, customerName, COALESCE(state, 'N/A') AS state FROM customers;
SELECT customerNumber, customerName, addressLine2 FROM customers WHERE addressLine2 IS NULL;

-- name cleaning
SELECT customerNumber, TRIM(customerName) AS cleaned_customerName FROM customers;
SELECT  customerNumber, TRIM(CONCAT(ContactFirstName,' ',ContactLastName)) 
AS contactFullName, phone FROM customers;-- concating first and last name

-- email cleaning
SELECT * FROM employees;
SELECT  EmployeeNumber, TRIM(CONCAT(FirstName,' ',LastName)) AS FullName,
LOWER(TRIM(email)) AS cleaned_email FROM employees; -- trmining and concating names & emails

-- phone cleaning
SELECT officeCode, city, phone AS original_phone, REGEXP_REPLACE(phone, '[^0-9]','')
as cleaned_phone_number FROM offices;


-- duplicate detection
SELECT * FROM customers;
SELECT phone, COUNT(*) AS duplicate_count FROM customers GROUP BY phone HAVING COUNT(*) > 1;

-- order analysis
SELECT * FROM orders;
SELECT  orderNumber, orderDate, shippedDate, status, CASE WHEN shippedDate IS NULL THEN "Not Shipped Yet"
ELSE CAST(DATEDIFF(shippedDate,orderDate) AS CHAR) END AS fullfillment_days FROM orders;-- status condition

-- product transformation
SELECT * FROM products;
SELECT  productCode, productName, productScale,
CAST(SUBSTRING_INDEX(productScale,':',-1) AS unsigned) AS ScaleFactor FROM products;

-- data inconsistency
SELECT * FROM customers;
SELECT customerNumber, customerName, creditLimit FROM customers WHERE creditLimit <= 0;

-- standarisation
SET SQL_SAFE_UPDATES = 0;
UPDATE customers SET country = CASE 
    WHEN country = 'USA' THEN 'United States'
    WHEN country = 'UK' THEN 'United Kingdom'
ELSE country END WHERE country IN ('USA', 'UK');

SELECT country, customerName FROM customers;