-- Other analysis
SELECT 		first_name
			,last_name
			,birth_date
FROM		employee
WHERE		birth_date BETWEEN '1952-01-01' AND '1952-12-31'
ORDER BY 	birth_date;

select count(*)
FROM		employee
WHERE		birth_date BETWEEN '1952-01-01' AND '1952-12-31';


SELECT 		first_name
			,last_name
			,birth_date
FROM		employee
WHERE		DATE_PART('year',birth_date) = 1953
ORDER BY 	birth_date;

SELECT  	DATE_PART('year',birth_date) as yr
			,count(*)
from 		employee
where		DATE_PART('year',birth_date) between 1952 and 1955
group by 	DATE_PART('year',birth_date);

-- Retirement eligibility
SELECT 		first_name
			,last_name
			,birth_date
			,hire_date
FROM		employee
WHERE		(birth_date BETWEEN '1952-01-01' AND '1955-12-31')
			AND (hire_date between '1985-01-01' AND '1988-12-31');

SELECT 		count(1)
FROM		employee
WHERE		(birth_date BETWEEN '1952-01-01' AND '1955-12-31')
			AND (hire_date between '1985-01-01' AND '1988-12-31');

drop table retirement_info;

SELECT 		first_name
			,last_name
INTO 		retirement_info
FROM		employee
WHERE		(birth_date BETWEEN '1952-01-01' AND '1955-12-31')
			AND (hire_date between '1985-01-01' AND '1988-12-31');

SELECT * FROM retirement_info;

--Let's do retirement eligibility again.
DROP TABLE retirement_info;

SELECT 		emp_no
			,first_name
			,last_name
INTO 		retirement_info
FROM		employee
WHERE		(birth_date BETWEEN '1952-01-01' AND '1955-12-31')
			AND (hire_date between '1985-01-01' AND '1988-12-31');

select * from retirement_info;

-- use inner join to see full list of departments, their managers, and their tenures
SELECT 		dpt.dept_name
			,dm.emp_no AS mgr_no
			,dm.from_date
			,dm.to_date
FROM 		dept_manager dm
INNER JOIN 	department dpt ON dm.dept_no = dpt.dept_no;

drop table current_emp;

SELECT 		ri.emp_no
			,ri.first_name
			,ri.last_name
			,de.to_date
INTO		current_emp
FROM 		retirement_info AS ri
LEFT JOIN 	dept_emp AS de ON ri.emp_no = de.emp_no
WHERE		to_date = '9999-01-01';
-- WHERE 		to_date >= NOW();

select * from current_emp;

-- employee count by dept number. 
SELECT 		dept_no
			,count(*)
FROM 		current_emp ce
LEFT JOIN 	dept_emp de ON ce.emp_no = de.emp_no
GROUP BY 	dept_no
ORDER BY 	dept_no

-- Module 7.3.5:
--table 1:Employee Information: A list of employees containing their unique employee number
--, their last name, first name, gender, and salary
select * from salary order by to_date desc;

DROP TABLE emp_info;

SELECT  	emp.emp_no
			,emp.last_name
			,emp.first_name
			,emp.gender
			,s.salary
			,de.to_date
INTO 		emp_info
FROM 		employee emp
INNER JOIN 	salary s ON emp.emp_no = s.emp_no
INNER JOIN	dept_emp de ON emp.emp_no = de.emp_no
WHERE		(emp.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
			AND (emp.hire_date between '1985-01-01' AND '1988-12-31')
			AND (de.to_date = '9999-01-01');


SELECT * FROM emp_info;

--table2:Management: A list of managers for each department, including the department number, 
--name, and the manager's employee number, last name, first name, and the starting and ending employment dates
SELECT 	dm.dept_no
		,dept.dept_name
		,dm.emp_no
		,mgr.last_name
		,mgr.first_name
		,dm.from_date
		,dm.to_date
FROM dept_manager dm
INNER JOIN department dept ON dept.dept_no = dm.dept_no
INNER JOIN current_emp mgr ON dm.emp_no = mgr.emp_no;
--WHERE dm.to_date = '9999-01-01';

--table3:Department Retirees: An updated current_emp list that includes everything it currently has,
--but also the employee's departments
DROP TABLE dept_info;

SELECT		ce.emp_no
			,ce.first_name
			,ce.last_name
			,d.dept_name
into 		dept_info
FROM		current_emp AS ce
INNER JOIN 	dept_emp AS de ON ce.emp_no = de.emp_no
INNER JOIN 	department AS d ON de.dept_no = d.dept_no;

-- select emp_no, count(*)
-- from dept_info
-- group by emp_no
-- having count(*) > 1