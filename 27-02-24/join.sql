create database joinTask;
use joinTask;
create table tbl_department(
id bigint(20) primary key not null auto_increment,
department varchar(16),
is_active boolean default '1' COMMENT '1=active, 0=inactive',
is_delete boolean default '0' Comment '1=deleted, 0=non-deleted',
created_at  timestamp default current_timestamp,
updated_at timestamp default current_timestamp on update current_timestamp
);
create table TBLWorker(
id bigint(20) primary key not null auto_increment,
first_name  varchar(20),
last_name varchar(20),
salary int,
joining_date datetime, 
department_id bigint(20), 
is_active boolean default '1' COMMENT '1=active, 0=inactive',
is_delete boolean default '0' Comment '1=deleted, 0=non-deleted',
created_at  timestamp default current_timestamp,
updated_at timestamp default current_timestamp on update current_timestamp,
foreign key (department_id) references tbl_department(id)
);

create table tbl_worker_rating(
id bigint(20) primary key not null auto_increment,
worker_id bigint(20),
rating int,
is_active boolean default '1' COMMENT '1=active, 0=inactive',
is_delete boolean default '0' Comment '1=deleted, 0=non-deleted',
created_at  timestamp default current_timestamp,
updated_at timestamp default current_timestamp on update current_timestamp,
foreign key (worker_id) references TBLWorker(id)
);

insert into tbl_department (department) values('HR'),('Admin'),('Account'),('Sales');

insert into TBLWorker (first_name,last_name,salary,joining_date,department_id) values
('monika','arora','100000','2014-02-20 09:00:00',1),
('Niharika','Verma','80000','2014-06-11 09:00:00',2),
('Vishal','Singhal','300000','2014-02-20 09:00:00',1),
('Amitabh','Singh','500000','2014-02-20 09:00:00',2),
('Vivek','Bhati','500000','2014-06-11 09:00:00',2),
('Vipul','Diwan','200000','2014-06-11 09:00:00',3),
('Satish','Kumar','75000','2014-01-20 09:00:00',4),
('Geetika','Chauhan','90000','2014-04-11 09:00:00',2);


insert into  tbl_worker_rating (worker_id,rating) value(1,3),(1,2),(2,4),(3,5),(4,2),(2,1),(1,3),(5,2);

-- Q1. Write an SQL query to fetch worker details with department name.
select w. *, department from TBLWorker w join tbl_department d  on w.department_id= d.id;
-- Q2. Write an SQL query to fetch the department-wise highest salary record
select d.*, MAX(salary) from tbl_department d join TBLWorker w  on w.department_id= d.id group  by d.id;
-- Q3. Write an SQL query to fetch the average rating with worker details.
select w.*, avg(rating) from TBLWorker w join tbl_worker_rating r on w.id= r.id group  by r.rating;
-- Q4. Write an SQL query to fetch the average rating with worker details whose rating is greater than or equal to 4
select w.*, avg(rating) from TBLWorker w join tbl_worker_rating r on w.id= r.id where rating >= 4 group  by r.id; 
-- Q5. Write an SQL query to fetch the Department wise worker count.
select d.*, count(first_name) as worker from tbl_department d join TBLWorker w  on w.department_id= d.id group  by d.id;
-- Q6. Write an SQL query to fetch data whose joining in the month of February
 select w.*,joining_date from TBLWorker w where month(joining_date)=2;
-- Q7. Write an SQL query to fetch data on who joined in 2014-02.
 select w.*,joining_date from TBLWorker w where month(joining_date)=2 AND year(joining_date)=2014;
-- Q8. Write an SQL query to find the experience of workers from the joining date.
 select id,first_name,year(from_days(datediff(created_at,joining_date)))as experience from TBLWorker;
-- Q9. Write an SQL query to display the joining date in the format of eg. 21-feb-2014
 select id,first_name,DATE_FORMAT(JOINING_DATE,"%d-%b-%Y")from TBLWorker;
-- Q10. Write an SQL query to get the count of workers joining year wise
select year(joining_date)as join_year,count(*)as total_worker from TBLWorker group by year(joining_date);
-- Q11. Write an SQL query to display workers who earn more than the average salary in that company
 select id,first_name,salary from TBLWorker where salary > (select avg(salary) as averageSalary from TBLWorker);
-- Q12. Write a SQL query to display the 5 highest earning workers
 select id,first_name,salary from TBLWorker order by  salary desc limit 5;
-- Q13. Find the workers hired in the 80s means (1980 to 1989)
 select id,first_name,salary from TBLWorker where year(joining_date) between 1980 and 1989;
-- Q14. Find the workers who joined the company after the 15th date.
 select id,first_name,joining_date from TBLWorker  where extract(day from joining_date)>15;

