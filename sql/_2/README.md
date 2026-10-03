# SQL using ClassicModels Database

This project contains SQL practice queries performed on the **ClassicModels** sample database.

The **ClassicModels database was downloaded from the internet** and used for practicing SQL queries on customers, products, payments, filtering, sorting, grouping, aggregate functions, and joins.

---

## 📌 Project Overview

The project focuses on analyzing data from the ClassicModels database using MySQL.

The queries cover:

* Customer information
* Customer locations
* Credit limits
* Customer searches
* Sales representatives
* Customer payments
* Product information
* Product lines
* Stock levels
* Product searches
* Payment dates
* Payment analysis
* Aggregate functions
* Grouping and filtering grouped data
* Table joins

---

## 🗄️ Database Used

### ClassicModels

The **ClassicModels sample database was downloaded from the internet** and imported into MySQL for practice.

The main tables used in this project are:

* `customers`
* `payments`
* `products`

```sql
USE classicmodels;
```

---

# 📚 SQL Concepts Used

## 1. Selecting Data

The `SELECT` statement is used to retrieve data from tables.

```sql
SELECT * FROM customers;
```

`*` retrieves all columns from the table.

Specific columns can also be selected:

```sql
SELECT customerName, city, country
FROM customers;
```

---

# 🌍 2. Filtering Data Using `WHERE`

The `WHERE` clause is used to filter records based on a condition.

### Customers from the USA

```sql
SELECT customerName, city, country
FROM customers
WHERE country = 'USA';
```

This returns only customers whose country is USA.

---

# 🔢 3. Using `IN`

The `IN` operator is used when checking multiple possible values.

```sql
SELECT customerName, country
FROM customers
WHERE country IN ('USA', 'France', 'Germany');
```

Instead of writing multiple `OR` conditions, `IN` allows several values to be checked together.

---

# 💰 4. Filtering Credit Limits

```sql
SELECT customerName, creditLimit
FROM customers
WHERE creditLimit > 100000;
```

The comparison operator `>` is used to find customers with a credit limit greater than 100,000.

---

# 📊 5. Sorting Data Using `ORDER BY`

The `ORDER BY` clause sorts query results.

```sql
SELECT customerName, creditLimit
FROM customers
ORDER BY creditLimit DESC;
```

### Sorting options:

* `ASC` → Ascending order
* `DESC` → Descending order

Here, customers are sorted from the highest credit limit to the lowest.

---

# 🔢 6. Using `LIMIT` and `OFFSET`

`LIMIT` restricts the number of rows returned.

```sql
SELECT customerName, creditLimit
FROM customers
ORDER BY creditLimit DESC
LIMIT 5;
```

`OFFSET` skips a specified number of rows.

```sql
SELECT customerName, creditLimit
FROM customers
ORDER BY creditLimit DESC
LIMIT 5 OFFSET 5;
```

This skips the first 5 rows and returns the next 5 rows.

---

# 🔎 7. Searching Using `LIKE`

The `LIKE` operator is used for pattern matching.

```sql
SELECT customerName
FROM customers
WHERE customerName LIKE '%Gift%'
LIMIT 10;
```

### Wildcard `%`

`%` represents zero or more characters.

For example:

```text
%Gift%
```

means the word `Gift` can appear anywhere in the customer name.

---

# 👤 8. Checking `NULL` Values

The `IS NOT NULL` condition is used to find records where a value exists.

```sql
SELECT customerName, salesRepEmployeeNumber
FROM customers
WHERE salesRepEmployeeNumber IS NOT NULL;
```

This returns customers who have an assigned sales representative.

---

# 🔗 9. Using `JOIN`

A `JOIN` combines related data from multiple tables.

```sql
SELECT c.customerNumber,
       c.customerName,
       p.paymentDate,
       p.amount
FROM customers c
JOIN payments p
ON c.customerNumber = p.customerNumber;
```

### Concepts used:

* `JOIN`
* Table aliases
* `ON`
* Matching columns between tables

Here:

```text
customers.customerNumber
        ↓
payments.customerNumber
```

is used to connect customers with their payment information.

### Table Aliases

```sql
customers c
payments p
```

Here:

* `c` represents `customers`
* `p` represents `payments`

Aliases make queries shorter and easier to read.

---

# 🚗 10. Product Information

The `products` table contains information about products.

```sql
SELECT *
FROM products;
```

Specific product information can be retrieved using:

```sql
SELECT productCode,
       productName,
       productLine,
       buyPrice,
       MSRP
FROM products
LIMIT 10;
```

---

# 🚘 11. Filtering Product Lines

A single product line can be filtered using `WHERE`.

```sql
SELECT productName, productLine
FROM products
WHERE productLine = 'Classic Cars';
```

Multiple product lines can be selected using `IN`.

```sql
SELECT productName, productLine
FROM products
WHERE productLine IN ('Planes', 'Classic Cars');
```

---

# 📦 12. `GROUP BY` and `COUNT()`

The `GROUP BY` clause groups records based on a column.

```sql
SELECT productLine,
       COUNT(*) AS productCount
FROM products
GROUP BY productLine;
```

### Concepts:

* `GROUP BY`
* `COUNT()`
* `AS`

This calculates the number of products available in each product line.

---

# 📉 13. Filtering Stock Levels

```sql
SELECT productName, quantityInStock
FROM products
WHERE quantityInStock < 1500;
```

The `<` operator is used to find products with stock below 1500 units.

---

# 🔍 14. Product Search Using `LIKE`

```sql
SELECT productName, productLine
FROM products
WHERE productName LIKE '%Ford%'
LIMIT 20;
```

