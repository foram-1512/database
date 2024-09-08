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
