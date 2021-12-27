--TO-DO: FIGURE OUT WHY UNIQUE ENTRIES ARE DIFFERENT THAN EXPECTED IN SCREENSHOT

--Challenge part 1
DROP TABLE IF EXISTS retirement_titles;

SELECT		e.emp_no
			,e.first_name
			,e.last_name
			,t.title
			,t.from_date
			,t.to_date
INTO		retirement_titles
FROM		employee AS e
INNER JOIN 	title AS t ON e.emp_no = t.emp_no
WHERE		DATE_PART('year',e.birth_date) BETWEEN 1952 and 1955
ORDER BY 	emp_no ASC;

--SELECT * FROM retirement_titles

-- Retrieve all unique retirement-eligible employee names and their titles
DROP TABLE IF EXISTS unique_title;

select	DISTINCT ON (emp_no) 
		emp_no
		,first_name
		,last_name
		,title
INTO	unique_title
FROM 	retirement_titles rt
WHERE 	to_date = '9999-01-01'
ORDER BY emp_no ASC, to_date DESC;

--SELECT * FROM unique_title;

--Determine count of individual titles.  WHY is this different from expected?
DROP TABLE IF EXISTS retiring_title;

SELECT 		COUNT(*)
			,title
INTO		retiring_title
FROM 		unique_title
GROUP BY 	title
ORDER BY 	COUNT(*) DESC;

SELECT * FROM retiring_title;