create database angularForms;
use angularForms;

create table tbl_user(
	id bigint AUTO_INCREMENT PRIMARY KEY,
    name varchar(128),
    email varchar(128),
    password text,
	is_active boolean default '1' COMMENT '1=active,0=deactive',
    is_delete boolean default '0' comment '1=delete 0=not_delete',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp
);

create table tbl_contact_us(
	id bigint AUTO_INCREMENT PRIMARY key,
    name varchar(128),
    email varchar(128),
    message varchar(128),
    file varchar(128),
    is_active boolean default '1' COMMENT '1=active,0=deactive',
    is_delete boolean default '0' comment '1=delete 0=not_delete',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp
);

 


create table tbl_survey_form(
	id bigint AUTO_INCREMENT PRIMARY KEY,
    user_id bigint,
    question1 text,
    answer1 text,
    question2 text,
    answer2 text,
    
    
);


create table tbl_checkout(
	id bigint AUTO_INCREMENT PRIMARY key,
    name varchar(128),
    shipping_address text,
    street_address text,
    city varchar(64),
    state varchar(64),
    zipcode varchar(16),
    billing_address TEXT,
    payment_method enum('cash', 'cod'),
    order_summary varchar(64),
    is_active boolean default '1' COMMENT '1=active,0=deactive',
    is_delete boolean default '0' comment '1=delete 0=not_delete',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp
);


create table tbl_job_application(
	id bigint AUTO_INCREMENT PRIMARY key,
    fullname varchar(128),
    email varchar(128),
    mobile bigint,
    resume varchar(128),
    is_active boolean default '1' COMMENT '1=active,0=deactive',
    is_delete boolean default '0' comment '1=delete 0=not_delete',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp
);


create table tbl_event_registration(
	id bigint AUTO_INCREMENT PRIMARY key,
    fullname varchar(128),
    email varchar(128),
    mobile bigint, 
    payment_status enum('pending', 'completed'),
    is_active boolean default '1' COMMENT '1=active,0=deactive',
    is_delete boolean default '0' comment '1=delete 0=not_delete',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp
);

CREATE TABLE survey_responses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id bigint,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    age INT,
    coffee_frequency ENUM('Daily', 'Weekly', 'Monthly', 'Occasionally', 'Never') NOT NULL,
    favorite_flavor_reason TEXT,
    submission_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    foreign key (user_id) references tbl_user(id)
);



CREATE TABLE billing_info (
    id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(128),
    email VARCHAR(128),
    address text,
    city VARCHAR(64),
    state VARCHAR(64),
    zip VARCHAR(16) 
);

-- Table for storing payment information











-- new
CREATE TABLE tbl_payment_info (
    id bigint AUTO_INCREMENT PRIMARY KEY,
    cardholder_name VARCHAR(128),
    card_number VARCHAR(16),
    exp_month VARCHAR(8),
    exp_year VARCHAR(8),
    cvv VARCHAR(8)
);


CREATE TABLE  tbl_billing_info (
    id bigint AUTO_INCREMENT PRIMARY KEY,
    fullname VARCHAR(128),
    email VARCHAR(128),
    address text,
    city VARCHAR(64),
    state VARCHAR(64),
    zip VARCHAR(16)
);


-- Table for storing shipping information
CREATE TABLE tbl_shipping_info (
    id INT AUTO_INCREMENT PRIMARY KEY,
    fullname VARCHAR(128),
    email VARCHAR(128),
    address text,
    city VARCHAR(64),
    state VARCHAR(64),
    zip VARCHAR(20)
);


create table tbl_user_prefrence(
	id bigint AUTO_INCREMENT PRIMARY KEY,
    theme_color varchar(64),
    notification_setting varchar(64),
    language_prefrence varchar(64)
);
