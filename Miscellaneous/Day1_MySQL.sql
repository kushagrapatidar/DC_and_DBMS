create database day1mysql;
use day1mysql;

create table employee(
	id int primary key auto_increment,
    ename varchar(100),
    gender char(1),
    dob date,
    doj date,
    address varchar(100)
);

create table department(
	d_no int primary key auto_increment,
    d_name varchar(50),
    location varchar(100)
);

create table dependent(
	d_name varchar(100),
    gender char(1),
    relationship varchar(40)
);