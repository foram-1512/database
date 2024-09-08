create database practise29_02;
use practise29_02;


create table tbl_department (
  dept_no bigint primary key,
  dept_name varchar(255) NOT NULL,
  created_at timestamp default current_timestamp,
  updated_at timestamp default current_timestamp on update current_timestamp,
  is_active tinyint default '1' COMMENT '1=active,2=inactive'
);

insert into tbl_department (dept_no, dept_name) values (10, 'Account');
insert into tbl_department (dept_no, dept_name) values (20, 'Loan');
insert into tbl_department (dept_no, dept_name) values (30, 'Service');
insert into tbl_department (dept_no, dept_name) values (40, 'Sales');
insert into tbl_department (dept_no, dept_name) values (50, 'Corporate');
insert into tbl_department (dept_no, dept_name) values (60, 'HR');
insert into tbl_department (dept_no, dept_name) values (70, 'Support');
select * from tbl_department;
select * from tbl_employee;



create table tbl_employee (
  id bigint primary key auto_increment,
  e_name varchar(128),
  street_address text,
  city varchar(62),
  phone_no varchar(16) unique,
  salary decimal(8,2),
  commission decimal(8,2),
  job enum('analysts','president','manager','salesman','clerks'),
  department_no bigint(8),
  hire_date date NOT NULL,
  company_name enum('First Bank Corporation','Axis bank','HDFC bank'),
  created_at timestamp default current_timestamp,
  updated_at timestamp default current_timestamp on update current_timestamp,
  is_active tinyint default '1' COMMENT '1=active,2=inactive',
  FOREIGN KEY (department_no) REFERENCES tbl_department(dept_no)
);

insert into tbl_employee (e_name, street_address, city, phone_no, salary, commission, job, department_no, hire_date, company_name) values 
('Abhi', '101 Ganesh Meredian', 'Ahmdabad', '9876543210', 2000, 15000, 'salesman', 10, '1980-12-21', 'First Bank Corporation');

insert into tbl_employee (e_name, street_address, city, phone_no, salary, commission, job, department_no, hire_date, company_name) values 
('Pathan', '1101 Ganesh Meredian', 'Ahmdabad', '9872331010', 2000, 0, 'manager', 10, '1980-12-21', 'First Bank Corporation');


insert into tbl_employee (e_name, street_address, city, phone_no, salary, commission, job, department_no, hire_date, company_name) values 
('Mayur', '201, Ganesh Meredian', 'Ahmdabad', '9876244410', 5000, 10000, 'clerks', 20, '1984-01-11', 'First Bank Corporation'),
('Abdul', '301, Ganesh Meredian', 'Ahmdabad', '3876543210', 4000, 12000, 'manager', 30, '1989-02-14', 'First Bank Corporation'),
('Sohail', '401, Ganesh Meredian', 'Ahmdabad', '4576543210', 1000, 400, 'salesman', 40, '1999-04-14', 'Axis bank'),
('Taylor', '501, Ganesh Meredian', 'Ahmdabad', '3875712210', 12000, 1000, 'president', 50, '1978-01-3', 'HDFC bank');

insert into tbl_employee (e_name, street_address, city, phone_no, salary, commission, job, department_no, hire_date, company_name) values 
('Bhavesh', '102 Shivalik Plaza', 'Surat', '8765432109', 3000, 10000, 'clerks', 20, '1981-01-15', 'First Bank Corporation');

insert into tbl_employee (e_name, street_address, city, phone_no, salary, commission, job, department_no, hire_date, company_name) values 
('Chetan', '103 Shyamal Cross Road', 'Rajkot', '7654321098', 4000, 12000, 'analysts', 30, '1982-02-10', 'Axis bank');

insert into tbl_employee (e_name, street_address, city, phone_no, salary, commission, job, department_no, hire_date, company_name) values 
('hiten', '103 Shyamal Cross Road', 'Rajkot', '7653321198', 4000, 12000, 'analysts', 20, '1982-02-10', 'Axis bank');

insert into tbl_employee (e_name, street_address, city, phone_no, salary, commission, job, department_no, hire_date, company_name) values 
('mitesh', '103 Shyamal Cross Road', 'Rajkot', '765432456', 14000, 12000, 'salesman', 20, '1992-03-10', 'HDFC bank');



insert into tbl_employee (e_name, street_address, city, phone_no, salary, commission, job, department_no, hire_date, company_name) values 
('Dhaval', '104 Satellite Road', 'Vadodara', '6543210987', 5000, 8000, 'manager', 40, '1983-03-05', 'Axis bank');

insert into tbl_employee (e_name, street_address, city, phone_no, salary, commission, job, department_no, hire_date, company_name) values 
('Ekta', '105 Prahlad Nagar', 'Ahmedabad', '5432109876', 6000, 9000, 'salesman', 10, '1984-04-01', 'First Bank Corporation');

insert into tbl_employee (e_name, street_address, city, phone_no, salary, commission, job, department_no, hire_date, company_name) values 
('Falguni', '106 Vastrapur Lake', 'Surat', '4321098765', 7000, 11000, 'clerks', 20, '1985-05-20', 'First Bank Corporation');
select * from tbl_employee;

