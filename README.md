# Pewlett-Hackard-Analysis

## Project Description

Database construction and subsequent analysis for a software company that had been managing employee information using only CSVs.  I think it was CSVs at least.

Data was migrated into a PostgreSQL database based on a model constructed as part of this exercise.

This analaysis requires two deliverables based on the processed data:
* A count of employees eligible for requirement based on their title
* The number of employees eligible for mentorship programs.

## Resources

* PostgreSQL 11
* pgAdmin 4.6.1
* Visual Studio Code (1.63.2)
* [quickdatabasediagrams.com](http://www.quickdatabasediagrams.com)

## The Data

### Source files

Six CSVs:
* `employees.csv`
* `departments.csv`
* `titles.csv`
* `salaries.csv`
* `dept_emp.csv`
* `dept_manager.csv`

### Transformation

Generated data model based on the source files listed above.  Results migrated into a PostgreSQL database.

Data schema was created based on this model and schema creation scripts are retained in `Queries/Schema.sql`.

![asdf](EmployeeDB.png)

## Analysis

Queries are listed in the file `Queries/Employee_Database_challenge.sql`

### Retirement-eligible employees by title

Employees are listed as eligible to retire based on their year of birth, which is between 1952 and 1955.  

* `Data/retirement_titles.csv` - Contains the full list of all employees born in this window along with every title they have held during their tenure.  
* `Data/unique_titles.csv` - Contains the list from the above, but reduced to one entry per employee, containing their current title.
* `Data/retiring_titles.csv` - The final results, containing the values from `unique_titles.csv`, counted by specific title. 

Final results are as follows:

| Count | Title |
| ----- | ----- |
| 29414	| Senior Engineer |
| 28254	| Senior Staff |
| 14222	| Engineer |
| 12243	| Staff |
| 4502 | Technique Leader |
| 1761 | Assistant Engineer |
| 2	| Manager |


### Employees entering a mentorship program

Oddly, the mentorship program is only available to employees born in the year 1965.  Results are contained in `Data/mentorship_eligibility.csv`

## Challenges encountered

None?