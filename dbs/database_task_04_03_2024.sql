create database 04_03_2024;
use 04_03_2024;

create table tbl_user (
  id bigint primary key auto_increment,
  social_id varchar(255),
  user_name varchar(128) not null,
  email varchar(64) unique,
  password varchar(256),
  role enum('User'),
  gender enum('male', 'female'),
  age int(3),
  profile_image varchar(128) default('dem01.jpg'),
  fav_activity text,
  login_type enum('S', 'G', 'F'),
  created_at timestamp default current_timestamp,
  updated_at timestamp default current_timestamp on update current_timestamp,
  is_active tinyint default '1' COMMENT '1=active,2=inactive'
);


create table  tbl_post(
id bigint primary key auto_increment,
user_id bigint,
title varchar(128),
painting_type enum('Portrate','Landscape'),
medium enum('Glass Paint','Acralic'),
style enum('Glass Paint','Acralic'),
sale double(8,2),
post_media varchar(64),
location text,
description text,
like_count bigint(20),
comment_count bigint(20),
created_at timestamp default current_timestamp,
updated_at timestamp default current_timestamp on update current_timestamp,
is_active tinyint default '1' COMMENT '1=active,2=inactive',
foreign key (user_id) references tbl_user(id)
);

create table tbl_event(
 id bigint primary key auto_increment,
 user_id bigint,
 title varchar(128),
 painting_type enum('Portrate','Landscape'),
 medium enum('Glass Paint','Acralic'),
 style enum('Glass Paint','Acralic'),
 sale double(8,2),
 location text,
 description text,
 start_date date,
 end_date date,
 created_at timestamp default current_timestamp,
 updated_at timestamp default current_timestamp on update current_timestamp,
 is_active tinyint default '1' COMMENT '1=active,2=inactive',
 foreign key (user_id) references tbl_user(id)
 );
 
 
 create table tbl_event_image(
 id bigint primary key auto_increment,
 event_id bigint,
 event_image varchar(64),
 created_at timestamp default current_timestamp,
  updated_at timestamp default current_timestamp on update current_timestamp,
 is_active tinyint default '1' COMMENT '1=active,2=inactive',
  foreign key (event_id) references tbl_event(id)
 );
 
 create  table tbl_like(
 id bigint primary key,
 user_id bigint,
 post_id bigint,
 likes bigint,
  is_active tinyint default '1' COMMENT '1=active,2=inactive',
  foreign key(user_id) references tbl_user(id),
  foreign key(post_id) references tbl_post(id)
 );
 
 create table tbl_comments(
 id bigint primary key,
 user_id bigint,
 post_id bigint,
 comments varchar(64),
 is_active tinyint default '1' COMMENT '1=active,2=inactive',
 foreign key(user_id) references tbl_user(id),
 foreign key(post_id) references tbl_post(id)
 );
 
 
 INSERT INTO tbl_user (user_name, email, password, role, gender, age, fav_activity, login_type)
VALUES 
('john_doe', 'john.doe@example.com', 'password123', 'User', 'male', 30, 'hiking', 'S'),
('jane_smith', 'jane.smith@example.com', 'password456', 'User', 'female', 25, 'reading', 'S'),
('sam_jones', 'sam.jones@example.com', 'password789', 'User', 'male', 35, 'swimming', 'S'),
('sara_williams', 'sara.williams@example.com', 'passwordabc', 'User', 'female', 28, 'painting', 'S'),
('chris_evans', 'chris.evans@example.com', 'passworddef', 'User', 'male', 40, 'biking', 'S');



INSERT INTO tbl_post (user_id, title, painting_type, medium, style, sale, post_media, location, description, like_count, comment_count)
VALUES 
(1, 'Beautiful Sunset', 'Landscape', 'Acralic', 'Acralic', 1500.00, 'sunset.jpg', 'New York', 'A stunning depiction of a sunset over the city skyline.', 0, 0),
(2, 'Portrait of a Woman', 'Portrate', 'Acralic', 'Acralic', 2000.00, 'portrait.jpg', 'Paris', 'A realistic portrait capturing the essence of femininity.', 0, 0),
(3, 'Mountain View', 'Landscape', 'Acralic', 'Acralic', 1200.00, 'mountain.jpg', 'Switzerland', 'An abstract representation of majestic mountains.', 0, 0),
(4, 'Still Life with Flowers', 'Portrate', 'Glass Paint', 'Glass Paint', 1800.00, 'still_life.jpg', 'London', 'A modern interpretation of a still life arrangement.', 0, 0),
(5, 'Seascape', 'Landscape', 'Glass Paint', 'Glass Paint', 1700.00, 'seascape.jpg', 'California', 'A beautiful seascape capturing the essence of the ocean.', 0, 0);


