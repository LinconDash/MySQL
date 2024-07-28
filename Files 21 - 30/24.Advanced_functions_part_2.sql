-- Now that we know about the string functions , we will know about the date and time functions , these are quite necessary 
-- when you are dealing with time-series data . Since we have many functions of date and time , we will only consider those that
-- are most widely used in solving SQL Problems

## Advanced Date and Time functions ##
-- 1. CURDATE / CURRENT_DATE : Returns the current date.
select curdate();
select current_date();

-- 2. CURTIME / CURRENT_TIME : Returns the current time.
select curtime();
select current_time();

-- 3. NOW / CURRENT_TIMESTAMP: Returns the current date and time.
select now();
select current_timestamp();  

-- 4. DATE : Extracts the date part of a date or datetime expression.
select DATE(now()) as today_date; 

-- 5. TIME : Extracts the time part of a date or datetime expression.
select TIME(now()) as today_time; 

-- 6. YEAR / MONTH / DAY / HOUR / MINUTE / SECOND / MICROSECOND: Extracts that specific part of a date or time 
select year(now());
select month(now());
select day(now());
select hour(now());
select minute(now());
select second(now());
select microsecond(now());

-- 7. DATE_ADD / ADDDATE : Adds a time/date interval to a date and then returns the date.
select date_add(current_date(), interval 5 day) as 5_days_from_today;
select date_add('2021-03-22', interval '5-6' year_month);   -- 2026-09-22
select adddate(current_date(), 5) as 5_days_from_today;    # just another syntax for adddate() without using interval
select adddate(current_date(), interval -5 day) as past_5days_from_today;
select adddate(now(), interval 5 hour) as 5_hours_from_now;

-- 8. DATE_SUB : Subtracts a time/date interval from a date and then returns the date.
select date_sub(current_date(), interval 5 day) as 5_past_days_from_today;   # same as 'select adddate(current_date(), interval -5 day) as past_5days_from_today;'

-- 9. DATEDIFF : Returns the number of days between two dates.
select datediff(now(), '2023-06-18');  -- 366 because a year from todays date
select datediff('2024-01-01', '2024-01-10');  # negative
select datediff('2024-01-10', '2024-01-01');  # positive

-- 10. DATE_FORMAT : It formats the given date according to the specified format and returns the result.
select date_format('2024-01-01', '%W %M %Y');
select date_format(now(), '%D %M %Y');  -- It even accepts the time-stamps , also there are various formats avaliable in the internet.

-- 11. TIMEDIFF : Returns the difference between two times.
select timediff('14:30:00', '12:00:00');  -- '02:30:00'

-- 12. DAYOFWEEK / DAYOFMONTH / DAYOFYEAR / WEEK / DAYNAME / MONTHNAME / YEARWEEK / LAST_DAY / QUARTER
SELECT DAYOFWEEK('2023-05-22');  -- 2 (Sunday is 1)
SELECT DAYOFMONTH('2023-05-22');  -- 22
SELECT DAYOFYEAR('2023-05-22');  -- 142
SELECT WEEK('2023-05-22');  -- 21
SELECT QUARTER('2023-05-22');  -- 2
SELECT DAYNAME('2023-05-22');  -- Monday
SELECT MONTHNAME('2023-05-22');  -- 'May'
SELECT YEARWEEK('2023-05-22');  -- '202321'
SELECT LAST_DAY('2023-05-22');  -- '2023-05-31'    

-- 13. SEC_TO_TIME : This function converts seconds to 'HH:MM:SS' format
select sec_to_time(3600);  -- 01:00:00 (as 1hr = 3600 secs)

-- 14. STR_TO_DATE : This function converts a string to a date/time
select STR_TO_DATE('Sat Sep 10 23', '%a %b %d %y') as Result;
select STR_TO_DATE('20 Hours 40 Minutes 45 Seconds', '%H Hours %i Minutes %S Seconds') as Result;
select STR_TO_DATE('Sep 05 15 10:23:00 PM', '%b %d %y %r') as Result;

-- 15. SYSDATE : This function returns the time at which the function executes
select SYSDATE();
select SYSDATE() + 0;
select SYSDATE() + 10;
 
-- 16. TIME_FORMAT : This function formats the given date in the specified format
select TIME_FORMAT('10:30:35', '%H Hours %i Minutes');
select TIME_FORMAT('09', '%T');

-- 17. TIME_TO_SEC : Just opposite of SEC_TO_TIME
select time_to_sec("01:00:00");  -- 3600

# I think thats it for the date and time , my time is running quickly.
# Untill then , lets see some wild animals in the zoo and don't forget Happy Coding !! . 