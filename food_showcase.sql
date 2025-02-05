create database db_food_showcase;
use db_food_showcase;

create table tbl_user (
	id bigint primary key auto_increment not null,
    social_id bigint,
    fullname varchar(128) not null,
    mobile_number varchar(16) not null unique,
    email varchar(128) not null unique,
    login_type enum('S', 'F'),
    password varchar(128) not null,
    role enum('User') default 'user' not null,
    is_active tinyint default '1' COMMENT '1=active,0=deactive',
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp
);

INSERT INTO tbl_user (fullname, mobile_number, email, login_type, password, role)
VALUES
('Priya Sharma', '1234567890', 'priya@gmail.com', 'S', '3001', 'User'),
('Foram Panchal', '9876543210', 'foram@gmail.com', 'F', '1512', 'User'),
('Anjali Singh', '5551234567', 'anjali@gmail.com', 'S', '2001', 'User'),
('Pooja Gupta', '9995551234', 'pooja@gmail.com', 'F', '1234', 'User'),
('Divya Tirthani', '4442223333', 'divya@gmail.com', 'F','2000', 'User');


create table tbl_user_location(
	id bigint primary key auto_increment not null,
    user_id bigint not null,
    location_type enum('Home', 'Office', 'Other'),
    address text,
	latitude varchar(64) not null,
    longitude varchar(64) not null,
	is_active tinyint default '1' COMMENT '1=active,0=deactive',
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key (user_id) references tbl_user(id)
);

INSERT INTO tbl_user_location (user_id, location_type, address, latitude, longitude)
VALUES
(1, 'Home', '123, Example Street, Ahmedabad', '23.0225', '72.5714'),
(2, 'Office', '456, Sample Road, Ahmedabad', '23.0396', '72.5660'),
(3, 'Other', '789, Test Avenue, Ahmedabad', '23.0225', '72.5714'),
(4, 'Home', '321, Demo Lane, Ahmedabad', '23.0225', '72.5714'),
(5, 'Office', '654, Trial Boulevard, Ahmedabad', '23.0225', '72.5714');

create table tbl_restaurant (
	id bigint primary key auto_increment,
    name varchar(128) not null,
    avg_rating float(5,1),
    image varchar(128) default 'restaurant.jpg',
    total_reviews int(8),
    free_delivery boolean default '0' comment '0=free, 1=paid',
    delivery_time varchar(64) not null,
    is_card boolean default '0' comment '0=Available, 1=unavailable',
    about_us text,
    address text,
	latitude varchar(64) not null,
    longitude varchar(64) not null,
-- 	is_like boolean default '0' comment '0=dislike, 1=like',
--  is_open boolean default '0' comment '0=open, 1=close',
    is_active tinyint default '1' COMMENT '1=active,0=deactive',
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp
);

INSERT INTO tbl_restaurant (name, avg_rating,delivery_time, address, latitude, longitude)
VALUES
('Spice N Grill', 0, '30 minutes', '123, Example Street, Ahmedabad', '23.0225', '72.5714'),
('Tandoori Flames', 0, '40 minutes', '456, Sample Road, Ahmedabad', '23.0396', '72.5660'),
('Natraj Dining Hall', 0, '25 minutes', '789, Test Avenue, Ahmedabad', '23.0225', '72.5714'),
('Purohit Restaurant', 0, '35 minutes', '321, Demo Lane, Ahmedabad', '23.0225', '72.5714'),
('Cafe Upper Crust', 0, '45 minutes', '654, Trial Boulevard, Ahmedabad', '23.0225', '72.5714');

create table tbl_dish (
	id bigint primary key auto_increment,
    restaurant_id bigint not null,
    name varchar(128) not null,
    image varchar(128) default 'food1.jpg',
    price float(8,2) not null,
    order_count int,
-- 	is_like boolean default '0' comment '0=dislike, 1=like',
    total_likes int,
	is_active tinyint default '1' COMMENT '1=active,0=deactive',
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key (restaurant_id) references tbl_restaurant(id)
);

