create Database showcasetrigger;

use showcasetrigger;

create table tbl_user(
id bigint(20) primary key auto_increment,
user_name varchar(128),
social_id varchar(64),
login_type enum('S','F','G','A') comment 'F = Facebook G = Google S = signup A = Apple_id',
gender enum('male','female'),
Email varchar(128) unique,
password varchar(128),
fav_Activity text,
role enum ('user'),
is_active tinyint(1) default 1 comment '1=Active 0= Inactive', 
created_at timestamp default current_timestamp,
updated_at timestamp default current_timestamp on update current_timestamp);

create table tbl_post_like(
id bigint primary key auto_increment,
user_id bigint,
post_id bigint,
is_active tinyint(1) default 1 comment '1=Active 0= Inactive', 
created_at timestamp default current_timestamp,
foreign key (user_id)references tbl_user(id),
foreign key (post_id)references tbl_post(id)
);

create table tbl_post_comment(
id bigint primary key auto_increment,
user_id bigint,
post_id bigint,
comments text,
is_active tinyint(1) default 1 comment '1=Active 0= Inactive', 
created_at timestamp default current_timestamp,
updated_at timestamp default current_timestamp on update current_timestamp,
foreign key (user_id)references tbl_user(id),
foreign key (post_id)references tbl_post(id)
);

create table tbl_post(
id bigint primary key auto_increment,
user_id bigint,
Add_post enum('image','video') ,
title text,
painting_type enum('landscape','portrait'),
Medium enum('glass paint','Acrylic'),
style enum('glass paint','Acrylic'),
sale double(8,2),
location text,
description text,
is_active tinyint(1) default 1 comment '1=Active 0= Inactive', 
created_at timestamp default current_timestamp,
updated_at timestamp default current_timestamp on update current_timestamp,
foreign key(user_id) references tbl_user(id)
);

create table tbl_event(
id bigint primary key auto_increment,
user_id bigint,
title text,
painting_type enum('landscape','portrait'),
Medium enum('glass paint','Acrylic'),
style enum('glass paint','Acrylic'),
sale double(8,2),
location text,
description text,
start_date date,
end_date date,
is_active tinyint(1) default 1 comment '1=Active 0= Inactive', 
created_at timestamp default current_timestamp,
updated_at timestamp default current_timestamp on update current_timestamp,
foreign key(user_id) references tbl_user(id)
);

create table tbl_event_image(
id bigint primary key auto_increment,
event_id bigint(20),
imag_desc varchar(128),
is_active tinyint(1) default 1 comment '1=Active 0= Inactive', 
created_at timestamp default current_timestamp,
updated_at timestamp default current_timestamp on update current_timestamp,
foreign key (event_id)references tbl_event(id)
);



-- 1. signup
-- insert query 
insert into tbl_user(user_name,social_id,login_type,gender,email,password,fav_Activity,role) values
('Foram','for@m','f','Female','foram@gmail.com','1512','designer','user');

-- 2 login with simple_user
select * from tbl_user where login_type='s' and is_active=1;

-- 3 login with Apple_id_user
select * from tbl_user where login_type='A' and is_active=1;

-- 4 login with facebook
select * from tbl_user where login_type='f' and is_active=1;

-- 5 login with goggle
select * from tbl_user where login_type='g' and is_active=1;

-- 6. login
select * from tbl_user where email='pforam056@gmail.com' and password='2001' and is_active=1;

-- 7 forget password
update tbl_user set password='1512' where email='pforam056@gmail.com';

-- 8.for user_name,user_image,sale,location,description   In Home Page
-- create account details for the user
select u.user_name,u.user_img,e.sale,e.location,e.description  from tbl_user u join tbl_event e on e.user_id = u.id;

-- 9.another page add the information in to the active user   
select u.user_img,e.description,date_format(e.start_date,'%d %b %Y'),date_format(e.end_date,'%d %b %Y'),e.location from tbl_user u join tbl_event e on e.user_id= u.id;

-- 10. create account details for user
select u.user_img,u.user_name,e.sale,e.location,e.description  from tbl_user u join tbl_event e on e.user_id = u.id;

-- 11.post listingactive user information
select u.user_img,e.description,date_format(e.start_date,'%d %b %Y'),date_format(e.end_date,'%d %b %Y'),e.location from tbl_user u join tbl_event e on e.user_id= u.id;

-- 12. event listing calender format
select e.title, date_format(e.start_date, '%d %b %Y') as start_date, date_format(e.end_date, '%d %b %Y') as end_date, e.location, e.description from tbl_event e join tbl_event_image ei on ei.event_id= e.id where e.id=1;
  
-- 13 Add event 
insert into tbl_event set 
title='lorem10', 
painting_type='portrait', 
medium='glass paint', 
style='Acrylic',
sale=7000.00, 
location='baroda', 
description='lorem12 lorem123', 
start_date='2024-03-05', 
end_date='2024-03-15';

-- 14 .my event's list :-
select  *, (select count(id) as total_event from tbl_event where date('2024-03-1') between start_date and end_date) as total_events from tbl_event where date('2024-03-1') between start_date and end_date group by id;

-- trigger queries

-- 1.comment_count_insert
update tbl_post p set comment_count=
(SELECT COUNT(c.user_id) from tbl_post_comment c WHERE c.post_id=NEW.post_id) 
WHERE p.id = NEW.post_id;

-- 2.comment_count_delete
update tbl_post p set comment_count=
(SELECT COUNT(c.user_id) from tbl_post_comment c WHERE c.post_id=OLD.post_id) 
WHERE p.id = OLD.post_id;

-- 3.like_insert
update tbl_post p set like_count =
(select count(pl.user_id) from tbl_post_like pl where pl.post_id=new.post_id)
where p.id=new.post_id;

-- 4.like delete
update tbl_post p set like_count =
(select count(pl.user_id) from tbl_post_like pl where pl.post_id=old.post_id)
where p.id=old.post_id
 



