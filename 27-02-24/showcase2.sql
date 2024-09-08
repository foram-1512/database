create database show_case2;
use show_case2;

create table tbl_user(
id bigint(20) primary key auto_increment,
social_id varchar(256),
name varchar(128),
email varchar(64) unique,
password varchar(128),
profile_image varchar(64),
about text,
role enum ("user"),
login_type enum ("S","F","G") comment 'S- sign up & F - Facebook & G - Google',
is_active boolean default '1' COMMENT '1=active, 0=inactive',
is_delete boolean default '0' Comment '1=deleted, 0=non-deleted',
created_at  timestamp default current_timestamp,
updated_at timestamp default current_timestamp on update current_timestamp
);


create table tbl_place(
id bigint(20) primary key auto_increment,
user_id bigint(20),
location text,
lattitude varchar(16),
longitude varchar(16),
about_place text,
avg_rating float(5,1),
review_count int,
is_active boolean default '1' COMMENT '1=active, 0=inactive',
is_delete boolean default '0' Comment '1=deleted, 0=non-deleted',
created_at  timestamp default current_timestamp,
updated_at timestamp default current_timestamp on update current_timestamp,
foreign key(user_id) references tbl_user(id)
);


create table tbl_place_image(
id bigint(20) primary key auto_increment,
place_id bigint(20),
image_name varchar (64),
is_active boolean default '1' COMMENT '1=active, 0=inactive',
is_delete boolean default '0' Comment '1=deleted, 0=non-deleted',
created_at  timestamp default current_timestamp,
updated_at timestamp default current_timestamp on update current_timestamp,
foreign key(place_id) references tbl_place(id)
);

create table tbl_review(
id bigint(20) primary key auto_increment,
user_id bigint(20),
place_id bigint(20),
rating float(5,1),
review_desc varchar(64),
is_active boolean default '1' COMMENT '1=active, 0=inactive',
is_delete boolean default '0' Comment '1=deleted, 0=non-deleted',
created_at  timestamp default current_timestamp,
updated_at timestamp default current_timestamp on update current_timestamp,
foreign key(user_id) references tbl_user(id),
foreign key(place_id) references tbl_place(id)
);

insert into tbl_user(social_id,name,email,password,profile_image,about,role,login_type) values
('foram1512','foram','foram@gmail.com','1512','img.jpg','my name is foram','user','f');

insert into tbl_user(social_id,name,email,password,profile_image,about,role,login_type) values
('piyu3001','Priya','priya@gmail.com','3001','img.jpg','student of bca','user','s'),
('riya3y2','Riya','riya@gmail.com','74846','img.jpg','amazig','user','g'),
('siya546yt1','Siya','siya@gmail.com','89479','img.jpg','sunset ','user','s'),
('vrusha65','vrusha','vrusha@gmail.com','36571','img.jpg','student','user','f'),
('deep7646','deep','deep@gmail.com','68349','img.jpg','artist','user','s'),
('dixa4278','dixa','dixa@gmail.com','87873','img.jpg','dancer','user','f');

insert into tbl_place(user_id,location,lattitude,longitude,about_place,avg_rating,review_count)values
('1','maninagar','22.9927762','72.58378','about place  very..','2','1'),
('2','gota','23.1008967','72.5229621','about place  very..','4.1','2'),
('3','gandhinagar','23.220846','72.5631455','about place  very..','2.1','1'),
('4','visnagar','23.6987775','72.521802','about place  very nice..','3','2'),
('5','sargasan','23.1935646','72.5942478','about place  very Bigest..','2.1','2'),
('6','ranip','23.0769469','72.5637018','about place  very Nearest..','3','2');

insert into tbl_place_image(place_id,image_name) values
('1','img1.jpg'),
('2','img1.jpg'),
('3','img1.jpg'),
('4','img1.jpg'),
('5','img1.jpg'),
('6','img1.jpg');

insert into tbl_review(user_id,place_id,rating,review_desc)values
('1','1','2.3','picture is not clean'),
('2','2','4.3','picture is not clean'),
('3','3','3.3','picture is not clean'),
('4','4','4.0','picture is not clean'),
('5','5','2.0','picture is not clean'),
('6','6','1.5','picture is not clean');


-- 1. login Query
select * from tbl_user where email like 'foram@gmail.com' and  password = '2001' and role = 'user' and is_active = '1'; 

-- 2 forgot password query
update tbl_user set password='2001' where email='foram@gmail.com';

-- 3 find place
select * from tbl_place where user_id='1'; 

-- 4. 
select r.*,u.name, u.profile_image from tbl_review r join tbl_user u on r.user_id  = u.id where place_id='1' and r.is_active='1';

-- 5.date time format
 select r.*,u.name, u.profile_image, date_format(r.created_at, '%d %b %Y %h:%i %p') from tbl_review r join tbl_user u on r.user_id  = u.id where place_id='1' and r.is_active='1';
 
--  6.distence query 
select p.*,group_concat(pi.image_name),(6371 * acos( cos( radians('23.0752323') )
* cos( radians (p.lattitude) )
        * cos( radians (p.longitude) - radians('72.5208067'))
        + sin( radians('23.0752323'))
        * sin( radians (p.lattitude) ) ) ) as distance
from tbl_place p join tbl_place_image pi on p.id=pi.place_id group by p.id;

-- 7. current location to nearby 5km place show by near by place
select p.*,(6371 * acos( cos( radians('23.0752323') )
* cos( radians (p.lattitude) )
        * cos( radians (p.longitude) - radians('72.5208067'))
        + sin( radians('23.0752323'))
        * sin( radians (p.lattitude) ) ) ) as distance 
        from tbl_place p where is_active = '1' having distance <= '15 ';
        
-- review_count_insert
CREATE DEFINER=`root`@`localhost` TRIGGER `review_count_insert` AFTER INSERT ON `tbl_review` FOR EACH ROW update tbl_place SET review_count=(select count(id) from tbl_review r where r.place_id=New.place_id) where tbl_place.id=New.place_id;

-- review_count_delete
CREATE TRIGGER `review_count_delete` AFTER DELETE ON `tbl_review` FOR EACH ROW update tbl_place SET review_count=(select count(id) from tbl_review r where r.place_id=Old.place_id) where tbl_place.id=Old.place_id;
update tbl_place SET review_count=(select count(id) from tbl_review r where r.place_id=Old.place_id) where tbl_place.id=Old.place_id;

-- avg_rating_insert
CREATE TRIGGER `avg_rating_insert` AFTER INSERT ON `tbl_review` FOR EACH ROW update tbl_place SET review_count=(select ROUND((AVG(rating)),1) from tbl_review r where r.place_id=NEW.place_id) where tbl_place.id=NEW.place_id;


-- avg_rating_delete
DROP TRIGGER IF EXISTS `avg_rating_delete`;CREATE DEFINER=`root`@`localhost` TRIGGER `avg_rating_delete` AFTER DELETE ON `tbl_review` FOR EACH ROW UPDATE tbl_place Set avg_rating=(select IfNull(Round(AVG(rating),1),0)from tbl_review r where r.place_id=old.place_id) where tbl_place.id=old.place_id
