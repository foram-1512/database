create database db_06_03_2024;
use db_06_03_2024;

create table tbl_user (
	id bigint primary key auto_increment not null,
    social_id bigint,
    fullname varchar(128) not null,
    phone varchar(16) not null unique,
    email varchar(128) not null unique,
    login_type enum('S', 'F'),
    password varchar(128) not null,
    role enum('User') default 'user' not null,
    is_active tinyint default '1' COMMENT '1=active,0=deactive',
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp
);

insert into tbl_user (fullname, phone, email, login_type, password) values 
('Abhi', '9876543210', 'abhi@gmail.com', 'S', 'abhi123'),
('Mayur', '9976543210', 'mayur@gmail.com', 'S', 'mayur123'),
('Abdul', '9996543210', 'abdul@gmail.com', 'F', 'abdul123'),
('Viral', '9886543210', 'viral@gmail.com', 'S', 'viral123'),
('Foram', '9889543210', 'foram@gmail.com', 'S', 'foram123')
;


create table tbl_user_location(
	id bigint primary key auto_increment not null,
    user_id bigint not null,
    location_type enum('Home', 'Office', 'Other'),
    address text,
	latitude varchar(64) not null,
    longtitude varchar(64) not null,
	is_active tinyint default '1' COMMENT '1=active,0=deactive',
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key (user_id) references tbl_user(id)
);

insert into tbl_user_location (user_id, address, location_type, latitude, longtitude) values
	(1,'vakhariya nager Nr.sharda circle, Vardhaman Nagar, Kalol, Gujarat 382721', 'home', '23.2417356', '72.4892562'),
    (1,'Near, D-404, Shivalik High-Street, Ahmedabad, Gujarat 380015', 'office', '23.0299327', '72.527958'),
	(2,'3GJM+7HG, Rana Pratap Marg, Chanakyapuri, Ahmedabad, Gujarat 380061', 'other', '23.0752626', '72.5228597'),
    (2,'Ganesh Meridian, BLOCK-C, Sarkhej - Gandhinagar Hwy, Sola, Ahmedabad, Gujarat 380061', 'office', '23.0752323', '72.5208067'),
    (4,'Akhbar Nagar, Nava Vadaj, Ahmedabad, Gujarat 380081', 'home', '23.0675597', '72.5598283'),
    (4,'Opp Kali Bari Temple, Rajpath, Bopal Rd, Ahmedabad, Gujarat 380058', 'other', '23.036822', '72.4768563'),
    (3,'Sarkhej - Gandhinagar Hwy, opp. Shalby Hospital, Ahmedabad, Gujarat 380058', 'home', '23.0197507', '72.5017381'),
    (3,'L J ,  Sanand - Sarkhej Rd, Makarba, Sarkhej-Okaf, Gujarat 380054', 'other', '22.9909248', '72.4852888'),
    (5,'Station Rd, Sardar Bagh, Kadi, Gujarat 382715', 'home', '23.2944501', '72.3254267'),
    (5,'Impero IT service pvt ltd,  Makarba, Ahmedabad, Gujarat 380051', 'office', '22.9931086', '72.4963036');


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
    longtitude varchar(64) not null,
    is_active tinyint default '1' COMMENT '1=active,0=deactive',
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp
);

insert into tbl_restaurant (name, free_delivery, delivery_time, is_card, about_us, address, latitude, longtitude) values 
('Honest', 0, '10-15 min', 0, ' We pride ourselves on the honesty and quality', 'Ground Floor, Shapath Hexa, G-8-9, Sarkhej - Gandhinagar Hwy, beside Domino’s, opp. Gujarat High Court, Vishwas City 1, Sola, Ahmedabad, Gujarat 380060', '23.0744438', '72.50707'),
('Candela Restaurant', 1, '10-15 min', 1, ' We pride ourselves on the honesty and quality', 'Candela restaurant and banquet,kalasagar mall, near, sattadhar char Rasta, Ahmedabad, Gujarat 380061', '23.0645722', '72.5244507'),
('Ripples Restaurant', 0, '20-25 min', 0, ' We pride ourselves on the honesty and quality', 'Off S.G. Road, Thaltej, Ahmedabad, Gujarat 380006', '23.0581556', '72.4935465'),
('Silver Platter Restaurant', 0, '20-25 min', 0, ' We pride ourselves on the honesty and quality', 'Shivanand Arcade, Borisana Rd, Sitaram Nagar, Kalol, Borishana, Gujarat 382721', '23.2368063', '72.4636397'),
('Sunrise Hotel', 1, '25-30 min', 1, ' We pride ourselves on the honesty and quality', 'Ujala, Sarkhej Cir, Sarkhej, Sarkhej-Okaf, Gujarat 382210', '22.9775992', ',72.4721611');

