create database cargo_ride;

drop database cargo_ride;
use cargo_ride;


create table tbl_user (
	id bigint primary key auto_increment,
    social_id bigint,
    profile_image text,
    company_name varchar(128),
    name varchar(32),
    country_code varchar(8) default '+91',
    mobile bigint unique,
    email varchar(32) unique,
    password varchar(64),
    role enum('user', 'driver', 'admin'),
    step enum('0','1','2') default '0',
    login_status enum('online', 'offline') default 'offline',
	login_type enum('S', 'G', 'F') default 's' comment 's-simple, f-facebook, g-google',
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


create table tbl_package (
	id bigint primary key auto_increment,
    user_id bigint,
	type set('document', 'package'),
    weight int default '0',
    unit int,
    height float(8,1) default'0',
    width float(8,1) default'0',
    notes text,
    schedule timestamp,	
    is_delete boolean default '0' comment '1=delete 0=not_delete',
    is_active boolean default '1' COMMENT '1=active,0=deactive',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key (user_id) references tbl_user(id)
);

create table tbl_location (
	id bigint primary key auto_increment,
    user_id bigint,
	location text,
    latitude varchar(16),
    longitude varchar(16),
    tag enum('current', 'other') DEFAULT 'current',
	is_delete boolean default '0' comment '1=delete 0=not_delete',
    is_active boolean default '1' COMMENT '1=active,0=deactive',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key (user_id) references tbl_user(id)
    
);


create table tbl_vehicle (
	id bigint primary key auto_increment,
    category_type enum('local', 'outstation', 'other'),
    name varchar(64),
    image text,
    capacity varchar(64),
    dimension varchar(64),
    per_km_charge float(8,1),
    per_km_time varchar(16),
    is_delete boolean default '0' comment '1=delete 0=not_delete',
    is_active boolean default '1' COMMENT '1=active,0=deactive',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp
);

create table tbl_vehicle_details(
	id BIGINT AUTO_INCREMENT PRIMARY KEY,
    vehicle_id bigint,
    driver_id BIGINT,
    model varchar(64),
    company_name varchar(128),
    number varchar(16),
    rto varchar(64),
	is_delete boolean default '0' comment '1=delete 0=not_delete',
    is_active boolean default '1' COMMENT '1=active,0=deactive',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key (vehicle_id) references tbl_vehicle(id),
    foreign key (driver_id) references tbl_user(id)
);



create table tbl_receiver(
	id BIGINT AUTO_INCREMENT PRIMARY KEY,
    location_id bigint,
    fullname varchar(64),
    mobile BIGINT,
    country_code varchar(8) DEFAULT '+91',
    location text,
    latitude varchar(16),
    longitude varchar(16),
    is_delete boolean default '0' comment '1=delete 0=not_delete',
    is_active boolean default '1' COMMENT '1=active,0=deactive',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key (location_id) references tbl_location(id)
);



create table tbl_card_details (
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


create table tbl_payment (
	id bigint primary key auto_increment,
    card_id bigint,
    type enum('cod', 'card' ), 
    transaction_id varchar(32),
	is_delete boolean default '0' comment '1=delete 0=not_delete',
    is_active boolean default '1' COMMENT '1=active,0=deactive',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key (card_id) references tbl_card_details(id)

);

create table tbl_cancel_reason(
	id BIGINT PRIMARY KEY AUTO_INCREMENT,
    reason varchar(256),
    is_delete boolean default '0' comment '1=delete 0=not_delete',
    is_active boolean default '1' COMMENT '1=active,0=deactive',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp
);

create table tbl_order (
	id bigint primary key auto_increment,
    driver_id bigint,
    cancel_reason_id bigint DEFAULT '0',
    receiver_location_id BIGINT,
    user_id BIGINT,
    payment_id bigint,
    order_number varchar(16),
    order_date date,
    discount_price float(8,1),
    pod_charge float(8,1),
    total_qty int,
    total_amount int,
    taxes float(8,1),
    grand_total float(8,1),
    status enum('confirmed', 'way to pickup', 'way to dropoff', 'delivered', 'cancel'),
    is_delete boolean default '0' comment '1=delete 0=not_delete',
    is_active boolean default '1' COMMENT '1=active,0=deactive',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
	foreign key (driver_id) references tbl_user(id),
	foreign key (cancel_reason_id) references tbl_cancel_reason(id),
	foreign key (receiver_location_id) references tbl_receiver(id),
	foreign key (user_id) references tbl_user(id),
	foreign key (payment_id) references tbl_payment(id)
    
);



  create table tbl_order_details (
	id bigint primary key auto_increment,
    order_id bigint,
    package_id bigint,
    total_qty int,
    per_package_price float(8,1),
    total_amount float(8,1),
	is_delete boolean default '0' comment '1=delete 0=not_delete',
    is_active boolean default '1' COMMENT '1=active,0=deactive',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp
    
  
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

create table tbl_contact_us(
	id bigint primary key auto_increment,
    name varchar(64),
    company_name varchar(64),
    email varchar(64),
    country_code varchar(16),
    mobile bigint,
	is_active boolean default '1' COMMENT '1=active,0=deactive',
    is_delete boolean default '0' comment '1=delete 0=not_delete',
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp

);


create table tbl_driver_rating_review (
	id bigint primary key auto_increment,
    user_id bigint,
    driver_id bigint,
    rating float(8,1),
    review text,
    is_active boolean default '1' COMMENT '1=active,0=deactive',
    is_delete boolean default '0' comment '1=delete 0=not_delete',
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key (user_id) references tbl_user(id),
    foreign key (driver_id) references tbl_user(id)
    
);


create table tbl_driver_documents (
	id bigint primary key auto_increment,
    driver_id bigint,
    pan_card_front text,
    pan_card_back text,
    driving_license_front text,
    driving_license_back text,
    adhar_card_front text,
    adhar_card_back text,
	is_active boolean default '1' COMMENT '1=active,0=deactive',
    is_delete boolean default '0' comment '1=delete 0=not_delete',
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key (driver_id) references tbl_user(id)


);


create table tbl_pass_reset(
	id BIGINT PRIMARY key AUTO_INCREMENT,
    email varchar(128),
    token varchar(64)
);



create table tbl_driver_availability (
	id bigint primary key auto_increment,
	driver_id bigint,
    day enum('sun', 'mon', 'the', 'wed', 'thu', 'fri', 'sat'),
    start_time varchar(32),
    end_time varchar(32),
    radius varchar(32),
    is_active boolean default '1' COMMENT '1=active,0=deactive',
    is_delete boolean default '0' comment '1=delete 0=not_delete',
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key (driver_id) references tbl_user(id)
);


-- select curdate(date_format()); 

select l.location as sender_location, r.location as reveiver_location, p.type from tbl_order o 
join tbl_receiver r on r.id=o.receiver_location_id
join tbl_location l on l.id=o.pickup_location_id
join tbl_order_details od on od.id=
join tbl_package p on p.id = o.package_id;



select p.type, l.location as pickup_location, r.location as receiver_location, DATE_FORMAT(o.schedule, '%d-%b-%Y') as schedule_date, time_format(o.schedule, '%h:%i %p') as time
from tbl_order_details od 
join tbl_order o on od.order_id=o.id
join tbl_package p on p.id=od.package_id
join tbl_location l on l.id=o.pickup_location_id
join tbl_receiver r on r.id=o.receiver_location_id GROUP BY o.id;

-- history
select o.status,p.type,u.name,u.email,u.mobile, l.location as pickup_location, r.full_name as receiver_name,r.email as receiver_email,r.mobile as receiver_mobile, r.location as receiver_location, DATE_FORMAT(o.schedule, '%d-%b-%Y') as schedule_date, time_format(o.schedule, '%h:%i %p') as time
from tbl_order_details od 
join tbl_order o on od.order_id=o.id
join tbl_package p on p.id=od.package_id
join tbl_location l on l.id=o.pickup_location_id
join tbl_user u on u.id=l.user_id
join tbl_receiver r on r.id=o.receiver_location_id
where o.status='delivered'
GROUP BY o.id;


-- IFNULL((select(CASE when l.product_id !='' then 1 else 0 END) 
--         from tbl_product_like l where l.product_id=p.id AND l.user_id=2),0) as is_like  

select f.*, c.name as category_name, round((select avg(rating) from tbl_food_review_rating where f.id=food_id),1) as avg_rating,
IFNULL((select(CASE when l.food_id !='' then 1 else 0 END) 
        from tbl_food_like l where l.food_id=f.id AND l.user_id=1),0) as is_like  
 from tbl_food f join tbl_category c on c.id = f.category_id
 where c.name like '%%' or (f.price>100 and f.price<160)
 having avg_rating>=3.2 
 ORDER BY is_recomanded desc;
 
 select f.*, c.name as category_name, round((select avg(rating) from tbl_food_review_rating where f.id=food_id),1) as avg_rating,
                                                IFNULL((select(CASE when l.food_id !='' then 1 else 0 END) 
                                                        from tbl_food_like l where l.food_id=f.id AND l.user_id=1),0) as is_like  
                                                 from tbl_food f join tbl_category c on c.id = f.category_id;
                                                 
                                                 
                                                 
                                                 
select r.*,
ROUND(
		(6371 * acos( cos( radians(ul.latitude) ) 
		* cos( radians (r.latitude) )
        * cos( radians (r.longitude) - radians(ul.longitude))
        + sin( radians(ul.latitude))
        * sin( radians (r.latitude) ) ) )) as distance_in_killometers
 from tbl_restaurant r join tbl_user_location ul on ul.user_id=1 having distance_in_killometers<20;
 
 
 
 
 select f.*, r.location as restaurant_location,round((select avg(rating) from tbl_food_review_rating where f.id=food_id),1) as avg_rating,
 IFNULL((select(CASE when l.food_id !='' then 1 else 0 END) 
        from tbl_food_like l where l.food_id=f.id AND l.user_id=1),0) as is_like  
 from tbl_food f JOIN tbl_restaurant r on r.id=f.restaurant_id;
 
 
 
 
 select *,case 
                        when v.discount_type = 'flat' then  f.price - v.discount_value
                        when v.discount_type = 'percentage' then  f.price -  (f.price * v.discount_value/100) 
                        else 0
                    end as new_price from tbl_food as f
                    join tbl_voucher v on v.id=1
                    where f.id=1;
                    
                    
                    select *, 0 as new_price from tbl_food;
                    
                    select * from tbl_order;
                    
                    
                    
                    select f.*,round((select avg(rating) from tbl_food_review_rating where f.id=food_id),1) as avg_rating,
					IFNULL((select(CASE when l.food_id !='' then 1 else 0 END) 
					from tbl_food_like l where l.food_id=f.id AND l.user_id=1),0) as is_like 
                    from tbl_food_like l
                    join tbl_food f on f.id=l.food_id where user_id=1;
                    
                    
                    
                    select f.image, f.name, o.status, o.order_date, o.grand_total from tbl_order_details od join tbl_order o on od.order_id=o.id
                    join tbl_food f on f.id=od.food_id;
                    
                    select * from tbl_ingrediants;
                    
                    select f.image, f.name, f.price, c.qty, ingrediant from tbl_cart c join tbl_food f on c.food_id=f.id;
                    
                    
                    select * from tbl_voucher where voucher_code like '%%';