# Library Management System

## 📌 Project Overview

The **Library Management System** is a Python console-based application developed using **Object-Oriented Programming (OOP)** concepts. It enables users to add books, search for books, issue and return books, display available books, and save book records to a text file.

This project demonstrates the implementation of abstraction, encapsulation, exception handling, and file handling in Python.

---

## 🚀 Features

* Add new books
* Display all books
* Search books by Book ID
* Issue books
* Return issued books
* Save book records to a text file
* Handle invalid user input using exception handling

---

## 🛠 Technologies Used

* Python 3
* Object-Oriented Programming (OOP)
* Text File Handling

---

## 📂 Project Structure

```text
miniproj/
├── proj_courseregsys.py
├── proj_librarymanagsys.py            
└── README_librarymanagsys.md       
└── README_courseregsys.md                                   
```

---

## 📖 OOP Concepts Implemented

### 1. Abstraction

* `Library` is implemented as an abstract base class using the `abc` module.
* The abstract method `display()` is implemented by the `Book` class.

### 2. Inheritance

* `Book` inherits from the `Library` class.

### 3. Encapsulation

* Private attributes such as `__b_id`, `__author`, and `__issued` are accessed through getter methods.

### 4. Classes and Objects

The project contains the following classes:

* `Library`
* `Book`
* `LibItems`

### 5. Exception Handling

The program handles:

* Invalid Book ID input
* Invalid menu choice
* File handling errors

### 6. File Handling

Book records are stored in a text file named:

```text
books.txt
```
which will be opened when runned the project
---

## ▶️ How to Run

1. Ensure Python 3 is installed.
2. Download or clone the project.
3. Open a terminal in the project folder.
4. Run the program:

```bash
python proj_librarymanagsys.py
```

5. Choose an option from the menu:

   * Add Book
   * Display Books
   * Search Book
   * Issue Book
   * Return Book
   * Save Records
   * Exit

## 📄 Sample Output

```text
1. Add Book
2. Display Books
3. Search Book
4. Issue Book
5. Return Book
6. Save Records
7. Exit

Enter choice: 1
Enter book id: 101
Enter title of the book: Python Programming
Enter the author's name: Guido van Rossum
Book added successfully
```

## ScreenShort

<img width="661" height="494" alt="Screenshot 2026-07-30 100023" src="https://github.com/user-attachments/assets/58b8eeca-4c96-4f71-a423-c4c2617dea4c" />
<img width="694" height="430" alt="Screenshot 2026-07-30 100037" src="https://github.com/user-attachments/assets/3f1f1fad-4464-44b2-a2e4-f289353db4c7" />
<img width="629" height="428" alt="Screenshot 2026-07-30 100046" src="https://github.com/user-attachments/assets/2f5345f4-06f8-4d46-9d56-249e7eec12f9" />


## 📊 Output File

The program stores book information in **books.txt**.

Example:

```text
101,Python Programming,Guido van Rossum,False
102,Data Structures,Mark Allen Weiss,True
```

---

## 🎯 Learning Outcomes

This project demonstrates practical implementation of:

* Object-Oriented Programming (OOP)
* Abstract Classes
* Inheritance
* Encapsulation
* Exception Handling
* Text File Handling
* Menu-Driven Programming

---

## 👨‍💻 Author

**Animesh Kar**

