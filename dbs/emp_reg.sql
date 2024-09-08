create database employee;
use employee;

create table tbl_user(
	id bigint AUTO_INCREMENT PRIMARY KEY,
    fname varchar(128),
    lname varchar(128),
    email varchar(128),
    gender enum('male','female'),
    password text,
    role enum('normal', 'admin'),
	is_active boolean default '1' COMMENT '1=active,0=deactive',
    is_delete boolean default '0' comment '1=delete 0=not_delete',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp
);

select * from tbl_user limit  OFFSET 0;


select * from tbl_user where (is_active=1 and is_delete=0) and (fname like lower('%%') or lname like lower('%%') or email like lower('%%') or gender like lower('%%') or role like lower('%%')) limit 5 offset 0;