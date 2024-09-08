create database db_exam_food;
use db_exam_food;

create table tbl_user(
	id bigint primary key auto_increment,
    name varchar(128),
    image varchar(128) default 'default.jpg',
    email varchar(64) unique,
    country_code varchar(64) default '+91',
    mobile varchar(16) unique , 
    password varchar(64),
    address varchar(128),
    latitude varchar(64),
    longitude varchar(64),
    role enum('User','Seller','Delivery Person'),
	is_active tinyint(1) default 1 comment '1=Active 0= Inactive', 
	is_delete tinyint(1) default 0 comment '0 = non delete 1= delete',
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp
);

insert into tbl_user(name,email, mobile, password,address,latitude,longitude,role) values
	('foram','foram@gmail.com', '9106603730', 'foram12345','Nadiad vaishali road','22.6824679','72.8496527','User'),
    ('gayatri','gayatri@gmail.com', '7546734523', 'gayatri12345','Ahmedabad Rabari colony','23.0010957','72.6251497','Seller'),
	('mayur','mayur@gmail.com', '9879483440', 'mayur12345','Morbi','22.8049727','70.8155096','user'),
    ('abhi','abhi@gmail.com', '8401971214', 'abhi12345','Kalol','23.228059','72.4242963','user'),
    ('viral','viral@gmail.com', '9879353440', 'viral12345','Mehsana','23.5898665','72.3416933','Delivery Person');
    
create table tbl_category(
	id bigint primary key auto_increment,
    name varchar(64),
    image varchar(128) default 'default.jpg',
	is_active tinyint(1) default 1 comment '1=Active 0= Inactive', 
	is_delete tinyint(1) default 0 comment '0 = non delete 1= delete',
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp
);

insert into tbl_category(name) values 
('Vegetable'),
('Grocery');

create table tbl_store(
	id bigint(20) primary key auto_increment,
	cat_id bigint(20),
    name varchar(64),
    image varchar(128) default 'default.jpg',
	location varchar(128),
    latitude varchar(64),
    longitude varchar(64),
	rating float(5,1) default 0,
	review text default 0,
	is_active tinyint(1) default 1 comment '1=Active 0= Inactive', 
	is_delete tinyint(1) default 0 comment '0 = non delete 1= delete',
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
	foreign key(cat_id) references tbl_category(id)
);

INSERT INTO tbl_store (cat_id,name,location, latitude, longitude)
VALUES
('1','Ramnagar Vegetable Market','nr. Sajavat Building, Ramnagar, Ahmedabad', '23.0841468 ', '72.5907296'),
('1','Mahalaxmi Fruit and Vegetable Mart','Pritam Nagar, Paldi, Ahmedabad', '23.0173833', '72.567138'),
('1','GREEN VEGETABLES HUB','Lad Society road, Vastrapur, Ahmedabad', '23.036469', '72.5257434'),
('2','Reliance Fresh','Navrangpura, Ahmedabad', '23.0338518', '72.5672053'),
('2','Hearty Mart Super Market','Sarkhej Road, Ahmedabad', '22.995018', '72.532829');

create table tbl_store_rating_review (
	id bigint primary key auto_increment,
    user_id bigint,
    store_id  bigint,
    rating float(5,1),
    reviews text,
    is_active tinyint default '1' COMMENT '1=active,0=deactive',
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key (user_id) references tbl_user(id),
    foreign key (store_id) references tbl_store(id)
);

create table tbl_banner(
	id bigint primary key auto_increment,
    store_id bigint,
    image varchar(128),
    is_active tinyint default '1' COMMENT '1=active,0=deactive',
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp ,
    foreign key (store_id) references tbl_store(id)
);

INSERT INTO tbl_banner (store_id, image)
VALUES
(1, 'banner1.jpg'),
(2, 'banner2.jpg'),
(3, 'banner3.jpg'),
(4, 'banner4.jpg'),
(5, 'banner5.jpg');

