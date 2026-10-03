# SQL Data Cleaning and Transformation using ClassicModels

## 📌 Project Overview

This project is a SQL practice exercise using the ClassicModels sample database.

The ClassicModels database was downloaded from the internet and imported into MySQL for practicing SQL queries on customer, product, sales representative, and payment data.

This project focuses on identifying and handling common **data quality issues** in the ClassicModels database using MySQL.

The goal is to clean, transform, standardize, and analyze data so that it becomes more consistent and easier to work with.

The project works with tables such as:

* `customers`
* `employees`
* `offices`
* `orders`
* `products`

---

# 🔎 Issues Identified

The following data quality issues were identified in the ClassicModels dataset:

1. Missing values
2. Unclean customer names
3. Unclean email addresses
4. Inconsistent phone number formats
5. Possible duplicate phone numbers
6. Missing shipping dates
7. Product scale stored as text
8. Invalid or inconsistent credit limits
9. Inconsistent country names

---

# 🛠️ How the Issues Were Handled

## 1. Missing Values

Some customer records contain missing values in fields such as `state` and `addressLine2`.

### Handling missing `state`

```sql
SELECT customerNumber,
       customerName,
       COALESCE(state, 'N/A') AS state
FROM customers;
```

`COALESCE()` replaces a `NULL` value with the specified replacement value.

In this case:

```text
NULL → N/A
```

### Finding missing `addressLine2`

```sql
SELECT customerNumber,
       customerName,
       addressLine2
FROM customers
WHERE addressLine2 IS NULL;
```

`IS NULL` is used to identify records where a value is missing.

---

# 2. Name Cleaning

Customer names can contain unnecessary leading or trailing spaces.

```sql
SELECT customerNumber,
       TRIM(customerName) AS cleaned_customerName
FROM customers;
```

### Combining First and Last Names

The contact's first and last names are combined into one full name.

```sql
SELECT customerNumber,
       TRIM(CONCAT(ContactFirstName, ' ', ContactLastName))
       AS contactFullName,
       phone
FROM customers;
```

### Concepts Used

* `TRIM()`
* `CONCAT()`
* Column aliases using `AS`

`TRIM()` removes unnecessary spaces, while `CONCAT()` combines multiple strings.

---

# 3. Email Cleaning

Employee names and email addresses are cleaned using string functions.

```sql
SELECT EmployeeNumber,
       TRIM(CONCAT(FirstName, ' ', LastName)) AS FullName,
       LOWER(TRIM(email)) AS cleaned_email
FROM employees;
```

### Cleaning Process

The email is:

1. Trimmed using `TRIM()`
2. Converted to lowercase using `LOWER()`

For example:

```text
"  JOHN@EXAMPLE.COM  "
          ↓
"john@example.com"
```

This makes email values more consistent.

---

# 4. Phone Number Cleaning

Phone numbers may contain characters such as:

```text
+1 212 555 1234
(212) 555-1234
```

These formats can make phone numbers difficult to compare.

The project removes all non-numeric characters:

```sql
SELECT officeCode,
       city,
       phone AS original_phone,
       REGEXP_REPLACE(phone, '[^0-9]', '')
       AS cleaned_phone_number
FROM offices;
```

### Concept Used

`REGEXP_REPLACE()` uses a regular expression to replace unwanted characters.

The pattern:

```text
[^0-9]
```

means any character that is **not a digit**.

Therefore, only numbers from `0` to `9` remain.

---

# 5. Duplicate Detection

Possible duplicate phone numbers are identified using `GROUP BY` and `HAVING`.

```sql
SELECT phone,
       COUNT(*) AS duplicate_count
FROM customers
GROUP BY phone
HAVING COUNT(*) > 1;
```

### How It Works

* `GROUP BY phone` groups customers with the same phone number.
* `COUNT(*)` counts the records in each group.
* `HAVING COUNT(*) > 1` displays only phone numbers appearing more than once.

This helps identify potential duplicate records.

> Duplicate detection does not automatically mean the records are duplicates. The records should be checked further before deleting anything.

---

# 6. Order Fulfillment Analysis

Some orders may not have a `shippedDate` because they have not been shipped yet.

```sql
SELECT orderNumber,
       orderDate,
       shippedDate,
       status,
       CASE
           WHEN shippedDate IS NULL THEN 'Not Shipped Yet'
           ELSE CAST(DATEDIFF(shippedDate, orderDate) AS CHAR)
       END AS fullfillment_days
FROM orders;
```

### Concepts Used

* `CASE`
* `IS NULL`
* `DATEDIFF()`
* `CAST()`

### Logic

If `shippedDate` is missing:

```text
Not Shipped Yet
```

Otherwise, the number of days between the order date and shipping date is calculated.

```sql
DATEDIFF(shippedDate, orderDate)
```

