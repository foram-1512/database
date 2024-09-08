create database showcase0503;
use showcase0503;

create table tbl_user (
id bigint primary key auto_increment,
name varchar(128) not null unique,
mobile_number varchar(16) not null unique,
email varchar(128) not null unique,
password varchar(128) not null,
role enum ('user','Vendor'),
is_active tinyint(1) default 1 comment '1=Active 0= Inactive', 
delete_at tinyint(1) default 0 comment '0 = non delete 1= delete',
created_at timestamp default current_timestamp,
updated_at timestamp default current_timestamp on update current_timestamp
);

create table tbl_category(
id bigint(20) primary key auto_increment not null,
cat_type varchar(256),
is_active boolean default '1' COMMENT '1=active, 0=inactive',
is_delete boolean default '0' Comment '1=deleted, 0=non-deleted',
created_at  timestamp default current_timestamp,
updated_at timestamp default current_timestamp on update current_timestamp
);

create table tbl_store(
id bigint(20) primary key auto_increment not null,
vendor_id bigint(20),
avg_ratting double(5,1),
image varchar(128),
name varchar(16) not null,
cat_id bigint(20) not null,
location text,
latitude varchar(16),
longitude varchar(16),
email varchar(10),
mobile_Number varchar(16),
is_active boolean default '1' COMMENT '1=active, 0=inactive',
is_delete boolean default '0' Comment '1=deleted, 0=non-deleted',
created_at  timestamp default current_timestamp,
updated_at timestamp default current_timestamp on update current_timestamp,
foreign key(vendor_id) references tbl_user(id),
foreign key(cat_id) references tbl_category(id)
);

create table tbl_product(
id bigint(20) primary key auto_increment,
cat_id bigint(20),
store_id bigint(20),
name varchar(128),
image varchar(128),
price double(8,2),
description text,
is_active boolean default '1' COMMENT '1=active, 0=inactive',
is_delete boolean default '0' Comment '1=deleted, 0=non-deleted',
created_at  timestamp default current_timestamp,
updated_at timestamp default current_timestamp on update current_timestamp,
foreign key (store_id)references tbl_store(id),
foreign key (cat_id)references tbl_category(id)
);
create table tbl_rating(
id bigint(20) primary key auto_increment not null,
store_id bigint,
product_id bigint,
is_active boolean default '1' COMMENT '1=active, 0=inactive',
is_delete boolean default '0' Comment '1=deleted, 0=non-deleted',
created_at  timestamp default current_timestamp,
updated_at timestamp default current_timestamp on update current_timestamp,
foreign key (store_id)references tbl_store(id),
foreign key (product_id)references tbl_product(id)
);
INSERT INTO tbl_user (user_name, mobile_number, email, password, role)
VALUES
('foram', '1234567890', 'foram@gmail.com', '1512', 'Vendor'),
('tulsi', '1234567891', 'tulsi@gmail.com', '1223', 'user'),
('vrusha', '1234567893', 'vrusha@gmail.com', 'n1233', 'vendor'),
('dixa', '1234567896', 'dixa@gmail.com', 'N666', 'user'),
('priya', '1234567897', 'priya@gmail.com', 'h1234', 'user');

INSERT INTO tbl_category(cat_type)
 VALUES 
 ('household'),
 ('furniture'),
 ('grocery'),
 ('pharma'),
 ('household'),
 ('furniture'),
 ('pharma');
 
 INSERT INTO tbl_store(vendor_id,avg_ratting,image,name,cat_id,location,latitude,longitude,email,mobile_Number)
 VALUES
 ('1','0','furniture.jpg','Akshay Furniture','2','Nadiad','22.6932537','72.8695177','afurniture@gmail.com','7856342617'),
 ('3','0','furniture.jpg','JK FURNITURE MALL','2','Nadiad','22.6992883','72.85438','jkfurniture@gmail.com','9463572816'),
 ('1','0','certains.jpg','Home Centre','1','Ahmedabad','23.0645173','72.4652331','homecenter@gmail.com','9466498892'),
 ('3','0','pillow.jpg','Apna Bazar ','1','Ahmedabad','23.023975','72.5862118','apnabazar@gmail.com','9166498892'),
 ('1','0','soap.jpg','Param Mart ','3','Anand','22.550838','72.9626037','martr@gmail.com','9166788892'),
 ('3','0','stopek.jpg','Akshar Medical Store','4','Ahmedabad','23.059588','72.5359758','medical@gmail.com','8857668892'),
 ('1','0','vitamins.jpg','Gujarat Medical Stores','4','Ahmedabad','23.0205148','72.5699075','gujmedical@gmail.com','8854368892');
 
 INSERT INTO tbl_product(store_id,name ,image,price ,description)
 VALUES
 ('43','Couch','couch.jpg','33000','A timeless classic piece that'),
 ('44','Bed','Bed.jpg','27000','Built using premium quality wood'),
 ('45','Vaccume','vaccume.jpg','2000','A Versatile Vacuum'),
 ('46','Baskets','baskets.jpg','500','Caddy for bathroom cleaning supplies'),
 ('47','moov spray','moov.jpg','90','relex with moov'),
 ('48','Tablet','tablet.jpg','20','Tablets are the most common type of pill'),
 ('49','Couch','couch.jpg','33000','A timeless classic piece that');
 
 INSERT INTO tbl_rating(store_id,product_id)
 VALUES
 ('43','43'),
 ('44','44'),
 ('45','45'),
 ('46','46'),
 ('47','47'),
 ('48','48'),
 ('49','49');

