-- Now that we have almost covered up all the important string and date-time functions , its time to cover important conditional and numeric functions 
-- We already have learnt a lot about conditional functions in SQL , you can go checkout a dedicated worksheet on them . 
-- These are the important conditional functions we have in SQL 
/*
1. IF
2. IFNULL
3. NULLIF
4. CASE
5. COALESCE  -- ONLY FUNCTION THAT WE HAVE TO COVER IN CONDITIONAL FUNCTIONS
*/

## COALESCE function ##
-- The COALESCE function in SQL is used to return the first non-null value from a list of arguments. 
-- It is particularly useful for handling null values in your data. If all the arguments are null, it returns null.
select coalesce(null, "Hello", null, "World");  -- 'Hello'
select coalesce(null, "", null, "World");  -- ''

-- Note : coalesce has many kinds of applications in data analysis , but its upto the SQL problem how we can use it.
-- All of the other conditional functions are already covered in the previous worksheets , go check it out if you have not.

## Advanced Numeric functions ##
-- 1. ABS : It returns the absolute value of an integer or float value
select abs(-10);    
select abs(-12.89783);

-- 2. PI : Its the constant of maths pi = 3.14
select pi();

-- 3. COS / SIN / ACOS / ASIN / COT / TAN / ATAN / ATAN2 : All trigonometric functions . 
-- Returns NULL if value is not in the range -1 to 1 in cases of acos / asin
-- Note that all argument is provided in radians and not degrees
select cos(0);   -- 1
select sin(0);   -- 0
select tan(pi() / 4);  -- Its actually 1 but for precision and accuracy 0.999999999
select cot(pi() / 4); -- Its actually 1 but for precision and accuracy 1.000000002
select acos(0);
select asin(0);
select atan(pi() / 4);

set @x = 1;
set @y = 2;
select atan2(@y, @x);   -- first argument is y and second argument is x 

# Interesting query 
select tan(atan(1));

-- 4. DEGREES : Returns numeric expression converted from radians to degrees.
select degrees(pi() / 2);  -- 90 (because pi / 2 radians is 90 degrees)
 
-- 5. RADIANS : Returns the value of passed expression converted from degrees to radians.
select radians(180);  -- 3.14 (because 180 degrees is pi radians)

-- 6. CEIL / CEILING : Returns the smallest integer value that is not less than passed numeric expression
select ceil(10.2);   -- 11
select ceiling(10.9);  -- 11

-- 7. FLOOR : Returns the largest integer value that is not greater than passed numeric expression.
select floor(10.2);   -- 10
select floor(10.9);   -- 10

-- 8. CONV : Converts numeric expression from one base to another.
select conv(5, 10, 2);     -- convert 5 of decimal(10) to binary(2) so -- 101
select conv(18,16, 2);     -- convert 18 of hexadecimal(16) to binary(2) so -- 11000

-- 9. FORMAT : Returns a numeric expression rounded to a number of decimal places.
select FORMAT(85878.687555758, 3) as res;

-- 10. MOD : Returns the remainder of one expression by diving by another expression.
select MOD(11, 3);  -- 2

-- 11. POW / POWER : Returns the value of one expression raised to the power of another expression
select pow(2,3); -- 8
select power(2,3); -- 8

-- 12. RAND : Returns a random floating-point value with in the range 0 to 1.0.
select rand();

-- 13. ROUND : Returns numeric expression rounded to an integer. Can be used to round an expression to a number of decimal points
select round(10.213, 2);  -- 10.21
select round(10.219, 2);  -- 10.22

-- 14. TRUNCATE : Returns numeric exp1 truncated to exp2 decimal places. If exp2 is 0, then the result will have no decimal point.
select TRUNCATE(85878.687555758, 3)  as res;  
-- Note that TRUNCATE doesn't round the number but FORMAT does, thats the difference between TRUNCATE and FORMAT

-- 15. SQRT : Returns the non-negative square root of numeric expression.
select sqrt(4);  -- 2

-- 16. LOG / LN / LOG10 / LOG2 / EXP : logarithmic and euler values
select log(10, 2);   -- log of 10 base 2
select log(10, 10); -- 1
select log10(10);
select log2(2);
select ln(10);    -- same as log of 10 base e or Natrual log

select exp(1);  -- is same as e
select exp(2);  -- is same as e^2

# Interesting maths 
SELECT LN(10) AS ln_result;
SELECT LOG(10) / LOG(EXP(1)) AS log_result;
-- Both will be same

# Pheww !! that was so dammn long topic , well atleast it seems so.
# So lets wrap up the parts of advanced functions in SQL , we will meet soon with a new topic and new worksheet
# Untill then have some chips and coke to watch a new horror movie , "ADVANCED SQL", Just kidding , have fun.