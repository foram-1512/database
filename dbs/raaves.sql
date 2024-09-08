create database raaves;
use raaves;

create table tbl_user (
	id bigint primary key auto_increment,
    social_id bigint,
    fname varchar(32),
    lname varchar(32),
    username varchar(32) unique,
    profile_image text default 'profile.jpg',
    background_image text default 'bkc.jpg',
    country_code varchar(8) default '+91',
    mobile bigint unique,
    email varchar(64) unique,
    password varchar(64),
    date_of_birth date,
    login_type enum('S', 'I', 'F') default 's' comment 's-simple, f-facebook, i-instagram',
    step enum('1','2','3'),
    otp_code int(8) default '0',
    otp_verification boolean default '0' comment '0=Unverified 1=Verified',
    is_active boolean default '1' COMMENT '1=active,0=deactive',
    is_delete boolean default '0' comment '1=delete 0=not_delete',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp
);
insert into tbl_user (fname, lname, username, profile_image,mobile, email,password,date_of_birth) values
('mayur', 'mori', 'mayur_123', 'ma.jpg', '9387654321', 'mailto:mayur@gmail.com', 'mayur123', '2002-06-16');

insert into tbl_user (fname, lname, username, profile_image,mobile, email,password,date_of_birth) values
('abhi', 'makwana', 'abhi_123', 'ab.jpg', '938754321', 'mailto:abhi@gmail.com', 'abhi123', '2002-04-14'),
('foram', 'panchal', 'foram_123', 'fp.jpg', '9234754321', 'mailto:foram@gmail.com', 'foram123', '2001-01-11'),
('gayatri', 'patil', 'gayatri_123', 'gp.jpg', '2345654321', 'mailto:gayatri@gmail.com', 'gayatri123', '2003-08-14'),
('pathan', 'taheran', 'pathan_123', 'pt.jpg', '123754321', 'mailto:pathan@gmail.com', 'pathan123', '2000-04-14');





create table tbl_device_info (
	id bigint primary key auto_increment,
    user_id bigint,
    model_name varchar(32),
    os_version varchar(16),
    ip varchar(32),
    token varchar(128),
    device_token varchar(128),
    device_type varchar(32),
    device_name varchar(64),
    uuid varchar(32),	
	is_delete boolean default '0' comment '1=delete 0=not_delete',
    is_active boolean default '1' COMMENT '1=active,0=deactive',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key (user_id) references tbl_user(id)
    
);
insert into tbl_device_info (user_id, model_name, os_version, ip, device_token, device_type, device_name, uuid) values
		(1, 'Realme 11 Pro', 'Android 13', '127.00.002.234', 'abcd12345hdjj', 'Android', 'Realme', '12345');

create table tbl_business (
	id bigint primary key auto_increment,
    owner_id bigint,
    name varchar(64),
	background_image text default 'bkc.jpg',
    address text,
    latitude varchar(16),
    longitude varchar(16),
    avg_rating float(5,1) default '0',
    like_count int default '0',
    review_count int default '0',
    is_delete boolean default '0' comment '1=delete 0=not_delete',
    is_active boolean default '1' COMMENT '1=active,0=deactive',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key (owner_id) references tbl_user(id)
    
);

INSERT INTO tbl_business (owner_id, name, address, latitude, longitude)
VALUES
    (1, 'Business One', '123 Main St, City A', '40.7128', '-74.0060'),
    (2, 'Business Two', '456 Oak St, City B', '34.0522', '-118.2437'),
    (3, 'Business Three', '789 Elm St, City C', '51.5074', '-0.1278'),
    (4, 'Business Four', '101 Pine St, City D', '41.8781', '-87.6298'),
    (5, 'Business Five', '202 Maple St, City E', '45.4215', '-75.6919');



create table tbl_business_image (
	id bigint primary key auto_increment,
    business_id  bigint,
    image text,
	is_active boolean default '1' COMMENT '1=active,0=deactive',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key (business_id) references tbl_business(id)

);
-- Inserting sample data into tbl_business_image
INSERT INTO tbl_business_image (business_id, image)
VALUES
    (1, 'image_url_1.jpg'),
    (1, 'image_url_2.jpg'),
    (1, 'image_url_3.jpg'),
    (2, 'image_url_4.jpg'),
    (2, 'image_url_5.jpg'),
    (2, 'image_url_6.jpg'),
    (3, 'image_url_7.jpg'),
    (3, 'image_url_8.jpg'),
    (3, 'image_url_9.jpg'),
    (4, 'image_url_10.jpg'),
    (4, 'image_url_11.jpg'),
    (4, 'image_url_12.jpg'),
    (5, 'image_url_13.jpg'),
    (5, 'image_url_14.jpg'),
    (5, 'image_url_15.jpg');




