-- University Database

-- Step 1: Create Database
CREATE DATABASE UniversityDB;
USE UniversityDB;

-- Step 2: Create Tables

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY AUTO_INCREMENT,
    DepartmentName VARCHAR(100) NOT NULL
);

CREATE TABLE Students (
    StudentID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    Age INT NOT NULL,
    DepartmentID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

CREATE TABLE Courses (
    CourseID INT PRIMARY KEY AUTO_INCREMENT,
    CourseName VARCHAR(100) NOT NULL,
    StudentID INT,
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID)
);

-- Step 3: Insert Sample Data

INSERT INTO Departments (DepartmentName) VALUES
('Computer Science'),
('Mechanical Engineering'),
('Electrical Engineering');

INSERT INTO Students (Name, Age, DepartmentID) VALUES
('Alice Johnson', 21, 1),
('Bob Smith', 22, 2),
('Charlie Brown', 20, 1),
('David White', 23, 3),
('Emma Watson', 21, 2);

INSERT INTO Courses (CourseName, StudentID) VALUES
('Database Management', 1),
('Operating Systems', 1),
('Thermodynamics', 2),
('Digital Circuits', 3),
('Artificial Intelligence', 1),
('Heat Transfer', 2),
('Power Systems', 4),
('Data Structures', 3),
('Fluid Mechanics', 5),
('Machine Learning', 1);

-- Step 4: Query-Based Questions

-- 1. Retrieve all student details along with their department names.
SELECT Students.StudentID, Students.Name, Students.Age, Departments.DepartmentName 
FROM Students 
JOIN Departments ON Students.DepartmentID = Departments.DepartmentID;

-- 2. Find the names of all students who are enrolled in 'Artificial Intelligence'.
SELECT Students.Name 
FROM Students 
JOIN Courses ON Students.StudentID = Courses.StudentID 
WHERE Courses.CourseName = 'Artificial Intelligence';

-- 3. Count how many students are in each department.
SELECT Departments.DepartmentName, COUNT(Students.StudentID) AS StudentCount 
FROM Departments 
LEFT JOIN Students ON Departments.DepartmentID = Students.DepartmentID 
GROUP BY Departments.DepartmentName;

-- 4. List the courses taken by 'Alice Johnson'.
SELECT Courses.CourseName 
FROM Courses 
JOIN Students ON Courses.StudentID = Students.StudentID 
WHERE Students.Name = 'Alice Johnson';

-- 5. Find students who are enrolled in more than one course.
SELECT Students.Name, COUNT(Courses.CourseID) AS CourseCount 
FROM Students 
JOIN Courses ON Students.StudentID = Courses.StudentID 
GROUP BY Students.StudentID 
HAVING CourseCount > 1;

-- 6. Get the average age of students in each department.
SELECT Departments.DepartmentName, AVG(Students.Age) AS AvgAge 
FROM Departments 
JOIN Students ON Departments.DepartmentID = Students.DepartmentID 
GROUP BY Departments.DepartmentName;

-- 7. Find the department with the most students.
SELECT Departments.DepartmentName 
FROM Departments 
JOIN Students ON Departments.DepartmentID = Students.DepartmentID 
GROUP BY Departments.DepartmentName 
ORDER BY COUNT(Students.StudentID) DESC 
LIMIT 1;

-- 8. List all students who are NOT enrolled in any course.
SELECT Students.Name 
FROM Students 
LEFT JOIN Courses ON Students.StudentID = Courses.StudentID 
WHERE Courses.StudentID IS NULL;

-- 9. Retrieve students along with the total number of courses they are enrolled in.
SELECT Students.Name, COUNT(Courses.CourseID) AS TotalCourses 
FROM Students 
LEFT JOIN Courses ON Students.StudentID = Courses.StudentID 
GROUP BY Students.StudentID;

-- 10. Find students who belong to 'Computer Science' and are taking a course with 'Data' in its name.
SELECT Students.Name 
FROM Students 
JOIN Departments ON Students.DepartmentID = Departments.DepartmentID 
JOIN Courses ON Students.StudentID = Courses.StudentID 
WHERE Departments.DepartmentName = 'Computer Science' 
AND Courses.CourseName LIKE '%Data%';
