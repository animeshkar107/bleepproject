# SQL Data Cleaning and Transformation using ClassicModels

This project demonstrates **data cleaning, transformation, validation, duplicate detection, and standardization** using SQL.

The **ClassicModels sample database was downloaded from the internet** and used as the dataset for practicing SQL data-cleaning techniques.

---

## 📌 Project Overview

Real-world datasets often contain missing values, inconsistent formats, duplicate records, unnecessary spaces, and values that need to be transformed before analysis.

This project uses SQL to perform common data-cleaning operations on the ClassicModels database.

### Main concepts covered:

* Handling missing values
* Replacing `NULL` values
* Removing unnecessary spaces
* Combining columns
* Converting text to lowercase
* Cleaning phone numbers
* Detecting duplicates
* Calculating fulfillment time
* Extracting values from strings
* Type conversion
* Detecting inconsistent data
* Standardizing values
* Updating records

---

# 🗄️ Database Used

```sql
USE classicmodels;
```

The **ClassicModels database was downloaded from the internet** and imported into SQL for learning and practice.

The project works with tables such as:

* `customers`
* `employees`
* `offices`
* `orders`
* `products`

---

# 📚 SQL Concepts Used

## 1. Handling Missing Values with `COALESCE()`

```sql
SELECT customerNumber,
       customerName,
       COALESCE(state, 'N/A') AS state
FROM customers;
```

`COALESCE()` returns the first non-NULL value.

In this example:

* If `state` contains a value → that value is returned.
* If `state` is `NULL` → `'N/A'` is returned.

### Example

| state      | Result     |
| ---------- | ---------- |
| California | California |
| NULL       | N/A        |

---

# 2. Finding `NULL` Values

The `IS NULL` operator is used to find missing values.

```sql
SELECT customerNumber,
       customerName,
       addressLine2
FROM customers
WHERE addressLine2 IS NULL;
```

This returns customers whose `addressLine2` is missing.

### Important

For NULL values, use:

```sql
IS NULL
```

or

```sql
IS NOT NULL
```

rather than:

```sql
= NULL
```

---

# ✂️ 3. Removing Extra Spaces Using `TRIM()`

```sql
SELECT customerNumber,
       TRIM(customerName) AS cleaned_customerName
FROM customers;
```

`TRIM()` removes unnecessary spaces from the beginning and end of a string.

This is useful when cleaning text data.

---

# 👤 4. Combining First and Last Names

The `CONCAT()` function combines multiple strings.

```sql
SELECT customerNumber,
       TRIM(CONCAT(ContactFirstName, ' ', ContactLastName))
       AS contactFullName,
       phone
FROM customers;
```

### Functions used:

* `CONCAT()` → combines values
* `TRIM()` → removes unnecessary spaces

For example:

```text
Animesh + " " + Kar
        ↓
Animesh Kar
```

---

# 📧 5. Cleaning Email Addresses

```sql
SELECT EmployeeNumber,
       TRIM(CONCAT(FirstName, ' ', LastName)) AS FullName,
       LOWER(TRIM(email)) AS cleaned_email
FROM employees;
```

Multiple cleaning functions are combined here.

### `TRIM()`

Removes unnecessary spaces.

### `LOWER()`

Converts text to lowercase.

### `CONCAT()`

Combines first name and last name.

For example:

```text
" ANIMESH.KAR@GMAIL.COM "
          ↓
"animesh.kar@gmail.com"
```

This helps maintain a consistent email format.

---

# 📱 6. Cleaning Phone Numbers

```sql
SELECT officeCode,
       city,
       phone AS original_phone,
       REGEXP_REPLACE(phone, '[^0-9]', '') AS cleaned_phone_number
FROM offices;
```

`REGEXP_REPLACE()` is used to remove unwanted characters from phone numbers.

### Regular Expression

```text
[^0-9]
```

means any character that is **not a digit from 0 to 9**.

Therefore, characters such as:

```text
+
-
(
)
space
```

can be removed.

### Example

```text
+1 (555) 123-4567
        ↓
15551234567
```

---

# 🔎 7. Detecting Duplicate Values

```sql
SELECT phone,
       COUNT(*) AS duplicate_count
FROM customers
GROUP BY phone
HAVING COUNT(*) > 1;
```

This query identifies phone numbers that appear more than once.

### Concepts used:

* `GROUP BY`
* `COUNT()`
* `HAVING`

### How it works

1. Records are grouped by phone number.
2. `COUNT(*)` counts records in each group.
3. `HAVING COUNT(*) > 1` keeps only repeated phone numbers.

This is a common technique for **duplicate detection**.

---

# 📦 8. Order Fulfillment Analysis

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

This query calculates how many days it took to ship an order.

---

## `DATEDIFF()`

```sql
DATEDIFF(shippedDate, orderDate)
```

calculates the difference between two dates.

For example:

```text
Order Date   → 2024-01-01
Shipped Date → 2024-01-05

Difference   → 4 days
```

---

## `CASE`

The `CASE` expression handles orders that have not been shipped.

```sql
WHEN shippedDate IS NULL
THEN 'Not Shipped Yet'
```

If the shipping date is missing, the query displays:

```text
Not Shipped Yet
```

Otherwise, it displays the number of fulfillment days.

---

## `CAST()`