create table tbl_business_review_rating (
	id bigint primary key auto_increment,
    user_id bigint,
	business_id bigint,
    rating float(5,1) default '0',
    review text,
    amenities varchar(32),
	is_active boolean default '1' COMMENT '1=active,0=deactive',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key (user_id) references tbl_user(id),
    foreign key (business_id) references tbl_business(id)
    

);

create table tbl_review_amenities (
	id bigint primary key auto_increment,
    name varchar(64),
    is_active boolean default '1' COMMENT '1=active,0=deactive',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp

);
insert into tbl_review_amenities (name) values
	('parking'),
    ('service'),
    ('atmosphere'),
    ('breakfast'),
    ('food');
    
    
create table tbl_review_image (
	id bigint primary key auto_increment,
    review_id  bigint,
    image text,
	is_active boolean default '1' COMMENT '1=active,0=deactive',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key (review_id) references tbl_business_review_rating(id)

);

create table tbl_following (
	id bigint primary key auto_increment,
    user_id bigint,
    follow_id bigint,
    is_active boolean default '1' COMMENT '1=active,0=deactive',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key (user_id) references tbl_user(id),
    foreign key (follow_id) references tbl_user(id)
    

);

create table tbl_review_like (
	id bigint primary key auto_increment,
    user_id bigint,
    review_id bigint,
    is_active boolean default '1' COMMENT '1=active,0=deactive',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key (user_id) references tbl_user(id),
    foreign key (review_id) references tbl_business_review_rating(id)
    
);

create table tbl_block (
	id bigint primary key auto_increment,
    user_id bigint,
    block_id bigint,
    is_active boolean default '1' COMMENT '1=active,0=deactive',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key (user_id) references tbl_user(id),
    foreign key (block_id) references tbl_user(id)
    
);

create table tbl_report_type (
	id bigint primary key auto_increment,
	type varchar(256),
	is_active boolean default '1' COMMENT '1=active,0=deactive',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp
);

create table tbl_report_business (
	id bigint primary key auto_increment,
    user_id bigint,
    business_id bigint,
    report_type varchar(32),
    description text,
    is_active boolean default '1' COMMENT '1=active,0=deactive',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key (user_id) references tbl_user(id),
    foreign key (business_id) references tbl_business(id)
    

);

create table tbl_business_like (
	id bigint primary key auto_increment,
    user_id bigint,
    business_id bigint,
	is_active boolean default '1' COMMENT '1=active,0=deactive',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key (user_id) references tbl_user(id),
    foreign key (business_id) references tbl_business(id)
    
);

create table tbl_business_bookmark (
	id bigint primary key auto_increment,
    user_id bigint,
    business_id bigint,
	is_active boolean default '1' COMMENT '1=active,0=deactive',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key (user_id) references tbl_user(id),
    foreign key (business_id) references tbl_business(id)
    
    
);

create table tbl_notification (
	id bigint primary key auto_increment,
    user_id bigint,
    title varchar(128),
    description text,
    type varchar(128) ,
    is_active boolean default '1' COMMENT '1=active,0=deactive',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key (user_id) references tbl_user(id)

);

create table tbl_contact_us (
	id bigint primary key auto_increment,
    fname varchar(32),
    lname varchar(32),
    email varchar(64),
    subject varchar(256),
    description text,
	is_active boolean default '1' COMMENT '1=active,0=deactive',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp

);



use raaves;
    select b.*, concat(u.fname, ' ', u.lname) as fullname,
    IF( ( SELECT bl.id FROM tbl_business_like bl WHERE bl.user_id = 8 AND bl.business_id = 1 ), 'liked', 'not-liked' ) AS is_follow
    from tbl_business b join tbl_user u on b.owner_id=u.id order by created_at desc;
    
    
    select b.* from tbl_business b join tbl_business_review_rating rr on b.id=rr.business_id;
    
    select *,
    (select count(id) from tbl_business_review_rating where b.id=business_id) as review_count,
    (select avg(rating) from tbl_business_review_rating where b.id=business_id) as avg_rating,
    (select COUNT(id) from tbl_business_like  where b.id=business_id) as like_count
    from tbl_business b order by review_count desc; 
    
    
    select * from tbl_business where  address like '%%';
    
    select * from tbl_user where username like '' or fname like '%%';
    
    