INSERT INTO tbl_event (user_id, title, painting_type, medium, style, sale, location, description, start_date, end_date)
VALUES 
(1, 'Summer Art Exhibition', 'Landscape', 'Glass Paint', 'Glass Paint', 0.00, 'City Art Gallery', 'Join us for a vibrant summer art exhibition featuring landscape paintings.', '2024-03-01', '2024-03-15'),
(2, 'Portraits of Life', 'Portrate', 'Acralic', 'Acralic', 0.00, 'Metropolitan Museum', 'Experience the beauty of human portraits in this captivating exhibition.', '2024-03-10', '2024-03-20'),
(3, 'Abstract Expressions', 'Landscape', 'Acralic', 'Acralic', 0.00, 'Downtown Art Center', 'Explore the depths of abstract art in this thought-provoking exhibition.', '2024-03-01', '2024-03-08'),
(4, 'Modern Art Showcase', 'Portrate', 'Acralic', 'Acralic', 0.00, 'Contemporary Gallery', 'Discover the latest trends in modern art at our exclusive showcase.', '2024-03-25', '2024-04-03'),
(5, 'Nature Palette', 'Landscape', 'Glass Paint', 'Glass Paint', 0.00, 'Nature Park Gallery', 'Celebrate the beauty of nature through colorful landscape paintings.', '2024-03-01', '2024-03-20');


INSERT INTO tbl_event_image (event_id, event_image)
VALUES 
(1, 'event1_image1.jpg'),
(1, 'event1_image2.jpg'),
(1, 'event1_image3.jpg');

-- Insert records for event_id = 2
INSERT INTO tbl_event_image (event_id, event_image)
VALUES 
(2, 'event2_image1.jpg'),
(2, 'event2_image2.jpg'),
(2, 'event2_image3.jpg');

-- Insert records for event_id = 3
INSERT INTO tbl_event_image (event_id, event_image)
VALUES 
(3, 'event3_image1.jpg'),
(3, 'event3_image2.jpg'),
(3, 'event3_image3.jpg');

-- Insert records for event_id = 4
INSERT INTO tbl_event_image (event_id, event_image)
VALUES 
(4, 'event4_image1.jpg'),
(4, 'event4_image2.jpg'),
(4, 'event4_image3.jpg');

-- Insert records for event_id = 5
INSERT INTO tbl_event_image (event_id, event_image)
VALUES 
(5, 'event5_image1.jpg'),
(5, 'event5_image2.jpg'),
(5, 'event5_image3.jpg');


select * from tbl_user;
select * from tbl_post;
select * from tbl_event;
select * from tbl_event_image;

-- 1. Query for login

select * from tbl_user where email='john.doe@example.com' and password='password123' and is_active=1;
update tbl_user set password = 'john123' where email='john.doe@example.com';

-- 2. Post Listing Query
select * from tbl_post;
select u.profile_image, u.user_name, p.post_media, p.location, p.sale, p.description, p.like_count, p.comment_count from tbl_post p 
join tbl_user u on p.user_id=u.id;


select * from tbl_event_image;
select * from tbl_event;


-- 3. Event Listing Query
select ei.event_image, e.title, date_format(e.start_date, '%d %b %Y') as start_date, date_format(e.end_date, '%d %b %Y') as end_date, e.location  from tbl_event e
join tbl_event_image ei on ei.event_id = e.id group by ei.event_id;

-- 4. My Event's listing Query
select * from tbl_event;
select e.id, e.title, e.description, e.location, (select count(id) as total_event from tbl_event where date('2024-03-01') between start_date  and end_date) as total_events from tbl_event e where date('2024-03-1') between e.start_date and e.end_date group by id;

-- 5. Event Details Query
select * from tbl_event_image;
select * from tbl_event;

-- 6
select  e.id, group_concat(ei.event_image) as event_image, e.title, date_format(e.start_date, '%d %b %Y') as start_date, date_format(e.end_date, '%d %b %Y') as end_date, e.location, e.description from tbl_event e 
join tbl_event_image ei on ei.event_id= e.id where e.id=1;


select * from tbl_like;
-- is  like Query
SELECT *,IFNULL((SELECT(CASE WHEN l.post_id !='' THEN 1 ELSE 0 END) from tbl_like l where l.post_id=p.id AND l.user_id=1),0) as is_like FROM tbl_post p;




