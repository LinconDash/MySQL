# Now we already have an idea about views and how to perform operations on views, but what about Why Views are used ?
-- Views are mainly helpful while dealing with a client who wants to get access to a particular query result such as an analysis or a summary report etc.
-- There are 2 main reasons for using views :
-- 1. Data security / Data abstraction : By hiding the original query used to generate the view for the client 
-- 2. To simplify complex sql queries : Sharing a view is easier than sharing a complex sql query with the client 
--    by granting him access to the view only and not any tables in the database
-- 3. Avoid rewriting the complex sql queries multiple times

# But since we know views cannot contribute to query performance optimizations so we need something. That something is nothing but materialzed view

## MATERIALIZED VIEWS ##
-- Its a database object that is created over an sql query silimar to views and then it does two things
-- 1. Stores the query from which its created 
-- 2. Stores the data retured from the sql query   (this is the reason why it improves the performance of a query)

-- Now before going to the materialized view we will be creating a table having 0.1 million records (random numbers)
CREATE TABLE random_numbers (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    random_value DOUBLE
);


DELIMITER //

CREATE PROCEDURE insert_random_numbers(IN num_batches INT, IN batch_size INT)
BEGIN
    DECLARE i INT DEFAULT 0;
    DECLARE j INT DEFAULT 0;

    SET autocommit = 0;
    
    WHILE i < num_batches DO
        SET j = 0;
        WHILE j < batch_size DO
            INSERT INTO random_numbers (random_value)
            VALUES (RAND());
            SET j = j + 1;
        END WHILE;
        COMMIT;
        SET i = i + 1;
    END WHILE;

    SET autocommit = 1;
END //

DELIMITER ;

CALL insert_random_numbers(100, 1000);

select count(*) from random_numbers; # exactly 0.1 million records nice !!

# Now I am writing a random query so as to increase the duration of running a query 
select *,
ntile(4) over() as part_num,
sum(random_value) over(rows between unbounded preceding and current row) as running_total,
avg(random_value) over(rows between unbounded preceding and current row) as running_avg,
lead(random_value) over() as next_val,
lag(random_value) over() as prev_val
from random_numbers;

# Now this query takes almost 1 second to run 
# But a materialized view will only take 0.1 msec to run this 
# Unfortunately we donot have anything like materialized view in MySQL to perform this but its written as below
/*
create materialized view random_query as 
select *,
ntile(4) over() as part_num,
sum(random_value) over(rows between unbounded preceding and current row) as running_total,
avg(random_value) over(rows between unbounded preceding and current row) as running_avg,
lead(random_value) over() as next_val,
lag(random_value) over() as prev_val
from random_numbers;
*/

-- But it doesn't refresh automatically when new rows are added or deleted so we have use 
-- refresh materialized view random_query;

-- Also its far much faster than a normal view

/*  
So we can conclude that :
1) The materialized view is essentially a normal table under the hood with query logic for populating it thus you can index it, etc. 
2) The data is basically static until you refresh it at which time it's flushed and the data is replaced by the result of the query at the new run time.
They're particularly good when the performance to run the query is poor but the data doesn't have to be exact or up to the last second.  
For example, if you wanted to run a query that  generates a report for the previous day you could create the materialized view to get the data from yesterday 
and run it on a schedule after midnight. Then the user can query the materialized view with a select * in the morning and get quick results without waiting on 
the query to execute against the base data. Sometimes it makes sense to have the materialized view to contain most of the result set and then some optimized query 
to just pull data from the current day, hour, etc. and union the results together.
3) But that doesn't mean that we should use the materialized view always instead of a normal view
*/

# Apologies if you came here for materialized view in MySQL , I just wanted to show you whats and whys about materialized views
# But it certainly is availiable in PostgresSQL so you can practice that on your own 
# Untill then, lets have a coffee together sometime in a cafeteria also don't forget Happy Coding !!