INSERT INTO tbl_dish (restaurant_id, name, image, price, order_count)
VALUES
(1, 'Paneer Tikka', 'paneer_tikka.jpg', 250.00, 50),
(1, 'Veg Biryani', 'veg_biryani.jpg', 200.00, 30),
(2, 'Chole Bhature', 'chole_bhature.jpg', 150.00, 40),
(2, 'Dal Tadka', 'dal_tadka.jpg', 120.00, 20),
(3, 'Pav Bhaji', 'pav_bhaji.jpg', 180.00, 35),
(3, 'Dhokla', 'dhokla.jpg', 100.00, 25),
(4, 'Aloo Paratha', 'aloo_paratha.jpg', 80.00, 60),
(4, 'Pani Puri', 'pani_puri.jpg', 50.00, 70),
(5, 'Vegetable Chow Mein', 'chow_mein.jpg', 180.00,70),
(5, 'Spring Rolls', 'spring_rolls.jpg', 120.00, 55),
(3, 'Margherita Pizza', 'margherita_pizza.jpg', 300.00, 25),
(2, 'Pasta Primavera', 'pasta_primavera.jpg', 250.00, 35);

create table tbl_restaurant_rating_review (
	id bigint primary key auto_increment,
    user_id bigint,
    restaurant_id  bigint,
    rating float(5,1),
    reviews text,
    is_active tinyint default '1' COMMENT '1=active,0=deactive',
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key (user_id) references tbl_user(id),
    foreign key (restaurant_id) references tbl_restaurant(id)
);

INSERT INTO tbl_restaurant_rating_review (user_id, restaurant_id, rating, reviews)
VALUES
(1, 1, 0, 'Great food and excellent service!'),
(2, 1, 0, 'The paneer tikka was delicious but the biryani was a bit too spicy for my taste.'),
(3, 2, 0, 'Enjoyed the chole bhature!'),
(4, 2, 0, 'The dal tadka was okay, but nothing special.'),
(5, 3, 0, 'Pav bhaji was amazing, loved it!'),
(6, 3, 0, 'Dhokla was tasty, but a little too oily for my liking.'),
(7, 4, 0, 'Aloo paratha was yummy, but the pani puri was a bit too sweet.'),
(8, 4, 0, 'Pani puri was good, but the aloo paratha was a bit dry.'),
(9, 5, 0, 'The vegetable chow mein was delicious!'),
(10, 5, 0, 'Spring rolls were crispy and flavorful, loved it!');

create table tbl_restaurant_timing (
	id bigint primary key auto_increment,
    restaurant_id  bigint,
    day enum('Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'),
    opening_time time,
    closing_time time,
    is_active tinyint default '1' COMMENT '1=active,0=deactive',
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key (restaurant_id) references tbl_restaurant(id)
);

INSERT INTO tbl_restaurant_timing (restaurant_id, day, opening_time, closing_time)
VALUES
(1, 'Mon', '10:00:00', '09:00:00'),
(2, 'Tue', '10:00:00', '09:00:00'),
(3, 'Wed', '10:00:00', '09:00:00'),
(4, 'Thu', '10:00:00', '09:00:00'),
(5, 'Fri', '10:00:00', '10:00:00'),
(1, 'Sat', '10:00:00', '11:00:00'),
(2, 'Sun', '10:00:00', '11:00:00');

create table tbl_banner(
	id bigint primary key auto_increment,
    restaurant_id bigint,
    image varchar(128),
    is_active tinyint default '1' COMMENT '1=active,0=deactive',
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp ,
    foreign key (restaurant_id) references tbl_restaurant(id)
);

INSERT INTO tbl_banner (restaurant_id, image)
VALUES
(1, 'banner1.jpg'),
(2, 'banner2.jpg'),
(3, 'banner3.jpg'),
(4, 'banner4.jpg'),
(5, 'banner5.jpg');

