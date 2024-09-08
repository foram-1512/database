



create table tbl_user (
	id bigint primary key auto_increment,
    social_id bigint,
    username varchar(32) unique,
    full_name varchar(32),
    profile_image varchar(64),
    country_code varchar(8) default '+91',
    mobile bigint unique,
    email varchar(32) unique,
    password varchar(64),
    date_of_birth date,
    bio text,
    step enum('0','1','2','3') default '0',
	login_type enum('S', 'I', 'F') default 's' comment 's-simple, f-facebook, i-instagram',
    otp_code int(8) default'0',
    otp_verification boolean default '0' comment '0=Unverified 1=Verified',
    is_active boolean default '1' COMMENT '1=active,0=deactive',
    is_delete boolean default '0' comment '1=delete 0=not_delete',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp
	
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


create table tbl_category (
	id bigint primary key auto_increment,
    image text,
    name varchar(32),
    is_delete boolean default '0' comment '1=delete 0=not_delete',
    is_active boolean default '1' COMMENT '1=active,0=deactive',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp
);


create table tbl_group (
	id bigint primary key auto_increment,
    owner_id bigint,
    name varchar(32),
    image text,
    is_delete boolean default '0' comment '1=delete 0=not_delete',
    is_active boolean default '1' COMMENT '1=active,0=deactive',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key (owner_id) references tbl_user(id)
    
);


create table tbl_post (
	id bigint primary key auto_increment,
    category_id bigint,
    group_id bigint,
    user_id bigint,
    type enum('video', 'campare', 'me'),
    description text,
    avg_rating float(8,1) default '0',
    total_comment int default '0',
    tag_name varchar(64),
    hashtags varchar(128),
    expiry_time time,
    is_expiry boolean default '0' comment '1=expiry, 2=not-expiry',
    is_delete boolean default '0' comment '1=delete 0=not_delete',
    is_active boolean default '1' COMMENT '1=active,0=deactive',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key (category_id) references tbl_category(id),
    foreign key (group_id) references tbl_group(id),
    foreign key (user_id) references tbl_user(id)
    

);


create table tbl_post_image (
	id bigint primary key auto_increment,
    post_id bigint,
    type enum('video','image'),
    media text,
	is_delete boolean default '0' comment '1=delete 0=not_delete',
    is_active boolean default '1' COMMENT '1=active,0=deactive',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key (post_id) references tbl_post(id)

);

create table tbl_post_saved (
	id bigint primary key auto_increment,
    user_id bigint,
    post_id bigint,
     is_active boolean default '1' COMMENT '1=active,0=deactive',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key (post_id) references tbl_post(id),
    foreign key (user_id) references tbl_user(id)
    

);


create table tbl_post_comment (
	id bigint primary key auto_increment,
    post_id bigint,
    user_id bigint,
	is_active boolean default '1' COMMENT '1=active,0=deactive',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key (post_id) references tbl_post(id),
    foreign key (user_id) references tbl_user(id)
);


create table tbl_hashtag (
	id bigint primary key auto_increment,
    name varchar(128),
    is_active boolean default '1' COMMENT '1=active,0=deactive',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp

);


create table tbl_following (
	id bigint primary key auto_increment,
    user_id bigint,
    follow_id bigint,
    is_active boolean default '1' COMMENT '1=active,0=deactive',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key (follow_id) references tbl_post(id),
    foreign key (user_id) references tbl_user(id)
    

);


create table tbl_post_rating (
	id bigint primary key auto_increment,
    user_id bigint,
    rating varchar(64),
	is_active boolean default '1' COMMENT '1=active,0=deactive',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key (user_id) references tbl_user(id)
    

);

create table tbl_contact_us (
	id bigint primary key auto_increment,
    user_id bigint,
    subject varchar(64),
    description text,
    is_active boolean default '1' COMMENT '1=active,0=deactive',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key (user_id) references tbl_user(id)

);


create table tbl_report (
	id bigint primary key auto_increment,
    user_id bigint,
    post_id bigint,
    report_user_id bigint,
    is_active boolean default '1' COMMENT '1=active,0=deactive',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key (user_id) references tbl_user(id),
    foreign key (report_user_id) references tbl_user(id),
    foreign key (post_id) references tbl_post(id)
    

);