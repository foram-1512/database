create database db_socialmedia;
use db_socialmedia;

create table tbl_user (
	id bigint primary key auto_increment,
    social_id varchar(256) default '0',
    username varchar(128) not null unique,
    name varchar(128) not null,
    profile_image varchar(128) default 'default.jpg',
    email varchar(64) unique,
    country_code varchar(8) default '+91',
    mobile varchar(16) unique ,
	password varchar(64),
    role enum('user') default ('user'),
    login_type enum('S','G','A') comment 'G = Google A = Apple id S = simple',
    profile_type enum('Public','Private'),
    location varchar(128),
    latitude varchar(64),
    longitude varchar(64),
    is_verified tinyint(1) default 1 comment '1= Not-verified 0= Verified',
	is_active tinyint(1) default 1 comment '1=Active 0= Inactive', 
	is_delete tinyint(1) default 0 comment '0 = non delete 1= delete',
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp
);

insert into tbl_user(username,name,email, mobile, password,login_type,profile_type,location,latitude,longitude) values
	('foram1512','Foram Panchal','foram@gmail.com', '9106603730', 'foram12345','S','private','Nadiad','22.6824679','72.8496527'),
    ('gayu123','Gayatri Patil','gayatri@gmail.com', '7546734523', 'gayatri12345','G','private','Ahmedabad Rabari colony','23.0010957','72.6251497'),
	('mayur123','Mayur Mori','mayur@gmail.com', '9879483440', 'mayur12345','A','public','Morbi','22.8049727','70.8155096'),
    ('abhi123','Abhi Makwana','abhi@gmail.com', '8401971214', 'abhi12345','S','private','Kalol','23.228059','72.4242963'),
    ('viru123','Viral Prajapati','viral@gmail.com', '9879353440', 'viral12345','G','public','Mehsana','23.5898665','72.3416933');

create table tbl_following (
	id bigint primary key auto_increment,
    user_id bigint,
    following_id bigint,
    status enum('Requested','Accept','Reject'),
    is_active tinyint(1) default 1 comment '1=Active 0= Inactive', 
	is_delete tinyint(1) default 0 comment '0 = non delete 1= delete',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key (user_id) references tbl_user(id),
    foreign key (following_id) references tbl_user(id)
);

INSERT INTO tbl_following (user_id, following_id, status)
VALUES
(1, 2, 'Accept'),
(1, 3, 'Reject'),
(2, 1, 'Requested'),
(2, 2, 'Accept'),
(2, 3, 'Accept'),
(3, 2, 'Accept'),
(2, 4, 'Reject'),
(4, 1, 'Accept'),
(2, 3, 'Accept'),
(5, 2, 'Requested'),
(2, 4, 'Requested'),
(5, 1, 'Accept');


create table tbl_post (
	id bigint primary key auto_increment,
    user_id bigint,
    description text,
    media varchar(256),
    type enum('Image','Video'),
    like_count int default 0,
    comment_count int default 0,
    location varchar(128),
    is_active tinyint(1) default 1 comment '1=Active 0= Inactive', 
	is_delete tinyint(1) default 0 comment '0 = non delete 1= delete',
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key (user_id) references tbl_user(id)
);


insert into tbl_post(user_id, type, media, description, location) values
	(1, 'image', 'may.jpg', 'Lorem ipsum dolor sit amet consectetur, adipisicing elit', 'Delhi'),
	(1, 'video', 'may.mp4', 'Lorem ipsum dolor sit amet consectetur, adipisicing elit', 'Mumbai'),
	(2, 'image', 'abh1.jpg', 'Lorem ipsum dolor sit amet consectetur, adipisicing elit', 'Kolkata'),
	(2,'image', 'abh.jpg', 'Lorem ipsum dolor sit amet consectetur, adipisicing elit', 'Ahmdabad'),
	(3, 'video', 'frm1.mp4', 'Lorem ipsum dolor sit amet consectetur, adipisicing elit', 'Pune'),
	(3, 'video', 'frm.mp4', 'Lorem ipsum dolor sit amet consectetur, adipisicing elit', 'Indore'),
	(4, 'image', 'deva.jpg', 'Lorem ipsum dolor sit amet consectetur, adipisicing elit', 'Jaipur'),
	(4, 'video', 'deva.mp4', 'Lorem ipsum dolor sit amet consectetur, adipisicing elit', 'Surat'),
	(5, 'image', 'abd.jpg', 'Lorem ipsum dolor sit amet consectetur, adipisicing elit', 'Banglore'),
	(5, 'video', 'abd.mp4', 'Lorem ipsum dolor sit amet consectetur, adipisicing elit', 'Chennai');

create table tbl_post_media(
	id bigint primary key auto_increment,
	post_id  bigint,
	media varchar(128),
	is_active tinyint(1) default 1 comment '1=Active 0= Inactive', 
	is_delete tinyint(1) default 0 comment '0 = non delete 1= delete',
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
	foreign key(post_id) references tbl_post(id)
);

INSERT INTO tbl_post_media (post_id, media)
VALUES
	(1, 'image1.jpg'),
	(1, 'image2.jpg'),
	(2, 'video1.mp4'),
	(3, 'image3.jpg'),
	(3, 'image4.jpg'),
	(3, 'image1.jpg'),
	(4, 'image2.jpg'),
	(4, 'video1.mp4'),
	(5, 'image3.jpg'),
	(5, 'image4.jpg');

create table tbl_post_like(
	id bigint primary key auto_increment,
    post_id bigint,
    user_id bigint,
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key (post_id) references tbl_post(id),
    foreign key (user_id) references tbl_user(id)
);

create table tbl_post_comment(
	id bigint primary key auto_increment,
    post_id bigint,
    user_id bigint,
    comment blob,
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key (post_id) references tbl_post(id),
    foreign key (user_id) references tbl_user(id)
);

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 1.login with Simple user
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
select * from tbl_user where username='foram1512' and password='foram12345' and country_code='+91'and 	 login_type='s' and is_active=1 and is_delete=0;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 2.login with Google user
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
select * from tbl_user where username='viru123'and password='viral12345' and country_code='+91' and is_active=1 and is_delete=0;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 3.login with Apple user
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
select * from tbl_user where username='mayur123' and password='mayur12345'and country_code='+91' and is_active=1 and is_delete=0;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 4 forget password
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT id,email FROM tbl_user WHERE email ="foram@gmail.com" AND login_type='s' and  is_active = 1 AND is_delete=0;
update tbl_user set password='1512' where mobile='9106603730'AND id=2 AND is_active = 1 AND is_delete=0;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 5.Home Page
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
select p.*,f.following_id,f.status,
concat(datediff(curdate(),p.created_at),' Days Ago') as posted_on
from tbl_post p 
join tbl_following f on f.following_id=p.user_id
where f.user_id=4 and status='Accept';

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 6. view profile page
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
select u.profile_image,u.name,u.username,u.is_verified,p.description,
(select count(id) from tbl_post where user_id=1 and is_active=1) as posts,
(select count(id) from tbl_following where following_id=2 and status='Accept') as Followers,
(select count(id) from tbl_following where user_id=2 and status='Accept') as Following,
IF( ( SELECT f.id FROM tbl_following f WHERE f.user_id = 3 AND f.following_id = u.id ), 'Following','Follow' ) AS is_follow
from tbl_user u 
join tbl_post p on p.user_id=u.id
where u.id=3
group by u.id;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 7. view post
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
select *,(SELECT group_concat(media) from tbl_post_media where post_id=1) as other_post from tbl_post p
join tbl_post_media pm on pm.post_id=p.id
where pm.post_id=2;

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
where p.id=old.post_id;
 