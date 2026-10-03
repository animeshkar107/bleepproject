# SQL using ClassicModels

## 📌 Project Overview

This is a SQL project using the **ClassicModels** sample database.

The **ClassicModels database was downloaded from the internet** and imported into MySQL for practicing SQL queries on customer, product, sales representative, and payment data.

The project focuses on retrieving, filtering, sorting, grouping, and analyzing data using SQL.

---

## 📊 Dataset Used

**Dataset:** ClassicModels Database

The ClassicModels database contains information related to:

* Customers
* Products
* Product Lines
* Payments
* Sales Representatives

The database was **downloaded from the internet** and imported into MySQL.

### Main Tables Used

| Table       | Description                                           |
| ----------- | ----------------------------------------------------- |
| `customers` | Customer information and sales representative details |
| `products`  | Product information, prices, and stock                |
| `payments`  | Customer payment records                              |

---

# ❓ Questions / Tasks Solved

## 👥 Customer Analysis

1. Display all customer records.
2. Display customer name, city, and country.
3. Find customers from the USA.
4. Find customers from the USA, France, and Germany.
5. Find customers with a credit limit greater than 100,000.
6. Sort customers by credit limit in descending order.
7. Retrieve records using `LIMIT` and `OFFSET`.
8. Search for customers whose names contain `"Gift"`.
9. Find customers who have an assigned sales representative.

---

## 💳 Customer Payments

10. Display customer payment details using a `JOIN`.
11. Find payments made after a specific date.
12. Find payments greater than 50,000.
13. Count the total number of payments.
14. Find customers who made more than 3 payments.
15. Calculate the total payment amount for each customer.
16. Calculate the average payment amount.
17. Find the minimum payment.
18. Find the maximum payment.

---

## 🚗 Product Analysis

19. Display product information.
20. Display product code, name, product line, buy price, and MSRP.
21. Find products belonging to the `Classic Cars` product line.
22. Find products from multiple product lines.
23. Count the number of products in each product line.
24. Find products with stock levels below 1,500.
25. Search for products containing `"Ford"` in their name.
26. Find products with an MSRP greater than 100.

---

# 🧠 SQL Concepts Used

## 1. SELECT

Used to retrieve data from tables.

```sql
SELECT customerName, city, country
FROM customers;
```

---

## 2. WHERE

Used to filter records based on a condition.

```sql
SELECT customerName, city, country
FROM customers
WHERE country = 'USA';
```

---

## 3. IN

Used to check whether a value matches any value in a given list.

```sql
SELECT customerName, country
FROM customers
WHERE country IN ('USA', 'France', 'Germany');
```

---

## 4. Comparison Operators

Operators such as `>`, `<`, and `=` are used to filter data.

```sql
SELECT customerName, creditLimit
FROM customers
WHERE creditLimit > 100000;
```

---

## 5. ORDER BY

Used to sort query results.

```sql
SELECT customerName, creditLimit
FROM customers
ORDER BY creditLimit DESC;
```

`DESC` sorts in descending order.

---

## 6. LIMIT and OFFSET

Used to control the number of records returned and skip a specified number of records.

```sql
SELECT customerName, creditLimit
FROM customers
ORDER BY creditLimit DESC
LIMIT 5 OFFSET 5;
```

* `LIMIT 5` → returns 5 records.
* `OFFSET 5` → skips the first 5 records.

---

## 7. LIKE

Used for pattern matching and searching text.

```sql
SELECT customerName
FROM customers
WHERE customerName LIKE '%Gift%'
LIMIT 10;
```

`%Gift%` means the word `Gift` can appear anywhere in the customer name.

---

## 8. IS NOT NULL

Used to find records where a column contains a value.

```sql
SELECT customerName, salesRepEmployeeNumber
FROM customers
WHERE salesRepEmployeeNumber IS NOT NULL;
```

This finds customers who have an assigned sales representative.

---

## 9. JOIN

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

