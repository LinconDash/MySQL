-- A lock is a mechanism associated with a table used to restrict the unauthorized access of the data 
-- in a table. MySQL allows a client session to acquire a table lock explicitly to cooperate with other
-- sessions to access the table's data. MySQL also allows table locking to prevent it from unauthorized 
-- modification into the same table during a specific period.
-- Table Locking in MySQL is mainly used to solve concurrency problems.
-- MySQL provides two types of locks onto the table, which are:

-- READ LOCK: This lock allows a user to only read the data from a table.
-- WRITE LOCK: This lock allows a user to do both reading and writing into a table.

# Lets create a tabe first and then use the table locking in it
create table sensitive_info
(
Id int not null auto_increment,
Name varchar(20) not null, 
Phone_no varchar(10) not null,
primary key(Id)
);

# Insert some data into the table 
insert sensitive_info(Name, Phone_no) values ("Ramesh", "2901831283"), ("Suresh", "1236549870"), ("Mahesh", "0123654987"), ("Kamlesh", "0147852369");
select * from sensitive_info;

## LOCK THE TABLE FOR A TRANSACTION ##
-- Following is the syntax of the MySQL LOCK TABLES Statement − LOCK TABLES table_1 [READ | WRITE], table_2 [READ | WRITE] .. ;

-- query to use a READ LOCK on the table sensitive_info
LOCK TABLES sensitive_info READ;
select * from sensitive_info;      -- we can read from the table 
insert into sensitive_info(Name, Phone_no) values("Lincon", "2021365498");  -- but we cannot write into the tabe as its resticted now to read only mode

## UNLOCK THE TABLE AFTER TRANSACTION
-- Once the client session is done using/accessing a MySQL table, they must unlock the table for other client sessions to use it. To do so, you can use the MySQL UNLOCK TABLE statement. 
-- query to unlock the tables
UNLOCK TABLES;

-- now if i want to insert some values , we can do that 
insert into sensitive_info(Name, Phone_no) values("Lincon", "2021365498");
select * from sensitive_info;

# Same procedure goes for WRITE LOCK also. 

# Account Locking :
# Also we can do account locking and unlocking to choose whom to give access to db using the ACCOUNT LOCK and ACCOUNT UNLOCK statements

-- syntax to LOCK a newly created user
# CREATE USER username@hostname IDENTIFIED BY "new_password" ACCOUNT LOCK;
-- syntax to LOCK a existing user
# ALTER USER username@hostname ACCOUNT LOCK;
-- syntax to unlock an account
# ALTER USER username@hostname ACCOUNT UNLOCK;
