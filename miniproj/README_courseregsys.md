# Course Registration System

## 📌 Project Overview

The **Course Registration System** is a Python console application developed using **Object-Oriented Programming (OOP)** concepts. It allows users to create students and courses, register students in courses, drop registered courses, display student registration details, and save the registration information into a CSV file.

This project demonstrates the use of abstraction, encapsulation, inheritance, exception handling, and file handling in Python.

---

## 🚀 Features

* Add new students
* Add new courses
* Register a student for a course
* Drop a registered course
* Display student information and registered courses
* Save registration details to a CSV file
* Handle invalid operations using exception handling

---

## 🛠 Technologies Used

* Python 3
* CSV Module
* ABC (Abstract Base Class)

---

## 📂 Project Structure

```
miniproj/
│
├── course_registration.py             
└── README_courseregsys.md                   
```

---

## 📖 OOP Concepts Implemented

### 1. Abstraction

* `Person` is implemented as an abstract base class using the `abc` module.
* The abstract method `display_info()` must be implemented by derived classes.

### 2. Inheritance

* `Student` inherits from the `Person` class.

### 3. Encapsulation

* Private attributes (`__name`, `__person_id`, `__courses`, etc.) are accessed through getter methods.

### 4. Classes and Objects

The project contains the following classes:

* `Person`
* `Student`
* `Course`
* `RegistrationSystem`

### 5. Exception Handling

The program handles errors such as:

* Student not found
* Course not found
* Dropping a course that is not registered
* File saving errors

### 6. File Handling

Registration details are stored in a CSV file named:

```
registrations.csv
```

---

## ▶️ How to Run

1. Make sure Python 3 is installed.
2. Download or clone the project.
3. Open a terminal in the project folder.
4. Run the program:

```bash
python course_registration.py
```

5. Enter the required details:

   * Course ID
   * Course Name
   * Student Name
   * Student ID
6. Choose whether to drop the registered course.
7. The registration data will be saved automatically in `registrations.csv`.

---

## 📄 Sample Output

```
Enter course id: CS101
Enter course: Python Programming
Enter name of the student: Animesh
Enter student id: S001

Before Dropping
Student: Animesh
ID: S001
Courses: ['Python Programming']

Do you want to drop this course? (yes/no): no

Student: Animesh
ID: S001
Courses: ['Python Programming']

Data saved successfully.
```

 ## ScreenShort

 <img width="689" height="368" alt="Screenshot 2026-07-30 105014" src="https://github.com/user-attachments/assets/424703db-f80a-402f-b482-895472cf3cbb" />
<img width="763" height="199" alt="Screenshot 2026-07-30 105023" src="https://github.com/user-attachments/assets/aecb9b2c-40d9-465c-b3d3-dee50ccf4688" />


## 📊 Output File

The program creates or updates a CSV file containing registration records.

Example:

| Student ID | Student Name | Courses                |
| ---------- | ------------ | ---------------------- |
| S001       | Animesh      | ['Python Programming'] |

---

## 🎯 Learning Outcomes

This project demonstrates practical implementation of:

* Object-Oriented Programming (OOP)
* Abstract Classes
* Inheritance
* Encapsulation
* Exception Handling
* CSV File Handling
* Python Collections (Lists)

---

## 👨‍💻 Author

**Animesh Kar**
