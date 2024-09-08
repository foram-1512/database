create database showcase_05_03;
use showcase_05_03;

create table tbl_user (
id bigint primary key auto_increment,
name varchar(128) not null unique,
mobile_number varchar(16) not null unique,
email varchar(128) not null unique,
password varchar(128) not null,
role enum ('user','vendor'),
is_active tinyint(1) default 1 comment '1=Active 0= Inactive', 
delete_at tinyint(1) default 0 comment '0 = non delete 1= delete',
created_at timestamp default current_timestamp,
updated_at timestamp default current_timestamp on update current_timestamp
);

INSERT INTO tbl_user (name, mobile_number, email, password, role)
VALUES
('foram', '1234567890', 'foram@gmail.com', '1512', 'vendor'),
('tulsi', '1234567891', 'tulsi@gmail.com', '1223', 'user'),
('vrusha', '1234567893', 'vrusha@gmail.com', 'n1233', 'vendor'),
('dixa', '1234567896', 'dixa@gmail.com', 'N666', 'user'),
('priya', '1234567897', 'priya@gmail.com', 'h1234', 'user');

create table tbl_category(
id bigint(20) primary key auto_increment not null,
cat_type varchar(256),
is_active boolean default '1' COMMENT '1=active, 0=inactive',
is_delete boolean default '0' Comment '1=deleted, 0=non-deleted',
created_at  timestamp default current_timestamp,
updated_at timestamp default current_timestamp on update current_timestamp
);

INSERT INTO tbl_category(cat_type)
 VALUES 
 ('Household'),
 ('Furniture'),
 ('Grocery'),
 ('Pharma');

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
email varchar(32),
mobile_Number varchar(16),
is_active boolean default '1' COMMENT '1=active, 0=inactive',
is_delete boolean default '0' Comment '1=deleted, 0=non-deleted',
created_at  timestamp default current_timestamp,
updated_at timestamp default current_timestamp on update current_timestamp,
foreign key(vendor_id) references tbl_user(id),
foreign key(cat_id) references tbl_category(id)
);

INSERT INTO tbl_store(vendor_id,avg_ratting,name,image,cat_id,location,latitude,longitude,email,mobile_Number)
 VALUES
 ('1','0','Akshay Furniture','furniture.jpg','2','Nadiad','22.6932537','72.8695177','afurniture@gmail.com','7856342617'),
 ('3','0','JK FURNITURE MALL','furniture.jpg','2','Nadiad','22.6992883','72.85438','jkfurniture@gmail.com','9463572816'),
 ('1','0','Home Centre','certains.jpg','1','Ahmedabad','23.0645173','72.4652331','homecenter@gmail.com','9466498892'),
 ('3','0','Apna Bazar ','pillow.jpg','1','Ahmedabad','23.023975','72.5862118','apnabazar@gmail.com','9166498892'),
 ('1','0','Param Mart ','soap.jpg','3','Anand','22.550838','72.9626037','martr@gmail.com','9166788892'),
 ('3','0','Akshar Medical store','stopek.jpg','4','Ahmedabad','23.059588','72.5359758','medical@gmail.com','8857668892'),
 ('1','0','Gujarat Medical stores','vitamins.jpg','4','Ahmedabad','23.0205148','72.5699075','gujmedical@gmail.com','8854368892');
 
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

INSERT INTO tbl_product(cat_id,store_id,name ,image,price ,description)
 VALUES
 ('2','1','Couch','couch.jpg','33000','A timeless classic piece that'),
 ('2','2','Bed','Bed.jpg','27000','Built using premium quality wood'),
 ('1','3','milk','dairy.jpg','60','dairy products'),
 ('1','4','Chocolates','chocolates.jpg','50','happiness with chocolate'),
 ('3','5','Drower','drower.jpg','33000','A timeless classic piece that'),
 ('4','6','moov spray','moov.jpg','90','relex with moov'),
 ('4','7','Tablet','tablet.jpg','20','Tablets are the most common type of pill');
 

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

INSERT INTO tbl_rating(store_id,product_id)
 VALUES
 ('1','1'),
 ('2','2'),
 ('3','3'),
 ('4','4'),
 ('5','5'),
 ('6','6'),
 ('7','7');
 
CREATE table tbl_product_category(
id bigint NOT NULL PRIMARY KEY AUTO_INCREMENT,
store_id bigint,
name varchar(128),
is_active boolean default '1' COMMENT '1=active, 0=inactive',
is_delete boolean default '0' Comment '1=deleted, 0=non-deleted',
created_at  timestamp default current_timestamp,
updated_at timestamp default current_timestamp on update current_timestamp,
FOREIGN KEY(store_id)  REFERENCES tbl_store(id)
);

 -- //insert data