create table tbl_dish (
	id bigint primary key auto_increment,
    restaurant_id bigint not null,
    name varchar(128) not null,
    image varchar(128) default 'food1.jpg',
    price float(8,2) not null,
    order_count int,
	is_like boolean default '0' comment '0=dislike, 1=like',
    total_likes int,
	is_active tinyint default '1' COMMENT '1=active,0=deactive',
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key (restaurant_id) references tbl_restaurant(id)
);

truncate tbl_dish;
-- Insert dishes for Restaurant 1
INSERT INTO tbl_dish (restaurant_id, name, price)
VALUES
    (1, 'Spaghetti Carbonara', 12.99),
    (1, 'Margherita Pizza', 10.99),
    (1, 'Caesar Salad', 8.99),
    (1, 'Grilled Salmon', 16.99),
    (1, 'Tiramisu', 6.99);

-- Insert dishes for Restaurant 2
INSERT INTO tbl_dish (restaurant_id, name, price)
VALUES
    (2, 'Sushi Platter', 24.99),
    (2, 'Teriyaki Chicken', 14.99),
    (2, 'Miso Soup', 3.99),
    (2, 'Tempura Shrimp', 18.99),
    (2, 'Green Tea Ice Cream', 5.99);

-- Insert dishes for Restaurant 3
INSERT INTO tbl_dish (restaurant_id, name, price)
VALUES
    (3, 'Steak Frites', 22.99),
    (3, 'French Onion Soup', 9.99),
    (3, 'Escargot', 16.99),
    (3, 'Crème Brûlée', 7.99),
    (3, 'Croque Monsieur', 11.99);

-- Insert dishes for Restaurant 4
INSERT INTO tbl_dish (restaurant_id, name, price)
VALUES
    (4, 'Tacos al Pastor', 10.99),
    (4, 'Guacamole and Chips', 6.99),
    (4, 'Enchiladas Verdes', 12.99),
    (4, 'Chiles Rellenos', 14.99),
    (4, 'Margarita', 8.99);

-- Insert dishes for Restaurant 5
INSERT INTO tbl_dish (restaurant_id, name, price)
VALUES
    (5, 'Peking Duck', 28.99),
    (5, 'Kung Pao Chicken', 15.99),
    (5, 'Mapo Tofu', 12.99),
    (5, 'Dim Sum Platter', 19.99),
    (5, 'Egg Fried Rice', 8.99);


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

truncate table tbl_restaurant_timing;
INSERT INTO tbl_restaurant_timing (restaurant_id, day, opening_time, closing_time)
VALUES
    (1, 'Mon', '08:00:00', '20:00:00'),
    (1, 'Tue', '08:00:00', '20:00:00'),
    (1, 'Wed', '08:00:00', '20:00:00'),
    (1, 'Thu', '08:00:00', '20:00:00'),
    (1, 'Fri', '08:00:00', '20:00:00'),
    (1, 'Sat', '08:00:00', '20:00:00'),
    (1, 'Sun', '08:00:00', '20:00:00');

-- Restaurant 2
INSERT INTO tbl_restaurant_timing (restaurant_id, day, opening_time, closing_time)
VALUES
    (2, 'Mon', '09:00:00', '22:00:00'),
    (2, 'Tue', '09:00:00', '22:00:00'),
    (2, 'Wed', '09:00:00', '22:00:00'),
    (2, 'Thu', '09:00:00', '22:00:00'),
    (2, 'Fri', '09:00:00', '22:00:00'),
    (2, 'Sat', '09:00:00', '22:00:00'),
    (2, 'Sun', '09:00:00', '22:00:00');

-- Restaurant 3
INSERT INTO tbl_restaurant_timing (restaurant_id, day, opening_time, closing_time)
VALUES
    (3, 'Mon', '10:00:00', '21:00:00'),
    (3, 'Tue', '10:00:00', '21:00:00'),
    (3, 'Wed', '10:00:00', '21:00:00'),
    (3, 'Thu', '10:00:00', '21:00:00'),
    (3, 'Fri', '10:00:00', '21:00:00'),
    (3, 'Sat', '10:00:00', '21:00:00'),
    (3, 'Sun', '10:00:00', '21:00:00');

