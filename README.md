# Employee retirement: an enterprise-level risk analysis

## Project Description

This repository contains SQL queries and CSV files related to an initiative for database construction and subsequent analysis for a software company.  This company had historically been managing its employee data in comma-separated CSV files and required an upgrade of their data framework. 

Data was migrated into a PostgreSQL database based on a model constructed as part of this exercise.

The processed data was subsequently analyzed to investigate statistics related to retirement and mentorship, as the company's workforce is aging and a "silver tsunami" threatens to create significant loss of institutional knowledge. 

## Resources

* PostgreSQL 11
* pgAdmin 4.6.1
* Visual Studio Code (1.63.2)
* [quickdatabasediagrams.com](http://www.quickdatabasediagrams.com)

## The Data

### Input files

* `employees.csv` - Personal information of each employee, past and present.
* `departments.csv` - List of each company department.
* `titles.csv` - All titles held by an employee for their entire tenure.
* `salaries.csv` - All salaries earned by each employee for their entire tenure.
* `dept_emp.csv` - List of all departments to which employees have been allocated during the duration of their career at the company.
* `dept_manager.csv` - Full historical dataset of managers for each department.

### Output files

* `retirement_titles.csv` - Contains the full list of all employees born in the years **1952-1955** along with every title they have held during their tenure.  
* `unique_titles.csv` - Contains the list from the above, but reduced to one entry per employee, containing their current title.
* `retiring_titles.csv` - The final results, counting the number of each specific job title eligible for retirement as identified in `unique_titles.csv`.
* `mentorship_eligibility.csv` - List of all employees eligible for the mentorship program.
* `mentorship_by_title.csv` - Lists all candidates for mentorship program by title, compares with count of eligible retirees by same titles, and determines a ratio of retiree to mentee.
* `employee_age.csv` - Age in years of all employees as of January 8, 2022.
* `aggregate_age_statistics.csv` - Top-line summary data of company-wide employee age.
* `emp_age_by_dept.csv` - Average employee age per department.

### Transformation

Generated data model based on the source files listed below in Figure 1.  Results migrated into a PostgreSQL database.

Data schema was created based on this model and schema creation scripts are retained in `Queries/Schema.sql`.

![Fig. 1 - data model](EmployeeDB.png)

## Analysis

Queries for extraction of this data are listed in the file `Queries/Employee_Database_challenge.sql`.  Tables generated were then manually extracted into corresponding CSV files.

### Findings

* *"Silver Tsunami" confirmed* - This company is indeed in serious trouble for retirement-based attrition in the coming years, as the youngest employee in the organization was born in February 1965, and at the time of this analysis, almost 57 years old.  The average age of all employees in the firm is 63 years.

* *Advanged employee age is is evenly distributed across departments* - The average age in every single department is 63.  This is a company in profound and systemic crisis without a significant effort to aggressively staff younger candidates to backfill these departures.

* *Immediate retirement eligibility* - Employees are listed as eligible to retire based on their year of birth, which is between 1952 and 1955.  See # Retirees column below in Fig. 2 for eligibilty by role.

* *Mentorship availability* - The mentorship program is only available to employees born in the year 1965, which as stated before, is the youngest year of birth for any employee at the company.  This makes only **1,549** employees eligible for mentorship programs.  See Fig. 2 below - there is at least a **fifty-to-one** ratio of retirees to mentees in nearly every role; this is a highly disproportionate distribution.  The mentorship program needs aggressive expansion to keep up with brain drain.

_Fig. 2 - retirement-eligibility and mentorship-eligibility counts by department:_

| Title | # Mentees | # Retirees | Retiree/Mentee Ratio
| ----- | ----- | ----- | ----- |
Senior Engineer | 529 |	29414 | **55** |
Senior Staff | 569 | 28254 | **49** |
Engineer | 190 | 14222 | **74** |
Staff | 155 | 12243 | **78** |
Technique Leader | 77 |	4502 | **58** |
Assistant Engineer | 29 | 1761 | **60** |
Manager | 0 | 2	| **N/A**



