USE classicmodels;

-- product ranking
SELECT productCode, productName, productLine, buyPrice,
RANK() OVER ( PARTITION BY productLine ORDER BY buyPrice DESC ) AS productRank FROM products;

-- product ranking using row_number  
SELECT productCode, productName, productLine, buyPrice,
ROW_NUMBER() OVER ( PARTITION BY productLine ORDER BY buyPrice DESC ) AS rowNumber FROM products;

-- running totals
SELECT *FROM payments;
SELECT customerNumber, paymentDate, amount, 
SUM(amount) OVER ( PARTITION BY customerNumber ORDER BY paymentDate ) AS runningTotal
FROM payments;

-- highest rank product
SELECT *FROM products;
SELECT productCode, productName, productLine, buyPrice, productRank 
FROM ( SELECT productCode, productName, productLine, buyPrice, 
DENSE_RANK() OVER ( PARTITION BY productLine ORDER BY buyPrice DESC ) AS productRank FROM products ) 
ranked_products WHERE productRank = 1;

-- month over month analysis
SELECT * FROM payments;
WITH monthly_payments AS ( SELECT DATE_FORMAT(paymentDate, '%Y-%m') AS paymentMonth,
SUM(amount) AS totalPayment FROM payments GROUP BY DATE_FORMAT(paymentDate, '%Y-%m'))
SELECT paymentMonth, totalPayment, LAG(totalPayment) OVER (ORDER BY paymentMonth )
 AS previousMonthPayment FROM monthly_payments ORDER BY paymentMonth;
 
  -- growth analysis
 WITH monthly_payments AS ( SELECT DATE_FORMAT(paymentDate, '%Y-%m') AS paymentMonth,
SUM(amount) AS totalPayment FROM payments GROUP BY DATE_FORMAT(paymentDate, '%Y-%m'))
SELECT paymentMonth,totalPayment, totalPayment - LAG(totalPayment) OVER (ORDER BY 
paymentMonth ) AS paymentGrowth FROM monthly_payments ORDER BY paymentMonth;

-- moving average
WITH monthly_payments AS (SELECT DATE_FORMAT(paymentDate, '%Y-%m') AS paymentMonth,
SUM(amount) AS totalPayment FROM payments GROUP BY DATE_FORMAT(paymentDate, '%Y-%m'))
SELECT paymentMonth, totalPayment, 
AVG(totalPayment) OVER ( ORDER BY paymentMonth ROWS BETWEEN 2 PRECEDING AND CURRENT ROW ) 
AS threeMonthAvg FROM monthly_payments ORDER BY paymentMonth;