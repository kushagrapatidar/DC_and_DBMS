
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
foreign key (rtu_id) references rtu(rtu_id)  on delete set null
);
-- drop table sensors;

create table controllers(
user_id varchar(10) not null,
sensor_id varchar(10) not null,
primary key (user_id,sensor_id),
foreign key (user_id) references users(user_id),
foreign key (sensor_id) references sensors(sensor_id) on delete cascade
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
select * 
from sensors 
where sensor_status='DISABLED';

-- 2.	List sensors which are having required value less than current value
select * 
from sensors 
where req_val<curr_val;

-- 3.	List sensors which are of type TEMPERATURE and required value greater than 96. Sort on required value field.
select * 
from sensors 
where sensor_type='TEMPERATURE';

-- 4.	List sensors which has no current values
select * 
from sensors 
where isnull(curr_val);

-- 5.	List all sensors which are of type TEMPERATURE & PRESSURE.
select * 
from sensors 
where sensor_type='TEMPERATURE' or sensor_type='PRESSURE';

-- 6.	List sensors with rtu_id 102 and sensor type pressure and required value greater than 30.
select * 
from sensors 
where rtu_id='R102' and sensor_type='PRESSURE' and req_val>30;


-- Single Row Functions
-- 1.	Write a query which will display username in upper case, role first letter capitalized and all other letters lower case and length of the username.
select UPPER(user_name) as upper_username,CONCAT(UPPER(SUBSTRING(user_name,1,1)),LOWER(SUBSTRING(user_name,2,LENGTH(user_name)))) as init_cap_username,LENGTH(user_name) as length_username 
from users;

-- 2.	Display percentage of difference between req_value and curr_value as a whole number.
select ROUND(ABS(((curr_val-req_val)/curr_val)*100)) as percentage_difference 
from sensors;

-- Group Functions
-- 1.	List how many sensors are present of type PRESSURE.
select count(*) as pressure_sensorcount
from sensors
group by sensor_type
having sensor_type='PRESSURE';

-- 2.	Display number of sensors enabled and disabled. Sort on number of sensors
select sensor_status, count(*) as status_count
from sensors
group by sensor_status
order by status_count;

-- 3.	List how many sensors are present in each sensor type.
select sensor_type, count(*) as type_count
from sensors
group by sensor_type
order by type_count;

-- 4.	List number of sensors under each RTU_ID.
select rtu_id, count(*) as sensor_count
from sensors
group by rtu_id
order by rtu_id;

-- 5.	Display how many sensors are controlled by each user. Exclude users who are controlling less than 3 sensors and also restrict users with id “U503”. Sort on user_id.
select user_id, count(*) as sensor_count
from controllers
group by user_id
having sensor_count>=3 and user_id!='U503'
order by user_id;


-- Joins
-- 1.	Display RTU details alongwith sensor details for all RTU's
select *
from rtu
left join sensors
using (rtu_id)
order by rtu_id;

-- 2.	Display user details and sensor details controlled by each user.
select cntlr.user_id, user_name, user_role, cntlr.sensor_id, sensor_type, sensor_status, req_val, curr_val, rtu_id
from controllers as cntlr
right join users using (user_id)
left join sensors using (sensor_id)
order by user_id;

-- 3.	Display user details and sensor details controlled by each user alongwith RTU details.
select cntlr.user_id, user_name, user_role, cntlr.sensor_id, sensor_type, sensor_status, req_val, curr_val, rtu_id, location, ip_address
from controllers as cntlr
join users using (user_id)
join sensors using (sensor_id)
join rtu using (rtu_id)
order by user_id;

-- 4.	List how many sensors are controlled by each user. Display user_name and count. Sort on count.
select user_name, count(*) as sensor_count
from controllers
right join users using (user_id)
group by user_name
order by sensor_count;

-- 5.	Display user details who are controlling sensor_type TEMPERATURE
select users.*, sensor_id
from controllers
right join users using (user_id)
left join sensors using (sensor_id)
where sensor_type ='TEMPERATURE'
order by user_id;

-- 6.	Display user details that is controlling sensor S801 along with sensor details and location.
select cntlr.user_id, user_name, user_role, cntlr.sensor_id, sensor_type, sensor_status, req_val, curr_val, rtu_id, location, ip_address
from controllers as cntlr
join users using (user_id)
join sensors using (sensor_id)
join rtu using (rtu_id)
where sensor_id='S801'
order by user_id;


-- Sub-Queries
-- 1.	Display sensor details located in CHENNAI
select *
from sensors
where rtu_id in (select rtu_id from rtu where location='CHENNAI')
order by sensor_id;

-- 2.	Display user details controlling sensors in MUMBAI location
select *
from users 
where user_id in (select user_id 
					from controllers
					where sensor_id in (select sensor_id
											from sensors 
                                            where rtu_id in (select rtu_id
																from rtu 
                                                                where location='MUMBAI')));

-- 3.	Display sensor details controlled by SMITHA
select * 
from sensors
where sensor_id in (select sensor_id 
						from controllers
                        where user_id in (select user_id 
											from users
                                            where user_name='SMITHA'));

-- 4.	Display user details who are controlling sensors with id between S803 and S808
select users.*,fltrd_ctlrs.sensor_id
from users, (select *
					from controllers
					where sensor_id between 'S803' and 'S808') as fltrd_ctlrs
where users.user_id=fltrd_ctlrs.user_id
order by fltrd_ctlrs.sensor_id;

-- 5.	Display user details that are controlling most number of sensors.
select users.*, max_sensor_user.user_sensor_count 
from users, (select user_id, count(*) as user_sensor_count
					from controllers
					group by user_id
					having user_sensor_count =(select max(sensor_count) 
										from (select count(*) as sensor_count 
												from controllers 
                                                group by user_id) as max_sensor_count)) as max_sensor_user
where users.user_id = max_sensor_user.user_id;


-- 6.	Display RTU details which has most number of sensors.
select rtu.*, max_sensor_rtu.rtu_sensor_count 
from rtu, (select rtu_id, count(*) as rtu_sensor_count 
			from sensors 
            group by rtu_id 
            having rtu_sensor_count=(select max(sensor_count) 
										from (select count(*) as sensor_count 
												from sensors 
                                                group by rtu_id) as sensor_counts)) as max_sensor_rtu
where rtu.rtu_id=max_sensor_rtu.rtu_id;