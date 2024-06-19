-- Since we have written many queries as of now . But I kinda feel what's the execution logic behind a SQL query as like what statement 
-- are executed first then next statement and so on. So this file is a special file and generally people ignore this but I personally 
-- feel that this should be something any SQL learner should know about. So lets start the order of execution of a SQL query having multiple statements.

/*
In SQL, the order of execution of the clauses in a query is essential to understand how a query processes data. 
The logical order in which the clauses are executed is different from the written order in the SQL statement. 
Here’s the logical order of execution:

1. FROM: The FROM clause identifies the source table(s) for the query.
2. WHERE: The WHERE clause filters the rows based on specified conditions.
3. GROUP BY: The GROUP BY clause groups rows that have the same values in specified columns into summary rows.
4. HAVING: The HAVING clause filters the groups created by the GROUP BY clause based on a specified condition.
5. SELECT: The SELECT clause selects the columns to be returned in the final result set.
6. DISTINCT: The DISTINCT clause removes duplicate rows from the result set.
7. ORDER BY: The ORDER BY clause sorts the result set based on specified columns.
8. LIMIT / OFFSET: The LIMIT clause restricts the number of rows returned in the result set; OFFSET specifies the starting point within the result set.
*/

-- This is the logical order of execution but while writing the query we will have a different order of clauses 
SELECT DISTINCT department, AVG(salary) AS avg_salary
FROM employee_data
WHERE age > 30
GROUP BY department
HAVING AVG(salary) > 50000
ORDER BY avg_salary DESC
LIMIT 5;

-- If we have JOINS statements then also thier order of execution is after FROM and before WHERE incase of logical order of execution
-- As for the order of clauses including join is like this :
SELECT DISTINCT e.department, AVG(e.salary) AS avg_salary
FROM employee_data as e
JOIN manager_data as m
ON e.employee_id = m.manager_id
WHERE e.age > 30
GROUP BY department
HAVING AVG(e.salary) > 50000
ORDER BY avg_salary DESC
LIMIT 5;

## SUMMARY ##
-- The logical execution order ensures that each step is performed in a sequence that makes sense for data processing:

-- Retrieve data from tables and join conditions (FROM).
-- Filter the data based on conditions (WHERE).
-- Group the filtered data (GROUP BY).
-- Filter the grouped data (HAVING).
-- Select the required columns (SELECT).
-- Remove duplicate rows if DISTINCT is used.
-- Sort the result set (ORDER BY).
-- Limit the number of rows returned (LIMIT).