This searches for product names containing `Ford`.

---

# 💵 15. Filtering Product Prices

```sql
SELECT productName, MSRP
FROM products
WHERE MSRP > 100;
```

This returns products whose MSRP is greater than 100.

---

# 📅 16. Working with Dates

Payment information can be filtered using dates.

```sql
SELECT customerNumber, paymentDate, amount
FROM payments
WHERE paymentDate > '2004-12-15';
```

This returns payments made after December 15, 2004.

Dates are written in:

```text
YYYY-MM-DD
```

format.

---

# 💳 17. Filtering Payment Amounts

```sql
SELECT customerNumber, paymentDate, amount
FROM payments
WHERE amount > 50000;
```

This retrieves payments greater than 50,000.

---

# 🔢 18. Counting Records

The `COUNT()` aggregate function counts records.

```sql
SELECT COUNT(*) AS paymentCount
FROM payments;
```

This calculates the total number of payment records.

---

# 👥 19. Grouping Customer Payments

```sql
SELECT customerNumber,
       COUNT(*) AS paymentCount
FROM payments
GROUP BY customerNumber;
```

This calculates the number of payments made by each customer.

---

# 🎯 20. Using `HAVING`

`HAVING` is used to filter grouped results.

```sql
SELECT customerNumber,
       COUNT(*) AS paymentCount
FROM payments
GROUP BY customerNumber
HAVING COUNT(*) > 3
LIMIT 7;
```

### Difference between `WHERE` and `HAVING`

| `WHERE`                              | `HAVING`                               |
| ------------------------------------ | -------------------------------------- |
| Filters individual rows              | Filters groups                         |
| Used before `GROUP BY`               | Used after `GROUP BY`                  |
| Commonly used with normal conditions | Commonly used with aggregate functions |

---

# 💰 21. Calculating Total Payments

The `SUM()` function calculates the total value.

```sql
SELECT customerNumber,
       SUM(amount) AS totalPayment
FROM payments
GROUP BY customerNumber
ORDER BY totalPayment ASC;
```

This calculates the total payment amount for each customer and sorts the results in ascending order.

---

# 📊 22. Calculating Average Payment

The `AVG()` function calculates the average value.

```sql
SELECT AVG(amount) AS averagePayment
FROM payments;
```

This calculates the average payment amount across all payment records.

---

# ⬇️ 23. Minimum Payment

The `MIN()` function returns the smallest value.

```sql
SELECT MIN(amount) AS minimumPayment
FROM payments;
```

---

# ⬆️ 24. Maximum Payment

The `MAX()` function returns the largest value.

```sql
SELECT MAX(amount) AS maximumPayment
FROM payments;
```

---

# 🧮 Aggregate Functions Used

This project demonstrates several important SQL aggregate functions:

| Function  | Purpose             |
| --------- | ------------------- |
| `COUNT()` | Counts records      |
| `SUM()`   | Calculates total    |
| `AVG()`   | Calculates average  |
| `MIN()`   | Finds minimum value |
| `MAX()`   | Finds maximum value |

---

# 🛠️ SQL Concepts Covered

| Concept              | SQL           |
| -------------------- | ------------- |
| Select data          | `SELECT`      |
| Filter records       | `WHERE`       |
| Multiple values      | `IN`          |
| Pattern matching     | `LIKE`        |
| Handle NULL          | `IS NOT NULL` |
| Sort results         | `ORDER BY`    |
| Limit results        | `LIMIT`       |
| Skip rows            | `OFFSET`      |
| Combine tables       | `JOIN`        |
| Group records        | `GROUP BY`    |
| Filter groups        | `HAVING`      |
| Count records        | `COUNT()`     |
| Calculate total      | `SUM()`       |
| Calculate average    | `AVG()`       |
| Find minimum         | `MIN()`       |
| Find maximum         | `MAX()`       |
| Rename output column | `AS`          |
| Table aliases        | `c`, `p`      |

---

# 📖 Key SQL Concepts

## Filtering

Filtering is performed using conditions such as:

```sql
WHERE country = 'USA'
```

```sql
WHERE creditLimit > 100000
```

```sql
WHERE amount > 50000
```

---

## Sorting

```sql
ORDER BY creditLimit DESC;
```

Used to arrange query results in ascending or descending order.

---

## Grouping

```sql
GROUP BY customerNumber;
```

Used to create groups of rows with the same value.

---

## Aggregation

Aggregate functions perform calculations on multiple rows.

```sql
COUNT()
SUM()
AVG()
MIN()
MAX()
```

---

## Joining Tables

The `JOIN` operation combines related records from different tables.

```sql
FROM customers c
JOIN payments p
ON c.customerNumber = p.customerNumber;
```

---

# 🎯 Learning Objectives

This project provides practice with:

1. Retrieving data from existing databases.
2. Filtering records using `WHERE`.
3. Searching using `LIKE`.
4. Filtering multiple values using `IN`.
5. Sorting data using `ORDER BY`.
6. Limiting and skipping results using `LIMIT` and `OFFSET`.
7. Handling `NULL` values.
8. Joining tables using `JOIN`.
9. Grouping data using `GROUP BY`.
10. Filtering grouped data using `HAVING`.
11. Performing calculations using aggregate functions.
12. Working with dates and numerical conditions.

---

# 📝 Conclusion

The ClassicModels project provides practical experience with commonly used MySQL commands and concepts. By working with customer, product, and payment data, it demonstrates how SQL can be used to **retrieve, filter, search, sort, group, join, and analyze data**.

The ClassicModels database was **downloaded from the internet and used as a sample dataset for SQL learning and practice**.