```sql
CAST(DATEDIFF(shippedDate, orderDate) AS CHAR)
```

converts the numeric result of `DATEDIFF()` into text so it can be returned alongside the text value `'Not Shipped Yet'`.

---

# 🏷️ 9. Product Scale Transformation

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

This query extracts the numeric portion from the `productScale` column.

### `SUBSTRING_INDEX()`

```sql
SUBSTRING_INDEX(productScale, ':', -1)
```

extracts the part after the last `:`.

For example:

```text
1:18
 ↓
18
```

---

## `CAST()`

```sql
CAST(... AS UNSIGNED)
```

converts the extracted text into an unsigned integer.

So:

```text
'18'
```

becomes:

```text
18
```

This makes the value easier to use in numerical calculations.

---

# ⚠️ 10. Detecting Data Inconsistency

```sql
SELECT customerNumber,
       customerName,
       creditLimit
FROM customers
WHERE creditLimit <= 0;
```

This query identifies customers whose credit limit is zero or negative.

Such values can be investigated as potential **data-quality issues or inconsistencies**.

The query does not automatically mean that every returned value is incorrect; it identifies records that may require further checking.

---

# 🔄 11. Standardizing Data

Before updating the country values:

```sql
SET SQL_SAFE_UPDATES = 0;
```

This disables MySQL's safe-update restriction for the session.

The country values are then standardized:

```sql
UPDATE customers
SET country =
    CASE
        WHEN country = 'USA' THEN 'United States'
        WHEN country = 'UK' THEN 'United Kingdom'
        ELSE country
    END
WHERE country IN ('USA', 'UK');
```

### Transformation

```text
USA
 ↓
United States
```

and

```text
UK
 ↓
United Kingdom
```

Other country values remain unchanged because of:

```sql
ELSE country
```

---

# 🔐 12. `SQL_SAFE_UPDATES`

```sql
SET SQL_SAFE_UPDATES = 0;
```

MySQL's safe-update mode can prevent certain `UPDATE` or `DELETE` operations that do not use an appropriate key-based condition.

After disabling it, the update is performed with a `WHERE` condition:

```sql
WHERE country IN ('USA', 'UK');
```

This limits the update to the intended records.

---

# 📊 13. Verifying the Updated Data

```sql
SELECT country, customerName
FROM customers;
```

After standardization, this query can be used to verify the country values.

---

# 🧮 SQL Functions Used

| Function            | Purpose                                   |
| ------------------- | ----------------------------------------- |
| `COALESCE()`        | Replaces `NULL` with an alternative value |
| `TRIM()`            | Removes extra spaces                      |
| `CONCAT()`          | Combines strings                          |
| `LOWER()`           | Converts text to lowercase                |
| `REGEXP_REPLACE()`  | Replaces text using a regular expression  |
| `COUNT()`           | Counts records                            |
| `DATEDIFF()`        | Calculates difference between dates       |
| `CAST()`            | Converts a value to another data type     |
| `SUBSTRING_INDEX()` | Extracts part of a string                 |
| `CASE`              | Performs conditional logic                |

---

# 🛠️ SQL Concepts Covered

| Concept                | Example                  |
| ---------------------- | ------------------------ |
| Missing values         | `COALESCE()`             |
| NULL checking          | `IS NULL`                |
| Text cleaning          | `TRIM()`                 |
| String concatenation   | `CONCAT()`               |
| Text standardization   | `LOWER()`                |
| Pattern-based cleaning | `REGEXP_REPLACE()`       |
| Duplicate detection    | `GROUP BY + HAVING`      |
| Conditional logic      | `CASE`                   |
| Date calculation       | `DATEDIFF()`             |
| Data type conversion   | `CAST()`                 |
| String extraction      | `SUBSTRING_INDEX()`      |
| Data validation        | `WHERE creditLimit <= 0` |
| Data standardization   | `UPDATE + CASE`          |
| Safe update control    | `SQL_SAFE_UPDATES`       |

---

# 🎯 Learning Objectives

This project helps practice how SQL can be used for real-world data preparation.

The main objectives are:

1. Identify and handle missing values.
2. Replace `NULL` values with meaningful alternatives.
3. Remove unnecessary spaces from text.
4. Combine multiple columns into one value.
5. Standardize email formats.
6. Clean phone numbers using regular expressions.
7. Detect duplicate records.
8. Calculate date differences.
9. Transform string-based data into numeric values.
10. Identify potentially inconsistent data.
11. Standardize different representations of the same value.
12. Update existing records using conditional logic.

---

# 🔄 Data Cleaning Workflow

The project follows a basic data-cleaning workflow:

```text
Raw Data
   ↓
Identify Missing Values
   ↓
Handle NULL Values
   ↓
Clean Text
   ↓
Clean Emails and Phone Numbers
   ↓
Detect Duplicates
   ↓
Transform Data
   ↓
Identify Inconsistencies
   ↓
Standardize Values
   ↓
Verify Cleaned Data
```

---

# 📝 Conclusion

This project demonstrates practical **SQL data-cleaning and transformation techniques** using the ClassicModels sample database.

It shows how SQL can be used not only to retrieve data but also to **clean, validate, transform, standardize, and prepare data for further analysis**.

The **ClassicModels database was downloaded from the internet** and used as a sample dataset for learning and practicing these SQL data-cleaning concepts.