-- 1.login with user
select * from tbl_user where email='foram@gmail.com' and password='1512' and role='Vendor' and is_active=1;

-- 2.login with vendor
select * from tbl_user where email='tulsi@gmail.com' and password='1223' and role='user' and is_active=1;

-- 3.login with email or mobile number
select * from tbl_user where (email='foram@gmail.com ' or mobile_number='1234567890') and is_active=1;

-- 4 forget password
update tbl_user set password='1512' where email='pforam056@gmail.com';

-- 5.furniture
select c.cat_type,s.image,s.location,(6371 * acos( cos( radians('23.0752323') ) 
		* cos( radians (s.latitude) )
        * cos( radians (s.longitude) - radians('72.5208067'))
        + sin( radians('23.0752323'))
        * sin( radians (s.latitude) ) ) ) as distance,s.avg_ratting,s.email,s.mobile_Number  from tbl_category c join tbl_store s on c.id=s.cat_id where c.id=2; 
        
-- 6.grocery
select c.cat_type,s.image,s.location,(6371 * acos( cos( radians('23.0752323') ) 
		* cos( radians (s.latitude) )
        * cos( radians (s.longitude) - radians('72.5208067'))
        + sin( radians('23.0752323'))
        * sin( radians (s.latitude) ) ) ) as distance,s.avg_ratting,s.email,s.mobile_Number  from tbl_category c join tbl_store s on c.id=s.cat_id where c.id=3; 


-- 7. Pharma
select c.cat_type,s.name,s.image,s.location,(6371 * acos( cos( radians('23.0752323') ) 
		* cos( radians (s.latitude) )
        * cos( radians (s.longitude) - radians('72.5208067'))
        + sin( radians('23.0752323'))
        * sin( radians (s.latitude) ) ) ) as distance,s.avg_ratting,s.email,s.mobile_Number from tbl_category c join tbl_store s on c.id=s.cat_id where c.id=4; 

-- 8.household
select c.cat_type,s.name,s.image,s.location,(6371 * acos( cos( radians('23.0752323') ) 
		* cos( radians (s.latitude) )
        * cos( radians (s.longitude) - radians('72.5208067'))
        + sin( radians('23.0752323'))
        * sin( radians (s.latitude) ) ) ) as distance,s.avg_ratting,s.email,s.mobile_Number from tbl_category c join tbl_store s on c.id=s.cat_id where c.id=1; 

-- 8 listing product
select s.name,p.name,p.image,p.description,p.price from tbl_store s join tbl_product p on s.id=p.store_id where s.id=47;

-- 9 
SELECT c.id,c.cat_type FROM tbl_product p JOIN tbl_category c ON p.category_id = c.id WHERE p.store_id = 1 GROUP BY p.category_id;

-- 10.avg_count_insert
update tbl_store SET avg_ratting=(select ROUND((AVG(rating)),1) from tbl_rating r where r.store_id=NEW.store_id) where tbl_store.id=NEW.store_id;

-- 11.avg_count_delete
update tbl_store SET avg_ratting=(select ROUND((AVG(rating)),1) from tbl_rating r where r.store_id=OLD.store_id) where tbl_store.id=OLD.store_id;

-- 12.avg_count_update
update tbl_store SET avg_ratting=(select ROUND((AVG(rating)),1) from tbl_rating r where r.store_id=OLD.store_id) where tbl_store.id=OLD.store_id




create database Database_05_03_2024;
use Database_05_03_2024;

create table tbl_user (
	id bigint primary key auto_increment not null,
    user_name varchar(128) not null,
    phone_number varchar(16) not null unique,
    email_id varchar(128) not null unique,
    password varchar(128) not null,
    city varchar(128) not null,
    latitude varchar(64) not null,
    longtitude varchar(64) not null,
    role enum('User', 'Vendor') not null,
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
	is_active tinyint default '1' COMMENT '1=active,2=inactive'
);

