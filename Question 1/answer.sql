-- Creating a Department Table

CREATE TABLE Department (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL,
    department_code VARCHAR(10) NOT NULL UNIQUE,
    head_of_department VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Creating Student Information Table

CREATE TABLE Student (
    student_id VARCHAR(100) PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone_number VARCHAR(20),
    gender ENUM('Male', 'Female', 'Other'),
    adm_date DATE NOT NULL,
    graduate_date DATE,
    department_id INT,
    current_semester_id INT
    enrolled_status ENUM('Active', 'Inactive', 'Graduated', 'Suspended') DEFAULT 'Active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (current_semester_id) REFERENCES Semester(semester_id),
    FOREIGN KEY (department_id) REFERENCES Department(department_id)
);

-- Creating  a Course Table

CREATE TABLE Course (
    course_id INT PRIMARY KEY,
    course_code VARCHAR(20) NOT NULL UNIQUE,
    name VARCHAR(100) NOT NULL,
    department_id INT,
    credits INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (department_id) REFERENCES Department(department_id)
);

-- Creating Instructors Table

CREATE TABLE Instructor (
    instructor_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone_number VARCHAR(20),
    department_id INT,
    hire_date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (department_id) REFERENCES Department(department_id)
);

-- Creating Semester Table

CREATE TABLE Semester (
    semester_id INT PRIMARY KEY AUTO_INCREMENT,
    semester_name VARCHAR(50) NOT NULL,  
    semester_code VARCHAR(20) NOT NULL UNIQUE,  
    academic_year VARCHAR(9) NOT NULL,  
    semester_type ENUM('One', 'Two', 'Three') NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    registration_start DATE,
    registration_end DATE,
    is_current BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Creating Fees Table

CREATE TABLE Fees (
    fee_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id VARCHAR(100),
    semester_id INT
    total_amount DECIMAL(10,2) NOT NULL,
    paid_amount DECIMAL(10,2) DEFAULT 0.00,
    due_amount DECIMAL(10,2) GENERATED ALWAYS AS (total_amount - paid_amount) STORED,
    due_date DATE,
    payment_status ENUM('Paid', 'Partial', 'Unpaid') DEFAULT 'Unpaid',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (semester_id) REFERENCES Semester(semester_id),
    FOREIGN KEY (student_id) REFERENCES Student(student_id)
);

-- Creating Performance Table

CREATE TABLE Performance (
    performance_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    course_id INT,
    semester_id INT,
    instructor_id INT,
    attendance_percentage DECIMAL(5,2),
    score DECIMAL(5,2),
    grade VARCHAR(2),
    remarks TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (semester_id) REFERENCES Semester(semester_id);
    FOREIGN KEY (student_id) REFERENCES Student(student_id),
    FOREIGN KEY (course_id) REFERENCES Course(course_id),
    FOREIGN KEY (instructor_id) REFERENCES Instructor(instructor_id)
);

-- Course Enrollment Table 

CREATE TABLE CourseEnrollment (
    enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id VARCHAR(100),
    course_id INT,
    enrollment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('Enrolled', 'Dropped', 'Completed') DEFAULT 'Enrolled',
    FOREIGN KEY (student_id) REFERENCES Student(student_id),
    FOREIGN KEY (course_id) REFERENCES Course(course_id),
    UNIQUE (student_id, course_id)
);

-- Creating Instructor Teaches

CREATE TABLE CourseTeaching (
    teaching_id INT PRIMARY KEY AUTO_INCREMENT,
    instructor_id INT,
    course_id INT,
    emester_id INT,
    academic_year VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (semester_id) REFERENCES Semester(semester_id),
    FOREIGN KEY (instructor_id) REFERENCES Instructor(instructor_id),
    FOREIGN KEY (course_id) REFERENCES Course(course_id)
);


-- Sample of Data Insertions

-- Department Table
INSERT INTO Department (department_id, department_name, department_code, head_of_department) VALUES
(1, 'Computer Science', 'CS', 'Dr. Smith'),
(2, 'Electrical Engineering', 'EE', 'Dr. Johnson'),
(3, 'Mathematics', 'MATH', 'Dr. Williams'),
(4, 'Physics', 'PHY', 'Dr. Brown'),
(5, 'Business Administration', 'BUS', 'Dr. Davis');

-- Semester Table
INSERT INTO Semester (semester_name, semester_code, academic_year, semester_type, start_date, end_date, registration_start, registration_end, is_current) VALUES
('Fall 2023', 'FA23', '2023-2024', 'One', '2023-09-01', '2023-12-15', '2023-08-01', '2023-08-30', FALSE),
('Spring 2024', 'SP24', '2023-2024', 'Two', '2024-01-15', '2024-05-10', '2023-12-01', '2024-01-10', TRUE),
('Summer 2024', 'SU24', '2023-2024', 'Three', '2024-06-01', '2024-08-15', '2024-05-01', '2024-05-30', FALSE);

-- Student Table
INSERT INTO Student (student_id, first_name, last_name, date_of_birth, email, phone_number, gender, adm_date, graduate_date, department_id, current_semester_id, enrolled_status) VALUES
('S1001', 'John', 'Doe', '2000-05-15', 'john.doe@univ.edu', '555-1234', 'Male', '2022-09-01', '2026-05-15', 1, 2, 'Active'),
('S1002', 'Jane', 'Smith', '2001-02-20', 'jane.smith@univ.edu', '555-2345', 'Female', '2022-09-01', '2026-05-15', 2, 2, 'Active'),
('S1003', 'Michael', 'Johnson', '1999-11-10', 'michael.j@univ.edu', '555-3456', 'Male', '2021-09-01', '2025-05-15', 3, 2, 'Active'),
('S1004', 'Emily', 'Williams', '2000-07-22', 'emily.w@univ.edu', '555-4567', 'Female', '2022-09-01', '2026-05-15', 1, 2, 'Active'),
('S1005', 'David', 'Brown', '2001-03-30', 'david.b@univ.edu', '555-5678', 'Male', '2023-01-15', '2027-05-15', 4, 2, 'Active');

-- Course Table
INSERT INTO Course (course_id, course_code, name, department_id, credits) VALUES
(101, 'CS101', 'Introduction to Programming', 1, 4),
(102, 'CS201', 'Data Structures', 1, 4),
(103, 'EE101', 'Circuit Theory', 2, 3),
(104, 'MATH101', 'Calculus I', 3, 4),
(105, 'PHY101', 'General Physics', 4, 4),
(106, 'BUS101', 'Principles of Management', 5, 3),
(107, 'CS301', 'Database Systems', 1, 4),
(108, 'EE201', 'Digital Systems', 2, 3);

-- Instructor Table
INSERT INTO Instructor (instructor_id, first_name, last_name, email, phone_number, department_id, hire_date) VALUES
(1001, 'Robert', 'Wilson', 'r.wilson@univ.edu', '555-6789', 1, '2015-08-15'),
(1002, 'Sarah', 'Miller', 's.miller@univ.edu', '555-7890', 2, '2018-01-10'),
(1003, 'James', 'Taylor', 'j.taylor@univ.edu', '555-8901', 3, '2010-09-01'),
(1004, 'Patricia', 'Anderson', 'p.anderson@univ.edu', '555-9012', 4, '2012-03-15'),
(1005, 'Thomas', 'Thomas', 't.thomas@univ.edu', '555-0123', 5, '2019-08-20');

-- Fees Table 
INSERT INTO Fees (student_id, semester_id, total_amount, paid_amount, due_date, payment_status) VALUES
('S1001', 2, 5000.00, 5000.00, '2024-02-15', 'Paid'),
('S1002', 2, 5000.00, 3000.00, '2024-02-15', 'Partial'),
('S1003', 2, 4500.00, 0.00, '2024-02-15', 'Unpaid'),
('S1004', 2, 5000.00, 5000.00, '2024-02-15', 'Paid'),
('S1005', 2, 4500.00, 4500.00, '2024-02-15', 'Paid');

-- Performance Table
INSERT INTO Performance (student_id, course_id, semester_id, instructor_id, attendance_percentage, score, grade, remarks) VALUES
('S1001', 101, 1, 1001, 95.00, 88.50, 'A', 'Excellent performance'),
('S1001', 104, 1, 1003, 90.00, 82.00, 'B+', 'Good work'),
('S1002', 103, 1, 1002, 85.00, 78.50, 'B', 'Needs improvement in practicals'),
('S1003', 104, 1, 1003, 92.00, 91.00, 'A', 'Outstanding'),
('S1004', 101, 1, 1001, 88.00, 85.00, 'B+', 'Consistent performance');

-- Course Enrollment Table
INSERT INTO CourseEnrollment (student_id, course_id, status) VALUES
('S1001', 101, 'Completed'),
('S1001', 102, 'Enrolled'),
('S1001', 104, 'Completed'),
('S1002', 103, 'Completed'),
('S1002', 108, 'Enrolled'),
('S1003', 104, 'Completed'),
('S1003', 105, 'Enrolled'),
('S1004', 101, 'Completed'),
('S1004', 107, 'Enrolled'),
('S1005', 105, 'Enrolled');

-- Course Teaching Table
INSERT INTO CourseTeaching (instructor_id, course_id, semester_id, academic_year) VALUES
(1001, 101, 2, '2023-2024'),
(1001, 102, 2, '2023-2024'),
(1002, 103, 2, '2023-2024'),
(1002, 108, 2, '2023-2024'),
(1003, 104, 2, '2023-2024'),
(1004, 105, 2, '2023-2024'),
(1001, 107, 2, '2023-2024');