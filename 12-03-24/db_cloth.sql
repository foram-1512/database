create database db_cloth_shop;
use db_cloth_shop;

create table tbl_user(
	id bigint(20) primary key auto_increment,
	social_id varchar(256),
	firstname varchar(64),
	lastname varchar(64),
	email varchar(64) unique,
	country_code varchar(64) default '+91',
	mobile varchar(16) unique, 
	password text,
	login_type enum('S','F','G','A') comment 's = simple g = google f = facebook a = apple_id',
	role enum('user','owner') default 'user',
	is_active tinyint(1) default 1 comment '1=Active 0= Inactive', 
	is_delete tinyint(1) default 0 comment '0 = non delete 1= delete',
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp
);

insert into tbl_user(firstname,lastname,email, mobile, password,login_type) values
	('foram','panchal','foram@gmail.com', '9106603730', 'foram12345','S'),
    ('gayatri','patil','gayatri@gmail.com', '7546734523', 'gayatri12345','F'),
	('mayur','mori','mayur@gmail.com', '9879483440', 'mayur12345','G'),
    ('abhi','makwana','abhi@gmail.com', '8401971214', 'abhi12345','A'),
    ('viral','prajapati','viral@gmail.com', '9879353440', 'viral12345','S');
    
create table tbl_category(
	id bigint(20) primary key auto_increment,
	user_id bigint(20),
	name varchar(32),
	image varchar(128) default 'default.jpg',
	is_active tinyint(1) default 1 comment '1=Active 0= Inactive', 
	is_delete tinyint(1) default 0 comment '0 = non delete 1= delete',
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
	foreign key(user_id) references tbl_user(id)
);

insert into tbl_category(name)
	values
	('Men'),
	('Women'),
	('Kid'),
	('Beauty'),
	('Shoes'),
	('Jewellary');
    
create table tbl_store(
id bigint(20) primary key auto_increment,
product_id bigint(20),
rating float(5,1),
reviews text,
is_active tinyint(1) default 1 comment '1=Active 0= Inactive', 
is_delete tinyint(1) default 0 comment '0 = non delete 1= delete',
created_at timestamp default current_timestamp,
updated_at timestamp default current_timestamp on update current_timestamp,
foreign key(product_id) references tbl_product(id)
);

INSERT INTO tbl_store (product_id, rating, reviews)
VALUES
    (1, 4.5, 'Good store with great products.'),
    (2, 4.2, 'Nice store, but could improve on product variety.');
    
create table tbl_product(
	id bigint(20) primary key auto_increment,
	cat_id bigint(20),
	store_id bigint(20),
	name varchar(256),
	tag varchar(64),
	cloth_type varchar(16),
	price double(8,2),
	discount enum('flat','percentage'),
	discount_value  double(8,2),
	is_like tinyint(1),
	like_count int,
	comment_count int,
	avg_rating float(5,1),
	review text,
	description text,
	is_stock enum('instock','out of stock','few left'),
	shipping enum('free','paid'),
	delivery_day varchar(8),
	is_return enum('no return policy',''),
	is_active tinyint(1) default 1 comment '1=Active 0= Inactive', 
	is_delete tinyint(1) default 0 comment '0 = non delete 1= delete',
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
	foreign key(cat_id) references tbl_category(id)
);


