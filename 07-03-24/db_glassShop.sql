CREATE DATABASE db_GlassShop;
USE db_GlassShop;
create table tbl_user (
	id bigint primary key auto_increment,
    name varchar(128),
    email varchar(64) unique,
    country_code varchar(64),
    mobile varchar(16) unique default '+91', 
    password varchar(64),
	role enum('user') default 'user',
	is_active boolean default '1' COMMENT '1=active, 0=inactive',
	is_delete boolean default '0' Comment '1=deleted, 0=non-deleted',
	created_at  timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp
);

insert into tbl_user( name, email, mobile, password) values
	('foram', 'foram@gmail.com', '7859644260', 'foram12345'),
    ('gayatri', 'gayatri@gmail.com', '7859644290', 'gayatri12345'),
	('mayur', 'mayur@gmail.com', '7359644260', 'mayur12345'),
    ('abhi', 'abhi@gmail.com', '8359644260', 'abhi12345'),
    ('viral', 'viral@gmail.com', '9859644260', 'viral12345'),
    ('harsh', 'harsh@gmail.com', '8649644260', 'harsh12345');

select * from tbl_user;

create table tbl_category (
	id bigint primary key auto_increment,
    name varchar(64),
    product_count int default '0',
    image varchar(64),
	type set('men', 'women'),
  	is_active boolean default '1' COMMENT '1=active, 0=inactive',
	is_delete boolean default '0' Comment '1=deleted, 0=non-deleted',
	created_at  timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp
);
INSERT INTO tbl_category (name, image, type) VALUES
('Eye Glasses',  'aviator.jpg', 'men' ),
('Computer Glasses', 'wayfarer.jpg', 'men'),
('half-rim Glasses',  'round.jpg', 'women'),
('Cat Eye Glasses', 'cateye.jpg', 'women'),
('rectangle Glasses',  'square.jpg', 'men');

select * from tbl_category;

create table tbl_product (
	id bigint primary key auto_increment,
    category_id bigint,
    user_id bigint,
    name varchar(64),
    image varchar(64),
    price varchar(64),
    description text,
	type set('men', 'women'),
    discount_type enum('flat', 'percentage'),
    discount_value varchar(16),
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
	is_active boolean default '0' COMMENT '1=active,0=inactive',
	foreign key (category_id) references tbl_category(id),
	foreign key (user_id) references tbl_user(id)
);					


