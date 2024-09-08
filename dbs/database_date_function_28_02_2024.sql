-- Q1 Sample current date : 2014-09-03
-- Expected result : 2014-06-01
SELECT DATE_FORMAT(CURDATE(), '%Y-%m-01') as formated_date;

-- 2. Write a query to display the last day of the month (in datetime format) three months before the current month.
SELECT lAST_DAY(DATE_FORMAT(SUBDATE(CURDATE(), INTERVAL 3 MONTH),'%Y-%m-01')) as formated_date;

-- 3. Write a query to get the distinct Mondays from hire_date in employees tables.
select * from worker where date_format(joining_date, '%W')='Wednesday';

-- 4. Write a query to get the first day of the current year.
select makedate(extract(year from curdate()),1);

-- 5. Write a query to get the last day of the current year.
select makedate(extract(year from curdate()),366);

-- 6. Write a query to calculate the age in year.
SELECT  year(from_days(datediff(created_at, '2002-04-14'))) as AGE from worker group by AGE;



-- 7. Write a query to get the current date in the following format.
-- Sample date : 2014-09-04
-- Output : September 4, 2014

SELECT DATE_FORMAT('2014-09-04', '%M %d, %Y') as formated_date;


-- 8. Write a query to get the current date in Thursday September 2014 format.
-- Thursday September 2014 
SELECT DATE_FORMAT('2014-09-04', '%W %M %d, %Y') as formated_date;

-- 9. Write a query to extract the year from the current date
select year(curdate()) as extracted_year;

-- 10. Write a query to get the DATE value from a given day (number in N).
-- Sample days: 730677
-- Output : 2000-07-11
select from_days(730677);

-- 11. Write a query to get the first name and hire date from employees table where hire date between '1987-06-01' and '1987-07-30'



-- 12. Write a query to display the current date in the following format.
-- Sample output: Thursday 4th September 2014 00:00:00 
select  date_format(current_timestamp(), '%W %D %M %Y %T');

-- 13. Write a query to display the current date in the following format.
-- Sample output: 05/09/2014
select  date_format(current_timestamp(), '%d/%m/%Y') as formated_date;

-- 14. Write a query to display the current date in the following format.
-- Sample output: 12:00 AM Sep 5, 2014
select  date_format(current_timestamp(), '0%l:%i  %p  %b  %d, %Y') as formated_date;


-- 15. Write a query to get the firstname, lastname who joined in the month of June.
select first_name, last_name, month(joining_date) as joining_month from worker where month(joining_date)=6;

-- 16. Write a query to get the years in which more than 10 employees joined.
select year(joining_date), count(year(joining_date)) as year_of_join from worker group by joining_date having count(year(joining_date))>1;

-- 17. Write a query to get first name of employees who joined in 1987.
select first_name, year(joining_date)as year_of_joining from worker where year(joining_date)=1982;


-- 18. Write a query to get department name, manager name, and salary of the manager for all managers whose experience is more than 5 years.
SELECT w.worker_id,w.first_name, d.department, year(from_days(datediff(w.created_at, w.joining_date))) as experience_in_years 
from worker w join department d on w.department_id=d.id group by w.worker_id having experience_in_years>10;  


-- 19. Write a query to get employee ID, last name, and date of first salary of the employees.
select worker_id, first_name, last_name, LAST_DAY(date(joining_date)) as first_salary_date, joining_date from  worker;  

--  20. Write a query to get first name, hire date and experience of the employees.
SELECT worker_id,first_name, date(joining_date) as hire_date,year(from_days(datediff(created_at, joining_date))) as experience from worker;  

-- 21. Write a query to get the department ID, year, and number of employees joined. 
select d.id as department_id, w.first_name, d.department as department_name, year(joining_date) as joining_year, count(year(joining_date)) as number_of_employee_joined
from worker w join department d on w.department_id=d.id group by year(joining_date);

select * from worker;
select * from department;
