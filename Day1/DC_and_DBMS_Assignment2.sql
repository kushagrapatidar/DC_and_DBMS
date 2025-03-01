-- Database Creation
create database assignment2;

use assignment2;

-- Data Definition Language
-- Table Creation
create Table books(
    _name VARCHAR(50) Not Null,
    author VARCHAR(50) Not Null,
    price decimal(10,2) not null,
    writer varchar(50) not null,
    primary key (_name, author)
    );
    
desc books;

Alter Table books
-- Add a new column published_year (YEAR).
add published_year year,

-- Modify the price column to DECIMAL(10,3).
modify column price decimal(10,3),

-- Rename the column writer to publisher.
rename column writer to publisher;

desc books;

-- Drop the published_year column.
Alter table books
drop column published_year;

desc books;

-- Drop the Books table.
drop table books;

-- Data Manipulation Language
-- Insert at least 5 records into the Books table.
insert into books values 
	('You Only Live Once', 'Stuti Changle', 179, 'Stuti Changle');

insert into books values
	("Don't Believe Everything You Think", 'Joseph Guin', 200, 'Joseph Guin');

insert into books values
	('Too Good To Be True', 'Prajakta Koli', 257, 'Prajakta Koli');
    
insert into books values
	('The Time Machine', 'S.G. Wells', 119, 'S.G. Wells');
    
insert into books values
	('Virasat', 'Hitesh Jain', 200, 'Hitesh Jain');

-- Update the price of a specific book
select * from books where _name='You Only Live Once' and author='Stuti Changle';

update books set price=255 where _name='You Only Live Once' and author='Stuti Changle';

select * from books where _name='You Only Live Once' and author='Stuti Changle';

-- Delete a book by name.
delete from books where _name='You Only Live Once';

select * from books;

-- Remove all records from the Books table but keep the structure.
truncate books;

select * from books;


-- Data Control Language
-- Create a new user named dbda with a password.
create user dbda identified by 'dbdaacts';

-- Grant ALL privileges on the database to dbda. 
grant all on books_db to dbda;

-- Revoke the DELETE privilege from dbda.
revoke delete on books_db from dbda;

-- Perform an INSERT and UPDATE operation, then ROLLBACK to check if changes revert. 
start transaction;
insert into books values ( 'magical' , 'ben', 234, 'ben');

select * from books;

update books set price = 530 where (_name,author)=('magical','ben');

select * from books;

rollback;

select * from books;

-- Perform an INSERT, then COMMIT and check if data persists.
insert into books values ( 'magical' , 'ben', 234, 'ben');
commit;
select * from books;

