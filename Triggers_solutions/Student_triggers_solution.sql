/*

Question 1:
Create two called Student_details and Student_details_backup.

Table 1: Attributes 		
Student id, Student name, mail id, mobile no.	

Table 2: Attributes
Student id, student name, mail id, mobile no.

You have the above two tables Students Details and Student Details Backup. Insert some records into Student details. 

Problem:

Let’s say you are studying SQL for two weeks. 
In your institute, there is an employee who has been maintaining the student’s details and Student Details Backup tables. 
He / She is deleting the records from the Student details after the students completed 
the course and keeping the backup in the student details backup table by inserting the records every time. 
You are noticing this daily and now you want to help him/her by not inserting the records for backup purpose 
when he/she delete the records.write a trigger that should be capable enough to insert 
the student details in the backup table whenever the employee deletes records from the student details table.

Note: Your query should insert the rows in the backup table before deleting the records from student details.

*/

Create database Student_Triggers;
use Student_Triggers;
-- Create the main table to store student details
CREATE TABLE student_details(
	Student_id INT,
	Student_name VARCHAR(50), 
	mail_id VARCHAR(50), 
	mobile_no VARCHAR(25));

-- Create a backup table with the same structure to 
-- store deleted student details
CREATE TABLE student_details_backup(
    Student_id INT, 
    Student_name VARCHAR(50), 
    mail_id VARCHAR(50), 
    mobile_no VARCHAR(25));

-- Insert some sample data into the main table
INSERT INTO student_details VALUES
(1, 'Abhinav', 'abhinav01@gmail.com', '9787003211'),
(2, 'Bavithra', 'bavi02@gmail.com', '8885560300');

-- Display the contents of the main table
SELECT * FROM student_details;

SET SQL_SAFE_UPDATES = 0;
-- Define a trigger that activates before a record is deleted from the main table
DELIMITER //
CREATE TRIGGER BeforeDeleteStudent
BEFORE DELETE ON student_details
FOR EACH ROW
BEGIN
-- Insert the deleted student details into the backup table
INSERT INTO student_details_backup (student_id, student_name, mail_id, mobile_no)
VALUES (OLD.student_id, OLD.student_name, OLD.mail_id, OLD.mobile_no);
END;
//
DELIMITER ;
-- Delete a record from the main table (this will trigger the BeforeDeleteStudent trigger)
DELETE FROM student_details WHERE student_id = 2;

-- Display the contents of the main table after deletion
SELECT * FROM student_details;

-- Display the contents of the backup table to see the deleted student details
SELECT * FROM student_details_backup;
