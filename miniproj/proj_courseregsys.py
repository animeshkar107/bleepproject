# Mini Project 1
'''
10. Course Registration System
-- Suggested Features:
-- Add students/courses
-- register/drop courses
-- display registrations
-- save data.
 '''

from abc import ABC, abstractmethod
import csv
class Person(ABC):
    def __init__(self, name, person_id):
        self.__name = name
        self.__person_id = person_id

    def get_name(self):
        return self.__name

    def get_id(self):
        return self.__person_id

    @abstractmethod
    def display_info(self):
        pass


class Student(Person):
    def __init__(self, name, student_id):
        super().__init__(name, student_id)
        self.__courses = []

    def register_course(self, course):
        self.__courses.append(course)

    def drop_course(self, course):
        if course in self.__courses:
            self.__courses.remove(course)
        else:
            raise Exception("Course not registered.")

    def get_courses(self):
        return self.__courses

    def display_info(self):
        print("Student:", self.get_name())
        print("ID:", self.get_id())
        print("Courses:", [c.get_course_name() for c in self.__courses])


class Course:
    def __init__(self, course_id, course_name):
        self.__course_id = course_id
        self.__course_name = course_name

    def get_course_name(self):
        return self.__course_name

    def get_course_id(self):
        return self.__course_id


class RegistrationSystem:
    def __init__(self):
        self.students = []
        self.courses = []

    def add_student(self, student):
        self.students.append(student)

    def add_course(self, course):
        self.courses.append(course)

    def find_student(self, student_id):
        for student in self.students:
            if student.get_id() == student_id:
                return student
        raise Exception("Student not found.")

    def find_course(self, course_id):
        for course in self.courses:
            if course.get_course_id() == course_id:
                return course
        raise Exception("Course not found.")

    def save_data(self):
        try:
            with open("registrations.csv", "a") as file:
                writer = csv.writer(file)

                if file.tell()==0:
                    writer.writerow(["Student ID", "Student Name", "Courses"])

                for student in self.students:
                    courses = [c.get_course_name() for c in student.get_courses()]
                    writer.writerow([
                        student.get_id(),
                        student.get_name(),
                        courses
                    ])

            print("Data saved successfully.")

        except IOError:
            print("File saving error.")


sys = RegistrationSystem()

try:
    cid=input("Enter course id: ")
    b=input("Enter course: ")
    c = Course(cid, b)

    sys.add_course(c)

    stu=input("Enter name of the student: ")
    sid=input("Enter student id: ")
    s = Student(stu,sid)
    sys.add_student(s)

    stu1=sys.find_student(sid)
    course1 = sys.find_course(cid)
    print("Before Dropping")
    stu1.register_course(course1)
    stu1.display_info()

    choice = input("Do you want to drop this course? (yes/no): ")

    if choice.lower() == "yes":
        stu1.drop_course(course1)
        print("Course dropped successfully.")
    stu1.display_info()

    sys.save_data()

except Exception as e:
    print("Error:", e)