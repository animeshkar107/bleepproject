USE classicmodels;

-- customer and payment analysis
SELECT c.customerNumber, c.customerName, p.checkNumber, p.paymentDate, p.amount
FROM customers c INNER JOIN payments p ON c.customerNumber = p.customerNumber;

-- employee and office analysis
SELECT e.firstName, e.lastName, o.officeCode, o.city, o.country, phone, addressLine1
FROM employees e INNER JOIN offices o ON e.officeCode = o.officeCode;

-- order and product analysis
SELECT od.orderNumber, p.productName, od.quantityOrdered, od.priceEach 
FROM orderdetails od INNER JOIN products p ON od.productCode = p.productCode;

SELECT od.orderNumber, od.productCode, p.productName, od.quantityOrdered, od.priceEach
FROM orderdetails od INNER JOIN products p ON od.productCode = p.productCode 
WHERE od.orderNumber = 10101;

-- office analysis
SELECT o.officeCode, o.city, o.country,
COUNT(e.employeeNumber) AS employeeCount
FROM offices o LEFT JOIN employees e ON o.officeCode = e.officeCode 
GROUP BY o.officeCode, o.city, o.country ORDER BY employeeCount DESC;

-- sales representative analysis
SELECT c.customerName, e.employeeNumber, e.firstName,e.lastName, e.email
FROM customers c INNER JOIN employees e ON c.salesRepEmployeeNumber = e.employeeNumber
ORDER BY c.customerName;

-- employee hierarchy
SELECT e.firstName AS employeeFirstName,
e.lastName AS employeeLastName,
m.firstName AS managerFirstName,
m.lastName AS managerLastName
FROM employees e LEFT JOIN employees m ON e.reportsTo = m.employeeNumber;

-- missiong relationships
-- customer without orders
SELECT c.customerName, c.customerNumber FROM customers c
LEFT JOIN orders o ON c.customerNumber = o.customerNumber WHERE o.orderNumber IS NULL;

-- product that have never been sold
SELECT p.productCode, p.productName FROM products p
LEFT JOIN orderdetails od ON p.productCode = od.productCode WHERE od.productCode IS NULL;

-- records without matching relationship
SELECT c.customerNumber, c.customerName, c.salesRepEmployeeNumber FROM customers c
LEFT JOIN employees e ON c.salesRepEmployeeNumber = e.employeeNumber WHERE e.employeeNumber
 IS NULL;