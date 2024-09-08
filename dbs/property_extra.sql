create database hotel_booking;
use hotel_booking;


create table tbl_user(
	id BIGINT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(128) UNIQUE,
    firstname varchar(256),
    lastname varchar(256),
    email varchar(128),
    country_code varchar(8) default '+91',
    phone BIGINT(12) UNIQUE,
    password text,
    address text,
    image VARCHAR(128),
    role enum('User','Owner') DEFAULT 'User',
    latitude varchar(16),
    longtitude varchar(16),
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
	is_active boolean default '1' COMMENT '1=active,0=inactive'
);

insert into tbl_user (username, image, firstname, lastname, email, phone, password, address, latitude, longtitude) values
	('abhi-123', 'ab.jpg', 'abhi','makwana', 'abhi@gmail.com', '6776543210', 'abhi123', 'kalol',  '23.2281517','72.4609524'),
    ('mayur-123', 'ma.jpg', 'mayur','mori', 'mayur@gmail.com', '9876543210', 'mayur123','Morbi', '23.0752323', '72.5231027'),
    ('foram-123', 'fr.jpg', 'foram','panchal', 'foram@gmail.com', '9456543210', 'foram123','Nadiad puff','22.6958742','72.7807841');
    

create table tbl_property(
	id bigint primary key AUTO_INCREMENT,
    owner_id bigint,
    name varchar(128),
    image varchar(128),
    price float(8,2),
    bed int,
    bathtub int,
    sqft float(8,1),
    location text,
    latitude varchar(16),
    longtitude varchar(16),
    avg_rating float(5,1),
    about text,
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
	is_active boolean default '1' COMMENT '1=active,0=inactive',
    foreign key(owner_id)references tbl_user(id)
);

insert into tbl_property (owner_id,name, image, price, bed, bathtub, sqft, location, latitude,longtitude, about) values 
(3, 'The stewbew residancy', 'stbw1.jpg', 5000, 5,4,500, 'Nadiad','22.6958742','72.7807841', 'forem ipsum ipsum'),
(3, 'The maxhub residancy', 'maxhub1.jpg', 2500, 2,1,300, 'Aanand','22.6958742','72.7807841', 'forem ipsum ipsum')
;

create table tbl_rating(
	id bigint PRIMARY key AUTO_INCREMENT,
    user_id bigint,
    property_id bigint,
    rating float(5,1),
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
	is_active boolean default '1' COMMENT '1=active,0=inactive',
    foreign key(user_id)references tbl_user(id),
    foreign key(property_id)references tbl_property(id)
);

create table tbl_like(
	id bigint PRIMARY key AUTO_INCREMENT,
    user_id bigint,
    property_id bigint,
    foreign key(user_id)references tbl_user(id),
    foreign key(property_id)references tbl_property(id)
);


-- user display

select * from tbl_user where id=1;

select * from tbl_property where name like '%ste%';

-- display property

select * from tbl_property;

select p.*,u.id, u.firstname, u.image, u.phone from tbl_property p
join tbl_user u on u.id=p.owner_id
where p.id=1;