INSERT INTO tbl_product (cat_id, store_id, name, tag, cloth_type, price, discount, discount_value, is_like, like_count, comment_count, avg_rating, review, description, is_stock, shipping, delivery_day, is_return)
VALUES
    (1, 1, 'Shirt', 'Shirt, best deal, best seller', 'Clothing', 100.00, 'flat', 10.00, 1, 20, 5, 4.5, 'Good product', 'Product description', 'instock', 'free', '2 days', ''),
    (1, 2, 'T-Shirt', 'T-Shirt, best deal', 'Clothing', 150.00, 'percentage', 15.00, 1, 25, 8, 4.2, 'Nice product', 'Product description', 'instock', 'free', '3 days', ''),
    (2, 1, 'Pants', 'Pants', 'Clothing', 200.00, 'flat', 20.00, 0, 10, 3, 3.8, 'Average product', 'Product description', 'out of stock', 'paid', '5 days', ''),
    (2, 1, 'Dress', 'Dress, best deal', 'Clothing', 120.00, 'flat', 8.00, 1, 15, 6, 4.3, 'Great product', 'Product description', 'instock', 'free', '2 days', ''),
    (2, 1, 'Skirt', 'Skirt', 'Clothing', 160.00, 'flat', 14.00, 1, 22, 9, 4.1, 'Superb product', 'Product description', 'few left', 'free', '3 days', ''),
    (3, 2, 'Jacket', 'Jacket, best seller', 'Clothing', 220.00, 'flat', 18.00, 1, 28, 10, 4.4, 'Excellent product', 'Product description', 'instock', 'free', '2 days', ''),
    (3, 1, 'Coat', 'Coat', 'Clothing', 190.00, 'percentage', 16.00, 0, 12, 5, 3.9, 'Satisfactory product', 'Product description', 'instock', 'free', '4 days', ''),
	(4, 2, 'Sport Shoes','shoes','Running shoes',500.00, 4 , 3 ,4.5 ,'Excellent product', 'Product description', 'instock', 'free', '2 days', ''),
    (5, 2,'Neckless','Diamond','Ivory',3000.00, 10, 2700, 3,5.0,'Excellent product', 'Product description', 'instock', 'free', '2 days', '');
    
create table tbl_product_image(
id bigint(20) primary key auto_increment,
product_id  bigint(20),
image varchar(128),
is_active tinyint(1) default 1 comment '1=Active 0= Inactive', 
is_delete tinyint(1) default 0 comment '0 = non delete 1= delete',
created_at timestamp default current_timestamp,
updated_at timestamp default current_timestamp on update current_timestamp,
foreign key(product_id) references tbl_product(id)
);

INSERT INTO tbl_product_image (product_id, image)
VALUES
    (1, 'image1.jpg'),
    (1, 'image2.jpg'),
    (2, 'image3.jpg'),
    (2, 'image4.jpg'),
    (2, 'image5.jpg'),
    (3, 'image6.jpg'),
    (3, 'image7.jpg'),
    (3, 'image8.jpg'),
    (4, 'image9.jpg'),
    (4, 'image10.jpg'),
    (5, 'image11.jpg'),
    (5, 'image12.jpg'),
    (6, 'image13.jpg'),
    (7, 'image14.jpg'),
    (8, 'image15.jpg'),
    (9, 'image15.jpg');


create table tbl_color(
id bigint(20) primary key auto_increment,
color enum('blue','grey','pink','black','green'),
is_active tinyint(1) default 1 comment '1=Active 0= Inactive', 
is_delete tinyint(1) default 0 comment '0 = non delete 1= delete',
created_at timestamp default current_timestamp,
updated_at timestamp default current_timestamp on update current_timestamp
); 

create table tbl_size(
id bigint(20) primary key auto_increment,
product_id bigint,
size set('S','M','L','XL','XXL'),
price enum('0','50','50','60','80'),
is_active tinyint(1) default 1 comment '1=Active 0= Inactive', 
is_delete tinyint(1) default 0 comment '0 = non delete 1= delete',
created_at timestamp default current_timestamp,
updated_at timestamp default current_timestamp on update current_timestamp,
foreign key(product_id) references tbl_product(id)
); 

INSERT INTO tbl_size (product_id, size, price)
VALUES
    (1, 'S,M,L', '50'),
    (2, 'M,L,XL', '60'),
    (3, 'S,L,XL', '50'),
    (4, 'M,XL,XXL', '80'),
    (5, 'S,M,XXL', '50'),
    (6, 'S,L,XL,XXL', '60'),
	(7, 'L,XL,XXL', '50'),
	(7, 'S,L,XL,XXL', '60'),
	(9, 'L,XL,XXL', '50');
    
