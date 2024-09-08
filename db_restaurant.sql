create database db_restaurant;
use db_restaurant;

create table tbl_user (
	id bigint primary key auto_increment,
    social_id varchar(256) default '0',
    name varchar(128),
    image varchar(128) default 'default.jpg',
    email varchar(64) unique,
    country_code varchar(64) default '+91',
    mobile varchar(16) unique , 
	address text,
	latitude varchar(64),
    longitude varchar(64),
    password varchar(64),
    role enum('user') default 'user',
    login_type enum('S','F','T','I') comment 'F = Facebook T = Twitter S = simple I = Instagram',
	is_active tinyint(1) default 1 comment '1=Active 0= Inactive', 
	is_delete tinyint(1) default 0 comment '0 = non delete 1= delete',
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp
);

insert into tbl_user(name,email, mobile, password,login_type,address,latitude,longitude) values
	('foram','foram@gmail.com', '9106603730', 'foram12345','S','Nadiad vaishali road','22.6824679','72.8496527'),
    ('gayatri','gayatri@gmail.com', '7546734523', 'gayatri12345','S','Ahmedabad Rabari colony','23.0010957','72.6251497'),
	('mayur','mayur@gmail.com', '9879483440', 'mayur12345','S','Morbi','22.8049727','70.8155096'),
    ('abhi','abhi@gmail.com', '8401971214', 'abhi12345','S','Kalol','23.228059','72.4242963'),
    ('viral','viral@gmail.com', '9879353440', 'viral12345','S','Mehsana','23.5898665','72.3416933');

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
('Breakfast'),
('Lunch'),
('Dinner'),
('Pizza'),
('Fruits'),
('Vegetables'),
('Protin');
    
create table tbl_dish(
	id bigint primary key auto_increment,
    category_id bigint,
    name varchar(64),
    price double(8,2),
    unit enum('ltr','gm','kg','ml'),
    weight varchar(64),
    chefname varchar(64),
    description text,
    making_time varchar(64),
    is_active tinyint(1) default 1 comment '1=Active 0= Inactive', 
	is_delete tinyint(1) default 0 comment '0 = non delete 1= delete',
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key (category_id) references tbl_category(id)
);

insert into tbl_dish(category_id,name,price,unit,weight,chefname,description) values
(1,'Sandwich',80,'gm','100','Vrusha',' SANDWICH is two or more slices of bread or a split roll having a filling in cheese'),
(2, 'Spaghetti Carbonara', 120, 'gm', '200', 'Foram', 'Spaghetti Carbonara is a classic Italian pasta dish with creamy egg sauce, pancetta, and Parmesan cheese.'),
(3, 'Grilled Salmon', 200, 'gm', '150', 'Vivek', 'Grilled salmon is a delicious and healthy dish, seasoned with herbs and served with lemon wedges.'),
(4, 'Margherita Pizza', 150, 'gm', '300', 'pratham', 'Margherita pizza is a simple yet flavorful pizza topped with tomato sauce, mozzarella cheese, and fresh basil.'),
(5, 'Mango delight', 200, 'ltr', '1', 'Divya', 'Apples are crisp, juicy fruits that are commonly eaten fresh or used in various desserts and dishes.'),
(6, 'Broccoli', 40, 'kg', '150', 'Dixa', 'Broccoli is a nutritious green vegetable, rich in vitamins and minerals, often steamed or stir-fried as a side dish.'),
(7, 'Pinut Butter', 180, 'gm', '200', 'Priya', 'Peanut butter is a food paste or spread made from ground, dry-roasted peanuts');
    
