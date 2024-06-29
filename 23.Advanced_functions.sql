-- Now that we have almost covered everything for the intermediate SQL part, now the only thing left is to know what are the functions 
-- that are almost used in every kind of SQL interview questions. Since we have like more than 100 functions , we will only be focusing 
-- on the most widely used functions in the SQL problems, so without any further confusion lets start with the types of function we 
-- will be focusing on :
 /* Types of function :
 1. String functions
 2. Date and Time functions
 3. Conditional functions  
 4. Numeric functions
 */

## Advanced String functions ##
-- 1. CONCAT : Concatenates two or more strings.
SELECT concat("I", " am", " Batman", " ! "); -- I am Batman ! 
SELECT concat(first_name, " ", last_name) AS full_name FROM students;

-- 2. CONCAT_WS : Concatenates two or more strings with a separator.
SELECT concat_ws(" - ", "2024", "06", "18") AS today;

-- 3. SUBSTRING (or SUBSTR) : Extracts a substring from a string from the given range of indexes
SELECT substring("Naruto Uzumaki", 1, 5);  -- "Narut"  because it starts from 1st and ends with 5th character.
SELECT substring("Sosuke Aizen", 1, 100); -- Note if the end limit is larger than string itself, it will stop after the length of the string.
-- This function never throws error, even in case of null or empty string , it just returns what it is, so cool.
SELECT substr("Naruto Uzumaki", 1, 5);  -- same work as substring()

-- 4. LEFT : Returns the left part of a string with the specified number of characters.
SELECT LEFT('Hello World', 5);  -- 'Hello'

-- 5. RIGHT : Returns the right part of a string with the specified number of characters.
SELECT RIGHT('Hello World', 5);  -- 'World'

-- 6. LENGTH : Returns the length of a string.
SELECT LENGTH('Hello World');  -- 11

-- 7. TRIM : Removes leading and trailing spaces from a string.
SELECT TRIM('  Hello World  ');  -- 'Hello World'

-- 8. LTRIM : Removes leading spaces from a string.
SELECT TRIM('  Hello World  ');  -- 'Hello World  '

-- 9. RTRIM : Removes trailing spaces from a string.
SELECT RTRIM('  Hello World  ');  -- '  Hello World'

-- 10. UPPER : Converts a string to uppercase.
SELECT UPPER('Hello World');  -- 'HELLO WORLD'

-- 11. LOWER : Converts a string to lowercase.
SELECT LOWER("HELLO WORLD"); -- 'hello world'

-- 12. POSITION / LOCATE/ INSTR : Returns the position of the first occurrence of a substring.
SELECT POSITION('World' IN 'Hello World');  -- 7
SELECT LOCATE('World','Hello World'); -- 7
SELECT INSTR('Hello World', 'World');  -- 7
-- Same Same but different got real !! , Actually all have same work but the syntax is only a bit different

-- 13. REPLACE : Replaces all occurrences of a substring within a string.
SELECT REPLACE('Hello World', 'World', 'Everyone');  -- 'Hello Everyone'

-- 14. REPEAT : Repeats a string a specified number of times.
SELECT REPEAT("Hello", 3); -- 'HelloHelloHello'

-- 15. REVERSE : Reverses a string.
SELECT REVERSE("Hello World"); -- dlroW olleH

-- 16. ELT : This function returns string at index number.
SELECT ELT(2, "Python", "C++", "SQL", "Java", "Go");  -- C++

-- 17 INSERT : Inserts a substring at the specified position up to the specified number of characters with syntax as - INSERT(str,pos,len,newstr)
SELECT INSERT('Hello World', 5, 3, 'ABC');  -- HellABCorld

-- 18. STRCMP : This function is used to compare two given strings. (Not a function used in SQL Problems but generally asked in mock interviews)
/* 
If both strings are equal this function returns 0.
If first argument is greater than the second, this function returns 1.
If the first argument is smaller than the second, this function returns -1.
If either of the arguments is NULL, this function returns NULL.
If both the arguments holds empty strings, this function return 0 as result.
*/
SELECT STRCMP("Hello", "Hello");    -- 0
SELECT STRCMP("Hello", "HELLO");    -- 0
SELECT STRCMP("Hello", "HELLLOOOO"); -- 1
SELECT STRCMP("HELLLOOOO", "Hello"); -- -1

# Now i feel like this is it for the string functions that are widely used in SQL problems
# Up next, we will see about date and time advanced functions , Untill then, keep eating watermelons in summers.