create table tbl_product_like(
	id bigint primary key  auto_increment,
    product_id bigint,
    user_id bigint,
    is_active tinyint default '1' COMMENT '1=active,0=deactive',
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

create table tbl_report(
id bigint(20) primary key auto_increment,
product_id bigint(20),
store_id bigint(20),
is_active tinyint(1) default 1 comment '1=Active 0= Inactive', 
is_delete tinyint(1) default 0 comment '0 = non delete 1= delete',
created_at timestamp default current_timestamp,
updated_at timestamp default current_timestamp on update current_timestamp,
foreign key(product_id) references tbl_product(id),
foreign key(store_id) references tbl_store(id)
);


create table tbl_store_review_rating(
	id bigint NOT NULL PRIMARY KEY AUTO_INCREMENT,
	user_id bigint,
	product_id bigint,
	rating float(5,1),
	review varchar(128),
	is_active tinyint(1) default 1 comment '1=Active 0= Inactive', 
	is_delete tinyint(1) default 0 comment '0 = non delete 1= delete',
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
	foreign key (user_id) references tbl_user(id),
	foreign key (product_id) references tbl_product(id)
);


-- query 

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 1.signup query
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO `tbl_user`(`firstname`, `lastname`, `email`, `country_code`, `mobile`, `password`, `login_type`, `role`)
VALUES ('Foram','Panchal','foramp@gmail.com','+91','849384893','foram@133','S','user');

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 1.login with Simple user
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
select * from tbl_user where email='foram@gmail.com' and password='foram12345' and  login_type='s' and is_active=1 and is_delete=0;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 2.login with Apple user
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
select * from tbl_user where email='abhi@gmail.com'and country_code='+91' and login_type='A' and is_active=1 and is_delete=0;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 3.login with Facebook user
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
select * from tbl_user where email='gayu@gmail.com' and country_code='+91'and login_type='F'and is_active=1 and is_delete=0;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 4.login with google user
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
select * from tbl_user where email='mayur@gmail.com' and country_code='+91' and login_type='G'and is_active=1 and is_delete=0;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 5 forget password
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT id,email FROM tbl_user WHERE email ="foram@gmail.com" AND login_type='s' AND county_code='+91' and  is_active = 1 AND is_delete=0;
update tbl_user set password='1512' where mobile='9106603730'AND id=2 AND is_active = 1 AND is_delete=0;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 6.listing category
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT c.id,c.name,c.image FROM tbl_category c;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 7.products_list
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT p.id,rr.id,p.name,p.tag,p.price,p.discount,p.discount_value,
p.is_like,rr.rating,rr.review 
FROM tbl_product p join tbl_review_rating rr on p.id = rr.id;


select p.*,  ps.size, ps.price as size_price, pc.color, 
	(select concat(ci.name,' / ',c.name) from tbl_category c 
	join tbl_category ci on c.id=ci.id 
	join tbl_product p on p.cat_id=c.id where p.id=1) as category,
	case 
		when p.discount = 'flat' then  p.price - p.discount_value + ps.price
		when p.discount = 'percentage' then  p.price -  (p.price * p.discount_value/100) + (ps.price)
	else 0
	end as grand_total, s.*
 from tbl_product p 
 join tbl_size ps on ps.product_id=p.id 
 join tbl_color pc on pc.id=p.id
 join tbl_store s on s.id=p.store_id where p.id=1;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 8.specific product details 
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT p.*,s.id,s.size,s.price,c.color,pi.image,ci.name
FROM tbl_product p
JOIN tbl_color c ON p.id = c.id
JOIN tbl_size s ON p.id = s.product_id
JOIN tbl_product_image pi ON p.id = pi.product_id
JOIN tbl_category ci ON p.id = ci.id
HAVING p.id=1;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 9.is_like
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
 select * ,ifnull((select (case when l.product_id !='' then 1 else 0 end )
 from tbl_product_like l where l.product_id = p.id and  l.user_id = 1),0) as is_likes
 from tbl_product p;