create table tbl_dish_image(
	id bigint primary key auto_increment,
    dish_id bigint,
    image varchar(128),
	is_active tinyint(1) default 1 comment '1=Active 0= Inactive', 
	is_delete tinyint(1) default 0 comment '0 = non delete 1= delete',
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
	foreign key (dish_id) references tbl_dish(id)
);
 insert into tbl_dish_image (dish_id,image) values
 (1,'image1.jpg'),
 (1,'image2.jpg'),
 (1,'image3.jpg'),
 (2,'image4.jpg'),
 (2,'image5.jpg'),
 (2,'image6.jpg'),
 (2,'image7.jpg'),
 (3,'image8.jpg'),
 (3,'image9.jpg'),
 (3,'image10.jpg'),
 (4,'image11.jpg'),
 (4,'image11.jpg'),
 (4,'image12.jpg'),
 (5,'image13.jpg'),
 (5,'image14.jpg'),
 (5,'image15.jpg'),
 (6,'image16.jpg'),
 (6,'image17.jpg'),
 (6,'image18.jpg'),
 (7,'image19.jpg'),
 (7,'image20.jpg'),
 (7,'image21.jpg');

create table tbl_dish_review(
	id bigint primary key auto_increment,
    user_id bigint,
    dish_id bigint,
    review text,
    is_active tinyint(1) default 1 comment '1=Active 0= Inactive', 
	is_delete tinyint(1) default 0 comment '0 = non delete 1= delete',
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key (user_id) references tbl_user(id),
	foreign key (dish_id) references tbl_dish(id)
);

INSERT INTO tbl_dish_review (user_id, dish_id, review)
VALUES
    (1, 1, 'Great dish, loved the flavors!'),
    (2, 2, 'The presentation was excellent, but the taste could be improved.'),
    (3, 3, 'Absolutely delicious, would highly recommend!'),
    (4, 4, 'Disappointed with the portion size, expected more.'),
    (5, 5, 'Average dish, nothing special.'),
    (2, 6, 'Fantastic dish, exceeded my expectations!'),
    (5, 7, 'Good dish, but a bit too spicy for my taste.');

create table tbl_dish_like(
	id bigint primary key auto_increment,
    user_id bigint,
	dish_id bigint,
	is_active tinyint(1) default 1 comment '1=Active 0= Inactive', 
	is_delete tinyint(1) default 0 comment '0 = non delete 1= delete',
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key (user_id) references tbl_user(id),
	foreign key (dish_id) references tbl_dish(id)
);

INSERT INTO tbl_dish_like(dish_id, user_id)
VALUES
(1,3),
(1,5),
(1,2),
(2,4),
(2,1),
(3,2),
(3,4),
(3,1),
(3,3),
(4,4),
(4,5),
(5,3),
(6,1),
(6,3),
(7,4),
(7,5),
(7,3);

create table tbl_cart (
	id bigint primary key auto_increment,
    user_id bigint,
    totalitem int,
	is_active tinyint(1) default 1 comment '1=Active 0= Inactive', 
	is_delete tinyint(1) default 0 comment '0 = non delete 1= delete',
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key (user_id) references tbl_user(id)
);
INSERT INTO tbl_cart(user_id,totalitem)
VALUES
(1,3),
(2,5),
(3,1),
(4,2),
(5,4);

create table tbl_cart_details(
	id bigint primary key auto_increment,
    cart_id bigint,
    dish_id bigint,
    qty int default '1',
	is_active tinyint(1) default 1 comment '1=Active 0= Inactive', 
	is_delete tinyint(1) default 0 comment '0 = non delete 1= delete',
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key (dish_id) references tbl_dish(id),
    foreign key (cart_id) references tbl_cart(id)
);

INSERT INTO tbl_cart_details (cart_id, dish_id, qty)
VALUES
    (1, 3, 2),
    (1, 5, 1),
    (1, 1, 3),
    (2, 7, 1),
    (2, 4, 2),
    (2, 7, 1),
    (2, 4, 2),
	(2, 7, 1),
    (3, 4, 2),
    (4, 7, 1),
    (4, 4, 2),
    (5, 7, 1),
    (5, 4, 2),
	(5, 7, 1),
    (5, 4, 2);

create table tbl_order (
	id bigint primary key auto_increment,
    user_id bigint,
    delivery_id bigint,
    order_no varchar(64),
    order_date datetime,
    total_qty int,
    total_amount int,
    delivery_charges int,
    grand_total int,
    status enum('Cancelled','Pending','Delivered','Shipped'),
    is_active tinyint(1) default 1 comment '1=Active 0= Inactive', 
	is_delete tinyint(1) default 0 comment '0 = non delete 1= delete',
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key (user_id) references tbl_user(id),
    foreign key (delivery_id) references tbl_delivery_address(id)
);

