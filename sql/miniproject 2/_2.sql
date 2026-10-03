USE classicmodels;

-- customer location
SELECT * FROM customers;
SELECT customerName, city, country FROM customers;
SELECT customerName, city, country FROM customers WHERE country = 'USA'; -- particular country
SELECT customerName, country FROM customers WHERE country IN ('USA', 'France', 'Germany'); -- some countries

-- credit limits
SELECT customerName, creditLimit FROM customers WHERE creditLimit > 100000;
SELECT customerName, creditLimit FROM customers ORDER BY creditLimit DESC; -- in desecnding order
-- using linit and offset
SELECT customerName, creditLimit FROM customers ORDER BY creditLimit DESC LIMIT 5 OFFSET 5; 

-- customer searches
SELECT customerName FROM customers WHERE customerName LIKE '%Gift%' LIMIt 10;

-- salesrepresentative
SELECT * FROM customers;
SELECT customerName, salesRepEmployeeNumber FROM customers WHERE salesRepEmployeeNumber IS NOT NULL;

-- customer payments
SELECT c.customerNumber, c.customerName, p.paymentDate, p.amount
FROM customers c JOIN payments p ON c.customerNumber = p.customerNumber;

-- product prices
SELECT * FROM products;
SELECT productCode, productName, productLine, buyPrice, MSRP FROM products LIMIT 10;

-- product line
SELECT productName, productLine FROM products WHERE productLine = 'Classic Cars'; -- using single pline
-- multiple p line
SELECT productName, productLine FROM products WHERE productLine IN ('Planes', 'classic Cars'); 
-- no. of productlines
SELECT productLine, COUNT(*) AS productCount FROM products GROUP BY productLine;

-- stock levels
SELECT productName, quantityInStock FROM products WHERE quantityInStock < 1500;

-- product search
SELECT productName, productLine FROM products WHERE productName LIKE '%Ford%' LIMIT 20;

-- product  sorting
SELECT productName, MSRP FROM products WHERE MSRP > 100 ;

-- payment dates 
SELECT * FROM payments;
SELECT customerNumber, paymentDate, amount FROM payments;
SELECT customerNumber, paymentDate, amount FROM payments WHERE paymentDate > '2004-12-15';
SELECT customerNumber, paymentDate, amount FROM payments WHERE amount > 50000;

-- payment count
SELECT COUNT(*) AS paymentCount FROM payments;

-- customer payment
SELECT customerNumber, COUNT(*) AS paymentCount 
FROM payments GROUP BY customerNumber HAVING COUNT(*) > 3 limit 7;

-- total payment
SELECT customerNumber, SUM(amount) AS totalPayment
FROM payments GROUP BY customerNumber ORDER BY totalPayment ASC;

-- average payment
SELECT AVG(amount) AS averagePayment FROM payments;

-- maximun and minimun payment
SELECT MIN(amount) AS minimumPayment FROM payments;
SELECT MAX(amount) AS maximumPayment FROM payments;