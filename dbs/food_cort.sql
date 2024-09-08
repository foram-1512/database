create database food_cort;
use food_cort;

create table tbl_user(
    id bigint primary key auto_increment,
    social_id bigint,
    username varchar(32),
    email_mobile varchar(128),
    password varchar(64),
    role enum('user', 'driver'),
	login_type enum('S', 'G', 'F') default 'S' comment 's-simple, f-facebook, g-google',
    otp_code int(8) default'0',
    otp_verification boolean default '0' comment '0=Unverified 1=Verified',
    is_forgot boolean default '0' comment '1=forgot, 0=not-forgot',
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

create table tbl_user_location(
	id bigint AUTO_INCREMENT primary key,
    user_id bigint,
    location text,
    latitude varchar(16),
    longitude varchar(16),
	is_active boolean default '1' COMMENT '1=active,0=deactive',
    is_delete boolean default '0' comment '1=delete 0=not_delete',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key (user_id) references tbl_user(id)
);


create table tbl_category(
	id bigint AUTO_INCREMENT PRIMARY key,
    name varchar(128),
    image text,
    is_active boolean default '1' COMMENT '1=active,0=deactive',
    is_delete boolean default '0' comment '1=delete 0=not_delete',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp
);

create table tbl_restaurant(
	id bigint AUTO_INCREMENT PRIMARY key,
    name varchar(128),
    image text,
    location text,
    latitude varchar(16),
    longitude varchar(16),
    opening_time time,
    closing_time time,
    is_active boolean default '1' COMMENT '1=active,0=deactive',
    is_delete boolean default '0' comment '1=delete 0=not_delete',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp
);

create table tbl_food(
	id bigint AUTO_INCREMENT PRIMARY key,
    restaurant_id bigint,
    catrgory_id bigint,
    image text,
    name varchar(128),
    calories varchar(16),
    avg_time varchar(32),
    description text,
    price float,
    is_recomanded boolean default '0' COMMENT '1=recomanded,0=not recomanded',
	is_active boolean default '1' COMMENT '1=active,0=deactive',
    is_delete boolean default '0' comment '1=delete 0=not_delete',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key (restaurant_id) references tbl_restaurant(id),
    foreign key (catrgory_id) references tbl_category(id)
);

create table tbl_ingrediants(
	id bigint AUTO_INCREMENT PRIMARY key,
    name varchar(64),
    image text,
    is_active boolean default '1' COMMENT '1=active,0=deactive',
    is_delete boolean default '0' comment '1=delete 0=not_delete',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp
);

create table tbl_food_like(
	id bigint AUTO_INCREMENT PRIMARY key,
    food_id bigint,
    user_id bigint,
	is_active boolean default '1' COMMENT '1=active,0=deactive',
    is_delete boolean default '0' comment '1=delete 0=not_delete',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key (food_id) references tbl_food(id),
    foreign key (user_id) references tbl_user(id)
);


create table tbl_food_review_rating(
	id bigint AUTO_INCREMENT PRIMARY key,
    food_id bigint,
    user_id bigint,
    rating float(5,1),
    review text,
    is_active boolean default '1' COMMENT '1=active,0=deactive',
    is_delete boolean default '0' comment '1=delete 0=not_delete',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key (food_id) references tbl_food(id),
    foreign key (user_id) references tbl_user(id)
);


create table tbl_restaurant_review_rating(
	id bigint AUTO_INCREMENT PRIMARY key,
    restaurant_id bigint,
    user_id bigint,
    rating float(5,1),
    review text,
    is_active boolean default '1' COMMENT '1=active,0=deactive',
    is_delete boolean default '0' comment '1=delete 0=not_delete',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key (restaurant_id) references tbl_restaurant(id),
    foreign key (user_id) references tbl_user(id)
);


create table tbl_cart(
	id bigint AUTO_INCREMENT PRIMARY key,
    food_id bigint,
    user_id bigint,
    qty int,
    ingrediant varchar(32),
    ingrediant_qty int,
    is_active boolean default '1' COMMENT '1=active,0=deactive',
    is_delete boolean default '0' comment '1=delete 0=not_delete',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key (food_id) references tbl_food(id),
    foreign key (user_id) references tbl_user(id)
);


create table tbl_voucher(
	id  bigint AUTO_INCREMENT PRIMARY key,
    image text,
    voucher_name varchar(128),
    voucher_code varchar(32),
    discount_type enum('flat', 'percentage'),
    discount_value varchar(16),
	is_active boolean default '1' COMMENT '1=active,0=deactive',
    is_delete boolean default '0' comment '1=delete 0=not_delete',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp
);
drop table card;
create table tbl_card (
	id bigint primary key auto_increment,
    user_id bigint,
    number bigint,
    holdername varchar(64),
    expiry_month int,
    expiry_year int,
    is_delete boolean default '0' comment '1=delete 0=not_delete',
    is_active boolean default '1' COMMENT '1=active,0=deactive',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key (user_id) references tbl_user(id)
);



create table tbl_order(
	id  bigint AUTO_INCREMENT PRIMARY key,
    user_id bigint,
    voucher_id bigint,
    address_id bigint,
    card_id bigint,
    payment_method enum('card', 'cod'),
    order_number varchar(16),
    order_date date,
    total_qty int,
    total_price float(8,1),
    discount_price float(8,1),
    shipping_cose int,
    grand_total float(8,1),
    status enum('completed', 'on progress', 'cancelled') default 'on progress',
    is_active boolean default '1' COMMENT '1=active,0=deactive',
    is_delete boolean default '0' comment '1=delete 0=not_delete',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
	foreign key (user_id) references tbl_user(id),
    foreign key (voucher_id) references tbl_voucher(id),
    foreign key (address_id) references tbl_user_location(id),
    foreign key (card_id) references tbl_card(id)
);


create table tbl_order_details(
	id bigint AUTO_INCREMENT PRIMARY key,
    user_id bigint,
    food_id bigint,
    order_id bigint,
    qty int,
    per_food_price float(8,1),
    total_amount float(8,1),
	is_active boolean default '1' COMMENT '1=active,0=deactive',
    is_delete boolean default '0' comment '1=delete 0=not_delete',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key (user_id) references tbl_user(id),
    foreign key (food_id) references tbl_food(id),
    foreign key (order_id) references tbl_order(id)
);


create table tbl_notification (
	id bigint primary key auto_increment,
    sender_id bigint,
    sender_type enum('user', 'admin', 'bysystem'),
    receiver_type enum('user'),
	title varchar(512) ,
	content text ,
    read_status enum('read','unread') DEFAULT 'unread',
	is_active boolean default '1' COMMENT '1=active,0=deactive',
    is_delete boolean default '0' comment '1=delete 0=not_delete',
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key (sender_id) references tbl_user(id)

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


create table tbl_banner(
	id bigint AUTO_INCREMENT PRIMARY KEY,
    image text,
    is_active boolean default '1' COMMENT '1=active,0=deactive',
    is_delete boolean default '0' comment '1=delete 0=not_delete',
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp
);



create table tbl_notification (
	id bigint primary key auto_increment,
    sender_id bigint,
    receiver_id bigint,
    sender_type enum('user', 'admin', 'bysystem'),
    receiver_type enum('user'),
	title varchar(512) ,
	content text ,
    type varchar(32),
    read_status enum('read','unread') DEFAULT 'unread',
	is_active boolean default '1' COMMENT '1=active,0=deactive',
    is_delete boolean default '0' comment '1=delete 0=not_delete',
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key (sender_id) references tbl_user(id),
    foreign key (receiver_id) references tbl_user(id)


);


select f.* from tbl_food f 
join tbl_category c on c.id=f.category_id
where c.name='pizza' and (f.price>100 and f.price<200);