create database 01_03_2024;
use 01_03_2024;

create table tbl_user (
  id bigint primary key auto_increment,
  social_id varchar(256),
  name varchar(128) not null,
  email varchar(64) unique,
  password varchar(256),
  role enum('User'),
  profile_image varchar(128) default('demp1.jpg'),
  about text,
  login_type enum('S', 'G', 'F'),
  created_at timestamp default current_timestamp,
  updated_at timestamp default current_timestamp on update current_timestamp,
  is_active tinyint default '1' COMMENT '1=active,2=inactive'
);

insert into tbl_user (name, email, password, role, about, login_type) values
 ('Abhi', 'abhi@gmail.com','12345678', 'User', 'fxjhasdfsk', 'S'),
 ('Mayur', 'mayur@gmail.com', '12345678', 'User', 'fxjhasdfsk', 'G'),
 ('Dev', 'dev@gmail.com', '12345678', 'User', 'fxjhasdfsk', 'F'),
 ('Nisha', 'nisha@gmail.com', '12345678', 'User', 'fxjhasdfsk', 'S'),
 ('Jisha', 'jisha@gmail.com', '12345678', 'User', 'fxjhasdfsk', 'S'),
 ('Tisha', 'tisha@gmail.com', '12345678', 'User', 'fxjhasdfsk', 'G');
 
 create table tbl_place (
  id bigint primary key auto_increment,
  location varchar(128),
  latitude varchar(16),
  longtitude varchar(16),
  avg_rating float(5,1),
  user_id bigint,
  review_count varchar(16),
  about text,
  created_at timestamp default current_timestamp,
  updated_at timestamp default current_timestamp on update current_timestamp,
  is_active tinyint default '1' COMMENT '1=active,2=inactive',
  FOREIGN KEY (user_id) REFERENCES tbl_user(id)
);

insert into tbl_place (location, latitude, longtitude, avg_rating, user_id, review_count, about) values 
('San Diago', '32.706191', '-117.147406', '3.2', '1','0', 'dfghjkl;kjht');

insert into tbl_place (location, latitude, longtitude, avg_rating, user_id, review_count, about) values 
('North Park', '32.742093', '-117.127897', '4.2', '1','0', 'dfghjdfgdkl;kjht');

insert into tbl_place (location, latitude, longtitude, avg_rating, user_id, review_count, about) values 
('Los Angels', '33.969125', '-118.219132', '4.8', '1','0', 'dfghjdasdffgdkl;kjht');


insert into tbl_place (location, latitude, longtitude, avg_rating, user_id, review_count, about) values 
('Gota', '23.1071603', '72.5366876', '3.8', '1','0', 'dfghjdasdffgdklkjht');

insert into tbl_place (location, latitude, longtitude, avg_rating, user_id, review_count, about) values 
('Sarkhej', '22.980793', '72.493460', '4.1', '1','0', 'dfghjdasdffgdklkjht');




create table tbl_place_image(
id bigint primary key auto_increment,
place_id bigint,
image_name varchar(64),
created_at timestamp default current_timestamp,
updated_at timestamp default current_timestamp on update current_timestamp,
is_active tinyint default '1' COMMENT '1=active,2=inactive',
FOREIGN KEY (place_id) REFERENCES tbl_place(id)
);

insert into tbl_place_image (place_id, image_name) values 
(1, '2.jpg');
insert into tbl_place_image (place_id, image_name) values 
(1, '4.jpg');
insert into tbl_place_image (place_id, image_name) values 
(1, '6.jpg');

create table tbl_review(
	id bigint primary key auto_increment,
    place_id bigint,
    user_id bigint,
    review_description text,
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
	is_active tinyint default '1' COMMENT '1=active,2=inactive',
	FOREIGN KEY (place_id) REFERENCES tbl_place(id),
    FOREIGN KEY (user_id) REFERENCES tbl_user(id)
);


insert into tbl_review (place_id, user_id, review_description) values 
(1,1,'user1 place1 review'),
(1,2,'user2 place1 review'),
(1,3,'user3 place1 review'),
(2,1,'user1 place2 review'),
(2,2,'user2 place2 review'),
(2,3,'user3 place2 review'),
(3,1,'user1 place3 review'),
(3,2,'user2 place3 review'),
(3,3,'user3 place3 review');


-- 1. login query 1
select * from tbl_user where email='abhi@gmail.com' and password='12345678' and is_active=1;

-- forgot password 2
select * from tbl_user where email='abhi@gmail.com';
update tbl_user set password='abhi1234' where email='abhi@gmail.com' and is_active=1;




-- 2. query for displaying user profile 3
select p.id,u.id as user_id, u.name, u.profile_image, u.about, p.location  from tbl_user u join tbl_place p on u.id=p.user_id where u.id=1;


-- 3. query for finding distance, in km, miles and meter 4
select *,
ROUND(
		(3959 * acos( cos( radians('23.0759779') ) 
		* cos( radians (p.latitude) )
        * cos( radians (p.longtitude) - radians('72.5265198'))
        + sin( radians('23.0759779'))
        * sin( radians (p.latitude) ) ) )) as Distance_in_miles
from tbl_place p;


select *,
floor(
		(6371 * acos( cos( radians('23.0759779') ) 
		* cos( radians (p.latitude) )
        * cos( radians (p.longtitude) - radians('72.5265198'))
        + sin( radians('23.0759779'))
        * sin( radians (p.latitude) ) ) )) as Distance
from tbl_place p where p.location like 'g%' having distance<5;

select *,
ROUND(
		(6371000 * acos( cos( radians('23.0759779') ) 
		* cos( radians (p.latitude) )
        * cos( radians (p.longtitude) - radians('72.5265198'))
        + sin( radians('23.0759779'))
        * sin( radians (p.latitude) ) ) )) as Distance_in_meter
from tbl_place p;

select *,
ROUND(
		(637100000 * acos( cos( radians('23.0759779') ) 
		* cos( radians (p.latitude) )
        * cos( radians (p.longtitude) - radians('72.5265198'))
        + sin( radians('23.0759779'))
        * sin( radians (p.latitude) ) ) )) as Distance_in_centimeter
from tbl_place p;

        
        
select * from tbl_place;
        
-- 4. query for displaying reviews 8
select u.id, u.profile_image, u.name, r.review_description, date_format(r.created_at,'%d %b %Y %h:%i %p') as review_added from tbl_user u join tbl_review r on u.id=r.user_id where place_id=2;

-- 5 details 9
select p.location, count(r.id) as total_rating, group_concat(pi.image_name) as all_image ,p.avg_rating, p.about from tbl_place p 
join tbl_place_image pi on p.id = pi.place_id
join tbl_review r on p.id = r.place_id
where p.id=1 group by pi.image_name ;





SELECT 
    p.location, 
    COUNT(r.id) AS total_rating, 
    GROUP_CONCAT(pi.image_name) AS all_image,
    p.avg_rating,
    p.about
FROM 
    tbl_place p 
JOIN 
    tbl_place_image pi ON p.id = pi.place_id
LEFT JOIN 
    tbl_review r ON p.id = r.place_id
WHERE 
    p.id = 1 
GROUP BY 
    pi.image_name;






select p.location, count(r.id) as total_rating, group_concat(pi.image_name) as all_image ,p.avg_rating, p.about from tbl_place p 
join tbl_place_image pi on pi.image_name = pi.image_name
join tbl_review r on p.id = r.place_id
where p.id=1;