Here, the `customers` and `payments` tables are joined using `customerNumber`.

---

## 10. GROUP BY

Used to group rows having the same value.

```sql
SELECT productLine, COUNT(*) AS productCount
FROM products
GROUP BY productLine;
```

This calculates the number of products in each product line.

---

## 11. Aggregate Functions

The project uses several aggregate functions.

### COUNT()

Counts the number of records.

```sql
SELECT COUNT(*) AS paymentCount
FROM payments;
```

### SUM()

Calculates the total value.

```sql
SELECT customerNumber, SUM(amount) AS totalPayment
FROM payments
GROUP BY customerNumber;
```

### AVG()

Calculates the average value.

```sql
SELECT AVG(amount) AS averagePayment
FROM payments;
```

### MIN()

Finds the minimum value.

```sql
SELECT MIN(amount) AS minimumPayment
FROM payments;
```

### MAX()

Finds the maximum value.

```sql
SELECT MAX(amount) AS maximumPayment
FROM payments;
```

---

## 12. HAVING

Used to filter grouped results.

```sql
SELECT customerNumber, COUNT(*) AS paymentCount
FROM payments
GROUP BY customerNumber
HAVING COUNT(*) > 3;
```

Unlike `WHERE`, which filters individual rows, `HAVING` filters groups created by `GROUP BY`.

---

## 13. Column Aliases

Aliases provide a temporary name to a column or calculated result.

```sql
SELECT COUNT(*) AS paymentCount
FROM payments;
```

Here, `paymentCount` is an alias for the calculated value.

---

# 🔍 Key Findings

The queries provide the following types of insights from the ClassicModels dataset:

* Customer information can be filtered by specific countries such as the USA, France, and Germany.
* Customers can be identified based on their credit limits.
* Customers can be sorted according to their credit limits.
* Customer names can be searched using pattern matching with `LIKE`.
* Customers with assigned sales representatives can be identified using `IS NOT NULL`.
* Customer payment information can be combined with customer details using `JOIN`.
* Products can be analyzed based on product lines, prices, and stock levels.
* The number of products in each product line can be calculated using `COUNT()` and `GROUP BY`.
* Low-stock products can be identified using a `WHERE` condition.
* Payment records can be filtered by payment date and payment amount.
* The total, average, minimum, and maximum payment amounts can be calculated using aggregate functions.
* Customers with more than three payment records can be identified using `GROUP BY` and `HAVING`.

---

# 🛠️ SQL Concepts Summary

| Concept       | Purpose                    |
| ------------- | -------------------------- |
| `SELECT`      | Retrieve data              |
| `WHERE`       | Filter records             |
| `IN`          | Match multiple values      |
| `LIKE`        | Search text patterns       |
| `IS NOT NULL` | Find non-empty values      |
| `ORDER BY`    | Sort results               |
| `LIMIT`       | Restrict number of results |
| `OFFSET`      | Skip records               |
| `JOIN`        | Combine related tables     |
| `GROUP BY`    | Group records              |
| `HAVING`      | Filter grouped records     |
| `COUNT()`     | Count records              |
| `SUM()`       | Calculate total            |
| `AVG()`       | Calculate average          |
| `MIN()`       | Find minimum               |
| `MAX()`       | Find maximum               |
| `AS`          | Create aliases             |

---

# 🎯 Learning Objectives

This project helps develop practical knowledge of:

* SQL data retrieval
* Filtering and searching
* Sorting data
* Pagination using `LIMIT` and `OFFSET`
* Pattern matching
* Handling `NULL` values
* Joining multiple tables
* Grouping data
* Aggregate functions
* Filtering grouped results
* Basic data analysis using SQL

---

## 📝 Conclusion

The ClassicModels project provides hands-on practice with fundamental and intermediate SQL concepts. By working with customer, product, and payment data, the project demonstrates how SQL can be used to retrieve, filter, organize, combine, and analyze relational database information.