insert into tbl_employee (e_name, street_address, city, phone_no, salary, commission, job, department_no, hire_date, company_name) values 
('Gaurav', '107 Navrangpura', 'Rajkot', '3210987654', 8000, 13000, 'analysts', 30, '1986-06-15', 'First Bank Corporation');

insert into tbl_employee (e_name, street_address, city, phone_no, salary, commission, job, department_no, hire_date, company_name) values 
('Harsh', '108 C G Road', 'Vadodara', '2109876543', 9000, 7000, 'manager', 40, '1987-07-10', 'HDFC bank');

insert into tbl_employee (e_name, street_address, city, phone_no, salary, commission, job, department_no, hire_date, company_name) values 
('Isha', '109 Maninagar', 'Ahmedabad', '1098765432', 10000, 14000, 'salesman', 10, '2002-08-05', 'First Bank Corporation');

insert into tbl_employee (e_name, street_address, city, phone_no, salary, commission, job, department_no, hire_date, company_name) values 
('Nisha', '119 Maninagar', 'Ahmedabad', '108765432', 10000, 14000, 'clerks', 10, '2002-08-05', 'First Bank Corporation');

insert into tbl_employee (e_name, street_address, city, phone_no, salary, commission, job, department_no, hire_date, company_name) values 
('Lisha', '10/9 Gota', 'Ahmedabad', '91/8765432', 10000, 14000, 'manager', 10, '2000-08-05', 'First Bank Corporation');



insert into tbl_employee (e_name, street_address, city, phone_no, salary, commission, job, department_no, hire_date, company_name) values 
('Jignesh', '110 Naranpura', 'Surat', '0987654321', 11000, 15000, 'clerks', 20, '2004-09-01', 'Axis bank');

insert into tbl_employee (e_name, street_address, city, phone_no, salary, commission, job, department_no, hire_date, company_name) values 
('Komal', '111 Paldi', 'Rajkot', '9873456660', 12000, 16000, 'analysts', 30, '2003-10-20', 'HDFC bank');
insert into tbl_employee (e_name, street_address, city, phone_no, salary, commission, job, department_no, hire_date, company_name) values 
('jalak', '111 Paldi', 'Mehsana', '4473456660', 12000, 16000, 'analysts', 30, '2003-10-20', 'First Bank Corporation');

insert into tbl_employee (e_name, street_address, city, phone_no, salary, commission, job, department_no, hire_date, company_name) values 
('palak', '111 Paldi', 'Mehsana', '4453456660', 18000, 16000, 'manager', 40, '2001-10-20', 'First Bank Corporation');

insert into tbl_employee (e_name, street_address, city, phone_no, salary, commission, job, department_no, hire_date, company_name) values 
('malay', '111 Paldi', 'Mehsana', '454758900', 1400, 4400, 'salesman', 30, '2001-10-20', 'First Bank Corporation');

insert into tbl_employee (e_name, street_address, city, phone_no, salary, commission, job, department_no, hire_date, company_name) values 
('Christopher Columbus', '2022 Paldi', 'Palanpur', '49178900', 1000, 0, 'analysts', 50, '2001-10-20', 'Axis bank');

insert into tbl_employee (e_name, street_address, city, phone_no, salary, commission, job, department_no, hire_date, company_name) values 
('Petter', '202 Paldi', 'Jamnagar', '569178900', 10000, 220, 'salesman', 30, '2024-10-20', 'First Bank Corporation');

select * from tbl_employee;


-- 1. Find the names, street address, and cities of residence for all employees who work
-- for'First Bank Corporation' and earn more than $10,000.
select e_name, street_address, city, company_name, salary from tbl_employee where salary>10000 and company_name = 'First Bank Corporation';


-- 2. Select the employees in department 30.
select * from tbl_employee where department_no = 30;

-- 3. List the names, numbers and departments of all clerks.
select e_name, phone_no, department_no, d.dept_name, job from tbl_employee e join tbl_department d on e.department_no = d.dept_no where job='clerks';

-- 4. Find the department numbers and names of employees of all departments with
-- deptno greater than 20.
select  d.dept_no, d.dept_name, e.e_name from tbl_department d join tbl_employee e on d.dept_no = e.department_no where dept_no > 20; 

-- 5. Find employees whose commission is greater than their salaries.
select * from tbl_employee where salary<commission;

-- 6. Find employees whose commission is greater than 60 % of their salaries.
select * from tbl_employee where salary<(commission*0.6);

-- 7. List name, job and salary of all employees in department 20 who earn more than
-- 2000/-.
select e_name, job, salary from tbl_employee where department_no = 20 and salary>2000;

-- 8. Find all salesmen in department 30 whose salary is greater than 1500/-.
select * from tbl_employee where department_no = 30 and salary >1100 and job = 'salesman';

-- 9. Find all employees whose designation is either manager or president.
select * from tbl_employee where job='president' or job='manager';

-- 10. Find all managers who are not in department 30.
select * from tbl_employee where job = 'manager' and department_no!=30 ;

-- 11. Find all the details of managers and clerks in dept 10.	
select * from tbl_employee where job in('manager', 'clerks') and department_no = 10;