create table tbl_like(
	id bigint primary key  auto_increment,
    restaurant_id bigint,
    user_id bigint,
    is_active tinyint default '1' COMMENT '1=active,0=deactive',
    foreign key (user_id) references tbl_user(id),
    foreign key (restaurant_id) references tbl_restaurant(id)
);

INSERT INTO tbl_like (restaurant_id, user_id)
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(1, 2),
(2, 1),
(3, 5);

INSERT INTO tbl_restaurant_timing (restaurant_id, day, opening_time, closing_time, is_available ) VALUES
    (1, 'Mon', '08:00:00', '20:00:00' , 0),
    (1, 'Tue', '08:00:00', '20:00:00' , 0),
    (1, 'Wed', '08:00:00', '20:00:00' , 0),
    (1, 'Thu', '08:00:00', '20:00:00' , 0),
    (1, 'Fri', '08:00:00', '20:00:00' , 0),
    (1, 'Sat', '08:00:00', '20:00:00' , 0),
    (1, 'Sun', '08:00:00', '20:00:00' , 0);

INSERT INTO tbl_restaurant_timing (restaurant_id, day, opening_time, closing_time , is_available) VALUES
    (2, 'Mon', '09:00:00', '22:00:00' , 0),
    (2, 'Tue', '09:00:00', '22:00:00' , 0),
    (2, 'Wed', '09:00:00', '22:00:00' , 0),
    (2, 'Thu', '09:00:00', '22:00:00' , 0),
    (2, 'Fri', '09:00:00', '22:00:00' , 0),
    (2, 'Sat', '09:00:00', '22:00:00' , 0),
    (2, 'Sun', '09:00:00', '22:00:00' , 1);

INSERT INTO tbl_restaurant_timing (restaurant_id, day, opening_time, closing_time , is_available) VALUES
    (3, 'Mon', '10:00:00', '21:00:00' , 0),
    (3, 'Tue', '10:00:00', '21:00:00' , 0),
    (3, 'Wed', '10:00:00', '21:00:00' , 0),
    (3, 'Thu', '10:00:00', '21:00:00' , 0),
    (3, 'Fri', '10:00:00', '21:00:00' , 0),
    (3, 'Sat', '10:00:00', '21:00:00' , 0),
    (3, 'Sun', '10:00:00', '21:00:00' , 0);

INSERT INTO tbl_restaurant_timing (restaurant_id, day, opening_time, closing_time, is_available) VALUES
    (4, 'Mon', '07:30:00', '19:30:00', 0),
    (4, 'Tue', '07:30:00', '19:30:00', 0),
    (4, 'Wed', '07:30:00', '19:30:00', 0),
    (4, 'Thu', '07:30:00', '19:30:00', 0),
    (4, 'Fri', '07:30:00', '19:30:00', 0),
    (4, 'Sat', '07:30:00', '19:30:00', 0),
    (4, 'Sun', '07:30:00', '19:30:00', 0);

INSERT INTO tbl_restaurant_timing (restaurant_id, day, opening_time, closing_time , is_available) VALUES
    (5, 'Mon', '11:00:00', '23:00:00', 0),
    (5, 'Tue', '11:00:00', '23:00:00', 0),
    (5, 'Wed', '11:00:00', '23:00:00', 0),
    (5, 'Thu', '11:00:00', '23:00:00', 0),
    (5, 'Fri', '11:00:00', '23:00:00', 0),
    (5, 'Sat', '11:00:00', '23:00:00', 0),
    (5, 'Sun', '11:00:00', '23:00:00', 1);




-- QUERIES
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 1.login with facebook user
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
select * from tbl_user where email='foram@gmail.com' and password='1512'and login_type='F' and is_active=1;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 2.login with simple user
-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------
select * from tbl_user where email='priya@gmail.com' and password='3001'and login_type='S' and is_active=1;

