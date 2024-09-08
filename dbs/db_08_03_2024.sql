create database 08_03_2024;
use 08_03_2024;

create table tbl_user(
	id BIGINT PRIMARY KEY AUTO_INCREMENT,
    name varchar(128),
    email varchar(128) unique,
    country_code varchar(8) default '+91',
    phone int(16),
    password varchar(128),
    image varchar(128),
    address text,
	latitude varchar(32),
    longitude varchar(32),
    role enum('User', 'Owner'),
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
	is_active boolean default '1' COMMENT '1=active,0=inactive'
);
drop table tb_user;

truncate table tbl_user;

insert into tbl_user (name, phone, email, password, latitude, longitude, role, address) values
	('mayur','9876543210','mayur@gmail.com','mayur123', '23.0752323','72.5231027','User','sola'),
    ('abdul','6776543210','abdul@gmail.com','abdul123','23.1008967','72.5229621','Owner','gota'),
    ('abhi','9123443210','abhi@gmail.com','abhi123','23.2281517','72.4609524','User','kalol'),
    ('devarsh','8796543210','devarsh@gmail.com','devarsh123','22.8050519','70.8155953','User','morbi'),
    ('foram','98213543210','foram@gmail.com','foram123','22.6958742','72.7807841','Owner','nadiad');



CREATE table tbl_parking (
	id bigint primary key AUTO_INCREMENT,
    owner_id bigint,
    name varchar(128),
    address text,
    avg_rating float(5,1),
    total_spots int(8),
    occuipied_spots int(8),
    price float(8,2),
    latitude varchar(32),
    longitude varchar(32),
    description text,
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
	is_active boolean default '1' COMMENT '1=active,0=inactive',
    FOREIGN KEY (owner_id) REFERENCES tbl_user(id)
);

insert into tbl_parking (owner_id, name, address, total_spots, price, latitude, longitude, description) VALUES
(3, 'Blue Nest Parking', 'Near, D-404, Shivalik High-Street, Ahmedabad, Gujarat 380015', 30, 20, '23.0546803', '72.5202359', 
	'Parking is the act of stopping and disengaging a vehicle and usually leaving it unoccupied.'),
(5, 'City Parking', 'near Block-I,Samarpan Residency, Pratap Pura Village, Kalol, Gujarat 382721', 25, 15, '23.2499588', '72.4823743',
	'Parking is the act of stopping and disengaging a vehicle and usually leaving it unoccupied.'),
(3, 'Nest West Parking',  'G-2 , GROUND FLOOR, Astron Tech Park, opp. FUN REPUBLIC COMPLEX, near ISKON, Satellite, Ahmedabad, Gujarat 380054', 45, 25, '23.0277458', '72.4860224',
	'Parking is the act of stopping and disengaging a vehicle and usually leaving it unoccupied.');


create table tbl_service(
	id BIGINT AUTO_INCREMENT primary key,
    parking_id bigint,
    name varchar(128),
    image varchar(128),
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
	is_active boolean default '1' COMMENT '1=active,0=inactive'
    );
    
insert into tbl_service (name, image) values 
('Water Supply', 'water.jpg'),
('Charging Facility', 'chargeing.jpg'),
('wifi', 'wifi.jpg'),
('Barbeque', 'barbeque.jpg'),
('Camping', 'camping.jpg');

drop table tbl_parking_service;

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


create table tbl_parking_rating (
	id bigint primary key auto_increment,
	user_id bigint,
    parking_id bigint,
    rating float(5,1),
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
	is_active boolean default '1' COMMENT '1=active,0=inactive',
    foreign key (user_id) references tbl_user(id),
    foreign key (parking_id) references tbl_parking(id)
);

create table tbl_parking_image(
	id bigint AUTO_INCREMENT primary key,
    parking_id BIGINT,
    image varchar(128),
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
	is_active boolean default '1' COMMENT '1=active,0=inactive',
	foreign key (parking_id) references tbl_parking(id)
);





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

insert into tbl_parking_service (parking_id, service_id) values 
(1, 1),
(1,2),
(1,3),
(1,4),
(2,1),
(2,2),
(2,3),
(3,1),
(3,2),
(3,3),
(3,4),
(3,5);


select * from tbl_user 
where (email='mayur@gmail.com' or phone='9876543210')
and password='mayur123' and is_active=1;


-- forgot password :--
select * from tbl_user
where (email='abhi@gmail.com' or phone='9876543212') and is_active=1;


update tbl_user set password='abhi123'
where (email='abhi@gmail.com' or phone='8359644260') and is_active=1;




-- Query for displaying nearby parking

select address from tbl_user where id=1;

select u.id, u.name, u.latitude, u.longitude, p.id, pi.image, p.name, p.address, p.avg_rating, p.occuipied_spots, p.total_spots, p.price,
ROUND(
		(6371 * acos( cos( radians(u.latitude) ) 
		* cos( radians (p.latitude) )
        * cos( radians (p.longitude) - radians(u.longitude))
        + sin( radians(u.latitude))
        * sin( radians (p.latitude) ) ) )) as distance_in_killometers
 from tbl_parking p 
 join tbl_parking_image pi on pi.parking_id=p.id
join tbl_user u on u.id=3 
where  p.is_active=1 GROUP BY p.id having  Distance_in_killometers <30 order by distance_in_killometers;


-- Query for displaying particular parking 

select p.id, p.name, p.address, p.avg_rating, p.occuipied_spots, p.total_spots, p.price, p.description,
	group_concat(ps.service_id) as service_id, group_concat(s.name) as service_name, group_concat(s.image) as service_image
from tbl_parking p
JOIN tbl_parking_service ps on ps.parking_id=p.id
join tbl_service s on ps.service_id=s.id
join tbl_user u on p.owner_id=u.id
where p.id=2 and p.is_active=1 GROUP BY p.id;

select * from tbl_parking_image where parking_id=1;



SELECT p.*,GROUP_CONCAT(s.name,' ',s.image) as services,u.id,u.name,u.image,u.phone, (SELECT GROUP_CONCAT(pi.image,' ') FROM tbl_parking_image AS pi WHERE pi.is_active = 1 AND pi.parking_id = p.id ) AS parking_photos
FROM tbl_parking AS p
 JOIN tbl_parking_service AS ps ON ps.parking_id = p.id
 JOIN tbl_service AS s ON s.id = ps.service_id
 JOIN tbl_user AS u ON u.id = p.owner_id
 WHERE p.is_active = 1 AND p.id = 1 AND ps.is_active = 1 AND s.is_active = 1;