create table tbl_order_details (
	id bigint primary key auto_increment,
    dish_id bigint,
    ingrediant_id bigint,
    order_id bigint,
    ingrediants text,
    total_qty int,
    per_price float(8,2),
    total int,
    status enum('Cancelled','Pending','Delivered','Shipped'),
    is_active tinyint(1) default 1 comment '1=Active 0= Inactive', 
	is_delete tinyint(1) default 0 comment '0 = non delete 1= delete',
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key (order_id) references tbl_order(id),
    foreign key (ingrediant_id) references tbl_ingrediants(id),
	foreign key (dish_id) references tbl_dish(id)
);

create table tbl_ingrediants(
    id bigint primary key auto_increment,
	name varchar(16),
    price float(8,2),
    image varchar(256) default ('default.jpg'),
    is_active tinyint(1) default 1 comment '1=Active 0= Inactive', 
	is_delete tinyint(1) default 0 comment '0 = non delete 1= delete',
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp
);

insert into tbl_ingrediants(name,price)
values
('Double cheese',40),
('Olives',10),
('Mushroom',20),
('Onion',10),
('Green Chilies',5);

-- create table tbl_payment (
-- 	id bigint primary key auto_increment,
--     type enum('Credit/Debit card','Payment Gateways','Cash On Deliver'),
-- 	is_active tinyint(1) default 1 comment '1=Active 0= Inactive', 
-- 	is_delete tinyint(1) default 0 comment '0 = non delete 1= delete',
-- 	created_at timestamp default current_timestamp,
-- 	updated_at timestamp default current_timestamp on update current_timestamp
-- );

-- insert into tbl_payment (type) values 
-- ('credit/debit card'),
-- ('payment gateways'),
-- ('cash on delivery');

create table tbl_card_detail (
	id bigint primary key auto_increment,
    payment_id bigint,
    number text,
	name varchar(64),
    month_year date,
    zip_code varchar(16),
	is_active tinyint(1) default 1 comment '1=Active 0= Inactive', 
	is_delete tinyint(1) default 0 comment '0 = non delete 1= delete',
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key (payment_id) references tbl_payment(id)
);

INSERT INTO tbl_card_detail (payment_id, number, name, month_year, zip_code)
VALUES 
(1, '1234567890123456', 'Foram Panchal', '2024-05-01', '12345'),
(1, '9876543210987654', 'Abhi Makwana', '2023-12-01', '54321'),
(1, '4567890123456789', 'Mayur Mori', '2025-09-01', '67890'),
(1, '1111222233334444', 'Viral Prajapati', '2024-08-01', '11111'),
(1, '2222333344445555', 'Parth Patel', '2023-11-01', '22222');

