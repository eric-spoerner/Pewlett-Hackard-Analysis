-- TO DO: ADD DROP IF EXISTS using appropriate postgres syntax and fk considerations

CREATE TABLE department (
	dept_no VARCHAR(4) PRIMARY KEY,
	DEPT_NAME VARCHAR(40) NOT NULL UNIQUE
);

CREATE TABLE employee (
	emp_no INT NOT NULL PRIMARY KEY,
	birth_date DATE NOT NULL,
	first_name VARCHAR(20) NOT NULL,
	last_name VARCHAR(30) NOT NULL,
	gender varchar(1) NOT NULL,
	hire_date DATE NOT NULL
);

CREATE TABLE dept_manager (
	dept_no VARCHAR(4) NOT NULL,
	emp_no INT NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NULL,
	FOREIGN KEY (dept_no) REFERENCES department (dept_no),
	FOREIGN KEY (emp_no) REFERENCES employee (emp_no),
	PRIMARY KEY (emp_no, dept_no)
);

CREATE TABLE dept_emp (
	emp_no INT NOT NULL,
	dept_no VARCHAR(4) NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NULL,
	FOREIGN KEY (emp_no) REFERENCES employee (emp_no),
	FOREIGN KEY (dept_no) REFERENCES department (dept_no),
	PRIMARY KEY (emp_no, dept_no)
);

CREATE TABLE title (
	emp_no INT NOT NULL,
	title VARCHAR(50) NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NULL,
	FOREIGN KEY (emp_no) REFERENCES employee (emp_no),
	PRIMARY KEY (emp_no, title, from_date)
);


CREATE TABLE salary (
	emp_no INT NOT NULL,
	salary MONEY NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NULL,
	FOREIGN KEY (emp_no) REFERENCES employee (emp_no),
	PRIMARY KEY (emp_no, from_date)
);