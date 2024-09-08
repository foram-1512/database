create database store;
use store;

create table tbl_subscription(
	id bigint AUTO_INCREMENT PRIMARY KEY,
    subscription_id bigint,
    customer_id varchar(64),
    price_id varchar(64),
    foreign key (subscription_id) references tbl_subscription_detail(id),
    foreign key (customer_id) references tbl_user(stripe_id)
);

create table tbl_user_subscription(
	id  BIGINT AUTO_INCREMENT PRIMARY key,
	customer_id VARCHAR(64),
    subscription_id varchar(64),
    start_date date,
    end_date date,
    total_amount float(8,2)
);


create table tbl_subscription_detail(
	id bigint AUTO_INCREMENT PRIMARY KEY,
    name varchar(128),
    description text,
    price float(8,2)
);

create table tbl_category(
	id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name varchar(128),
    image text,
	is_active boolean default '1' COMMENT '1=active,0=deactive',
    is_delete boolean default '0' comment '1=delete 0=not_delete',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp
);


create table tbl_subcategory(
	id BIGINT AUTO_INCREMENT PRIMARY KEY,
    category_id bigint,
    name varchar(128),
    image text,
	is_active boolean default '1' COMMENT '1=active,0=deactive',
    is_delete boolean default '0' comment '1=delete 0=not_delete',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key (category_id) references tbl_category(id)
);

create table tbl_product(
	id BIGINT AUTO_INCREMENT PRIMARY KEY,
    category_id bigint,
    name varchar(128),
    image text,
    time varchar(64),
    size varchar(64),
	discount_type enum('flat', 'percentage'),
    discount_value varchar(16),
    price float(8,1),
    is_active boolean default '1' COMMENT '1=active,0=deactive',
    is_delete boolean default '0' comment '1=delete 0=not_delete',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key (category_id) references tbl_subcategory(id)
);