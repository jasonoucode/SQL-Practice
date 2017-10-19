-- Create Student Table
CREATE TABLE students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100)
);

-- Create papers table
CREATE TABLE papers (
    title VARCHAR(100),
    grade INT,
    student_id INT,
    FOREIGN KEY(student_id) REFERENCES students(id)
);

-- Insert data into students
INSERT INTO students (first_name) VALUES 
    ('Caleb'), 
    ('Samantha'), 
    ('Raj'), 
    ('Carlos'), 
    ('Lisa');

-- Insert data into papers
INSERT INTO papers (student_id, title, grade) VALUES
    (1, 'My First Book Report', 60),
    (1, 'My Second Book Report', 75),
    (2, 'Russian Lit Through The Ages', 94),
    (2, 'De Montaigne and The Art of The Essay', 98),
    (4, 'Borges and Magical Realism', 89);
    
-- Query #1
SELECT
    first_name,
    title,
    grade
FROM students
JOIN papers
    ON students.id = papers.student_id
ORDER BY grade;

-- Query #2
SELECT
    first_name,
    title,
    grade
FROM students
LEFT JOIN papers
    ON students.id = papers.student_id
ORDER BY grade;

-- Query #3
SELECT
    first_name,
    IFNULL(title, 'MISSING'),
    IFNULL(grade, 0)
FROM students
LEFT JOIN papers
    ON students.id = papers.student_id
ORDER BY grade;

-- Query #4
SELECT
    first_name,
    IFNULL(AVG(grade), 0) AS average_grade
FROM students
LEFT JOIN papers
    ON students.id = papers.student_id
GROUP BY students.id 
ORDER BY average_grade;

-- Query #5
SELECT
    first_name,
    IFNULL(AVG(grade), 0) AS average_grade,
    CASE
        WHEN AVG(grade) IS NULL THEN 'FAILING'
        WHEN AVG(grade) >= 75 THEN 'PASSING'
        ELSE 'FAILING'
    END AS passing_status
FROM students
LEFT JOIN papers
    ON students.id = papers.student_id
GROUP BY students.id
ORDER BY average_grade DESC;