create table tbl_product(
	id bigint(20) primary key auto_increment,
	cat_id bigint(20),
	store_id bigint(20),
	name varchar(256),
	rating float(5,1) default 0,
	review text default 0,
	delivery_day datetime,
	is_active tinyint(1) default 1 comment '1=Active 0= Inactive', 
	is_delete tinyint(1) default 0 comment '0 = non delete 1= delete',
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
	foreign key(cat_id) references tbl_category(id),
    foreign key (store_id) references tbl_store(id)
);

insert into tbl_product(cat_id,store_id,name,description)
values
(1,1,'Carrot',' improve immunity, and boost brain health.'),
(1,1,'Ladyfingure',' improve immunity, and boost brain health.'),
(1,1,'curly flower',' improve immunity, and boost brain health.'),
(1,2,'Cabbage','green leves.'),
(1,2,'Potatos','green leves.'),
(1,3,'Eggplant','boost brain health.'),
(2,4,'Banana',' improve immunity and health.'),
(2,4,'Pinapple',' improve immunity and health.'),
(2,4,'Cepodilla',' improve immunity and health.'),
(2,4,'Strawberry',' improve immunity and health.'),
(2,5,'Apple',' boost brain health.'),
(2,5,'Beat',' boost brain health.'),
(2,5,'Orange',' boost brain health.');

create table tbl_product_image(
	id bigint primary key auto_increment,
    product_id bigint,
    image varchar(128),
	is_active tinyint(1) default 1 comment '1=Active 0= Inactive', 
	is_delete tinyint(1) default 0 comment '0 = non delete 1= delete',
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
	foreign key (product_id) references tbl_product(id)
);
insert into tbl_product_image (product_id,image) values
	(1,'image1.jpg'),
	(2,'image2.jpg'),
	(3,'image3.jpg'),
	(4,'image4.jpg'),
	(5,'image5.jpg'),
	(6,'image6.jpg'),
	(7,'image7.jpg'),
	(8,'image8.jpg'),
	(9,'image9.jpg'),
	(10,'image10.jpg'),
	(11,'image11.jpg'),
	(12,'image12.jpg'),
	(13,'image13.jpg');
 
create table tbl_masurement(
	id bigint(20) primary key auto_increment,
	product_id bigint,
    unit_type enum('ltr','gm','kg','ml'),
    unit set('1ltr','100gm','1kg','100ml'), 
	price enum('60','50','70','29'),
	is_active tinyint(1) default 1 comment '1=Active 0= Inactive', 
	is_delete tinyint(1) default 0 comment '0 = non delete 1= delete',
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
	foreign key(product_id) references tbl_product(id)
);
create table tbl_product_like(
	id bigint primary key auto_increment,
    user_id bigint,
	product_id bigint,
	is_active tinyint(1) default 1 comment '1=Active 0= Inactive', 
	is_delete tinyint(1) default 0 comment '0 = non delete 1= delete',
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key (user_id) references tbl_user(id),
	foreign key (product_id) references tbl_product(id)
);


create table tbl_review_rating(
	id bigint(20) primary key auto_increment,
	user_id bigint(20),
	product_id bigint(20),
	rating float(5,1),
	review text,
	is_active tinyint(1) default 1 comment '1=Active 0= Inactive', 
	is_delete tinyint(1) default 0 comment '0 = non delete 1= delete',
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
	foreign key(user_id) references tbl_user(id),
	foreign key(product_id) references tbl_product(id)
);
create table tbl_cart (
	id bigint primary key auto_increment,
    user_id bigint,
    product_id bigint,
    qty int default '1',
    totalitem int,
	is_active tinyint(1) default 1 comment '1=Active 0= Inactive', 
	is_delete tinyint(1) default 0 comment '0 = non delete 1= delete',
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key (user_id) references tbl_user(id),
	foreign key (product_id) references tbl_product(id)
);