INSERT INTO tbl_product (category_id,  name, image, price, description, type, discount_type, discount_value) VALUES
    -- Category 1: Aviator Glasse
    (1, 'Aviator Glasses 1', 'aviator_2.jpg', '45', 'Classic aviator design', 'men', 'percentage', '10%'),
    (1, 'Aviator Glasses 2', 'aviator_1.jpg', '50', 'High-quality aviator glasses', 'men', 'flat', '5'),
    (1, 'Aviator Glasses 3', 'aviator_3.jpg', '55', 'Stylish aviator glasses for men', 'men', 'flat', '8'),
    (1, 'Aviator Glasses 4', 'aviator_4.jpg', '60', 'Aviator glasses with polarized lenses', 'men', 'percentage', '15%'),
    (1, 'Aviator Glasses 5', 'aviator_5.jpg', '48', 'Aviator glasses with UV protection', 'men', 'flat', '6'),

    -- Category 2: Wayfarer Glasses
    (2, 'Wayfarer Glasses 1', 'wayfarer_1.jpg', '40', 'Classic wayfarer design', 'men', 'flat', '4'),
    (2, 'Wayfarer Glasses 2', 'wayfarer_2.jpg', '35', 'Trendy wayfarer glasses', 'men', 'percentage', '12%'),
    (2, 'Wayfarer Glasses 3', 'wayfarer_3.jpg', '42', 'High-quality wayfarer glasses for men', 'men', 'flat', '7'),
    (2, 'Wayfarer Glasses 4', 'wayfarer_4.jpg', '38', 'Classic wayfarer glasses with UV protection', 'men', 'percentage', '18%'),
    (2, 'Wayfarer Glasses 5', 'wayfarer_5.jpg', '44', 'Stylish wayfarer glasses for men', 'men', 'flat', '6'),

    -- Category 3: Round Glasses
    (3, 'Round Glasses 1', 'round_1.jpg', '60', 'Vintage round glasses', 'men, women', 'flat', '6'),
    (3, 'Round Glasses 2', 'round_2.jpg', '55', 'Trendy round glasses for all', 'men', 'percentage', '10%'),
    (3, 'Round Glasses 3', 'round_3.jpg', '65', 'Stylish round glasses for everyone', 'women,men', 'flat', '8'),
    (3, 'Round Glasses 4', 'round_4.jpg', '70', 'Round glasses with anti-glare coating', 'women', 'percentage', '15%'),
    (3, 'Round Glasses 5', 'round_5.jpg', '58', 'Comfortable round glasses', 'women', 'flat', '7'),

    -- Category 4: Cat Eye Glasses
    (4, 'Cat Eye Glasses 1', 'cateye_1.jpg', '55', 'Elegant cat eye glasses for women', 'women', 'flat', '5'),
    (4, 'Cat Eye Glasses 2', 'cateye_2.jpg', '50', 'Trendy cat eye glasses', 'women', 'percentage', '10%'),
    (4, 'Cat Eye Glasses 3', 'cateye_3.jpg', '60', 'Stylish cat eye glasses for women', 'women', 'flat', '8'),
    (4, 'Cat Eye Glasses 4', 'cateye_4.jpg', '65', 'Cat eye glasses with UV protection', 'women', 'percentage', '15%'),
    (4, 'Cat Eye Glasses 5', 'cateye_5.jpg', '52', 'Comfortable cat eye glasses for women', 'women', 'flat', '6'),

    -- Category 5: Square Glasses
    (5, 'Square Glasses 1', 'square_1.jpg', '50', 'Modern square glasses', 'women, men', 'flat', '5'),
    (5, 'Square Glasses 2', 'square_2.jpg', '45', 'Classic square glasses design', 'women', 'percentage', '10%'),
    (5, 'Square Glasses 3', 'square_3.jpg', '55', 'Stylish square glasses for everyone', 'men', 'flat', '8'),
    (5, 'Square Glasses 4', 'square_4.jpg', '60', 'Square glasses with anti-reflective coating', 'women,men', 'percentage', '15%'),
    (5, 'Square Glasses 5', 'square_5.jpg', '48', 'Comfortable square glasses for daily use', 'men', 'flat', '6');
    
create table tbl_product_image (
	id bigint primary key auto_increment,
    product_id bigint,
    image varchar(64),
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
	is_active boolean default '0' COMMENT '1=active,0=inactive',
    foreign key (product_id) references tbl_product(id)
);
truncate table tbl_product_image;