This provides a simple measure of order fulfillment time.

---

# 7. Product Scale Transformation

The `productScale` column contains values such as:

```text
1:18
1:24
1:32
```

The numeric scale factor is extracted from the text.

```sql
SELECT productCode,
       productName,
       productScale,
       CAST(
           SUBSTRING_INDEX(productScale, ':', -1)
           AS UNSIGNED
       ) AS ScaleFactor
FROM products;
```

### Concepts Used

* `SUBSTRING_INDEX()`
* `CAST()`
* `AS UNSIGNED`

For example:

```text
1:18
 ↓
18
```

The value after the last `:` is extracted and converted from text into an unsigned integer.

---

# 8. Data Inconsistency

The project checks for customers with invalid or unusual credit limits.

```sql
SELECT customerNumber,
       customerName,
       creditLimit
FROM customers
WHERE creditLimit <= 0;
```

This identifies records where the credit limit is zero or negative.

Such records can be reviewed as potential data quality issues.

---

# 9. Country Standardization

Different abbreviations can represent the same country.

For example:

```text
USA → United States
UK  → United Kingdom
```

The project standardizes these values using `CASE`.

```sql
SET SQL_SAFE_UPDATES = 0;

UPDATE customers
SET country =
    CASE
        WHEN country = 'USA' THEN 'United States'
        WHEN country = 'UK' THEN 'United Kingdom'
        ELSE country
    END
WHERE country IN ('USA', 'UK');
```

### Result

| Original | Standardized   |
| -------- | -------------- |
| USA      | United States  |
| UK       | United Kingdom |

The `WHERE` condition ensures that only the required country values are updated.

---

# 🧠 SQL Concepts Used

| SQL Concept         | Purpose                            |
| ------------------- | ---------------------------------- |
| `SELECT`            | Retrieve data                      |
| `WHERE`             | Filter records                     |
| `IS NULL`           | Find missing values                |
| `COALESCE()`        | Replace `NULL` values              |
| `TRIM()`            | Remove unnecessary spaces          |
| `CONCAT()`          | Combine strings                    |
| `LOWER()`           | Convert text to lowercase          |
| `REGEXP_REPLACE()`  | Remove unwanted characters         |
| `GROUP BY`          | Group similar records              |
| `COUNT()`           | Count records                      |
| `HAVING`            | Filter grouped results             |
| `CASE`              | Apply conditional logic            |
| `DATEDIFF()`        | Calculate difference between dates |
| `CAST()`            | Convert data types                 |
| `SUBSTRING_INDEX()` | Extract part of a string           |
| `UPDATE`            | Modify existing records            |
| `SET`               | Assign new values                  |
| `SQL_SAFE_UPDATES`  | Control safe update restrictions   |

---

# 📋 Issue → Solution Summary

| Issue                        | Solution                  | SQL Concepts                    |
| ---------------------------- | ------------------------- | ------------------------------- |
| Missing `state`              | Replace `NULL` with `N/A` | `COALESCE()`                    |
| Missing `addressLine2`       | Identify missing records  | `IS NULL`                       |
| Extra spaces in names        | Remove spaces             | `TRIM()`                        |
| Separate first/last names    | Combine names             | `CONCAT()`                      |
| Inconsistent emails          | Trim and lowercase        | `TRIM()`, `LOWER()`             |
| Inconsistent phone formats   | Keep only digits          | `REGEXP_REPLACE()`              |
| Duplicate phone numbers      | Identify repeated values  | `GROUP BY`, `COUNT()`, `HAVING` |
| Missing shipping dates       | Show shipping status      | `CASE`, `IS NULL`               |
| Calculate fulfillment time   | Find date difference      | `DATEDIFF()`                    |
| Product scale stored as text | Extract numeric value     | `SUBSTRING_INDEX()`, `CAST()`   |
| Invalid credit limits        | Find values ≤ 0           | `WHERE`                         |
| Inconsistent country names   | Standardize country names | `CASE`, `UPDATE`                |

---

# 🎯 Key Outcomes

After applying these queries:

* Missing values can be identified and handled.
* Customer and employee names can be cleaned.
* Email addresses can be standardized.
* Phone numbers can be converted into a consistent numeric format.
* Potential duplicate phone numbers can be detected.
* Orders can be analyzed based on shipping status and fulfillment time.
* Product scale information can be transformed from text into numeric values.
* Potentially invalid credit limits can be identified.
* Country names can be standardized for consistency.

---

## 📝 Conclusion

This project demonstrates how SQL can be used not only to retrieve data but also to perform basic **data cleaning, transformation, validation, and standardization**.

The queries use MySQL string functions, conditional expressions, aggregate functions, regular expressions, date functions, and data modification commands to improve the consistency and usability of the ClassicModels dataset.
