# Advanced SQL-Window Functions using ClassicModels

## 📌 Project Overview

This project uses the **ClassicModels** database to practice advanced SQL concepts, especially **Window Functions** and **time-based analysis**.

The queries analyze product prices, product rankings, customer payment history, monthly payment trends, payment growth, and moving averages.

---

# 🎯 Analysis Performed

The project covers the following analyses:

1. Product ranking within each product line
2. Product ranking using `ROW_NUMBER()`
3. Customer payment running totals
4. Highest-priced product in each product line
5. Month-over-month payment analysis
6. Monthly payment growth
7. Three-month moving average of payments

---

# 🧠 SQL Concepts Used

## 1. Window Functions

Window functions perform calculations across related rows without combining those rows into a single result.

The main window functions used are:

* `RANK()`
* `ROW_NUMBER()`
* `DENSE_RANK()`
* `SUM() OVER()`
* `LAG()`
* `AVG() OVER()`

The `OVER()` clause defines how the window for the calculation is created.

---

# 🏆 2. Product Ranking Using `RANK()`

```sql id="5ux5ph"
SELECT productCode,
       productName,
       productLine,
       buyPrice,
       RANK() OVER (
           PARTITION BY productLine
           ORDER BY buyPrice DESC
       ) AS productRank
FROM products;
```

### Concept

`RANK()` assigns a ranking to products based on their `buyPrice`.

`PARTITION BY productLine` means that ranking starts separately for each product line.

`ORDER BY buyPrice DESC` places the highest-priced products first.

### Important

If two products have the same price, they receive the same rank, and the next rank is skipped.

Example:

```text
Price   Rank
100      1
100      1
90       3
```

---

# 🔢 3. Product Ranking Using `ROW_NUMBER()`

```sql id="4q6gqa"
SELECT productCode,
       productName,
       productLine,
       buyPrice,
       ROW_NUMBER() OVER (
           PARTITION BY productLine
           ORDER BY buyPrice DESC
       ) AS rowNumber
FROM products;
```

`ROW_NUMBER()` assigns a unique sequential number to every row.

Unlike `RANK()`, tied values do not receive the same number.

Example:

```text
Price   Row Number
100          1
100          2
90           3
```

---

# 💰 4. Running Total of Customer Payments

```sql id="4et3fc"
SELECT customerNumber,
       paymentDate,
       amount,
       SUM(amount) OVER (
           PARTITION BY customerNumber
           ORDER BY paymentDate
       ) AS runningTotal
FROM payments;
```

This calculates the cumulative payment amount for each customer over time.

### Concepts Used

* `SUM()`
* `OVER()`
* `PARTITION BY`
* `ORDER BY`

For example:

```text
Payment  Running Total
1000        1000
2000        3000
1500        4500
```

---

# 🥇 5. Highest-Ranked Product in Each Product Line

A subquery and `DENSE_RANK()` are used to find the highest-priced product in each product line.

```sql id="q0ujj1"
SELECT productCode,
       productName,
       productLine,
       buyPrice,
       productRank
FROM (
    SELECT productCode,
           productName,
           productLine,
           buyPrice,
           DENSE_RANK() OVER (
               PARTITION BY productLine
               ORDER BY buyPrice DESC
           ) AS productRank
    FROM products
) ranked_products
WHERE productRank = 1;
```

### Concepts Used

* `DENSE_RANK()`
* Subquery
* `PARTITION BY`
* `ORDER BY`
* `WHERE`

`DENSE_RANK()` gives the same rank to products with equal prices without skipping the next rank.

The outer query filters the result to:

```text
productRank = 1
```

Therefore, it returns the highest-priced product or products in each product line.

---

# 📅 6. Month-over-Month Payment Analysis

First, the payments are grouped by month using a Common Table Expression (CTE).

```sql id="l7d5r4"
WITH monthly_payments AS (
    SELECT DATE_FORMAT(paymentDate, '%Y-%m') AS paymentMonth,
           SUM(amount) AS totalPayment
    FROM payments
    GROUP BY DATE_FORMAT(paymentDate, '%Y-%m')
)
SELECT paymentMonth,
       totalPayment,
       LAG(totalPayment) OVER (
           ORDER BY paymentMonth
       ) AS previousMonthPayment
FROM monthly_payments
ORDER BY paymentMonth;
```

