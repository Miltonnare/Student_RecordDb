# University Database Schema

## Overview

The Student Record Database Schema is designed to manage comprehensive information about Students, including departments, students, courses, instructors, semesters, fees, student performance, course enrollments, and course teachings. The schema leverages relationships between tables to maintain data integrity, ensure consistency, and facilitate efficient data operations.

## Database Structure

### 1. Department Table

The Department table is the foundational entity for academic divisions within the an Institution. It contains information such as the department name, unique code, and the head of the department. This table is referenced by multiple other tables, including the Student and Course tables, to link academic records to their respective departments.

### 2. Student Table

The Student table stores personal, academic, and contact information for each student. It includes details such as first and last names, date of birth, admission and graduation dates, and the current academic semester. Additionally, each student record is associated with a specific department and semester, creating a linkage to other academic entities in the schema.

### 3. Course Table

The Course table represents the various courses offered by the university. Each course is uniquely identified by a course code and is linked to a department. It also includes information such as course credits, course name, and timestamps to track when the record was created or last updated.

### 4. Instructor Table

The Instructor table manages records of teaching staff within the university. It includes the instructor's personal details, contact information, and the department they are associated with. This table is linked to both the Department and Course tables to track which instructor teaches which course and in which department.

### 5. Semester Table

The Semester table defines the academic periods during which courses are offered. Each record includes the semester name, code, academic year, start and end dates, and a status flag indicating whether it is the current semester. This table is a key reference for tracking student enrollments and course offerings.

### 6. Fees Table

The Fees table is designed to handle financial transactions related to student enrollment for each semester. It records the total fee amount, amount paid, remaining balance, and payment status. The table is linked to the Student and Semester tables, allowing the system to manage fee payments for individual students across different academic periods.

### 7. Performance Table

The Performance table captures academic performance data for students in specific courses. It includes the attendance percentage, course scores, grades, and instructor feedback. This table links to the Student, Course, Instructor, and Semester tables to provide a comprehensive view of academic performance.

### 8. Course Enrollment Table

The Course Enrollment table manages student registrations for specific courses. Each record includes the enrollment status (e.g., Enrolled, Dropped, Completed) and the course and student details. It establishes many-to-many relationships between students and courses, tracking the student's academic journey.

### 9. Course Teaching Table

The Course Teaching table maintains records of which instructor is assigned to teach which course during a specific semester. This table also includes the academic year and semester to clearly define the teaching period.

## Data Insertion and Testing

The schema includes sample data insertion statements for each table to facilitate testing and validation of data relationships. These records cover department creation, student registration, course setup, instructor assignments, fee payment tracking, performance monitoring, and course enrollments.

## Usage and Implementation

* Execute the schema creation queries sequentially to ensure that all necessary tables and relationships are established correctly.
* Populate the tables with sample data as provided to verify database integrity and functionality.
* Utilize SQL queries to perform data retrieval, updates, and analytics based on the established relationships.

## Database Constraints and Relationships

* Primary keys and foreign keys are employed extensively to maintain data integrity.
* Unique constraints prevent duplicate entries for key fields such as course codes and student emails.
* ENUM data types are used to enforce specific value restrictions for fields like gender, semester type, and enrollment status.

## Scalability and Extensibility

The database schema is designed with scalability in mind, allowing for the addition of new tables or modification of existing ones without disrupting data integrity. New modules, such as library management, hostel allocation, or extracurricular tracking, can be easily integrated into the existing schema structure.

## License

This project is open-source and allowed for Contribution
