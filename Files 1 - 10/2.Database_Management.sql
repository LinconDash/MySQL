## A database is used to store the collection of records in an organized form. It allows us to hold the data into tables, 
## rows, columns, and indexes to find the relevant information frequently. We can access and manage the records through the database very easily.

## All related queries to database management ##
## view databases to view all the availiable databases here. ##
show databases;

-- query to see all the databases that starts with "s"
show databases like "s%";

## Select a database to use it ##
-- query to select the database world and use it
use world;

## create a new database ##
-- we can create a new database using the create database command using the following syntax : create database [if not exists] database_name[character set charset_name] [collate collation_name]
create database if not exists lincondb;
show databases;

## copy a database using the mysqldump command on command_line ##

## Delete / Drop a database ##
-- Note if we delete a database it permanently deletes all the tables, indexes, constraints , etc. in that database. So use it carefully
-- Syntax : drop database [if exists] database_name; or drop schema [if exists] database_name;
drop database if exists lincondb;