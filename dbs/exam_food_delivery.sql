create table tbl_user (
	id bigint primary key auto_increment,
    social_id bigint,
	fullname varchar(128),
    country_code varchar(8) default '+91',
    mobile bigint unique,
    email varchar(64) unique,
    password varchar(64),
    login_type enum('S', 'F', 'T', 'A') default 'S' comment 's-simple, f-facebook, a-Apple, t-twitter',
    step enum('1','2'),
    otp_code int(8) default '0',
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

create table tbl_restaurant(
	id  BIGINT PRIMARY key AUTO_INCREMENT,
    name varchar(128),
    image text,
    delivery_type enum ('Free', 'Paid'),
    delivery_time varchar(128),
    is_active boolean default '1' COMMENT '1=active,0=deactive',
    is_delete boolean default '0' comment '1=delete 0=not_delete',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp
);

create table tbl_food(
	id bigint PRIMARY KEY AUTO_INCREMENT,
    restaurant_id bigint,
    name varchar(256),
    image text,
    description text,
    size varchar(128),
    ingrediants varchar(128),
     is_active boolean default '1' COMMENT '1=active,0=deactive',
    is_delete boolean default '0' comment '1=delete 0=not_delete',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key (restaurant_id) references tbl_restaurant(id)
);

create table tbl_ingrediant(
	id bigint primary key AUTO_INCREMENT,
    name varchar(128),
    image text,
	is_active boolean default '1' COMMENT '1=active,0=deactive',
    is_delete boolean default '0' comment '1=delete 0=not_delete',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp
);

create table tbl_size(
	id bigint PRIMARY key AUTO_INCREMENT,
    food_id bigint,
    size varchar(128),
    is_active boolean default '1' COMMENT '1=active,0=deactive',
    is_delete boolean default '0' comment '1=delete 0=not_delete',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key (food_id) references tbl_food(id)
);

create table tbl_combination(
	id bigint primary key AUTO_INCREMENT,
    food_id bigint,
    size_id bigint,
    price float(8,1),
	is_active boolean default '1' COMMENT '1=active,0=deactive',
    is_delete boolean default '0' comment '1=delete 0=not_delete',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
      foreign key (food_id) references tbl_food(id),
    foreign key (size_id) references tbl_size(id)
);

create table tbl_restaurant_review_rating (
	id bigint primary key auto_increment,
    user_id bigint,
	restaurant_id bigint,
    rating float(5,1) default '0',
    review text,
	is_active boolean default '1' COMMENT '1=active,0=deactive',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key (user_id) references tbl_user(id),
    foreign key (restaurant_id) references tbl_restaurant(id)
);


create table tbl_food_review_rating (
	id bigint primary key auto_increment,
    user_id bigint,
	food_id bigint,
    rating float(5,1) default '0',
    review text,
	is_active boolean default '1' COMMENT '1=active,0=deactive',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key (user_id) references tbl_user(id),
    foreign key (food_id) references tbl_food(id)
);

create table tbl_food_like(
	id bigint AUTO_INCREMENT PRIMARY KEY,
    user_id bigint,
    food_id BIGINT,
    is_active boolean default '1' COMMENT '1=active,0=deactive',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key (user_id) references tbl_user(id),
    foreign key (food_id) references tbl_food(id)
);


select *,(select avg(rating) FROM tbl_restaurant_review_rating rr where r.id=rr.restaurant_id) as avg_rating from tbl_restaurant r;

create table tbl_cart_details(
	id bigint primary key auto_increment,
    user_id bigint,
    food_id bigint,
    qty int default '1',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
	is_active boolean default '1' COMMENT '1=active,0=inactive',
    foreign key (food_id) references tbl_food(id),
    foreign key (user_id) references tbl_user(id)
    
);
select f.*,s.size,( SELECT ifnull((SELECT (CASE WHEN l.food_id!='' then 1 else 0 end) 
        FROM tbl_food_like l WHERE l.food_id=f.id and l.user_id=1),0)) as is_like,ROUND( (SELECT AVG(rr.rating ) 
        FROM tbl_food_review_rating AS rr WHERE f.id = rr.food_id AND rr.is_active = 1 ) ,1 ) as avg_rating,c.*,r.delivery_type,
        r.delivery_time from tbl_food f join tbl_restaurant r on r.id= f.restaurant_id join tbl_combination c on 
        c.food_id= f.id join tbl_size s on s.id = c.size_id WHERE c.id=1 and c.is_active=1 and f.is_active=1;



create table tbl_order (
	id bigint primary key auto_increment,
    user_id bigint,
    order_no varchar(64),
    order_date datetime,
    total_qty int,
    total_amount int,
    delivery_charges int,
    grand_total int ,
    status enum ('pending', 'delivered', 'cancelled', 'shipped'),
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
	is_active boolean default '1' COMMENT '1=active,0=inactive',
    foreign key (user_id) references tbl_user(id)

);





create table tbl_order_details (
	id bigint primary key auto_increment,
    food_id bigint,
    order_id bigint ,
    ingrediants text,
    total_qty int,
    per_price float(8,2),
    total int,
	status enum ('pending', 'delivered', 'cancelled', 'shipped'),
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
	is_active boolean default '1' COMMENT '1=active,0=inactive',
    foreign key (food_id) references tbl_food(id),
    foreign key (order_id) references tbl_order(id)
);
