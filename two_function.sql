--create a function to return a report of two joined table which will contain some condtion 
--school table:
CREATE TABLE school (
    student_id SERIAL PRIMARY KEY,
    student_name TEXT,
    grade TEXT
);

INSERT INTO school (student_name, grade) VALUES
('Ravi Kumar', 'A'),
('Meena Singh', 'B'),
('Aman Verma', 'A'),
('Priya Sharma', 'C');
SELECT * FROM school

--college table:

CREATE TABLE college (
    college_id SERIAL PRIMARY KEY,
    student_id INT REFERENCES school(student_id),
    college_name TEXT,
    admission_year INT
);
--Make sure the student_id values match the IDs from the school table.

INSERT INTO college (student_id, college_name, admission_year) VALUES
(1, 'ABC College', 2022),
(2, 'XYZ University', 2023),
(3, 'LMN College', 2019),
(4, 'PQR University', 2021);

SELECT * FROM college

--Create a function that returns a report of:
--Student name
--Grade
--College name
--Admission year
--But only for students admitted after a certain year.
CREATE OR REPLACE FUNCTION get_student_college_report(min_admission_year INT)
RETURNS TABLE (
    student_name TEXT,
    grade TEXT,
    college_name TEXT,
    admission_year INT
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        s.student_name,
        s.grade,
        c.college_name,
        c.admission_year
    FROM 
        school s
    JOIN 
        college c ON s.student_id = c.student_id
    WHERE 
        c.admission_year > min_admission_year;
END;
$$ LANGUAGE plpgsql;
SELECT * FROM get_student_college_report(2020);