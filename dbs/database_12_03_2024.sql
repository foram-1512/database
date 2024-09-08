create database database_12_03_2024;
use database_12_03_2024;
drop DATABASE database_12_03_2024;

create table tbl_user (
	id BIGINT PRIMARY KEY AUTO_INCREMENT,
    social_id varchar(128),
    firstname varchar(128),
    lastname varchar(128),
    email varchar(128),
    country_code varchar(8) DEFAULT '+91',
    phone varchar(16),
    password text,
    role enum('User') DEFAULT 'User',
    login_type enum('F', 'G', 'S', 'A'),
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
	is_active boolean default '1' COMMENT '1=active,0=inactive'
);
insert into tbl_user( firstname, lastname, email, phone, password, login_type) values
	('abhi','makwana', 'abhi@gmail.com', '8359644260', 'abhi12345', 'S'),
    ('mayur','mori', 'mayur@gmail.com', '7359644260', 'mayur12345', 'G'),
    ('foram','pamchal', 'foram@gmail.com', '7859644260', 'foram12345', 'S'),
    ('abdul','kadir', 'abdul@gmail.com', '9859644260', 'abdul12345', 'A'),
    ('devarsh','panchal', 'devarsh@gmail.com', '8649644260', 'devarsh12345', 'F');


create table tbl_category (
	id BIGINT PRIMARY KEY AUTO_INCREMENT,
    parent_id BIGINT,
    name varchar(128),
    image varchar(128),
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
	is_active boolean default '1' COMMENT '1=active,0=inactive',
    foreign key(parent_id)references tbl_category(id)
);

insert into tbl_category (name, image) values 
('Men', 'men_image.jpg'),
('Women', 'women_image.jpg'),
('Kids', 'kids_image.jpg'),
('Beauty', 'Beauty_image.jpg');


insert into tbl_category (parent_id, name, image) values 
(1, 'Top Wear', 'Shirt_image.jpg'),
(1, 'jeans', 'jeans_image.jpg'),
(2, 'dress', 'dress_image.jpg'),
(2, 'saree', 'saree_image.jpg'),
(3, 'hoodies', 'hoodies_image.jpg'),
(3, 'shorts', 'shorts_image.jpg'),
(4, 'lipstick', 'lipstick_image.jpg'),
(4, 'body loation', 'bodyloation_image.jpg');



create table tbl_store(
	id bigint AUTO_INCREMENT primary key,
    name varchar(128),
    image varchar(128),
    avg_rating float(5,2) default '0.00',
    total_reviews int,
    owner_name varchar(128),
    phone VARCHAR(16),
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
	is_active boolean default '1' COMMENT '1=active,0=inactive'
);
insert into tbl_store (name, image, owner_name, phone) values 
('The New Store', 'newstore.jpg', 'John Doe', '+91 9876543210'),
('H&M', 'H&M.jpg', 'Mark Pitt', '+91 9826556780'),
('ZARA', 'zara.jpg', 'Mathew Lewis', '+91 6854543220');



create table tbl_product (
	id bigint primary key auto_increment,
    store_id bigint,
    category_id bigint,
    name varchar(64),
    image varchar(64),
    type varchar(64),
    price float(8,1),
    discount_type enum('flat','percentage'),
    discount_value varchar(8),
    description text,
    avg_rating float(5,1),
    total_like int,
    total_review int,
    in_stock BOOLEAN DEFAULT 1,
    return_policy boolean default 1,
    free_delivery boolean default 1,
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
	is_active boolean default '1' COMMENT '1=active,0=deactive',
    foreign key(store_id)references tbl_store(id)
);
truncate table tbl_product;

insert into tbl_product (store_id,category_id, name, image, type, price, discount_type, discount_value) values 
(1, 5, 'Loose Textured T-shirt', 'shirt_image.jpg', 'Denim', 900, 'flat', 100);


-- Insert records for store = 1
INSERT INTO tbl_product (store_id, category_id, name, image, type, price, discount_type, discount_value)
VALUES 
    (1, 5, 'Product 1', 'image_1.jpg', 'Type A', 1000, 'flat', '100'),
    (1, 6, 'Product 2', 'image_2.jpg', 'Type B', 1100, 'percentage', '10%'),
    (1, 5, 'Product 3', 'image_3.jpg', 'Type C', 1200, 'flat', '50');

-- Insert records for store = 2
INSERT INTO tbl_product (store_id, category_id, name, image, type, price, discount_type, discount_value)
VALUES 
    (2, 7, 'Product 1', 'image_1.jpg', 'Type A', 800, 'flat', '100'),
    (2, 7, 'Product 2', 'image_2.jpg', 'Type B', 850, 'percentage', '15%'),
    (2, 8, 'Product 3', 'image_3.jpg', 'Type C', 900, 'flat', '75');

