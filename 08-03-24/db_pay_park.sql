create database db_pay_parking;
use db_pay_parking;
create table tbl_user (
	id bigint primary key auto_increment,
    name varchar(128),
    image varchar(128),
    email varchar(64) unique,
    country_code varchar(64) default '+91',
    mobile varchar(16) unique , 
    password varchar(64),
    role enum('Owner','user'),
    address text,
    latitude varchar(64),
    longitude varchar(64),
	is_active boolean default '1' COMMENT '1=active, 0=inactive',
	is_delete boolean default '0' Comment '1=deleted, 0=non-deleted',
	created_at  timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp
);

insert into tbl_user( name,image, email, mobile, password,role,address,latitude,longitude) values
	('foram','Image1','foram@gmail.com', '9106603730', 'foram12345','Owner','Nadiad vaishali road','22.6824679','72.8496527'),
    ('gayatri','Image2','gayatri@gmail.com', '7546734523', 'gayatri12345','user','Ahmedabad Rabari colony','23.0010957','72.6251497'),
	('mayur','Image3','mayur@gmail.com', '9879483440', 'mayur12345','user','Morbi','22.8049727','70.8155096'),
    ('abhi','Image4','abhi@gmail.com', '8401971214', 'abhi12345','Owner','Kalol','23.228059','72.4242963'),
    ('viral','Image1','viral@gmail.com', '9879353440', 'viral12345','user','Mehsana','23.5898665','72.3416933');
    
create table tbl_parking (
	id bigint primary key auto_increment,
    owner_id bigint,
    name varchar(64),
    address text,
    latitude varchar(32),
    longitude varchar(32),
    avg_rating float(5,1),
    total_spots int,
    occupied_spots int,
    per_day_price varchar(8),
    parking_info text,
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
	is_active boolean default '1' COMMENT '1=active,0=inactive',
    foreign key (owner_id) references tbl_user(id)
);

insert into tbl_parking (owner_id, name, address, latitude, longitude, avg_rating, total_spots, occupied_spots, per_day_price, parking_info)
values
(1, 'City Center Parking', 'Nadiad City Center', '22.7002741', '72.8699964', 4.2, 100, 25, '50', 'Secure parking facility in the heart of the city.'),
(2, 'Atal Bridge Parking', 'Atal bridge ahmedabad', '23.0147844', '72.5726385', 3.8, 50, 15, '70', 'Spacious parking lot with easy access to nearby shops.'),
(3, 'AMC Pay and Park', 'Gota ahmedabad', '23.1008438', '72.5318255', 4.5, 80, 20, '30', 'Covered parking garage with valet service available.'),
(4, 'Riverfront Park', 'Riverfront Ahmedabad', '23.100801', '72.4494278', 4.0, 120, 30, '40', 'Scenic parking area next to the river.'),
(5, 'Airport Parking', 'Ahmedabad Airport', '23.0816708', '72.6165539', 4.3, 150, 40, '100', 'Convenient parking option for travelers with shuttle service to the airport.');

create table tbl_service (
	id bigint primary key auto_increment,
    name varchar(64),
    image varchar(64),
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
	is_active boolean default '1' COMMENT '1=active,0=inactive'
);

insert into tbl_service (name, image)
values
('Car Wash', 'car_wash.jpg'),
('Oil Change', 'oil_change.jpg'),
('Car Detailing', 'car_detailing.jpg'),
('Tire Rotation', 'tire_rotation.jpg'),
('Brake Service', 'brake_service.jpg');

create table tbl_parking_images (
	id bigint primary key auto_increment,
    parking_id bigint,
    image varchar(64),
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
	is_active boolean default '1' COMMENT '1=active,0=inactive',
    foreign key (parking_id) references tbl_parking(id)
);

insert into tbl_parking_images (parking_id, image)
values
(1, 'parking_image1.jpg'),
(1, 'parking_image2.jpg'),
(2, 'parking_image3.jpg'),
(2, 'parking_image4.jpg'),
(3, 'parking_image5.jpg'),
(3, 'parking_image6.jpg'),
(4, 'parking_image7.jpg'),
(4, 'parking_image8.jpg'),
(5, 'parking_image9.jpg'),
(5, 'parking_image10.jpg');

