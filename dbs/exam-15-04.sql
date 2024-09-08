CREATE database prep_it;
use prep_it;
drop database prep_it;

create table tbl_fitness_goal (
	id bigint primary key auto_increment,
    image text,
    name varchar(64),
    description text,
    is_active boolean default '1' COMMENT '1=active,0=deactive',
    is_delete boolean default '0' comment '1=delete 0=not_delete',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp
    
);

create table tbl_user (
	id bigint primary key auto_increment,
    social_id bigint,
    name varchar(32),
    country_code varchar(8) default '+91',
    mobile bigint unique,
    email varchar(32) unique,
    password varchar(64),
    date_of_birth date,
    gender enum('male', 'female'),
    weight float(8,1) default '0',
    target_weight float(8,1) default '0',
    activity_level enum('rookie', 'beginner', 'intermediate', 'advance', 'true beast'),
    fitness_goal_id bigint,
    height int default'0',
    address text,
    latitude varchar(64),
    longitude varchar(64),
    step enum('0','1','2') default '0',
    login_status enum('online', 'offline') default 'offline',
	login_type enum('S', 'G', 'F') default 's' comment 's-simple, f-facebook, g-google',
    otp_code int(8) default'0',
    otp_verification boolean default '0' comment '0=Unverified 1=Verified',
    is_forgot boolean default '0' comment '1=forgot, 0=not-forgot',
    is_active boolean default '1' COMMENT '1=active,0=deactive',
    is_delete boolean default '0' comment '1=delete 0=not_delete',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
	foreign key (fitness_goal_id) references tbl_fitness_goal(id)
);

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

create table tbl_pass_reset(
	id BIGINT PRIMARY key AUTO_INCREMENT,
    email varchar(128),
    token varchar(64)
);


-- create table tbl_days(
-- 	id bigint AUTO_INCREMENT PRIMARY KEY,
--     day_name  varchar(16),
--     
-- );


create table tbl_food(
	id bigint AUTO_INCREMENT PRIMARY KEY,
    category enum('Breakfast', 'Lunch', 'Dinner'),
    day_id bigint,
    image text,
    name varchar(256),
    kcal varchar(64),
    carbs varchar(64),
    protin varchar(64),
    fat varchar(64),
    description text,
    ingredients varchar(128),
	is_active boolean default '1' COMMENT '1=active,0=deactive',
    is_delete boolean default '0' comment '1=delete 0=not_delete',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
	foreign key (day_id) references tbl_day(id)
);

create table tbl_ingrediants(
	id bigint primary key auto_increment,
    name varchar(64)
);

create table tbl_delivery_address (
	id bigint primary key auto_increment,
    user_id bigint,
    type enum('home','office'),
    address text,
    latitude varchar(64),
    longitude varchar(64),
    foreign key (user_id) references tbl_user(id)
);
    
create table tbl_days(
	id bigint primary key auto_increment,
    name varchar(64),
	is_active boolean default '1' comment '1=active,0=deactive',

	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp
);


insert into tbl_days (name) values
("sun"),
("mon"),
("tue"),
("wed"),
("thu"),
("fri"),
("sat");

create table tbl_banner(
	id bigint primary key auto_increment,
    image varchar(128)
);    
   
create table tbl_food(
	id bigint primary key auto_increment,
	day_id bigint,
	category enum ('breakfast','lunch','dinner'),
	name varchar(64),
    ingrediants varchar(64),
	description text,
	image varchar(64),
	kcal int,
	carbs varchar(32),
	protein varchar(32),
	fat varchar(32),
	price float,
	is_active boolean default '1' comment '1=active,0=deactive',
	is_delete boolean default '0' comment '1=delete 0=not_delete',
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
	foreign key (day_id) references tbl_days(id)
);
   






create table tbl_order(
	id bigint primary key auto_increment,
	user_id bigint,
	food_id bigint,
	order_date date,
	total_qty int,
	total_amount float,
	discount_price float,
	delivery_charge float,
	grand_total float,
	delivery_address_id bigint,
	status enum ('delivered','cancle','pending', 'shipped'),
	is_active boolean default '1' comment '1=active,0=deactive',
	is_delete boolean default '0' comment '1=delete 0=not_delete',
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
	foreign key (user_id) references tbl_user(id),
	foreign key (food_id) references tbl_food(id),
	foreign key (delivery_address_id) references tbl_delivery_address(id)
);

create table tbl_order_details(
	id bigint primary key auto_increment,
	order_id bigint,
	food_id bigint,
	total_qty float,
	per_food_price float,
	total_amount float,
	foreign key (order_id) references tbl_order(id),
	foreign key (food_id) references tbl_food(id)
);

create table tbl_notification(
	id bigint primary key auto_increment,
	user_id bigint,
    order_id bigint,
	is_read tinyint,
	is_active boolean default '1' comment '1=active,0=deactive',
	is_delete boolean default '0' comment '1=delete 0=not_delete',
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key (order_id) references tbl_order(id),
	foreign key (user_id) references tbl_user(id)
);

create table tbl_contact_us(
	id bigint primary key auto_increment,
    fname varchar(64),
    lname varchar(64),
    email varchar(64),
    description text
);

