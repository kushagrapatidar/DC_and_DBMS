-- Data Definition Language
create database student_db;
use student_db;

create table Students (
	student_id int(10) primary key, 
    student_name varchar(40),
    email varchar (40) unique,
    age int(100),
    course varchar(50)
);

create table Courses (
	course_id int(10) primary key, 
    course_name varchar(40),
    duration varchar(4) ,
    fee decimal(10,2)
);

create table enrollment (
	enrollment_id int(10) primary key, 
	student_id int(10), 
	course_id int(10), 
    enroll_date date,
    foreign key (student_id) references students (student_id),
    foreign key (course_id) references courses (course_id)
);


alter table students
add column phone_number char(10);

alter table courses
modify column fee decimal(10,2);

alter table courses
rename column course_name to course_title;

drop table enrollment;

describe students;

-- Data Manipulation Language
insert into students values (001,'yen','yen001@school.com',25,'dbda','4558919988');

insert into students values (002,'gen','gen002@school.com',17,'dac','1498416919');

insert into students values (003,'ten','ten003@school.com',23,'vac','1635416546');

insert into students values (004,'ben','ben004@school.com',20,'vsli','6114465463');

insert into students values (005,'wen','wen005@school.com',16,'ai','5418919194');


insert into courses values (101,'dbda','900',125000);

insert into courses values (102,'dac','850',95000);

insert into courses values (103,'ai','700',115000);

insert into courses values (104,'vsli','750',120000);

insert into courses values (105,'vac','600',105000);

update courses set fee =fee*110/100;

delete from students where age<18;

truncate courses;

select * from courses;

-- Data Control Language
create user academy_user identified by 'academy_user';

grant select, insert, update on students to academy_user;

revoke insert on students from academy_user;

start transaction;

insert into students values(006,'zen','zen006@school.com',18,'dbda','4558918988');
rollback;

select* from students;
insert into students values(007,'ken','ken007@school.com',24,'dac','6558918988');
commit;


