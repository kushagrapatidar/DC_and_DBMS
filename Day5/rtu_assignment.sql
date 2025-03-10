
-- Create RTU Database
create database rtudb;
use rtudb;

--
-- Table Creations

create table rtu(
rtu_id varchar(10) primary key,
location varchar(50) not null,
ip_address varchar(15) unique not null
);
-- drop table rtu;


create table users(
user_id varchar(10) primary key,
user_name varchar(100) not null,
user_role varchar(20) not null
);
-- drop table users;

create table sensors(
sensor_id varchar(10) primary key,
rtu_id varchar(10),
sensor_status varchar(8) not null,
sensor_type varchar(20) not null,
req_val int not null,
curr_val int,
foreign key (rtu_id) references rtu(rtu_id)
);
-- drop table sensors;

create table controllers(
user_id varchar(10) not null,
sensor_id varchar(10) not null,
primary key (user_id,sensor_id),
foreign key (user_id) references users(user_id),
foreign key (sensor_id) references sensors(sensor_id)
);
-- drop table controllers;

--
-- Data Insertion

insert into rtu values
('R101', 'BENGALURU', '192.168.0.1'),
('R102', 'MUMBAI',    '192.168.0.2'),
('R103', 'CHENNAI',   '192.168.0.3'),
('R104', 'NEW DELHI', '192.168.0.4'),
('R105', 'KOLKATA',   '192.168.0.5');


insert into users values
('U501', 'PRAKASH',    'MONITOR'),
('U502', 'PARTHIV', 'ADMINISTER'),
('U503', 'SMITHA',  'ADMINISTER');


insert into sensors values
('S801','R101', 'ENABLED',  'PRESSURE',      34,   33),
('S802','R101', 'ENABLED',  'TEMPERATURE',   98,   90),
('S803','R101', 'DISABLED', 'TEMPERATURE',   96, null),
('S804','R102', 'ENABLED',  'PRESSURE',      30,   32),
('S805','R102', 'ENABLED',  'PRESSURE',      36,   32),
('S806','R102', 'DISABLED', 'TEMPERATURE',  108, null),
('S807','R102', 'ENABLED',  'BAROMETER',    750,  660),
('S808','R103', 'ENABLED',  'BAROMETER',    780,  690),
('S809','R103', 'ENABLED',  'ULTRASONIC',   510,  450),
('S810','R104', 'DISABLED', 'ULTRASONIC',   530, null),
('S811','R104', 'ENABLED',  'PRESSURE',      60,   50);


insert into controllers values
('U501','S801'),
('U501','S804'),
('U501','S806'),
('U502','S802'),
('U502','S804'),
('U503','S805'),
('U503','S806'),
('U501','S809'),
('U502','S810'),
('U503','S811'),
('U501','S807'),
('U503','S808'),
('U502','S801'),
('U501','S808');


--
-- Queries
-- Simple Queries
-- 1.	Fetch details of all the sensors which are disabled


-- 2.	List sensors which are having required value less than current value


-- 3.	List sensors which are of type TEMPERATURE and required value greater than 96. Sort on required value field.


-- 4.	List sensors which has no current values


-- 5.	List all sensors which are of type TEMPERATURE & PRESSURE.


-- 6.	List sensors with rtu_id 102 and sensor type pressure and required value greater than 30.



-- Single Row Functions
-- 1.	Write a query which will display username in upper case, role first letter capitalized and all other letters lower case and length of the username.


-- 2.	Display percentage of difference between req_value and curr_value as a whole number.


-- Group Functions
-- 1.	List how many sensors are present of type PRESSURE.


-- 2.	Display number of sensors enabled and disabled. Sort on number of sensors


-- 3.	List how many sensors are present in each sensor type.


-- 4.	List number of sensors under each RTU_ID.


-- 5.	Display how many sensors are controlled by each user. Exclude users who are controlling less than 3 sensors and also restrict users with id “U503”. Sort on user_id.



-- Joins
-- 1.	Display RTU details alongwith sensor details for all RTU's


-- 2.	Display user details and sensor details controlled by each user.


-- 3.	Display user details and sensor details controlled by each user alongwith RTU details.


-- 4.	List how many sensors are controlled by each user. Display user_name and count. Sort on count.


-- 5.	Display user details who are controlling sensor_type TEMPERATURE


-- 6.	Display user details that is controlling sensor S801 along with sensor details and location.



-- Sub-Queries
-- 1.	Display sensor details located in CHENNAI


-- 2.	Display user details controlling sensors in MUMBAI location


-- 3.	Display sensor details controlled by SMITHA


-- 4.	Display user details who are controlling sensors with id between S803 and S808


-- 5.	Display user details that are controlling most number of sensors.


-- 6.	Display RTU details which has most number of sensors.
