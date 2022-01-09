/* PART 1: identify the count of retirement-eligible employees per title. */
DROP TABLE IF EXISTS retirement_titles;

-- Identify all employees eligible for retirement based on DOB in the years from 1952 to 1995.
-- Query will also contain all of the titles those employees have held through their tenure.
SELECT		e.emp_no
			,e.first_name
			,e.last_name
			,t.title
			,t.from_date
			,t.to_date
			,e.birth_date
INTO		retirement_titles
FROM		employee AS e
INNER JOIN 	title AS t ON e.emp_no = t.emp_no
WHERE		DATE_PART('year',e.birth_date) BETWEEN 1952 and 1955
ORDER BY 	emp_no ASC;

-- Narrow down previous list to only the most recent title of all retirement-eligible employees
DROP TABLE IF EXISTS unique_title;

SELECT	DISTINCT ON (emp_no) 
		emp_no
		,first_name
		,last_name
		,title
INTO	unique_title
FROM 	retirement_titles r
ORDER BY emp_no ASC, to_date desc;

--Determine count of retirement-eligible employees per title.
DROP TABLE IF EXISTS retiring_title;

SELECT 		COUNT(*)
			,title
INTO		retiring_title
FROM 		unique_title
GROUP BY 	title
ORDER BY 	COUNT(*) DESC;

/* PART 2: create a Mentor Eligibility table for all employees born in 1965 */
DROP TABLE IF EXISTS mentorship_eligibility;

SELECT		DISTINCT ON (emp.emp_no)
			emp.emp_no
			,emp.first_name
			,emp.last_name
			,emp.birth_date
			,de.from_date
			,de.to_date
			,t.title
INTO		mentorship_eligibility
FROM		employee AS emp
INNER JOIN	dept_emp AS de ON emp.emp_no = de.emp_no
INNER JOIN 	title AS t ON t.emp_no = emp.emp_no
WHERE		DATE_PART('year',emp.birth_date) = 1965 AND t.to_date = ('9999-01-01')
ORDER BY 	emp_no ASC, t.to_date DESC;


/* PART 3 - FURTHER AGE BASED ANALYSIS */

--How many mentees are available by title?  How does that compare with imminent retirees?
DROP TABLE IF EXISTS mentorship_by_title;

with mentor_count_by_title AS (
	SELECT 		title
				,count(*) AS num_mentees
	FROM 		mentorship_eligibility
	GROUP BY 	title
)
SELECT 			COALESCE(rt.title,mc.title) AS title
				,COALESCE(mc.num_mentees,0) As num_mentees
				,rt.count AS num_retirees
				,rt.count / mc.num_mentees AS ratio
INTO			mentorship_by_title
FROM 			mentor_count_by_title mc
FULL OUTER JOIN retiring_title rt on mc.title = rt.title;

--What is the numerical age of each employee as of today?
DROP TABLE IF EXISTS employee_age;

SELECT		DISTINCT ON (e.emp_no)
			e.emp_no
			,e.first_name
			,e.last_name
			,e.birth_date
			,(now()::date - e.birth_date::date) / 365.25 AS age_years -- accounting for quadrennial leap day in age conversion
			,t.title
			,t.from_date
			,t.to_date
INTO		employee_age 
FROM		employee AS e
INNER JOIN 	title AS t ON e.emp_no = t.emp_no
WHERE		to_date = '9999-01-01'
ORDER BY 	emp_no ASC, t.to_date desc;

--What is the average age across the firm?
DROP TABLE IF EXISTS aggregate_age_statistics;

SELECT 	AVG(age_years) AS avg_employee_age
		,MIN(age_years) AS min_employee_age
		,MAX(age_years) AS max_employee_age
INTO 	aggregate_age_statistics
FROM 	employee_age;

--WHat is the average age by department?
DROP TABLE IF EXISTS emp_age_by_dept;

with dept_age as (
	SELECT 		ea.*
				,d.dept_name
	FROM 		employee_age ea
	INNER JOIN 	dept_emp de on ea.emp_no = de.emp_no
	INNER JOIN 	department d on d.dept_no = de.dept_no
	WHERE 		de.to_date = '9999-01-01'
)
SELECT 		dept_name
			,COUNT(*) AS num_employees
			,AVG(age_years)
INTO		emp_age_by_dept
FROM		dept_age
GROUP BY	dept_name;