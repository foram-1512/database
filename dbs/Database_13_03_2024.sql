create database database_13_03_2024;
use database_13_03_2024;
drop database database_13_03_2024;

create table tbl_user(
	id BIGINT PRIMARY KEY AUTO_INCREMENT,
    social_id BIGINT,
    username VARCHAR(128) UNIQUE,
    fullname varchar(256),
    email varchar(128),
    country_code varchar(8) default '+91',
    phone BIGINT(12) UNIQUE,
    password text,
    image VARCHAR(128),
    role enum('User') DEFAULT 'User',
    account_type enum('Public', 'Private'),
    login_type enum('S', 'G', 'A') comment 'S-Simple , G-Google, A-Apple',
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
	is_active boolean default '1' COMMENT '1=active,0=inactive'
);
insert into tbl_user (username, fullname, image, email, phone, password, account_type, login_type) values
	('abhi-123', 'ab.jpg', 'abhimakwana', 'mailto:abhi@gmail.com', '6776543210', 'abhi123', 'public', 's'),
    ('mayur-123', 'ma.jpg', 'mayurmori', 'mailto:mayur@gmail.com', '9876543210', 'mayur123', 'private', 's'),
    ('foram-123', 'fr.jpg', 'forampanchal', 'mailto:foram@gmail.com', '9456543210', 'foram123', 'private', 's'),
    ('devarsh-123', 'dv.jpg', 'devarshpanchal', 'mailto:devarsh@gmail.com', '7896543210', 'devarsh123', 'public', 's'),
    ('abdul-123', 'ab.jpg', 'abdulkadir', 'mailto:abdul@gmail.com', '9324543210', 'abdul123', 'public', 's');

create table tbl_post(
	id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id bigint,
    type enum('image', 'video'),
    media varchar(128),
    total_like int DEFAULT 0,
    total_comment int DEFAULT 0,
    description text,
    location_tag text,
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
	is_active boolean default '1' COMMENT '1=active,0=inactive'
);

insert into tbl_post(user_id, type, media, description, location_tag) values
(1, 'image','abc.jpg', 'Lorem ipsum dolor sit amet consectetur, adipisicing elit', 'Delhi'),
(1, 'video', 'xyz.mp4', 'Lorem ipsum dolor sit amet consectetur, adipisicing elit', 'Mumbai'),
(2, 'image', 'sda.jpg','Lorem ipsum dolor sit amet consectetur, adipisicing elit', 'Kolkata'),
(2, 'image', 'asd4.jpg', 'Lorem ipsum dolor sit amet consectetur, adipisicing elit', 'Ahmdabad'),
(3, 'video', 'asdasd.mp4','Lorem ipsum dolor sit amet consectetur, adipisicing elit', 'Pune'),
(3, 'video','fdgdfg.jpg', 'Lorem ipsum dolor sit amet consectetur, adipisicing elit', 'Indore'),
(4, 'image','ghr.mp4', 'Lorem ipsum dolor sit amet consectetur, adipisicing elit', 'Jaipur'),
(4, 'video', 'xyz.mp4','Lorem ipsum dolor sit amet consectetur, adipisicing elit', 'Surat'),
(5, 'image', 'asde3.jpg','Lorem ipsum dolor sit amet consectetur, adipisicing elit', 'Banglore'),
(5, 'video', 'fhrf.mp4', 'Lorem ipsum dolor sit amet consectetur, adipisicing elit', 'Chennai');



create table tbl_post_media (
	id bigint primary key auto_increment,
    post_id bigint,
    image varchar(32),
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
	is_active boolean default '1' COMMENT '1=active,0=deactive',
	foreign key(post_id)references tbl_post(id)
);
insert into tbl_post_media (post_id, image) values
	(1, 'mayur.jpg'),
    (1, 'mayur1.jpg'),
    (3, 'foram.jpg'),
    (3, 'frm1.mp4'),
    (5, 'abdl.jpg'),
    (5, 'abdl.mp4');

create table tbl_post_like (
	id bigint primary key auto_increment,
    user_id bigint,
    post_id bigint,
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
	foreign key(post_id)references tbl_post(id),
    foreign key(user_id)references tbl_user(id)
);
drop table tbl_post_like;
insert into tbl_post_like(user_id, post_id) values 
(1,3),
(1,6),
(1,9),
(1,10),
(2,1),
(2,2),
(2,6),
(2,9),
(3,1),
(3,2),
(3,3),
(3,4),
(3,10),
(3,7),
(4,1),
(4,3),
(4,10),
(4,6),
(5,8),
(5,6),
(5,4);

create table tbl_post_comment (
	id bigint primary key auto_increment,
    user_id bigint,
    post_id bigint,
    comment text,
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
	is_active boolean default '1' COMMENT '1=active,0=deactive',
	foreign key(post_id)references tbl_post(id),
    foreign key(user_id)references tbl_user(id)
);
drop table tbl_post_comment;



insert into tbl_post_comment (user_id, post_id, comment) values
	(1,3,'Lorem ipsum dolor sit amet consectetur'),
    (1,10,'dolor sit amet consectetur'),
    (2,5,'sit amet consectetur'),
    (2,8,' dolor sit a'),
    (3,1,'consectetur'),
    (3,7,'dolor sit'),
    (4,2,'xnjaix qkjnxqoo '),
    (5,5,'sit amet consectetur'),
    (5,4,'sit amet ');

create table tbl_following (
	id bigint primary key auto_increment,
    user_id bigint,
    follow_id bigint,
    status enum('requested', 'accepted', 'rejected'),
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
	foreign key(follow_id)references tbl_user(id),
    foreign key(user_id)references tbl_user(id)
);

-- Login Query
select *  from tbl_user where username='abhi-123' and password='abhi123' and login_type='S' and is_active=1;

-- forgot password
select * from tbl_user where email='abhi@gmail.com' and is_active=1;
UPDATE `tbl_user` SET `password` = 'abhi12345' WHERE `email` = 'abhi@gmail.com';


-- post page

select u.id,u.username,u.image, u.is_verified, p.*,
concat(datediff(curdate(),p.created_at), ' days ago') as posted_on
from tbl_post p 
join tbl_following f on f.follow_id = p.user_id
join tbl_user u on u.id=p.user_id
WHERE f.user_id=1 and f.status='accepted';


-- user profile page

SELECT u.*, 
(select count(id) from tbl_post where user_id=1 and is_active=1) as posts, 
(select count(id) from tbl_following where follow_id=1 and status='accepted')as followers,
(select count(id) from tbl_following where user_id=1 and status='accepted') as following,
IF( ( SELECT f.id FROM tbl_following f WHERE f.user_id = 5 AND f.follow_id = u.id ), 'Following', 'Follow' ) AS is_follow
from tbl_user u
where u.id=1
group by u.id;

select *,(SELECT group_concat(image) from tbl_post_media where post_id=1) as other_post from tbl_post p
join tbl_post_media pm on pm.post_id=p.id
where p.user_id=1;


select * from tbl_post where user_id=1;
select pm.* from tbl_post_media pm
join tbl_post p on pm.post_id=p.id
where p.user_id=1;
