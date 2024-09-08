-- create database student_query_solution;
-- use student_query_solution;


create table tbl_super_admin(
	id bigint AUTO_INCREMENT PRIMARY KEY,
    name varchar(128),
    email varchar(128) unique,
    country_code varchar(8),
    mobile bigint unique,
    password text,
    is_active boolean default '1' COMMENT '1=active,0=deactive',
    is_delete boolean default '0' comment '1=delete 0=not_delete',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp
);


create table tbl_admin(
	id bigint AUTO_INCREMENT PRIMARY KEY,
    fname varchar(64),
    lname varchar(64),
    email varchar(128) unique,
    country_code varchar(8),
    mobile bigint UNIQUE,
    password text,
    is_active boolean default '1' COMMENT '1=active,0=deactive',
    is_delete boolean default '0' comment '1=delete 0=not_delete',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp
);

create table tbl_school(
	id bigint AUTO_INCREMENT PRIMARY KEY,
    admin_id bigint,
    school_name varchar(256),
    email varchar(128),
    country_code varchar(8),
    mobile bigint unique,
    logo varchar(128),
    address text,
    latitude varchar(16),
    longitude varchar(16),
    country VARCHAR(64),
    no_of_students int,
    privacy_policy_link TEXT,
    primary_color_code varchar(16),
    desired_app_name varchar(64),
	is_active boolean default '1' COMMENT '1=active,0=deactive',
    is_delete boolean default '0' comment '1=delete 0=not_delete',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key (admin_id) references tbl_admin(id)
);

create table tbl_peer(
	id bigint AUTO_INCREMENT PRIMARY KEY,
    school_id bigint,
    name varchar(128),
    email varchar(128) UNIQUE,
    country_code varchar(8),
    mobile bigint unique,
    role enum('student', 'teacher'),
	is_active boolean default '1' COMMENT '1=active,0=deactive',
    is_delete boolean default '0' comment '1=delete 0=not_delete',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key (school_id) references tbl_school(id)
);


create table tbl_pass_reset(
	id BIGINT AUTO_INCREMENT PRIMARY KEY,
    token varchar(128),
    email varchar(128)
);

create table tbl_subject(
	id bigint AUTO_INCREMENT PRIMARY key,
    school_id bigint,
    teacher_id bigint,
    parent_id bigint,
    subject_name varchar(128),
    is_active boolean default '1' COMMENT '1=active,0=deactive',
    is_delete boolean default '0' comment '1=delete 0=not_delete',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key (school_id) references tbl_school(id),
    foreign key (teacher_id) references tbl_peer(id),
    FOREIGN KEY (parent_id) REFERENCES tbl_subject(id)
);


create table tbl_request(
		id BIGINT AUTO_INCREMENT PRIMARY KEY,
        school_id bigint,
        sender_id bigint,
        assign_id bigint,
        subject_id bigint,
        query text,
        solution text,
		is_critical boolean default '0' COMMENT '0=not critical,1=critical',
		is_resolved boolean default '0' COMMENT '0=not resolved,1=resolved',
        is_active boolean default '1' COMMENT '1=active,0=deactive',
		is_delete boolean default '0' comment '1=delete 0=not_delete',
		created_at timestamp default current_timestamp,
		updated_at timestamp default current_timestamp on update current_timestamp,
		foreign key (school_id) references tbl_school(id),
		foreign key (sender_id) references tbl_peer(id),
		foreign key (assign_id) references tbl_peer(id),
		foreign key (subject_id) references tbl_subject(id)
);


create table tbl_security_config(
	id bigint AUTO_INCREMENT PRIMARY key,
    school_id bigint,
    question text,
	is_active boolean default '0' COMMENT '1=active,0=deactive',
	is_delete boolean default '0' comment '1=delete 0=not_delete',
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
	foreign key (school_id) references tbl_school(id)
);

create table tbl_help_us(
	id bigint AUTO_INCREMENT PRIMARY KEY,
    full_name varchar(128),
    email varchar(128),
    country_code varchar(8),
    mobile bigint,
    country varchar(64),
    city varchar(64),
    title varchar(256),
    description text
);

create table tbl_contact_support(
	id bigint AUTO_INCREMENT PRIMARY key,
    full_name varchar(128),
    email varchar(128),
    country_code varchar(8),
    mobile bigint,
    message text
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
    foreign key (user_id) references tbl_peer(id)
);



create table tbl_notification (
	id bigint primary key auto_increment,
    sender_id bigint,
    sender_type enum('user', 'admin'),
    receiver_type enum('user'),
	title varchar(512) ,
	content text ,
    read_status enum('read','unread') DEFAULT 'unread',
	is_active boolean default '1' COMMENT '1=active,0=deactive',
    is_delete boolean default '0' comment '1=delete 0=not_delete',
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key (sender_id) references tbl_peer(id)

);

create table tbl_cms (
	id bigint primary key auto_increment,
    page_name varchar(64),
    content text,
    is_active boolean default '1' COMMENT '1=active,0=deactive',
    is_delete boolean default '0' comment '1=delete 0=not_delete',
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp


);
