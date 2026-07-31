# Mini Project 1
'''
2. Library Management System
-- Suggested Features:
-- Add/search/issue/return books
-- display available books
-- save records.
'''

from abc import ABC, abstractmethod

class Library(ABC):

    def __init__(self, title):
        self._title = title

    @abstractmethod
    def display(self):
        pass

class Book(Library):

    def __init__(self, b_id, title, author):
        super().__init__(title)
        self.__b_id = b_id
        self.__author = author
        self.__issued = False

    def display(self):
        status = "Issued" if self.__issued else "Not issued"
        print(self.__b_id, self._title, self.__author, status)

    def get_bid(self):
        return self.__b_id

    def get_author(self):
        return self.__author

    def get_title(self):
        return self._title

    def get_status(self):
        return self.__issued

    def issue(self):
        self.__issued = True

    def return_book(self):
        self.__issued = False

class LibItems:
    def __init__(self):
        self.books = []
    def add_book(self):
        try:
            b_id = int(input("Enter book id: "))
            title = input("Enter title of the book: ")
            author = input("Enter the author's name: ")
            b = Book(b_id, title, author)
            self.books.append(b)
            print("Book added successfully")

        except ValueError:
            print("Invalid book id")

    def display_book(self):
        if len(self.books) == 0:
            print("No books available")
        else:
            for b in self.books:
                b.display()

    def search_book(self):
        try:
            b_id = int(input("Search book id: "))
            for b in self.books:
                if b.get_bid() == b_id:
                    print("Book found:")
                    b.display()
                    return
            print("Book not found")

        except ValueError:
            print("Invalid book id")

    def issue_book(self):
        try:
            b_id = int(input("Enter book id to issue: "))
            for b in self.books:
                if b.get_bid() == b_id:

                    if b.get_status():
                        print("Book already issued")

                    else:
                        b.issue()
                        print("Book issued successfully")

                    return
            print("Book not found")
        except ValueError:
            print("Invalid book id")

    def return_book(self):
        try:
            b_id = int(input("Enter book ID to return: "))
            for b in self.books:
                if b.get_bid() == b_id:

                    b.return_book()
                    print("Book returned successfully")
                    return

            print("Book not found")

        except ValueError:
            print("Invalid book ID")

    def save_records(self):
        try:
            with open("books.txt", "w") as file:
                for b in self.books:
                    file.write(
                        f"{b.get_bid()},"
                        f"{b.get_title()},"
                        f"{b.get_author()},"
                        f"{b.get_status()}\n"
                    )

            print("Records saved successfully")

        except FileNotFoundError:

            print("File error")



lby = LibItems()

while True:
    print("\n1. Add Book")
    print("2. Display Books")
    print("3. Search Book")
    print("4. Issue Book")
    print("5. Return Book")
    print("6. Save Records")
    print("7. Exit")

    try:

        choice = int(input("Enter choice: "))
        if choice == 1:
            lby.add_book()

        elif choice == 2:
            lby.display_book()


        elif choice == 3:
            lby.search_book()

        elif choice == 4:
            lby.issue_book()

        elif choice == 5:
            lby.return_book()

        elif choice == 6:
            lby.save_records()

        elif choice == 7:
            print("Program ended.")
            break

        else:
            print("Invalid choice.")


    except ValueError:

        print("Enter a valid number.")