INSERT INTO tbl_cart(user_id,product_id,qty,totalitem)
VALUES
(1,3,2,1),
(2,5,1,3),
(3,11,3,2),
(4,2,1,1),
(5,7,4,1);

create table tbl_shipping_address (
	id bigint primary key auto_increment,
    name varchar(16),
    address text,
    city varchar(16),
    state varchar(16),
    zip_code varchar(16),
    mobile varchar(16),
	is_active tinyint(1) default 1 comment '1=Active 0= Inactive', 
	is_delete tinyint(1) default 0 comment '0 = non delete 1= delete',
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp
);

insert into tbl_shipping_address (name, address, city, state, zip_code, mobile) values
	('foram', 'Vaniyawad', 'Nadiad', 'gujarat', '363987', '723523456383'),
    ('mayur','halvad', 'morbi', 'gujarat', '363330', '72354746383'),
    ('abhi','kalol', 'gandhinagar', 'gujarat', '365643', '72354566383'),
    ('viral', 'ahemedabad', 'Mehsana', 'gujarat', '363453', '72987646383'); 
    
create table tbl_order(
	id bigint primary key auto_increment,
    user_id bigint,
	order_no varchar(64),
    order_date datetime,
    total_qty int,
    subtotal double(5,2),
    discount enum('flat','percentage'),
	discount_value  double(8,2),
    delievary_charges double(5,2),
    grand_total double(8,2),
	is_active boolean default '1' COMMENT '1=active, 0=inactive',
	is_delete boolean default '0' Comment '1=deleted, 0=non-deleted',
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
	foreign key(user_id) references tbl_user(id)
);
create table tbl_order_details(
	id bigint primary key auto_increment,
    order_id bigint,
	product_id bigint,
    total_qty int,
	total double(8,2),
    is_active boolean default '1' COMMENT '1=active, 0=inactive',
	is_delete boolean default '0' Comment '1=deleted, 0=non-deleted',
	created_at  timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key(order_id) references tbl_order(id),
    foreign key(product_id) references tbl_product(id)
);

create table tbl_payment (
	id bigint primary key auto_increment,
	order_id bigint,
    type enum('Credit/Debit card','Payment Gateways','Cash On Deliver'),
    number text,
	is_active tinyint(1) default 1 comment '1=Active 0= Inactive', 
	is_delete tinyint(1) default 0 comment '0 = non delete 1= delete',
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
	foreign key(order_id) references tbl_order(id)
);

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 1 sign in  with email or mobile
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
select * from tbl_user where (email='foram@gmail.com' or mobile='7859644260') and country_code='+91' and  is_active=1 and is_delete=0;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 2 forget password
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
update tbl_user set password='1512' where email='foram@gmail.com'and country_code='+91' and  is_active=1 and is_delete=0;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 3 create account
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
insert into tbl_user(name,email, mobile, password,address,latitude,longitude,role) values
	('priya','priya@gmail.com', '9879483440', 'piyu12345','Nadiad vaishali road','22.6824679','72.8496527','User');

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 4 search product
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
select * from tbl_product where name like '%an%';

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 5 shop by category
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
select * from tbl_category;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 5 Top saving products
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
select p.id,pi.image,p.name,p.price,p.unit,s.name ,
concat(round(( 6371 * acos( cos( radians('23.0752323') ) 
              * cos( radians( s.latitude)) 
              * cos( radians( s.longitude) - radians( '72.5208067') ) 
              + sin( radians('23.0752323') ) 
              * sin( radians(s.latitude ) ) ) )),' km' ) AS distance_in_km 
