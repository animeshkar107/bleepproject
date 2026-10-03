# SQL Relational Analysis with JOINs  using ClassicModels

## 📌 Project Overview

This project analyzes relationships between different tables in the **ClassicModels** database using SQL `JOIN` operations.

The analysis connects customers, payments, employees, offices, orders, order details, and products to understand how the data is related.

---

## 🔗 SQL Concepts Used

The project mainly uses:

* `INNER JOIN`
* `LEFT JOIN`
* `GROUP BY`
* `ORDER BY`
* `WHERE`
* `IS NULL`
* Table aliases
* Self Join

### INNER JOIN

Used to retrieve records where matching data exists in both tables.

Example:

```sql
SELECT c.customerNumber,
       c.customerName,
       p.checkNumber,
       p.paymentDate,
       p.amount
FROM customers c
INNER JOIN payments p
ON c.customerNumber = p.customerNumber;
```

This connects customers with their payment records.

### LEFT JOIN

Used to keep all records from the left table, even when there is no matching record in the right table.

For example, it is used to identify customers without orders and products that have never been sold.

### Self Join

The `employees` table is joined with itself to identify employee-manager relationships.

```sql
SELECT e.firstName AS employeeFirstName,
       e.lastName AS employeeLastName,
       m.firstName AS managerFirstName,
       m.lastName AS managerLastName
FROM employees e
LEFT JOIN employees m
ON e.reportsTo = m.employeeNumber;
```

---

# 📊 Analysis Performed

The project analyzes:

1. Customer and payment relationships
2. Employee and office relationships
3. Orders and products
4. Number of employees in each office
5. Sales representatives assigned to customers
6. Employee-manager hierarchy
7. Customers without orders
8. Products that have never been sold
9. Customers with unmatched sales representative relationships

---

# 🔍 Key Observations

### 1. Customer–Payment Relationships

The customer and payment analysis shows that customer records can be connected to their payment history using `customerNumber`.

This makes it possible to view the customer name, payment date, check number, and payment amount together.

---

### 2. Employees Are Associated With Offices

Employees can be linked to their respective offices through `officeCode`.

This allows employee information to be analyzed together with office location, country, phone number, and address.

---

### 3. Products Can Be Connected to Individual Orders

The `orderdetails` and `products` tables can be joined using `productCode`.

This makes it possible to identify which products were included in an order along with their quantity ordered and price.

For example, order **10101** can be analyzed to see the products included in that particular order.

---

### 4. Offices Have Different Numbers of Employees

Using a `LEFT JOIN`, `GROUP BY`, and `COUNT()`, the number of employees associated with each office can be calculated.

The offices can then be sorted by employee count using `ORDER BY`.

This provides an overview of employee distribution across offices.

---

### 5. Missing Relationships Can Be Identified

`LEFT JOIN` combined with `IS NULL` helps identify records without matching relationships.

The analysis checks for:

* Customers who have never placed an order.
* Products that have never appeared in an order.
* Customers whose assigned sales representative does not have a matching employee record.

This demonstrates how SQL can be used to identify incomplete or missing relationships in a relational database.

---

# 🧠 Important SQL Concepts

| Concept       | Purpose                                 |
| ------------- | --------------------------------------- |
| `INNER JOIN`  | Find matching records between tables    |
| `LEFT JOIN`   | Keep all records from the left table    |
| `GROUP BY`    | Group records for analysis              |
| `COUNT()`     | Count related records                   |
| `ORDER BY`    | Sort query results                      |
| `WHERE`       | Filter records                          |
| `IS NULL`     | Find missing relationships              |
| Table Aliases | Make queries shorter and easier to read |
| Self Join     | Compare records within the same table   |

---

## 🎯 Conclusion

This project demonstrates how SQL `JOIN` operations can be used to analyze relationships across multiple tables. It also shows how `LEFT JOIN` and `IS NULL` can help identify missing relationships, while `GROUP BY` and aggregate functions can be used to summarize related data.
