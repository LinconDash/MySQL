## TRANSPOSE OF DATA ##
-- Sometimes what happens is we have to convert the data present in the rows to somewhat aggregated column data , now this technique is called as "PIVOTING DATA" 
-- by some professionals but we are students so we can say it as "PIVOTING DATA" because someday we have to be professionals :)

-- Transposing data (converting rows to columns) in SQL can be achieved using conditional aggregation. This approach is often referred to as "pivoting" the data. 
-- Now in oracle and ms sql server we have PIVOT function , in postgresSQL we have CROSSTAB functions but in MySQL we have to use CASE and aggregations to perform that.

-- Example : Transpose Departments to Columns with their Corresponding Salaries
-- Let's say you want to transpose the department column into multiple columns, each representing a department, and display the corresponding salaries.
SELECT
    employee_id,
    first_name,
    last_name,
    MAX(CASE WHEN department = 'Finance' THEN salary ELSE NULL END) AS Finance,
    MAX(CASE WHEN department = 'Sales' THEN salary ELSE NULL END) AS Sales,
    MAX(CASE WHEN department = 'HR' THEN salary ELSE NULL END) AS HR,
    MAX(CASE WHEN department = 'IT' THEN salary ELSE NULL END) AS IT
FROM employees
GROUP BY employee_id, first_name, last_name;

-- Another example : Lets suppose we already have a table called sales.
CREATE TABLE sales (
    id INT PRIMARY KEY AUTO_INCREMENT,
    year INT,
    quarter VARCHAR(2),
    sales DECIMAL(10, 2)
);

INSERT INTO sales (year, quarter, sales) VALUES
(2023, 'Q1', 1000.00),
(2023, 'Q2', 1500.00),
(2023, 'Q3', 2000.00),
(2023, 'Q4', 2500.00),
(2024, 'Q1', 1100.00),
(2024, 'Q2', 1600.00),
(2024, 'Q3', 2100.00),
(2024, 'Q4', 2600.00);

SELECT * FROM sales;

-- Suppose we have been asked to actually make a pivot table having yearly-quarterwise data of sales 
SELECT
    year,
    SUM(CASE WHEN quarter = 'Q1' THEN sales ELSE NULL END) AS Q1,
    SUM(CASE WHEN quarter = 'Q2' THEN sales ELSE NULL END) AS Q2,
    SUM(CASE WHEN quarter = 'Q3' THEN sales ELSE NULL END) AS Q3,
    SUM(CASE WHEN quarter = 'Q4' THEN sales ELSE NULL END) AS Q4
FROM sales
GROUP BY year;

-- Now look at that data , its now aggregated and we can build some insights out of it.
# This is not a very important topic but I suggest to look at some pivoting data in SQL as its possible it may be used in near future.
# I think thats it for this topic, Untill then lets meet with some advanced concepts like procedures / SQL functions , also Happy Coding !!