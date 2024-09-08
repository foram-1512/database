create database db_school_management;
use db_school_management;
drop database db_school_management;

create table tbl_user (
	id bigint PRIMARY KEY AUTO_INCREMENT,
    name varchar(128),
    email varchar(128),
    country_code varchar(128) DEFAULT '+91',
    phone BIGINT(12),
    password text,
    image varchar(128),
    role enum('Student') DEFAULT 'Student',
    latitude varchar(16),
    longtitude varchar(16),
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
	is_active boolean default '1' COMMENT '1=active,0=inactive'
);
insert into tbl_user(name, email, phone, password, image, latitude, longtitude) values 
('mayur', 'mayur@gmail.com', '9876543210', 'mayur123', 'mayur.jpg', '23.0752323', '72.5231027'),
('Abhi', 'abhi@gmail.com', '9876543311', 'abhi123', 'abhi.jpg', '23.2281517','72.4609524'),
('Folam', 'foram@gmail.com', '98213543210', 'foram123', 'foram.jpg','22.6958742','72.7807841');


create table tbl_course (
	id bigint PRIMARY key AUTO_INCREMENT,
    name varchar(128),
    image varchar(128),
    max_student int,
    start_date date,
    end_date date,
    price float(8,2),
    description text,
    enroll_student int,
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
	is_active boolean default '1' COMMENT '1=active,0=inactive'
);

insert  into tbl_course ( name, image, max_student, start_date, end_date, price, description) values 
('HTML', 'html.jpg', 10, '2024-03-1', '2024-03-10', 200, 'lorem ipsum'),
('JS', 'Js.jpg', 15, '2024-02-25', '2024-03-05', 200, 'lorem ipsum'),
('DBMS', 'DBMS.jpg', 5, '2024-02-20', '2024-03-1', 200, 'lorem ipsum');



create TABLE tbl_enroll_student(
	id bigint primary key AUTO_INCREMENT,
    student_id  bigint,
    course_id BIGINT,
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
	is_active boolean default '1' COMMENT '1=active,0=inactive',
    foreign key(student_id)references tbl_user(id),
    foreign key(course_id)references tbl_course(id)
);





create table tbl_lesson(
	id BIGINT primary KEY AUTO_INCREMENT,
    course_id BIGINT,
    name varchar(128),
    media varchar(128),
    description text,
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
	is_active boolean default '1' COMMENT '1=active,0=inactive',
    foreign key(course_id)references tbl_course(id)
);


insert into  tbl_lesson(course_id, name, media, description) values 
(1, 'lesson1', 'html.mp4', 'Lorem ipsum lorem'),
(1, 'lesson2', 'html.mp4', 'Lorem ipsum lorem'),
(1, 'lesson3', 'html.mp4', 'Lorem ipsum lorem'),
(1, 'lesson4', 'html.mp4', 'Lorem ipsum lorem'),
(1, 'lesson5', 'js.mp4', 'Lorem ipsum lorem'),
(2, 'lesson1', 'js.mp4', 'Lorem ipsum lorem'),
(2, 'lesson2', 'js.mp4', 'Lorem ipsum lorem'),
(2, 'lesson3', 'js.mp4', 'Lorem ipsum lorem'),
(2, 'lesson4', 'js.mp4', 'Lorem ipsum lorem'),
(2, 'lesson5', 'js.mp4', 'Lorem ipsum lorem'),
(3, 'lesson1', 'DBMS.mp4', 'Lorem ipsum lorem'),
(3, 'lesson2', 'DBMS.mp4', 'Lorem ipsum lorem'),
(3, 'lesson3', 'DBMS.mp4', 'Lorem ipsum lorem'),
(3, 'lesson4', 'DBMS.mp4', 'Lorem ipsum lorem'),
(3, 'lesson5', 'DBMS.mp4', 'Lorem ipsum lorem');


-- course display

select *, datediff(end_date,start_date) as duration from tbl_course;

-- particular course display

select * from tbl_course 
where id=1;


select * from tbl_lesson where course_id=1;
select *,count(id) from tbl_lesson where course_id=1;



