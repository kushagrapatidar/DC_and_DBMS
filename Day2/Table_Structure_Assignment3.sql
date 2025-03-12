create database companydb;
use companydb;

create table departments(
	dept_id int primary key auto_increment,
    dept_name varchar(50) not null unique
);

create table employees(
	emp_id int primary key auto_increment,
    first_name varchar(50) not null,
    last_name varchar(50) not null,
    email varchar(100) not null unique,
    dob date not null,
    hire_date date not null,
    salary decimal(10,2) not null,
    dept_id int(10),
    foreign key (dept_id) References departments(dept_id)
);

create table projects(
	project_id int primary key auto_increment,
    project_name varchar(100) not null,
    dept_id int null,
    foreign key (dept_id) references departments(dept_id)
);

create table salespersons(
	salesman_id int primary key auto_increment,
    salesman_name varchar(100) not null,
    commission decimal(5,2) not null
);

create table customers(
	customer_id int primary key auto_increment,
    customer_name varchar(100) not null,
    city varchar(50) not null,
    salesman_id int(10),
    foreign key (salesman_id) references salespersons(salesman_id)
);