-- --------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 3.login with email or mobile number
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
select * from tbl_user where (email='foram@gmail.com' or mobile_number='9876543210') and is_active=1;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 4 forget password
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
update tbl_user set password='1512' where email='foram@gmail.com';

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 5.current location  type-home
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
select * from tbl_user_location where location_type='Home'and is_active=1;

select ul.user_id, ul.location_type, ul.address from tbl_user_location ul join tbl_user u on ul.user_id=u.id where ul.location_type='Home' and ul.user_id=1;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 6.current location  type-Office
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
select * from tbl_user_location where location_type='Office'and is_active=1;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 7.current location  type-Other
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
select * from tbl_user_location  where location_type='Other'and is_active=1;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 8.display restaurant banner
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
select * from tbl_banner where is_active=1;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 9.display restaurants nearby
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
select r.id,r.image,r.name,r.free_delivery,r.avg_rating,r.delivery_time,r.address,ROUND(6371 * acos( cos( radians(ul.latitude) ) 
		* cos( radians (r.latitude) )
        * cos( radians (r.longitude) - radians(ul.longitude))
        + sin( radians(ul.latitude))
        * sin( radians (r.latitude) ) ) ) as distance_km from tbl_restaurant r join tbl_user_location  ul on ul.user_id=1 and ul.location_type='Home'
        where r.is_active=1 having distance_km < 6 order by distance_km;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 10.top picks
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
select id,name,image,price,order_count  from tbl_dish group by order_count desc limit 5;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 11 restaurant details
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
select r.id,r.image,r.name,r.avg_rating,r.total_reviews,
TIME_FORMAT(t.opening_time,"%H:%i") as open,
TIME_FORMAT(t.closing_time,"%H:%i") as close,
r.free_delivery,r.is_card,r.about_us,
date_format(current_date(), '%a') as Day_Name,
ifnull((select (case when l.restaurant_id !='' then 1 else 0 end ) 
from tbl_like l where l.restaurant_id = r.id and  l.user_id = 1),0) as is_likes 
 from tbl_restaurant r join tbl_restaurant_timing t on t.restaurant_id = r.id where r.id=1 and t.day=date_format(current_date(), '%a');


select r.*, 
	ifnull( (select (case when l.restaurant_id !='' then 1 else 0 end) 
	from tbl_like l where l.restaurant_id=r.id and l.user_id=1),0) as is_like, 
	rt.opening_time, rt.closing_time,
	lower( date_format(current_date(), '%a')) as dayname
	from tbl_restaurant r
    join tbl_restaurant_timing rt on r.id=rt.restaurant_id where r.id=2 and rt.day=date_format(current_date(), '%a');


select r.*,date_format(current_date(), '%a'),
ifnull( (select (case when l.restaurant_id !='' then 1 else 0 end) 
	from tbl_like l where l.restaurant_id=r.id and l.user_id=5),0) as is_like,
    rt.opening_time, rt.closing_time, date_format(current_date(), '%a')
    from tbl_restaurant r join tbl_restaurant_timing rt on rt.restaurant_id=r.id where r.id=1;
    -- and rt.day=date_format(current_date(), '%a');

select r.*,date_format(current_date(), '%a'),
ifnull( (select (case when l.restaurant_id !='' then 1 else 0 end) 
	from tbl_like l where l.restaurant_id=r.id and l.user_id=5),0) as is_like,
    rt.opening_time, rt.closing_time, date_format(current_date(), '%a')
    from tbl_restaurant r join tbl_restaurant_timing rt on rt.restaurant_id=r.id where r.id=1
    and rt.day='Wed';

----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 13 is_like
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
 select * ,ifnull((select (case when l.restaurant_id !='' then 1 else 0 end )
 from tbl_like l where l.restaurant_id = r.id and  l.user_id = 1),0) as is_likes 
 from tbl_restaurant r;
 
 -- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 14 Display perticular dish
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
select * from tbl_dish where restaurant_id=2;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 15 Display rate and review
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
select * from tbl_restaurant_rating_review where  restaurant_id=1;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------