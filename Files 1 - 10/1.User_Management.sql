-- The MySQL user is a record in the USER table of the MySQL server that contains the login information, account privileges, 
-- and the host information for MySQL account. It is essential to create a user in MySQL for accessing and managing 
-- the databases. MySQL is case insensitive

# All Related queries to User Management #

## View users ##
-- see the users in your server 
select user from mysql.user;

-- see all the columns related to user table in the server
select * from mysql.user;

-- view the current_user and its host as username@hostname using either user() or current_user()
select current_user();
select user();

-- view current logged users
select user, host, db, command from information_schema.processlist;  

-- Switching to an existing user using "system mysql -u username -p" syntax in cmd only

## create a new user ##
-- When the MySQL server installation completes, it has a ROOT user account only to access and manage the databases.
-- But, sometimes, you want to give the database access to others without granting them full control.
-- In that case, you will create a non-root user and grant them specific privileges to access and modify the database.
-- create a new user using the syntax :
-- CREATE USER [IF NOT EXISTS] account_name IDENTIFIED BY 'password';  where we can add the IF NOT EXISTS clause because the statement gives a warning for each named user that already exists instead of an error message.
-- and the account_name consists of hostname and username in the syntax username@hostname  . The hostname is optional. If you have not given the hostname, the user can connect from any host on the server.

-- query to create a user named Linx with host as localhost
create user if not exists Linx@localhost identified by "Linx@12345";
select user from mysql.user;

-- query to create a user named Linx2 without host
create user if not exists Linx2 identified by "Linx@12345";
select user,host from mysql.user;

## Grant Privileges to the MySQL New User ##
-- You dont want to grant all types of permissions to the user created now , use the following keywords as to grant what kind of permission
-- ALL PRIVILEGES, CREATE, DROP, DELETE, INSERT, SELECT, UPDATE
-- Use the syntax as : GRANT permission_type ON database_name.table_name or * (for all) TO account_name;

-- query to grant only select and create permission to Linx on all 
grant select, create on * to Linx@localhost;
select * from mysql.user where user="Linx";

-- query to grant all permission to Linx on all 
grant all privileges on * to Linx@localhost;
select * from mysql.user where user="Linx";

-- view the permissions for user
show grants for Linx@localhost;

-- flush the privileges to save changes
flush privileges;

## Drop the users ##
-- we can drop the multiple users using the syntax drop user account_name1, account_name2;
drop user Linx2;
select user from mysql.user;

## Modify user details or passwords ##
-- MySQL allows us to change the user account password in two different ways, which are given below:
-- SET PASSWORD Statement
-- ALTER USER Statement

-- Using the set password command change the password of Linx account
set password for "Linx"@"localhost" = "Lincon@12345";

-- using the alter command again change the passowrd
alter user Linx@localhost identified by "Linx@12345";

select * from mysql.user; -- check column password_last_changed