INSERT INTO tbl_product_category(store_id, name) VALUES
  (1,'milk'),
  (1,'ice cream'),
  (5,'chocolate'),
  (5,'milk');

-- 1.login with user
select * from tbl_user where email='foram@gmail.com' and password='1512' and role='Vendor' and is_active=1;

-- 2.login with vendor
select * from tbl_user where email='tulsi@gmail.com' and password='1223' and role='user' and is_active=1;

-- 3.login with email or mobile number
select * from tbl_user where (email='foram@gmail.com ' or mobile_number='1234567890') and is_active=1;

-- 4 forget password
update tbl_user set password='1512' where email='pforam056@gmail.com';

-- 5.furniture
select s.id,c.cat_type,s.name,s.image,s.location,(6371 * acos( cos( radians('23.0752323') ) 
		* cos( radians (s.latitude) )
        * cos( radians (s.longitude) - radians('72.5208067'))
        + sin( radians('23.0752323'))
        * sin( radians (s.latitude) ) ) ) as distance,s.avg_ratting,s.email,s.mobile_Number from tbl_store s join tbl_category c   on s.cat_id=c.id where c.id=2; 

        
-- 6.grocery
select s.id,c.cat_type,s.name,s.image,s.location,(6371 * acos( cos( radians('23.0752323') ) 
		* cos( radians (s.latitude) )
        * cos( radians (s.longitude) - radians('72.5208067'))
        + sin( radians('23.0752323'))
        * sin( radians (s.latitude) ) ) ) as distance,s.avg_ratting,s.email,s.mobile_Number from tbl_store s join tbl_category c   on s.cat_id=c.id where c.id=3; 



-- 7. Pharma
select s.id,c.cat_type,s.name,s.image,s.location,(6371 * acos( cos( radians('23.0752323') ) 
		* cos( radians (s.latitude) )
        * cos( radians (s.longitude) - radians('72.5208067'))
        + sin( radians('23.0752323'))
        * sin( radians (s.latitude) ) ) ) as distance,s.avg_ratting,s.email,s.mobile_Number from tbl_store s join tbl_category c   on s.cat_id=c.id where c.id=4; 

-- 8.household
select s.id,c.cat_type,s.name,s.image,s.location,(6371 * acos( cos( radians('23.0752323') ) 
		* cos( radians (s.latitude) )
        * cos( radians (s.longitude) - radians('72.5208067'))
        + sin( radians('23.0752323'))
        * sin( radians (s.latitude) ) ) ) as distance,s.avg_ratting,s.email,s.mobile_Number from tbl_store s join tbl_category c   on s.cat_id=c.id where c.id=1; 


-- 8 listing product
select s.name,p.name,p.image,p.description,p.price from tbl_store s join tbl_product p on s.id=p.store_id where s.id=2;

-- 9 
SELECT c.id,c.cat_type FROM tbl_product p JOIN tbl_category c ON p.cat_id = c.id WHERE p.store_id = 2 GROUP BY p.cat_id;

-- 10.avg_count_insert
update tbl_store SET avg_ratting=(select ROUND((AVG(rating)),1) from tbl_rating r where r.store_id=NEW.store_id) where tbl_store.id=NEW.store_id;

-- 11.avg_count_delete
update tbl_store SET avg_ratting=(select ROUND((AVG(rating)),1) from tbl_rating r where r.store_id=OLD.store_id) where tbl_store.id=OLD.store_id;

-- 12.avg_count_update
update tbl_store SET avg_ratting=(select ROUND((AVG(rating)),1) from tbl_rating r where r.store_id=OLD.store_id) where tbl_store.id=OLD.store_id;


SELECT s.id,s.name,s.image,s.location,( 6371 * acos( cos( radians(23.075574) ) 
              * cos( radians( s.latitude ) ) 
              * cos( radians( s.longitude ) - radians(72.5262165) ) 
              + sin( radians(23.075574) ) 
              * sin( radians(s.latitude ) ) ) ) AS distance,s.avg_ratting,s.email,s.mobile_number  FROM  tbl_store s WHERE s.id=1 AND s.is_active=1  ;

-- 13 .product category lising

select pc.id as category_id, pc.name as category_name , p.id as product_id, p.name as product_name, p.description, p.price from tbl_product_category pc
 join tbl_product p on p.cat_id=pc.id 
 where pc.id=1 and pc.is_active=1;
 
 