create table tbl_delivery_address (
	id bigint primary key auto_increment,
    fname varchar(16),
    lname varchar(16),
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

insert into tbl_delivery_address (fname, lname, address, city, state, zip_code, mobile) values
	('foram', 'panchal', 'Vaniyawad', 'Nadiad', 'gujarat', '363987', '723523456383'),
    ('mayur', 'mori', 'halvad', 'morbi', 'gujarat', '363330', '72354746383'),
    ('abhi', 'makwana', 'kalol', 'gandhinagar', 'gujarat', '365643', '72354566383'),
    ('viral', 'Prajapati', 'ahemedabad', 'Mehsana', 'gujarat', '363453', '72987646383');  
    
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 1.login with Simple user
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
select * from tbl_user where email='foram@gmail.com' and password='foram12345' and  login_type='s' and is_active=1 and is_delete=0;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 2.login with Facebook user
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
select * from tbl_user where social_id='abhi222'and county_code='+91' and is_active=1 and is_delete=0;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 3.login with Instgram user
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
select * from tbl_user where social_id='gayu34' and county_code='+91' and is_active=1 and is_delete=0;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 4.login with tweeter user
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
select * from tbl_user where social_id='m5656' and county_code='+91' and is_active=1 and is_delete=0;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 5 forget password
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT id,email FROM tbl_user WHERE email ="foram@gmail.com" AND login_type='s' AND county_code='+91' and  is_active = 1 AND is_delete=0;
update tbl_user set password='1512' where mobile='9106603730'AND id=2 AND is_active = 1 AND is_delete=0;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 4.Search  food
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
select  * from tbl_dish where name like 's%';

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 5. get price
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
select  * from tbl_dish where price between 20 and 100;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 6. time
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
select  * from tbl_dish where time_format(min_time,'%i')<15  or time_format(max_time,'%i')>45;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 7.Best Deal
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
select  d.id,di.image,d.name,d.price,time_format(d.min_time,'%i') as min_time,time_format(d.max_time,'%i') as max_time 
from tbl_dish d 
join tbl_dish_image di 
on di.dish_id=d.id 
group by d.id 
order by d.price desc;
 
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 8. Display Category
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
 select * from tbl_category;
 
-- 9. Display Category
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
 select * from tbl_category;
 
-- 10. Display dishes
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
 select c.id,d.id,c.image,d.name,d.price,time_format(d.min_time,'%i') as min_time,time_format(d.max_time,'%i') as max_time 
 from tbl_category c 
 join tbl_dish d 
 on d.category_id=c.id 
 where c.id=4;
 
 -- 11. Display dish details
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
 select d.id,c.id,(select group_concat(di.image) 
 from tbl_dish_image di
 where di.dish_id=d.id) as Image,d.name,time_format(d.min_time,'%i') as min_time,time_format(d.max_time,'%i') as max_time,d.weight,c.name,d.chefname 
 from tbl_dish d 
 join tbl_category c 
 on c.id=d.category_id  
 having c.id=6 ;
 
 -- 12 Rewiw Details-----
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
 select d.id,c.id,(select di.image
 from tbl_dish_image di
 where di.dish_id=d.id limit 1) as Image,d.name,time_format(d.min_time,'%i') as min_time,time_format(d.max_time,'%i') as max_time,d.weight,d.unit,c.name,d.chefname,u.image,u.name,r.review 
 from tbl_dish d 
 join tbl_category c on c.id=d.category_id  
 join tbl_user u on u.id=d.id
 join tbl_dish_review r on r.dish_id=d.id
 having d.id=1;
 
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 13. Display ingrediants
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
select id,image,name,price from tbl_ingrediants;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 14. Add to cart
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
select d.id,di.image,d.name,d.price,d.unit,cd.qty from tbl_cart_details cd 
join tbl_cart c on cd.cart_id = c.id
join tbl_dish d on d.id= cd.dish_id 
join tbl_dish_image di on di.dish_id=d.id
group by c.user_id=2;


SELECT c.* , cd.* , d.name,d.price,d.description , (SELECT di.image FROM tbl_dish_image di WHERE di.id = c.id ORDER BY di.id DESC LIMIT 1) as image FROM tbl_cart c
JOIN tbl_cart_details cd ON cd.cart_id = c.id
JOIN tbl_dish d ON d.id = c.id 
WHERE cd.cart_id = 3;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 15.listing of cart with order Details 
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------

SELECT c.id as category_id,d.id as dish_id,o.id as order_id,c.user_id,d.name,o.order_no,o.order_date,o.total_qty,o.total_amount,o.delivery_charges,o.grand_total,c.totalitem,
o.payment_type
from tbl_cart c 
JOIN tbl_dish d on c.id = d.id 
JOIN tbl_order o on d.id = o.id;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 16.order Details 
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------

SELECT c.id,c.user_id,c.id,op.id,op.fname,op.lname,op.address,op.city,op.state,op.zip_code,
op.mobile from tbl_cart c join tbl_delivery_address op on c.id = op.id
HAVING c.id=1;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 17.fav dishes listing for specific user 
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------

SELECT d.id,l.id,l.user_id,d.name,d.price,time_format(d.min_time,'%i') as min_time,time_format(d.max_time,'%i') as max_time 
from tbl_dish d 
join tbl_dish_like l on d.id=l.id HAVING l.user_id=1 

