# SQL Database named Practice

This project is a basic **MySQL practice project** that demonstrates fundamental SQL concepts using a student and course database.

## 📌 Project Overview

The project creates a database named `Practise` and performs different SQL operations such as:

* Creating and deleting databases
* Creating tables
* Inserting records
* Viewing databases and tables
* Altering table structures
* Updating records
* Deleting records
* Using conditional logic
* Categorizing records using `CASE`

---

## 🗄️ Database Structure

### Database

```sql
CREATE DATABASE Practise;
USE Practise;
```

The `Practise` database is used to store student and course information.

### Tables

#### 1. `students`

| Column        | Data Type   | Description              |
| ------------- | ----------- | ------------------------ |
| StudentID     | INT         | Unique ID of the student |
| FirstName     | VARCHAR(30) | Student's first name     |
| LastName      | VARCHAR(30) | Student's last name      |
| Course        | VARCHAR(30) | Course abbreviation      |
| Marks / Score | INT         | Student's marks/score    |
| Email         | VARCHAR(50) | Student's email address  |

`StudentID` is defined as the **Primary Key**, which uniquely identifies each student.

#### 2. `courses`

| Column     | Data Type   | Description             |
| ---------- | ----------- | ----------------------- |
| CourseID   | INT         | Unique ID of the course |
| CourseName | VARCHAR(50) | Name of the course      |
| Duration   | INT         | Course duration         |

`CourseID` is the **Primary Key** of the `courses` table.

---

# 📚 SQL Concepts Used

## 1. Database Creation

The project first removes the database if it already exists and then creates a new database.

```sql
DROP DATABASE IF EXISTS Practise;
CREATE DATABASE Practise;
USE Practise;
```

### Concepts:

* `DROP DATABASE`
* `IF EXISTS`
* `CREATE DATABASE`
* `USE`

`IF EXISTS` prevents an error if the database does not already exist.

---

## 2. Displaying Databases

```sql
SHOW DATABASES;
```

The `SHOW DATABASES` command displays all databases available in the MySQL server.

---

## 3. Creating Tables

Tables are created using the `CREATE TABLE` statement.

```sql
CREATE TABLE students (
    StudentID INT PRIMARY KEY,
    FirstName VARCHAR(30),
    LastName VARCHAR(30),
    Course VARCHAR(30),
    Marks INT
);
```

### Concepts:

* `CREATE TABLE`
* Data types such as `INT` and `VARCHAR`
* `PRIMARY KEY`

A **Primary Key** uniquely identifies each row in a table.

---

## 4. Displaying Tables

```sql
SHOW TABLES;
```

This command displays all tables present in the currently selected database.

---

## 5. Inserting Records

The `INSERT INTO` statement is used to add records to a table.

```sql
INSERT INTO students VALUES
(101, 'Animesh', 'Kar', 'CSE', 95);
```

### Concept:

* `INSERT INTO`

Multiple records can also be inserted using a single `INSERT` statement.

---

## 6. Retrieving Data

```sql
SELECT * FROM students;
SELECT * FROM courses;
```

The `SELECT` statement retrieves data from a table.

`*` means **all columns**.

---

## 7. Altering Table Structure

The project modifies the `students` table using `ALTER TABLE`.

### Adding a Column

```sql
ALTER TABLE students ADD Email VARCHAR(50);
```

This adds an `Email` column to the table.

### Renaming a Column

```sql
ALTER TABLE students RENAME COLUMN Marks TO Score;
```

This changes the column name from `Marks` to `Score`.

### Checking Table Structure

```sql
DESCRIBE students;
```

`DESCRIBE` displays the structure of the table, including column names and data types.

---

## 8. Updating Records

The `UPDATE` statement modifies existing records.

```sql
UPDATE students
SET Score = 88
WHERE StudentID = 103;
```

The `WHERE` condition ensures that only the student with `StudentID = 103` is updated.

Email addresses are also updated using the same concept.

```sql
UPDATE students
SET Email = 'animesh@gmail.com'
WHERE StudentID = 101;
```

### Concepts:

* `UPDATE`
* `SET`
* `WHERE`

---

## 9. Deleting Records

The `DELETE` statement removes records from a table.

```sql
DELETE FROM students
WHERE StudentID = 102;
```

Only the record matching `StudentID = 102` is deleted.

### Important

Always use a suitable `WHERE` condition with `DELETE` when you want to remove specific records.

---

# 🔀 Conditional Logic

## 10. Using `IF()`

The project uses MySQL's `IF()` function to determine whether a student has passed or failed.

```sql
SELECT StudentID, FirstName, Score,
       IF(Score >= 35, 'Pass', 'Fail') AS Result
FROM students;
```

### Logic

* Score ≥ 35 → `Pass`
* Score < 35 → `Fail`

`AS Result` gives the calculated column the name `Result`.

---

# 🏷️ Using `CASE`

The `CASE` expression is used to categorize students based on their scores.

```sql
SELECT StudentID, FirstName, Score,
    CASE
        WHEN Score >= 90 THEN 'O'
        WHEN Score >= 75 THEN 'A'
        WHEN Score >= 65 THEN 'B'
        WHEN Score >= 55 THEN 'C'
        WHEN Score >= 35 THEN 'D'
        ELSE 'Fail'
    END AS Category
FROM students;
```

### Categories

| Score Range  | Category |
| ------------ | -------- |
| 90 and above | O        |
| 75–89        | A        |
| 65–74        | B        |
| 55–64        | C        |
| 35–54        | D        |
| Below 35     | Fail     |

The `CASE` expression checks the conditions from top to bottom and returns the result of the first matching condition.

---

# 🛠️ SQL Commands Covered

| SQL Concept         | Command           |
| ------------------- | ----------------- |
| Delete database     | `DROP DATABASE`   |
| Create database     | `CREATE DATABASE` |
| Select database     | `USE`             |
| Show databases      | `SHOW DATABASES`  |
| Create table        | `CREATE TABLE`    |
| Show tables         | `SHOW TABLES`     |
| Insert records      | `INSERT INTO`     |
| Retrieve data       | `SELECT`          |
| Modify table        | `ALTER TABLE`     |
| View structure      | `DESCRIBE`        |
| Update records      | `UPDATE`          |
| Delete records      | `DELETE`          |
| Conditional logic   | `IF()`            |
| Multiple conditions | `CASE`            |
| Filter records      | `WHERE`           |
| Rename column       | `RENAME COLUMN`   |

---

# 🎯 Learning Objectives

This project helps practice the fundamentals of **MySQL and SQL**, including:

1. Creating and managing databases.
2. Creating tables with appropriate data types.
3. Using primary keys.
4. Inserting and retrieving records.
5. Modifying ttable structures.
Updating and deleting records.
Applying conditions using WHERE.
Using IF() for simple conditional logic.
Using CASE for multiple-condition categorization.
Understanding basic CRUD operations.
💡 Key Concepts
CRUD Operations

The project demonstrates the basic CRUD operations:

Create → INSERT
Read → SELECT
Update → UPDATE
Delete → DELETE
DDL Commands

Commands that define or modify database structures:

CREATE
ALTER
DROP
DML Commands

Commands that manipulate data:

INSERT
UPDATE
DELETE
DQL
SELECT

📝 Conclusion
This project provides hands-on practice with fundamental MySQL concepts. It covers database creation, table management, data manipulation, conditional expressions, and record categorization, making it a useful beginner-level SQL practice project.