create table tbl_parking_booking(
	id bigint primary key auto_increment,
    user_id bigint,
    parking_id bigint,
    date datetime,
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
	is_active boolean default '1' COMMENT '1=active,0=inactive',
    foreign key (user_id) references tbl_user(id),
    foreign key (parking_id) references tbl_parking(id)
    
);

insert into tbl_parking_booking (user_id, parking_id, date)
values
(1, 1, '2024-03-10'),
(2, 1, '2024-03-11'),
(3, 2, '2024-03-12'),
(4, 2, '2024-03-13'),
(5, 3, '2024-03-14');

create table tbl_parking_rating (
	id bigint primary key auto_increment,
	user_id bigint,
    parkig_id bigint,
    rating float(5,1),
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
	is_active boolean default '1' COMMENT '1=active,0=inactive',
    foreign key (user_id) references tbl_user(id),
	foreign key (parking_id) references tbl_parking(id)
);

insert into tbl_parking_rating (user_id, rating)
values
(1, 4.5),
(2, 4.0),
(3, 4.8),
(4, 3.5),
(5, 4.2);

create table tbl_parking_service (
	id bigint primary key auto_increment,
    parking_id bigint,
    service_id bigint,
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
	is_active boolean default '1' COMMENT '1=active,0=inactive',
    foreign key (service_id) references tbl_service(id),
    foreign key (parking_id) references tbl_parking(id)
);

insert into tbl_parking_service (parking_id, service_id)
values
(1, 1),
(1, 2),
(1, 3),
(2, 2),
(2, 4),
(3, 1),
(3, 3),
(4, 2),
(5, 1),
(5, 4);

-- QUERIES
 
 -- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 1.login with Owner
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
select * from tbl_user where email='foram@gmail.com' and password='foram12345' and role='Owner' and is_active=1 and is_delete=0;

-- --------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 2.login with mobile number or password
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
select * from tbl_user where (mobile='9106603730' or password='foram12345') and is_active=1 and is_delete=0;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 3 forget password
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT id,email FROM tbl_user WHERE email ="foram@gmail.com" AND role= 'Owner' AND is_active = 1 AND is_delete=0;
update tbl_user set password='1512' where mobile='9106603730'AND id=2 AND is_active = 1 AND is_delete=0;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 4.signup query
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
insert into tbl_user( name,image, email, mobile, password,role,address,latitude,longitude) values
	('foram','Image1','foram@gmail.com', '9106603730', 'foram12345','Owner','Nadiad vaishali road','22.6824679','72.8496527');
    
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 5. parking distence
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT p.id,(SELECT i.image FROM tbl_parking_images i WHERE i.parking_id = p.id LIMIT 1)AS  Image,p.name,p.address,p.avg_rating,p.count_spots,p.total_spots,p.per_day_price ,
			( 6371 * acos( cos( radians(23.075574) ) 
              * cos( radians( p.latitude)) 
              * cos( radians( p.longitude) - radians(72.5262165) ) 
              + sin( radians(23.075574) ) 
              * sin( radians(p.latitude ) ) ) ) AS distance 
         FROM tbl_parking p  WHERE p.count_spots < p.total_spots AND p.is_active=1 AND p.is_delete = 0   
HAVING distance < 5
ORDER BY distance;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 6. parking services
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------

select p.id, p.name, p.address, p.avg_rating,p.count_spots, p.total_spots, p.per_day_price, p.parking_info,
	group_concat(ps.service_id) as service_id, group_concat(s.name) as service_name, group_concat(s.image) as service_image
from tbl_parking p
JOIN tbl_parking_service ps on ps.parking_id=p.id
join tbl_service s on ps.service_id=s.id
join tbl_user u on p.owner_id=u.id
where p.id=2 and p.is_active=1 GROUP BY p.id;

SELECT * FROM tbl_parking  WHERE id = 1 AND is_active=1 AND is_delete = 0;

SELECT * FROM tbl_parking_images i WHERE i.parking_id =1;