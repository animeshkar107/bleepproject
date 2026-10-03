-- creating database
DROP database if exists Practise; -- if present then delete
CREATE DATABASE Practise;
USE Practise;

-- showing database
SHOW databases;

-- creating tables 
CREATE TABLE students (
    StudentID INT PRIMARY KEY,
    FirstName VARCHAR(30),
    LastName VARCHAR(30),
    Course VARCHAR(30),
    Marks INT
);
CREATE TABLE courses (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(50),
    Duration INT
);
-- showing tables
SHOW TABLES;

-- inserting tables
INSERT INTO students VALUES
(101, 'Animesh', 'Kar', 'CSE', 95),
(102, 'Ayush', 'kar', 'CSE', 92),
(103, 'Anisha', 'Dash', 'CSE', 91),
(104, 'Ankit', 'Dash', 'BCA', 84),
(105, 'Aniket', 'Kumar', 'IT', 85);

INSERT INTO courses VALUES
(1, 'Computer Science', 4),
(2, 'Computer Applications', 4),
(3, 'Information Technology', 4);

-- showing the students and courses
SELECT * FROM courses;
SELECT * FROM students;

-- altering tables
ALTER TABLE students ADD Email VARCHAR(50);
DESCRIBE students;

ALTER TABLE students RENAME COLUMN Marks TO Score;
DESCRIBE students;

-- updating records
UPDATE students SET Score = 88 WHERE StudentID = 103;
UPDATE students SET email = 'animesh@gmail.com' WHERE StudentID = 101;
UPDATE students SET email = 'ayush@gmail.com' WHERE StudentID = 102;
UPDATE students SET email = 'anisha@gmail.com' WHERE StudentID = 103;
UPDATE students SET email = 'ankit@gmail.com' WHERE StudentID = 104;
UPDATE students SET email = 'aniket@gmail.com' WHERE StudentID = 105;
SELECT  * FROM students;

-- deleting records
DELETE FROM students WHERE StudentID = 102;
SELECT  * FROM students;

-- conditional logic
SELECT StudentID, FirstName, Score, IF(Score >= 35, 'Pass', 'Fail') AS Result FROM students;

-- case category
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