insert into tbl_product_image (product_id, image) VALUES 
	(1, 'product1 image1'),
	(1, 'product1 image2'),
    (1, 'product1 image3'),
    (1, 'product1 image4'),
	(2, 'product2 image1'),
	(2, 'product2 image2'),
    (2, 'product2 image3'),
    (2, 'product2 image4'),
    (3, 'product3 image1'),
	(3, 'product3 image2'),
    (3, 'product3 image3'),
    (3, 'product3 image4'),
    (4, 'product4 image1'),
	(4, 'product4 image2'),
    (4, 'product4 image3'),
    (4, 'product4 image4'),
    (5, 'product5 image1'),
	(5, 'product5 image2'),
    (5, 'product5 image3'),
    (5, 'product5 image4'),
    (6, 'product1 image1'),
	(6, 'product1 image2'),
    (6, 'product1 image3'),
    (6, 'product1 image4'),
    (7, 'product1 image1'),
	(7, 'product1 image2'),
    (7, 'product1 image3'),
    (7, 'product1 image4'),
    (8, 'product1 image1'),
	(8, 'product1 image2'),
    (8, 'product1 image3'),
    (8, 'product1 image4'),
    (9, 'product1 image1'),
	(9, 'product1 image2'),
    (9, 'product1 image3'),
    (9, 'product1 image4'),
	(10, 'product1 image1'),
	(10, 'product1 image2'),
    (10, 'product1 image3'),
    (10, 'product1 image4'),
    (11, 'product1 image3'),
    (11, 'product1 image4'),
    (12, 'product1 image3'),
    (12, 'product1 image4'),
	(13, 'product1 image3'),
    (13, 'product1 image4'),
	(14, 'product1 image3'),
    (14, 'product1 image4'),
    (15, 'product1 image3'),
    (15, 'product1 image4'),
    (16, 'product1 image3'),
    (17, 'product1 image4'),
    (17, 'product1 image4'),
    (18, 'product1 image4'),
    (18, 'product1 image4'),
    (19, 'product1 image4'),
    (19, 'product1 image4'),
	(20, 'product1 image3'),
    (21, 'product1 image4'),
    (22, 'product1 image4'),
    (23, 'product1 image4'),
    (24, 'product1 image4'),
    (25, 'product1 image4');
  
create table tbl_order(
	id bigint primary key auto_increment,
    user_id bigint,
	order_no varchar(64),
    order_date date,
    total_qty int,
    total_amount double(5,2),
    discount_price double(5,2),
    delievary_charges double(5,2),
    grand_total double(8,2),
    status enum('Pending','Shipped','Delievered','Cancelled'),
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
    per_price double(8,2),
	total double(8,2),
    status enum('Pending','Shipped','Delievered','Cancelled'),
    is_active boolean default '1' COMMENT '1=active, 0=inactive',
	is_delete boolean default '0' Comment '1=deleted, 0=non-deleted',
	created_at  timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key(order_id) references tbl_order(id),
    foreign key(product_id) references tbl_product(id)
);
    
-- QUERIES
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 1.login with email
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
select * from tbl_user where email='foram@gmail.com' and password='foram12345' and is_active=1;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 2.login with mobile
-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------
select * from tbl_user where mobile='7859644260'  and is_active=1;

-- --------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 3.login with email or mobile number
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
select * from tbl_user where (email='foram@gmail.com' or mobile='7859644260') and is_active=1;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 4 forget password
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
update tbl_user set password='1512' where email='foram@gmail.com';

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 5.search category
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
select * from tbl_category where name like'C%';
select * from tbl_category where c.name;

select c.*, u.name from tbl_category c join tbl_user u on u.id=c.id  where c.name='Eye Glasses' and c.type='men';
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 7.total product count
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
select count(id) from tbl_product where category_id=4 and  find_in_set('women', type);

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 8.product
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
select p.*,(select group_concat(im.image) from tbl_product_image im where im.product_id=p.id) as image,
case 
	when discount_type = 'flat' then  price - discount_value
    when discount_type = 'percentage' then  price -  (price * discount_value/100) 
    else 0
end as new_price
from tbl_product p
where p.id=1;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 9.product category type men
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
select p.*,
case 
	when p.discount_type = 'flat' then  p.price - p.discount_value
    when p.discount_type = 'percentage' then  p.price -  (p.price * p.discount_value/100) 
    else 0
end as new_price,
c.* from tbl_category c 
join tbl_product p on p.category_id=c.id
where c.id=1 and find_in_set('men', p.type);

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 10.product category type women
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
select p.*,p.id as total_products, 
case 
	when discount_type = 'flat' then  price - discount_value
    when discount_type = 'percentage' then  price -  (price * discount_value/100) 
    else 0
end as new_price, 
c.* from tbl_category c 
join tbl_product p on p.category_id=c.id
where c.id=4 and find_in_set('women', p.type);

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 11.count products
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
select o.* from tbl_order o join tbl_order_details od on od.order_id = o.id where  o.id=2;
select * from tbl_order_details;