-- Insert records for store = 3
INSERT INTO tbl_product (store_id, category_id, name, image, type, price, discount_type, discount_value)
VALUES 
    (3, 9, 'Product 1', 'image_1.jpg', 'Type A', 1200, 'percentage', '20%'),
    (3, 10, 'Product 2', 'image_2.jpg', 'Type B', 1250, 'flat', '150'),
    (3, 10, 'Product 3', 'image_3.jpg', 'Type C', 1300, 'percentage', '25%'),
    (3, 11, 'Product 3', 'image_3.jpg', 'Type C', 1300, 'percentage', '25%'),
    (3, 12, 'Product 3', 'image_3.jpg', 'Type C', 1300, 'percentage', '25%');



create table tbl_store_review_rating (
	id bigint primary key auto_increment,
    user_id bigint,
    store_id bigint,
    review text,
    rating float(5,1),
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
	is_active boolean default '1' COMMENT '1=active,0=deactive',
    foreign key(store_id)references tbl_store(id),
	foreign key(user_id)references tbl_user(id)
);



create table tbl_product_review_rating (
	id bigint primary key auto_increment,
    user_id bigint,
    product_id bigint,
    review text,
    rating float(5,1),
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
	is_active boolean default '1' COMMENT '1=active,0=deactive',
	foreign key(user_id)references tbl_user(id),
	foreign key(product_id)references tbl_product(id)
);





create table tbl_product_size (
	id  bigint primary key AUTO_INCREMENT,
    product_id BIGINT,
    size enum('S','M', 'L', 'XL', 'XXL', 'XXXL'),
    price enum('0', '50', '60', '80', '90', '100'),
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
	is_active boolean default '1' COMMENT '1=active,0=deactive',
	foreign key(product_id)references tbl_product(id)
);


create table tbl_product_color (
	id  bigint primary key AUTO_INCREMENT,
    product_id BIGINT,
    color enum('Red', 'Blue', 'Grey', 'Black', 'White'),
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
	is_active boolean default '1' COMMENT '1=active,0=deactive',
	foreign key(product_id)references tbl_product(id)
);

create table tbl_like (
	id  bigint PRIMARY key AUTO_INCREMENT,
    product_id bigint,
    user_id BIGINT,
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
	is_active boolean default '1' COMMENT '1=active,0=deactive',
	foreign key(product_id)references tbl_product(id),
    foreign key(user_id)references tbl_user(id)
);


create table tbl_product_image (
	id BIGINT AUTO_INCREMENT primary KEY,
    product_id bigint,
    image varchar(128),
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
	is_active boolean default '1' COMMENT '1=active,0=deactive',
	foreign key(product_id)references tbl_product(id)
);



-- login query
select * from tbl_user where email='abhi@gmail.com' and password='abhi123' and is_active=1 and login_type='S';


-- forgot password
select * from tbl_user where (email='abhi@gmail.com' or phone='8359644260') and is_active=1 and login_type='s';
update tbl_user set password='abhi123' where id=1 and is_active=1;


-- sign up :-
insert into tbl_user set firstname='prajapati', lastname='viral', phone='7654321890', password='viral123';


-- category display
select * from tbl_category where parent_id=0;

-- best seller product

select p.*, pi.image from tbl_product p 
join tbl_product_image pi on pi.product_id=p.id
where p.avg_rating>4.2 GROUP BY p.id;

-- change image query

-- product display page
select p.*,ps.size,ps.price,pc.color,
case 
	when p.discount_type = 'flat' then  (p.price - p.discount_value)
    when p.discount_type = 'percentage' then  p.price -  (p.price * p.discount_value/100 )  
    else 0
end as grand_total
 from tbl_product p
 join tbl_product_size ps on ps.product_id=p.id
 join tbl_product_color pc on pc.product_id=p.id
join tbl_product_image pi on pi.product_id=p.id
where p.id=1
GROUP BY p.id;



select p.*,  ps.size, ps.price as size_price, pc.color, 
	(select concat(ci.name,' / ',c.name) from tbl_category c 
	join tbl_category ci on c.parent_id=ci.id 
	join tbl_product p on p.category_id=c.id where p.id=1) as category,
	case 
		when p.discount_type = 'flat' then    p.price - p.discount_value + ps.price
		when p.discount_type = 'percentage' then p.price -  (p.price * p.discount_value/100)
	else 0
	end as grand_total, s.*
 from tbl_product p 
 join tbl_product_size ps on ps.product_id=p.id 
 join tbl_product_color pc on pc.product_id=p.id
 join tbl_store s on s.id=p.store_id where p.id=1
 group by p.id;
 
 
 
 



SELECT *,IFNULL((SELECT(CASE WHEN l.product_id !='' THEN 1 ELSE 0 END) from tbl_like l where l.product_id=p.id AND l.user_id=1),0) as is_like FROM tbl_product p;


 select concat(ci.name,'/',c.name) as category_type from tbl_category c join tbl_category ci on c.parent_id=ci.id join tbl_product p on p.category_id=c.id where p.id=1;
 
  
 