truncate table tbl_user;
insert into tbl_user(user_name,phone_number,email_id,password,latitude,longtitude,role,city) values
	('mailto:mayur','9876543210','mayur@gmail.com','mayur123','23.0752323','72.5231027','user','sola'),
    ('mailto:abdul','6776543210','abdul@gmail.com','abdul123','23.1008967','72.5229621','vendor','gota'),
    ('mailto:abhi','9123443210','abhi@gmail.com','abhi123','23.2281517','72.4609524','user','kalol'),
    ('mailto:devarsh','8796543210','devarsh@gmail.com','devarsh123','22.8050519','70.8155953','vendor','morbi'),
    ('mailto:foram','98213543210','foram@gmail.com','foram123','22.6958742','72.7807841','user','nadiad');
    
select * from tbl_user;

create table tbl_category(
	id bigint primary key not null auto_increment,
    name enum('Household','Grocery', 'Furniture', 'Pharma') not null,
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
	is_active tinyint default '1' COMMENT '1=active,2=inactive'
);

insert into tbl_category (name) values 
('Household'),
('Grocery'),
('Furniture'),
('Pharma');

create table tbl_store (
	id bigint primary key auto_increment not null,
    category_id bigint not null,
    vendor_id bigint,
    name varchar(128) not null,
    image varchar(255) default 'demo1.jpg',
    description text,
    address text,
    phone_number varchar(16) not null unique,
    email_id varchar(128) not null unique,
    avg_rating float(5,1) default 0,
    city varchar(128) not null,
    latitude varchar(64) not null,
    longtitude varchar(64) not null,
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
	is_active tinyint default '1' COMMENT '1=active,2=inactive',
    foreign key (category_id) references tbl_category(id),
    foreign key (vendor_id) references tbl_user(id)
);
select * from tbl_store;
drop table tbl_store;

insert into tbl_store (category_id, vendor_id, name, description, address, phone_number, email_id, city, latitude, longtitude) values
	(2, 2, 'Walmart', 'Grocery and Shopping', 'Sarkhej - Gandhinagar Hwy, Thaltej, Ahmedabad, Gujarat 380054', '+91 9876543210', 'mailto:walmart@gmail.com', 'Thaltej', '23.0546803', '72.5202359'),
    (1, 4, 'D-Mart', 'Household', 'near Block-I,Samarpan Residency, Pratap Pura Village, Kalol, Gujarat 382721', '+91 9172543340', 'mailto:dmart@gmail.com', 'Kalol', '23.2499588', '72.4823743'),
    (4, 2, 'Apollo Pharmacy', 'Pharmacy', '19, Shayona Silver Estate, near Silver Oak College, Gota, Ahmedabad, Gujarat 382481', '+91 9846527235', 'mailto:apollo@gmail.com', 'Gota', '23.0828815', '72.5107924'),
    (3, 4, 'Royaloak Furniture', 'Furniture', 'Rangat Signature, Near Gota Bridge, Sarkhej - Gandhinagar Hwy, opp. Rangat Green Memories, Gota, Ahmedabad, Gujarat 380081', '+91 924657235', 'mailto:royaloak@gmail.com', 'Gota', '23.1060626', '72.528525'),
    (2, 2, 'Dominos Pizza', 'Grocery', 'G-2 , GROUND FLOOR, Astron Tech Park, opp. FUN REPUBLIC COMPLEX, near ISKO, Satellite, Ahmedabad, Gujarat 380054', '+91 98765567', 'mailto:dominos@gmail.com', 'Iskon', '23.0277458', '72.4860224');
    
    
    create table tbl_product_category(
	id bigint primary key not null auto_increment,
    store_id bigint not null,
    name varchar(128) not null,
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
	is_active tinyint default '1' COMMENT '1=active,2=inactive',
    foreign key (store_id) references tbl_store(id)
);
    insert into tbl_product_category(store_id, name) values 
    (1, 'Milk'),
    (1, 'Ice-Cream'),
    (1, 'Chocholate'),
    (2, 'Cloths'),
    (2, 'Shoes'),
    (2, 'Perfume'),
    (3, 'Medicine'),
    (3, 'Syrup'),
    (3, 'Injection'),
    (4, 'Bed'),
    (4, 'Dining Table'),
    (4, 'Sofa'),
    (5, 'margherita'),
    (5, '7 cheese'),
    (5, 'Mexican')
    ;