from tbl_product p
join tbl_product_image pi on pi.product_id=p.id
join tbl_store s on s.id=p.store_id
WHERE p.is_active=1 AND p.is_delete = 0   
HAVING distance_in_km <8 order by p.price desc;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 6 VEGETABLE STORE
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
select s.id,s.image,s.name,c.name as category,s.rating,s.location,
concat(round(( 6371 * acos( cos( radians('23.0752323') ) 
              * cos( radians( s.latitude)) 
              * cos( radians( s.longitude) - radians( '72.5208067') ) 
              + sin( radians('23.0752323') ) 
              * sin( radians(s.latitude ) ) ) )),' km' ) AS distance_in_km 
              from tbl_store s
              join tbl_category c on c.id=s.cat_id
              WHERE s.is_active=1 AND s.is_delete = 0   
              HAVING distance_in_km <15 order by s.rating desc;
              
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 7 store and product
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------              
 select p.id,s.id,s.name,c.name as category,(select im.image from tbl_product_image im where im.product_id=p.id) as image,p.name,p.description,p.price,p.unit,m.qty,
 ifnull((select (case when l.product_id !='' then 1 else 0 end )
 from tbl_product_like l where l.product_id = p.id and  l.user_id = 1),0) as is_likes
 from tbl_product p
 join tbl_store s on p.store_id=s.id
 join tbl_category c on c.id= p.cat_id
 join tbl_masurement m on m.product_id=p.id
 where s.id=1;
 
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 8 item details
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------              
 select p.id,(
 select im.image from tbl_product_image im where im.product_id=p.id) as image,p.name,p.price,p.unit,m.qty,m.unit,m.note,p.description,
 ifnull((select (case when l.product_id !='' then 1 else 0 end )
 from tbl_product_like l where l.product_id = p.id and  l.user_id = 1),0) as is_likes
 from tbl_product p
 join tbl_masurement m on m.product_id=p.id
 where p.id=1;
 
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 9 best Seller
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------              
select id,image,name,role from tbl_user where role='seller' and is_active=1 and is_delete=0;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 10 add to cart
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------              
SELECT c.id,c.user_id,c.product_id, (SELECT pi.image FROM tbl_product_image pi WHERE pi.product_id = p.id ORDER BY pi.id DESC LIMIT 1) as image,
p.name,p.price,p.description,c.qty,c.totalitem
FROM tbl_cart c
JOIN tbl_product p ON p.id = c.product_id 
order by c.id;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 11 price list
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------              

SELECT c.id,c.user_id,c.product_id, (SELECT pi.image FROM tbl_product_image pi WHERE pi.product_id = p.id ORDER BY pi.id DESC LIMIT 1) as image,
p.id,p.name,p.avg_rating,p.price,o.total_qty,o.delievary_charges,o.grand_total,
(CASE
    WHEN o.discount = 'flat' THEN (p.price - o.discount_value)
    WHEN o.discount = 'percentage' THEN (p.price - (p.price * o.discount_value / 100))
END) AS Discount
FROM tbl_product p 
JOIN tbl_product_image pi ON pi.product_id=p.id 
join tbl_cart c on c.id = p.cat_id
JOIN tbl_order o on o.id=p.id
WHERE p.cat_id=1
AND p.is_active=1 AND p.is_delete=0 GROUP BY pi.product_id;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 12 check out
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------              
select u.id,sa.id as shipping_id,u.name,u.address,u.country_code,u.mobile,p.type,p.number,o.delivery_date from tbl_shipping_address sa
join tbl_payment p on p.id=sa.id
join tbl_user u on u.id=sa.id
join tbl_order o on o.id=sa.id;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 13 Recipt
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------

 select o.id,od.total_qty,od.total,u.name,u.image,s.name from tbl_order o 
 join tbl_order_details od on o.id=od.order_id 
 join tbl_user u on u.id = o.user_id 
 join tbl_payment p on p.order_id=o.id 
 join tbl_store s on s.id=od.id 
 where o.id=1
 group by o.id;
 
 select * from tbl_shipping_address where name='foram' and is_active=1;
 
 select od.*,p.name from tbl_order_details od join tbl_product p where od.product_id=p.id  group by od.id;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 14 Rate and Review
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
 
 select count(sr.id)as reviews,s.name,s.rating  from tbl_store_rating_review sr join tbl_store s on sr.store_id=s.id where sr.store_id=1 and sr.is_active=1;
 
 -- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 15 Reviews
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
 
 select r.id as reviews,u.id as user,date_format(r.created_at,'%d %b,%Y')as posted_on,
 u.name,r.reviews,r.rating from tbl_store_rating_review r
 join tbl_user u on u.id=r.id
 group by store_id ;

 