### Concepts Used

* `WITH`
* CTE
* `DATE_FORMAT()`
* `SUM()`
* `GROUP BY`
* `LAG()`

`LAG()` retrieves the value from the previous row.

This allows the current month's payment total to be compared with the previous month's total.

---

# 📈 7. Payment Growth Analysis

The difference between the current month's payment and the previous month's payment is calculated.

```sql id="4d5m9k"
WITH monthly_payments AS (
    SELECT DATE_FORMAT(paymentDate, '%Y-%m') AS paymentMonth,
           SUM(amount) AS totalPayment
    FROM payments
    GROUP BY DATE_FORMAT(paymentDate, '%Y-%m')
)
SELECT paymentMonth,
       totalPayment,
       totalPayment -
       LAG(totalPayment) OVER (
           ORDER BY paymentMonth
       ) AS paymentGrowth
FROM monthly_payments
ORDER BY paymentMonth;
```

### Formula

```text
Payment Growth =
Current Month Payment - Previous Month Payment
```

A positive value indicates an increase compared with the previous month, while a negative value indicates a decrease.

---

# 📊 8. Three-Month Moving Average

A three-month moving average is calculated using `AVG()` as a window function.

```sql id="x7f8k2"
WITH monthly_payments AS (
    SELECT DATE_FORMAT(paymentDate, '%Y-%m') AS paymentMonth,
           SUM(amount) AS totalPayment
    FROM payments
    GROUP BY DATE_FORMAT(paymentDate, '%Y-%m')
)
SELECT paymentMonth,
       totalPayment,
       AVG(totalPayment) OVER (
           ORDER BY paymentMonth
           ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
       ) AS threeMonthAvg
FROM monthly_payments
ORDER BY paymentMonth;
```

### Window Definition

```text
ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
```

means the calculation includes:

* Current month
* Previous month
* Two months before the current month

Therefore, it produces a **three-month moving average**.

---

# 🔑 Key Concepts Summary

| Concept         | Purpose                               |
| --------------- | ------------------------------------- |
| `RANK()`        | Rank rows while allowing ties         |
| `ROW_NUMBER()`  | Give each row a unique number         |
| `DENSE_RANK()`  | Rank rows without gaps after ties     |
| `SUM() OVER()`  | Calculate running totals              |
| `LAG()`         | Access the previous row's value       |
| `AVG() OVER()`  | Calculate moving averages             |
| `PARTITION BY`  | Create separate calculation groups    |
| `ORDER BY`      | Define the order within a window      |
| `WITH` / CTE    | Create a temporary named result set   |
| `DATE_FORMAT()` | Format dates by month                 |
| `GROUP BY`      | Aggregate data by month               |
| Subquery        | Use one query's result inside another |

---

# 🔍 Key Observations

### 1. Product prices can be ranked within individual product lines

Using `PARTITION BY productLine`, products are ranked separately for each product line rather than across the entire product table.

### 2. `RANK()` and `ROW_NUMBER()` handle ties differently

`RANK()` gives the same rank to tied values and can skip rank numbers, while `ROW_NUMBER()` always assigns a unique sequential number.

### 3. Running totals show cumulative customer payments

The `SUM() OVER()` function allows payment amounts to be accumulated chronologically for each customer.

### 4. Monthly payment trends can be compared over time

`LAG()` makes it possible to compare each month's payment total with the previous month and calculate the change.

### 5. Moving averages help smooth monthly payment fluctuations

The three-month moving average provides a broader view of payment trends by considering the current month and the two preceding months.

---

# 🎯 Learning Objectives

This project helps develop practical knowledge of:

* SQL Window Functions
* Ranking techniques
* Running totals
* Previous-row analysis
* Common Table Expressions
* Date-based aggregation
* Month-over-month analysis
* Growth calculations
* Moving averages
* Advanced data analysis using SQL

---

## 📝 Conclusion

This project demonstrates how **SQL Window Functions** can be used for advanced data analysis without losing individual row-level information.

The ClassicModels database is used to practice ranking, cumulative calculations, time-series comparisons, growth analysis, and moving averages, providing practical experience with intermediate-to-advanced SQL techniques.