create table tbl_product(
	id bigint primary key auto_increment not null,
    store_id bigint not null,
    category_id bigint not null,
    name varchar(128) not null,
    image varchar(128) not null default 'demo1.jpg',
    description text,
    price float(8,2),
     created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
	is_active tinyint default '1' COMMENT '1=active,2=inactive',
    foreign key (store_id) references tbl_store(id),
    foreign key (category_id) references tbl_product_category(id)
);

insert into tbl_product (store_id, category_id, name, description, price) values 
(1, 1, 'Amul milk', 'Amul milk 500 ml fat 6%', 40),
(1, 2, 'Havemore Ice-cream', 'Havemore 750gm Ice cream', 200),
(1, 3, 'Dairy-Milk Silk Oreo', 'Dairy-Milk Silk Oreo Coated with Chocolate over oreo', 160),
(2,1, 'Raymond Shirt', 'Raymond full-sleve shirt size M for men',  1800),
(2,2, 'Skechers Running', 'Skechers Running Shoes size 10 for men', 4700),
(2,3, 'Christian Dior', 'Christian Dior perfume for men 200ml', 17000),
(3,1, 'Paracetamol', 'Paracetamol 10 strip for fever', 30),
(3,2, 'Cofsil', 'Cofsil for quick relif in strong Cough 100ml', 120),
(3,3, 'Diclofenac Injection', 'Injection for quick relif during pain', 450),
(4,1, 'Double Bed', 'Large size Double bed size 6*6', 20000),
(4,2, 'Dinning Table', 'Dinning table for the family of 6', 14000),
(4,3, 'Sofa', 'Premimum sofa with More comfortable seating, 8 seater sofa for complete family', 32000),
(5,1, 'Margherita Pizza', 'Large size 17 inch margherita pizza', 450),
(5,2, '7 Cheese Pizza', 'Medium size 10 inch 10 inch 7 cheese pizza', 350),
(5,3, 'Mexican Pizza', 'small size 6 inch mexican pizza', 230);

create table store_rating(
	id bigint primary key,
    user_id bigint not null,
    store_id bigint not null,
    rating float(5,1),
    review text,
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
	is_active tinyint default '1' COMMENT '1=active,2=inactive',
    foreign key (store_id) references tbl_store(id),
    foreign key (user_id) references tbl_user(id)
);




-- Q-1 login Query

select * from tbl_user where phone_number ='9123443210' and password = 'abhi1442' and is_active=1;

-- Q-2 Forgot Password
update tbl_user set password='abhi1442' where (phone_number='9123443210' or mailto:email='abhi@gmail.com') and is_active=1;

-- Q-3 Store Listing Page

select  c.id, c.name from tbl_category c;
select s.id,s.image,s.name,s.description,s.address,s.email_id,s.phone_number,s.avg_rating,
ROUND(
		(3959 * acos( cos( radians(u.latitude) ) 
		* cos( radians (s.latitude) )
        * cos( radians (s.longtitude) - radians(u.longtitude))
        + sin( radians(u.latitude))
        * sin( radians (s.latitude) ) ) )) as Distance_in_miles
 from tbl_store s 
join tbl_category c on s.category_id=c.id
join tbl_user u on u.id=3 where  s.is_active=1 having  Distance_in_miles <50;

-- category wise store filtering

select c.id as category_id,c.name as category_name, s.id as store_id, s.name as store_name,s.image,s.description,s.address,s.email_id,s.phone_number,s.avg_rating,
ROUND(
		(3959 * acos( cos( radians(u.latitude) ) 
		* cos( radians (s.latitude) )
        * cos( radians (s.longtitude) - radians(u.longtitude))
        + sin( radians(u.latitude))  
        * sin( radians (s.latitude) ) ) )) as Distance_in_miles from tbl_category c join tbl_store s on s.category_id=c.id
        join tbl_user u on u.id=3
        where c.id=4 and c.is_active=1;



-- Q-4 Product Listing

select s.id,s.image,s.name,s.description,s.address,s.email,s.phone,s.avg_rating,
ROUND(
		(3959 * acos( cos( radians(u.latitude) ) 
		* cos( radians (s.latitude) )
        * cos( radians (s.longtitude) - radians(u.longtitude))
        + sin( radians(u.latitude))
        * sin( radians (s.latitude) ) ) )) as Distance_in_miles
 from tbl_store s 
join tbl_category c on s.category_id=c.id
join tbl_user u on u.id=3
where s.id=1 and s.is_active=1;


-- 2.)selected store after display the category wise product
select p.id, p.image, p.name, p.description, p.price, pc.* 
	from tbl_product p
	join tbl_product_category pc on p.category_id=pc.id  
	where p.category_id=4 and p.store_id=2 and p.is_active=1;