CREATE TRIGGER `avg_rating_delete` AFTER DELETE ON `tbl_review_rating`
 FOR EACH ROW UPDATE tbl_product p SET avg_rating=(SELECT IFNULL(ROUND(AVG(r.rating),1),0) FROM tbl_review_rating r WHERE r.product_id=OLD.product_id )WHERE p.id=OLD.product_id;

CREATE TRIGGER `avg_rating_insert` AFTER INSERT ON `tbl_review_rating`
 FOR EACH ROW UPDATE tbl_product p SET avg_rating=(SELECT IFNULL(ROUND(AVG(r.rating),1),0) FROM tbl_review_rating r WHERE r.product_id=NEW.product_id )WHERE p.id=NEW.product_id;

CREATE TRIGGER `avg_rating_update` AFTER UPDATE ON `tbl_review_rating`
 FOR EACH ROW UPDATE tbl_product p SET avg_rating=(SELECT IFNULL(ROUND(AVG(r.rating),1),0) FROM tbl_review_rating r WHERE r.product_id=NEW.product_id )WHERE p.id=NEW.product_id;

CREATE TRIGGER `avg_store_rating_delete` AFTER DELETE ON `tbl_store_rating_review`
 FOR EACH ROW UPDATE tbl_store s SET rating=(SELECT IFNULL(ROUND(AVG(r.rating),1),0) FROM tbl_store_rating_review r WHERE r.store_id=OLD.store_id )WHERE s.id=OLD.store_id;

CREATE TRIGGER `avg_store_rating_insert` AFTER INSERT ON `tbl_store_rating_review`
 FOR EACH ROW UPDATE tbl_store s SET rating=(SELECT IFNULL(ROUND(AVG(r.rating),1),0) FROM tbl_store_rating_review r WHERE r.store_id=NEW.store_id )WHERE s.id=NEW.store_id;

CREATE TRIGGER `avg_store_rating_update` AFTER UPDATE ON `tbl_store_rating_review`
 FOR EACH ROW UPDATE tbl_store s SET rating=(SELECT IFNULL(ROUND(AVG(r.rating),1),0) FROM tbl_store_rating_review r WHERE r.store_id=NEW.store_id )WHERE s.id=NEW.store_id;

CREATE TRIGGER `delete_review_count` AFTER DELETE ON `tbl_review_rating`
 FOR EACH ROW UPDATE tbl_product p SET review_count=(SELECT COUNT(r.id) FROM tbl_review_rating r WHERE r.product_id=OLD.product_id )WHERE p.id=OLD.product_id;

CREATE TRIGGER `delete_store_review` AFTER DELETE ON `tbl_store_rating_review`
 FOR EACH ROW UPDATE tbl_store s SET review=(SELECT COUNT(r.id) FROM tbl_store_rating_review r WHERE r.store_id=OLD.store_id )WHERE s.id=OLD.store_id;

CREATE TRIGGER `insert/update_avg_store_review` AFTER INSERT ON `tbl_store_rating_review`
 FOR EACH ROW UPDATE tbl_store s SET review=(SELECT COUNT(r.id) FROM tbl_store_rating_review r WHERE r.store_id=NEW.store_id )WHERE s.id=NEW.store_id;

CREATE TRIGGER `insert/update_review_count` AFTER INSERT ON `tbl_review_rating`
 FOR EACH ROW UPDATE tbl_product p SET review_count=(SELECT COUNT(r.id) FROM tbl_review_rating r WHERE r.product_id=NEW.product_id )WHERE p.id=NEW.product_id;