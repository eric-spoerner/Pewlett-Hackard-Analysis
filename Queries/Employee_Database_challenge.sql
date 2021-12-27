--TO-DO: FIGURE OUT WHY UNIQUE ENTRIES ARE DIFFERENT THAN EXPECTED IN SCREENSHOT

--Challenge part 1
DROP TABLE IF EXISTS retirement_titles;

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

--SELECT * FROM retirement_titles order by birth_date desc

--select emp_no, count(*) from retirement_titles group by emp_no order by count(*) desc;

-- Retrieve all unique retirement-eligible employee names and their titles
DROP TABLE IF EXISTS unique_title;

--did not put end date in where clause, specifically in order to match list in challenge
select	DISTINCT ON (emp_no) 
		emp_no
		,first_name
		,last_name
		,title
INTO	unique_title
FROM 	retirement_titles r
ORDER BY emp_no ASC, to_date desc;

--SELECT * FROM unique_title;

--select emp_no, count(*) from unique_title group by emp_no order by count(*) desc;

--Determine count of individual titles.  WHY is this different from expected?
DROP TABLE IF EXISTS retiring_title;

SELECT 		COUNT(*)
			,title
INTO		retiring_title
FROM 		unique_title
GROUP BY 	title
ORDER BY 	COUNT(*) DESC;

--SELECT * FROM retiring_title;

--Part 2: create a Mentor Eligibility table for all employees born in 1965
/*
	SELECT		emp.emp_no
				,emp.first_name
				,emp.last_name
				,emp.birth_date
				,de.from_date
				,de.to_date
				,t.title
				,t.to_date as title_to_date
	FROM		employee AS emp
	INNER JOIN	dept_emp AS de ON emp.emp_no = de.emp_no
	INNER JOIN 	title AS t ON t.emp_no = emp.emp_no
	ORDER BY 	emp.emp_no
*/

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

SELECT * FROM mentorship_eligibility;