-- I know its late , donot yell at me !!
-- DISCLAIMER : Its not necessary to know the TCL(Transaction Control Language) commands for SQL interviews but still I do 
-- think that it should not be avoided especially when you actually want to be a part of the data community , 
-- but again its upto you : )

## TRANSACTION MANAGEMENT ##
-- Transactions are the atomic units of work that can be committed or rolled back . When a transaction makes multiple changes 
-- to the database, either all the changes succeeds when the transaction is committed , or all the changes are undone when 
-- the transaction is rolled back . Transaction should also satisfu the ACID properties of a database i.e :
/*
Atomicity − This ensures that all operations within a transaction are treated as a single unit.
			Either all the operations within the transaction are completed successfully, or none of them are. 
            If any part of the transaction fails, the entire transaction is rolled back, and the database is left in its original state.
            
Consistency − This ensures that the database properly changes states upon a successfully committed transaction.

Isolation − This enables transactions to operate independently and transparent to each other.

Durability − This ensures that once a transaction is committed, its effects on the database are permanent and will survive system failures.
*/

-- Now , Transaction management in MySQL is an essential feature that allows you to execute a sequence of SQL statements as 
-- a single unit of work. If any statement in the transaction fails, the entire transaction can be rolled back, ensuring the 
-- database remains in a consistent state. This is particularly important for maintaining data integrity and consistency.
-- These are the key concepts we will be learning about :
-- 1. Transaction: A sequence of one or more SQL operations treated as a single unit.
-- 2. Commit: Finalizes the transaction, making all changes permanent.
-- 3. Rollback: Reverts all changes made during the transaction, returning the database to its previous state.
-- 4. Savepoint: Sets a point within a transaction to which you can later roll back without affecting the entire transaction.

# All of these are involved in the transaction workflow

## TRANSACTION WORKFLOW ##

## 1 . Start a transaction ##
-- we can start a transaction by executiong one of the following statement :
-- start transaction;  or begin;

## 2 . Commit the changes done ##
-- NOTE : Bydefault Autocommit is ON, which means that all the transactions or changes done in the transactions are committed as soon as
-- they are executed, unless they are in a begin .... commit block. If autocommit is OFF, you need to explicitly use the COMMIT statements
-- after each transaction ends to issue a commit
-- If the autocommit is ON , we can turn it OFF by using this statement : SET autocommit = 0;
-- If the autocommit is OFF , we can turn it ON by using this statement : SET autocommit = 1;
-- DDL statements such as CREATE , DROP for databases and CREATE , DROP, ALTER for tables or stored procedures cannot be rolledback 
-- To check the status of autocommit , you can use : select @@autocommit; (If 1 -> autocommit is ON, If 0 -> autocommit is OFF)

-- If the autocommit is OFF,  then you can use COMMIT; to commit the changes for the transaction

## 3. Creating a Savepoint ##
-- Using savepoints you can rollback to certain points in the transaction without terminating the transaction . You can use an explicit 
-- SAVEPOINT identifier to set a name for a transaction and can use then ROLLBACK TO identifier statement to rollback a transaction to 
-- the named savepoint without terminating the transaction.
-- syntax : SAVEPOINT savepoint_name;

## 4. Rollback ##
-- Reverts all the changes done in the transaction, and returning the database to its previous state
-- syntax : ROLLBACK;  -> Rollbacks to previous commit
-- syntax :  ROLLBACK TO savepoint_name;  -> Rollbacks to the specified savepoint

## Lets simulate the process of a transaction ##
-- we will require a dummy table for that
CREATE TABLE accounts (
    account_id INT PRIMARY KEY AUTO_INCREMENT,
    account_name VARCHAR(50),
    balance DECIMAL(10, 2)
);

INSERT INTO accounts (account_name, balance) VALUES
('John Doe', 1000.00),
('Jane Smith', 500.00);

-- First set the auto-commit to OFF state.
set autocommit = 0;
select @@autocommit;

-- Start a transaction
start transaction;
select * from accounts;
update accounts set balance = balance - 100 where account_name = "John Doe";
update accounts set balance = balance + 100 where account_name = "Jane Smith";
select * from accounts;
commit;


update accounts set balance = balance - 200 where account_name = "John Doe";
savepoint before_transfer;
update accounts set balance = balance + 2000 where account_name = "Jane Smith";
select * from accounts;
-- OOps instead of 200 , I transferred 2000 in Jane Smith account

rollback to before_transfer;
select * from accounts;
update accounts set balance = balance + 200 where account_name = "Jane Smith";
commit;

-- remember to turn ON the autocommit so that you dont have to deal with commits later on in the study plan
set autocommit = 1;

-- Phew !! I just saw my termination from the bank in my eyes , Thank god I know about transaction management and TCL commands
-- That's all for the transaction guys , I am going to see a bank robbery movie now , Untill then Happy Coding !!!