-- 12. Find the details of all the managers (in any dept) and clerks in dept 20.
select * from tbl_employee where job='manager' or  (department_no=20 and job='clerks');

-- 13. Find the details of all the managers in dept. 10 and all clerks in dept 20 and all
-- employees who are neither managers nor clerks but whose salary is more than or
-- equal to 2000/-.
select * from tbl_employee where (job='manager' and department_no=10) or (job='clerks' and department_no=20) or (job!='manager' and job!='clerks' and salary>=2000);

-- 14. Find the names of anyone in dept. 20 who is neither manager nor clerk.
select * from tbl_employee where department_no=20 and (job !='manager' and job !='clerks');

-- 15. Find the names of employees who earn between 1200/- and 1400/-.
select * from tbl_employee where salary between 1200 and 1400;


-- 16. Find the employees who are clerks, analysts or salesmen.
select * from tbl_employee where job='clerks' or job='analysts' or job='salesman';
select * from tbl_employee where job!='manager' and job!='president';

-- 17. Find the employees who are not clerks, analysts or salesmen.
select * from tbl_employee where job!='clerks' and job!='analysts' and job!='salesman';

-- 18. Find the employees who do not receive commission.
select * from tbl_employee where commission =0;

-- 19. Find the different jobs of employees receiving commission.
select distinct job from tbl_employee where commission >0;

-- 20. Find the employees who do not receive commission or whose commission is less
-- than 100/-.
select * from tbl_employee where commission <100;

-- 21. If all the employees not receiving commission is entitles to a bonus of Rs. 250/-
-- show the net earnings of all the employees.
select *,
case commission
	when 0 then (salary+250)
end
as net_earnings
from tbl_employee;


-- 22. Find all the employees whose total earning is greater than 2000/
select * from tbl_employee where salary+commission>28000;

-- 23. Find all the employees whose name begins or ends with ‘M’
select *  from tbl_employee where e_name like'M%' or e_name like'%m';

-- 24. Find all the employees whose names contain the letter ‘M’ in any case.
select * from tbl_employee where e_name like '%M%' or e_name like '%m%';

-- 25. Find all the employees whose names are upto 15 character long and have letter
-- ‘R’ as 3rd character of their names.
select * from tbl_employee where length(e_name)>15 and e_name like '__r%';

-- 26. Find all the employees who were hired in the month of February (of any year).
select * from tbl_employee where month(hire_date) = 2;

-- 27. Find all the employees who were hired on last day of the month.
select * from tbl_employee where day(hire_date) = day(LAST_DAY(hire_date));


-- 28. Find all the employees who were hired more than 2 years ago.
select * from tbl_employee where hire_date < curdate() - interval 2 year;

-- 29. Find the managers hired in the year 2003.
select * from tbl_employee where job='manager'and year(hire_date)=2003;

-- 30. Display the names and jobs of all the employees separated by a space.
select concat(e_name, ' ', job) as name_and_job FROM tbl_employee;

-- 31. Display the names of all the employees right aligning them to 15 characters.
select lpad(e_name, 15, ' ') as name_with_padding from tbl_employee; 

-- 32. Display the names of all the employees padding them to the right up to 15
-- characters with ‘*’.
SELECT 
    RPAD(e_name, 15, '*') AS name_with_padding
FROM
    tbl_employee; 


-- 33. Display the names of all the employees without any leading ‘A’.
select trim(LEADING 'A' from e_name) from tbl_employee;

-- 34. Display the names of all the employees without any trailing ‘R’.
select trim(trailing 'r' from e_name) from tbl_employee;

-- 35. Show the first 3 and last 3 characters of the names of all the employees.
select substr(e_name, 1,3), right(e_name,3) as name from tbl_employee;

-- 36. Display the names of all the employees replacing ‘A’ with ‘a’.
select replace(e_name, 'a', 'A') as new_name from tbl_employee;

-- 37. Display the names of all the employees and position where the string ‘AR’
-- occurs in the name.
select e_name, locate('ar', e_name) as position FROM tbl_employee WHERE e_name LIKE '%ar%';

-- 38. Show the salary of all the employees , rounding it to the nearest Rs. 1000/-.
select e_name,salary,round(salary/1000)*1000 as rounded_salary from tbl_employee; 

-- 39. Display the names, jobs and salaries of employees, sorting on job and salary.
select e_name, job, salary from tbl_employee order by job,salary;

-- 40. Display the names, jobs and salaries of employees, sorting on descending order
-- of job and within job sorted on salary.
select e_name, job, salary from tbl_employee order by job desc;


-- 41. List the employee names, department names and salary for those employees who
-- have completed 1 year of service.

SELECT e_name,job, salary, year(from_days(datediff(created_at, hire_date)))=1 as experience, year(hire_date) as years from tbl_employee;  

-- 42. List the employee names, department names and hiredate for those employees
-- who have joined in 2003 . Sort your output in the order of joining date.
select e_name, job, hire_date, d.dept_name from tbl_employee e join tbl_department d on e.department_no=d.dept_no where year(hire_date)=2003 order by hire_date;

select * from tbl_employee;

