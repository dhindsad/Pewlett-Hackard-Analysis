-- Creating tables for PH-EmployeeDB
CREATE TABLE departments (
     dept_no VARCHAR (4) NOT NULL,
     dept_name VARCHAR(40) NOT NULL,
     PRIMARY KEY (dept_no),
     UNIQUE (dept_name)
);

SELECT * FROM departments



CREATE TABLE employees(
     emp_no INT NOT NULL,
     birth_date DATE NOT NULL,
     first_name VARCHAR NOT NULL,
     last_name VARCHAR NOT NULL,
     gender VARCHAR NOT NULL,
     hire_date DATE NOT NULL,
     PRIMARY KEY (emp_no)
);

SELECT * FROM employees

DROP TABLE dept_manager CASCADE;

CREATE TABLE dept_manager (
dept_no VARCHAR(4) NOT NULL,
    emp_no INT NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
    PRIMARY KEY (emp_no, dept_no)
);

SELECT * FROM dept_manager

DROP TABLE salaries CASCADE;

CREATE TABLE salaries (
  emp_no INT NOT NULL,
  salary INT NOT NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
  PRIMARY KEY (emp_no)
);

SELECT * FROM salaries

DROP TABLE titles CASCADE;

CREATE TABLE titles (
	emp_no INT NOT NULL,
	title VARCHAR NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
);

SELECT * FROM titles


CREATE TABLE dept_emp (
     emp_no INT NOT NULL,
     dept_no VARCHAR NOT NULL,
	 from_date DATE NOT NULL,
	 to_date DATE NOT NULL,
	 FOREIGN KEY (dept_no) REFERENCES departments (dept_no)
);

SELECT * FROM dept_emp


SELECT emp_no, first_name, last_name
FROM employees

SELECT title, from_date, to_date
FROM titles 

-- Create new table for retiring employees
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees 
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31');

-- Check the table
SELECT * FROM retirement_info;

SELECT retirement_info.emp_no,
    retirement_info.first_name,
retirement_info.last_name,
	titles.title,
    titles.from_date,
	titles.to_date

INTO retirement_titles

FROM retirement_info
LEFT JOIN titles
ON retirement_info.emp_no = titles.emp_no;

SELECT * FROM retirement_titles

SELECT emp_no, first_name, last_name, title
FROM retirement_titles

DROP TABLE retiring_titles CASCADE;

SELECT 
DISTINCT ON (emp_no) emp_no,
	first_name,
	last_name,
	title
INTO unique_titles
FROM retirement_titles
ORDER BY emp_no,
	to_date DESC
	
SELECT* FROM unique_titles



SELECT COUNT (title), title
INTO retiring_titles
FROM unique_titles
GROUP BY (title)
ORDER BY Count DESC

SELECT*FROM retiring_titles

SELECT emp_no,
	first_name,
	last_name,
	birth_date
FROM employees

SELECT from_date,
	to_date
FROM dept_emp

SELECT title
FROM titles

SELECT 
DISTINCT ON (employees) emp_no
INTO mentor_table

DROP TABLE mentorship_eligibilty CASCADE;


-- Joining employees and dept_emp tables
SELECT employees.emp_no,
employees.first_name,
	employees.last_name,
	employees.birth_date,
	titles.from_date,
    titles.to_date,
	 titles.title
INTO mentorship_eligibilty
FROM employees
INNER JOIN dept_emp
ON (employees.emp_no = dept_emp.emp_no)
INNER JOIN titles
ON (employees.emp_no = titles.emp_no)
WHERE(employees.birth_date BETWEEN '1965-01-01' AND '1965-12-31');

SELECT * FROM mentorship_eligibilty 








