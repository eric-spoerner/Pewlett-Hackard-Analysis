/* PART 1: identify anyone eligible for retirement */
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