-- Restaurant 4
INSERT INTO tbl_restaurant_timing (restaurant_id, day, opening_time, closing_time)
VALUES
    (4, 'Mon', '07:30:00', '19:30:00'),
    (4, 'Tue', '07:30:00', '19:30:00'),
    (4, 'Wed', '07:30:00', '19:30:00'),
    (4, 'Thu', '07:30:00', '19:30:00'),
    (4, 'Fri', '07:30:00', '19:30:00'),
    (4, 'Sat', '07:30:00', '19:30:00'),
    (4, 'Sun', '07:30:00', '19:30:00');

-- Restaurant 5
INSERT INTO tbl_restaurant_timing (restaurant_id, day, opening_time, closing_time)
VALUES
    (5, 'Mon', '11:00:00', '23:00:00'),
    (5, 'Tue', '11:00:00', '23:00:00'),
    (5, 'Wed', '11:00:00', '23:00:00'),
    (5, 'Thu', '11:00:00', '23:00:00'),
    (5, 'Fri', '11:00:00', '23:00:00'),
    (5, 'Sat', '11:00:00', '23:00:00'),
    (5, 'Sun', '11:00:00', '23:00:00');


create table tbl_banner(
	id bigint primary key auto_increment,
    restaurant_id bigint,
    image varchar(128),
    is_active tinyint default '1' COMMENT '1=active,0=deactive',
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp ,
    foreign key (restaurant_id) references tbl_restaurant(id)
);
insert into tbl_banner (restaurant_id, image) values 
(1, 'restaurant1_1.jpg'),
(1, 'restaurant1_2.jpg'),
(1, 'restaurant1_3.jpg');


create table tbl_like(
	id bigint primary key  auto_increment,
    restaurant_id bigint,
    user_id bigint,
    is_active tinyint default '1' COMMENT '1=active,0=deactive',
    foreign key (user_id) references tbl_user(id),
    foreign key (restaurant_id) references tbl_restaurant(id)
);





-- 1. Login Query
select * from tbl_user where (email='abhi@gmail.com' or phone='9876543210') and password='abhi123' and  login_type='S' and is_active=1;

-- forgot password :-
select * from tbl_user where (email='abhi@gmail.com' or phone='9876543210') and is_active=1 and login_type='S';
update tbl_user set password='abhi1234' where (email='abhi@gmail.com' or phone='9876543210') and is_active=1 ;


-- 2 user location page query

select * from tbl_user_location where user_id=1;

select * from tbl_user_location where user_id=1 and location_type='Home';


-- 3 for getting restaurants
select * from tbl_user_location where user_id=1 and location_type='Home';

select * from tbl_banner where is_active=1;

select r.id,r.image,r.name,r.free_delivery,r.avg_rating, r.delivery_time,
ROUND(
		(6371 * acos( cos( radians(ul.latitude) ) 
		* cos( radians (r.latitude) )
        * cos( radians (r.longtitude) - radians(ul.longtitude))
        + sin( radians(ul.latitude))
        * sin( radians (r.latitude) ) ) )) as distance_in_killometers
 from tbl_restaurant r 
join tbl_user_location ul on ul.user_id=2 
where  r.is_active=1 GROUP BY r.id having  Distance_in_killometers <20 order by distance_in_killometers;

select id, image, name, avg_rating from tbl_restaurant where avg_rating>=4 order by avg_rating desc;



-- Restaurant deatails query

select r.*, rt.opening_time, rt.closing_time,
case
when
	current_time() <= rt.closing_time and current_time() >= rt.opening_time
	then 'Restaurant is Opened'
    else 'Restaurant is closed'
    end as message,
    IFNULL( (select (case when l.restaurant_id !='' then 1 else 0 end) from tbl_like l where l.restaurant_id=r.id and l.user_id=1), 0 ) as is_like
 from tbl_restaurant r
join tbl_restaurant_timing rt on r.id=rt.restaurant_id 
where rt.day=(date_format(current_date(),'%a')) and r.id=1;


select * from tbl_dish where restaurant_id=1 and is_active=1;










-- user wise restaurant like :-
select r.*, IFNULL( (select (case when l.restaurant_id !='' then 1 else 0 end) from tbl_like l where l.restaurant_id=r.id and l.user_id=1), 0 ) as is_like from tbl_restaurant r;

