create database practise5;
use practise5;

create table department(
	id bigint auto_increment primary key,
    department enum('HR', 'Admin', 'Account', 'Sales'),
	is_active boolean default '1' comment'1 -> for is active, 2-> for deactive',
    created_at timestamp default current_timestamp,
    update_at timestamp default current_timestamp on update current_timestamp
);

create table worker(
	worker_id bigint auto_increment primary key,
    first_name varchar(16),
    last_name varchar(16),
    salary float,
    joining_date datetime,
    department_id bigint,
    is_active boolean default '1' comment'1 -> for is active, 2-> for deactive',
    created_at timestamp default current_timestamp,
    update_at timestamp default current_timestamp on update current_timestamp,
	foreign key (department_id) references department(id)
);


create table worker_rating(
	id bigint auto_increment primary key,
    worker_id bigint,
    rating int,
	is_active boolean default '1' comment'1 -> for is active, 2-> for deactive',
    created_at timestamp default current_timestamp,
    update_at timestamp default current_timestamp on update current_timestamp,
	foreign key (worker_id) references worker(worker_id)
);

insert into department (department) values(
	'HR'
);

insert into department (department) values(
	'Admin'
);
insert into department (department) values(
	'Account'
);
insert into department (department) values(
	'Sales'
);


insert into worker (first_name, last_name, salary, joining_date, department_id) values
	('Monika', 'Arora', 100000, '1982-02-20 09:00:00', 1),
    ('Niharika', 'Verma', 80000, '2014-06-11 09:00:00', 2)
;



insert into worker (first_name, last_name, salary, joining_date, department_id) values
	('Vishal', 'Singhal', 300000, '2015-02-20 09:00:00', 1),
    ('Amitabh', 'Singh', 500000, '2014-02-20 09:00:00', 2),
    ('Vivek', 'Bhati', 500000, '2016-06-11 09:00:00', 2),
    ('Vipul', 'Diwan', 200000, '2014-06-11 09:00:00', 3),
    ('Satish', 'Kumar', 75000, '1985-01-20 09:00:00', 4),
    ('Geetika', 'Chauhan', 90000, '1988-04-11 09:00:00', 2)
;


insert into worker_rating (worker_id, rating) values
(1, 3),
(1, 2),
(2, 4),	
(3, 5),
(4, 2),		
(2, 1),	
(1, 3),	
(5, 2);	

-- Q-1. Write an SQL query to fetch worker details with department name.
select w.*, department from worker w join department d on w.department_id = d.id;


-- Q-2. Write an SQL query to fetch the department-wise highest salary record
select w.first_name, max(salary) as highest_salary, department from worker w join department d on w.department_id = d.id group by d.id;

-- Q-3. Write an SQL query to fetch the average rating with worker details.
select w.*,avg(rating) as Average_rating from worker w join worker_rating r on r.id=w.worker_id group by r.worker_id;

-- Q-4. Write an SQL query to fetch the average rating with worker details whose rating is greater than or equal to 4
select w.*,avg(rating)<=4 as Average_rating from worker w join worker_rating r on r.id=w.worker_id group by r.worker_id;


-- Q-5. Write an SQL query to fetch the Department wise worker count.
select d.department, count(w.worker_id) as Total_worker from worker w join department d on w.department_id = d.id group by w.department_id;

-- Q-6. Write an SQL query to fetch data whose joining in the month of February 
select * from worker where month(joining_date)=2;

-- Q-7. Write an SQL query to fetch data on who joined in 2014-02.
select * from worker where year(joining_date)=2014 and month(joining_date)=2;



-- Q-8. Write an SQL query to find the experience of workers from the joining date.
SELECT worker_id,first_name, year(from_days(datediff(created_at, joining_date))) as experience from worker;  

-- Q-9. Write an SQL query to display the joining date in the format of eg. 21-feb-2014
select * ,date_format(joining_date, '%d %m %Y') as formated_date from worker;


-- Q10. Write an SQL query to get the count of workers joining year wise
select worker_id,first_name, year(joining_date) as joining_year, count(worker_id) as total from worker group by year((joining_date));


-- Q11. Write an SQL query to display workers who earn more than the average salary in that company
select worker_id,first_name, salary from worker where salary >(select avg(salary) from worker);

-- Q12. Write a SQL query to display the 5 highest earning workers
select * from worker order by salary desc limit 5;

-- Q13. Find the workers hired in the 80s means (1980 to 1989)
select * from worker where year(joining_date) between 1980 and 1989;

-- Q14. Find the workers who joined the company after the 15th date.
select *  from worker where day(joining_date) > 15;

 
select * from worker;
select * from worker_rating;
