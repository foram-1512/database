create database node_task2;
use node_task2;
-- drop database node_task2;
create table tbl_user (
	id bigint primary key auto_increment,
    username varchar(128) not null unique,
    name varchar(128) not null,
    profile_image varchar(128) default 'default.jpg',
    email varchar(64) unique,
    country_code varchar(64) default '+91',
    mobile varchar(16) unique ,
	password varchar(64),
    location varchar(128),
    role enum('user','owner'),
	is_active tinyint(1) default 1 comment '1=Active 0= Inactive', 
	is_delete tinyint(1) default 0 comment '0 = non delete 1= delete',
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp
);

insert into tbl_user(username,name,email, mobile, password,role,location) values
	('foram1512','Foram Panchal','foram@gmail.com', '9106603730', 'foram1512','owner','Nadiad'),
    ('gayu123','Gayatri Patil','gayatri@gmail.com', '7546734523', 'gayatri12345','user','Ahmedabad Rabari colony'),
	('mayur123','Mayur Mori','mayur@gmail.com', '9879483440', 'mayur12345','user','Morbi'),
    ('abhi123','Abhi Makwana','abhi@gmail.com', '8401971214', 'abhi12345','user','Kalol'),
    ('viru123','Viral Prajapati','viral@gmail.com', '9879353440', 'viral12345','user','Mehsana');

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

create table tbl_bookmark (
	id bigint primary key auto_increment,
    post_id bigint,
    user_id bigint,
    is_active boolean default '1' COMMENT '1=active,0=deactive',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key(post_id)references tbl_post(id),
    foreign key(user_id)references tbl_user(id)
    
);

insert into tbl_bookmark (post_id, user_id) values
	(1, 3),
	(2, 5),
	(3, 3),
	(4, 4),
	(5, 4),
	(6, 2),
	(7, 1),
    (8, 2),
    (9, 3),
    (10, 5);

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

UPDATE tbl_user SET password = 2001 WHERE id = 1 AND is_active = 1	;