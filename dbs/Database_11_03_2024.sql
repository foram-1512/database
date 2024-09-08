create database 11_03_2024;
use 11_03_2024;

create table tbl_user(
	id BIGINT PRIMARY KEY AUTO_INCREMENT,
    social_id VARCHAR(256),
    name varchar(128),
    email varchar(128) unique,
    country_code varchar(8) default '+91',
    phone int(16),
    password text,
    image varchar(128),
    address text,
	latitude varchar(32),
    longitude varchar(32),
    role enum('User'),
    login_type ENUM('F','T','I'),
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
	is_active boolean default '1' COMMENT '1=active,0=inactive'
);

insert into tbl_user (name, phone, email, password, latitude, longitude, login_type, address) values 
	('mayur','9876543210','mayur@gmail.com','mayur123', '23.0752323','72.5231027','S','sola'),
    ('abdul','6776543210','abdul@gmail.com','abdul123','23.1008967','72.5229621','S','gota'),
    ('abhi','9123443210','abhi@gmail.com','abhi123','23.2281517','72.4609524','F','kalol'),
    ('devarsh','8796543210','devarsh@gmail.com','devarsh123','22.8050519','70.8155953','I','morbi'),
    ('foram','98213543210','foram@gmail.com','foram123','22.6958742','72.7807841','T','nadiad');



create table tbl_category(
	id BIGINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(128),
    image varchar(128),
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
	is_active boolean default '1' COMMENT '1=active,0=inactive'
);

insert into tbl_category(name) values 
('Breakfast'),
('Lunch'),
('Dinner'),
('Pizza'),
('Fruits'),
('Vegetables'),
('Protin');

CREATE TABLE tbl_dish(
	id BIGINT PRIMARY KEY AUTO_INCREMENT,
    category_id BIGINT,
    name VARCHAR(128),
    price double(8,2),
    making_time varchar(128),
    weight float(8,2),
    unit enum('gm', 'kg', 'ml', 'ltr'),
    description text,
    chef_name varchar(128),
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
	is_active boolean default '1' COMMENT '1=active,0=inactive',
    FOREIGN KEY (category_id) REFERENCES tbl_category(id)
);

select * from tbl_category;
insert into tbl_dish(category_id,name,price,unit,weight,chef_name,description) values
(1,'Sandwhich',80,'gm','100','Vrusha',' SANDWICH is two or more slices of bread or a split roll having a filling in cheese'),
(2, 'Spaghetti Carbonara', 120, 'gm', '200', 'Mario', 'Spaghetti Carbonara is a classic Italian pasta dish with creamy egg sauce, pancetta, and Parmesan cheese.'),
(3, 'Grilled Salmon', 200, 'gm', '150', 'Isabella', 'Grilled salmon is a delicious and healthy dish, seasoned with herbs and served with lemon wedges.'),
(4, 'Margherita Pizza', 150, 'gm', '300', 'Lama', 'Margherita pizza is a simple yet flavorful pizza topped with tomato sauce, mozzarella cheese, and fresh basil.'),
(5, 'Fruit Salad', 50, 'ltr', '1', 'Ella', 'Apples are crisp, juicy fruits that are commonly eaten fresh or used in various desserts and dishes.'),
(6, 'Broccoli', 40, 'gm', '150', 'Olive', 'Broccoli is a nutritious green vegetable, rich in vitamins and minerals, often steamed or stir-fried as a side dish.'),
(7, 'Peanut Butter', 500, 'gm', '500', 'Sophia', 'Peanut butter is made from ground peanuts that have been roasted.'); 

create table tbl_dish_image(
	id bigint primary key AUTO_INCREMENT,
    dish_id bigint,
    image varchar(128),
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
	is_active boolean default '1' COMMENT '1=active,0=inactive',
    FOREIGN KEY (dish_id) REFERENCES tbl_dish(id)
);

insert into tbl_dish_image (dish_id, image) values 
(1, 'sandwhich1.jpg'),
(1, 'sandwhich2.jpg'),
(1, 'sandwhich3.jpg'),
(2, 'Spaghetti 1.jpg'),
(2, 'Spaghetti 2.jpg'),
(2, 'Spaghetti 3.jpg'),
(3, 'Grilled Salmon 1.jpg'),
(3, 'Grilled Salmon 2.jpg'),
(3, 'Grilled Salmon 3.jpg'),
(4, 'Margherita 1.jpg'),
(4, 'Margherita 2.jpg'),
(4, 'Margherita 3.jpg'),
(5, 'Fruit 1.jpg'),
(5, 'Fruit 2.jpg'),
(5, 'Fruit 3.jpg'),
(6, 'Broccoli 1.jpg'),
(6, 'Broccoli 2.jpg'),
(6, 'Broccoli 3.jpg'),
(7, 'Peanut Butter 1.jpg'),
(7, 'Peanut Butter 2.jpg'),
(7, 'Peanut Butter 3.jpg')
;

create table tbl_dish_review(
	id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id bigint,
    dish_id bigint,
    review text,
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
	is_active boolean default '1' COMMENT '1=active,0=inactive',
    FOREIGN KEY (dish_id) REFERENCES tbl_dish(id),
    FOREIGN KEY (user_id) REFERENCES tbl_user(id)
);
INSERT INTO tbl_dish_review (user_id, dish_id, review)
VALUES
    (1, 1, 'Great dish, loved the flavors!'),
    (2, 2, 'The presentation was excellent, but the taste could be improved.'),
    (3, 3, 'Absolutely delicious, would highly recommend!'),
    (4, 4, 'Disappointed with the portion size, expected more.'),
    (5, 5, 'Average dish, nothing special.'),
    (1, 6, 'Fantastic dish, exceeded my expectations!'),
    (2, 7, 'Good dish, but a bit too spicy for my taste.');


create table tbl_dish_like(
	id BIGINT PRIMARY key AUTO_INCREMENT,
    user_id bigint,
    dish_id bigint,
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
	is_active boolean default '1' COMMENT '1=active,0=inactive',
    FOREIGN KEY (dish_id) REFERENCES tbl_dish(id),
    FOREIGN KEY (user_id) REFERENCES tbl_user(id)
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
	id bigint PRIMARY KEY AUTO_INCREMENT,
    user_id bigint,
    total_items int,
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
	is_active boolean default '1' COMMENT '1=active,0=inactive',
    FOREIGN KEY (user_id) REFERENCES tbl_user(id)
);


create table tbl_cart_detail (
	id BIGINT PRIMARY KEY AUTO_INCREMENT,
    dish_id bigint,
    cart_id bigint,
    quantity int DEFAULT 1,
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
	is_active boolean default '1' COMMENT '1=active,0=inactive',
    FOREIGN KEY (dish_id) REFERENCES tbl_dish(id),
    FOREIGN KEY (cart_id) REFERENCES tbl_cart(id)
);


create table  tbl_order(
	id bigint PRIMARY KEY  AUTO_INCREMENT,
    user_id BIGINT,
    delivery_id bigint,
    order_no varchar(32),
    order_date DATETIME,
    total_qty int,
    delivery_charges float(5,2),
    grand_total float(8,2),
    status enum('Pending', 'Delivered', 'Shipped', 'Cancelled'),
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
	is_active boolean default '1' COMMENT '1=active,0=inactive',
    FOREIGN KEY (user_id) REFERENCES tbl_user(id),
    FOREIGN KEY (delivery_id) REFERENCES tbl_delivery_address(id)
);

create table tbl_order_details (
	id bigint primary key auto_increment,
    dish_id bigint,
    ingrediant_id bigint,
    order_id bigint ,
    total_qty int,
    per_price float(8,2),
    total int,
	status enum ('pending', 'delivered', 'cancelled', 'shipped'),
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
	is_active boolean default '1' COMMENT '1=active,0=inactive',
    foreign key (dish_id) references tbl_dish(id),
    foreign key (order_id) references tbl_order(id),
    foreign key (ingrediant_id) references tbl_ingrediants(id)
);

create table tbl_ingrediants (
	id bigint primary key auto_increment,
    name varchar(64),
    price int,
    image varchar(128),
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
	is_active boolean default '1' COMMENT '1=active,0=inactive'
);

insert into tbl_ingrediants(name,price)
values
('Double cheese',40),
('Olives',10),
('Mushroom',20),
('Onion',10),
('Green Chilies',5);

create table tbl_payment (
	id bigint primary key auto_increment,
    type enum('credit/debit card', 'payment gateways', 'cash on delivery'),
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
	is_active boolean default '1' COMMENT '1=active,0=inactive'
    
);

insert into tbl_payment (type) values 
('credit/debit card'),
('payment gateways'),
('cash on delivery');

create table tbl_card_details(
	id bigint primary key auto_increment,
    payment_id BIGINT,
    number text,
    month_year date,
    zip_code varchar(16),
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
	is_active boolean default '1' COMMENT '1=active,0=inactive',
    foreign key (payment_id) references tbl_payment(id)
);
INSERT INTO tbl_card_details(payment_id, number, name, month_year, zip_code)
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
    mobile int,
	is_active tinyint(1) default 1 comment '1=Active 0= Inactive', 
	is_delete tinyint(1) default 0 comment '0 = non delete 1= delete',
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp
);
 

insert into tbl_delivery_address (fname, lname, address, city, state, zip_code, mobile) values
	('mayur', 'mori', 'halvad', 'halvad', 'gujarat', '363330', '72354746383'),
    ('abhi', 'makwana', 'kalol', 'kalol', 'gujarat', '365643', '72354566383'),
    ('foram', 'panchal', 'nadiad', 'nadiad', 'gujarat', '363987', '723523456383'),
    ('abdul', 'kadir', 'kalupur', 'ahemedabad', 'gujarat', '363453', '72987646383');





-- login Query

select * from tbl_user where email='abhi@gmail.com' and password='abhi123' and is_active=1 and login_type='S';

select * from tbl_user where social_id='8765' and is_active=1;


-- forgot password

select * from tbl_user
where (email='abhi@gmail.com' or phone='9123443210') and is_active=1 and login_type='S';


update tbl_user set password='abhi1234'
where (email='abhi@gmail.com' or phone='9123443210') and is_active=1;



select * from tbl_dish where name like 'sandwhich%';

select * from tbl_dish where price BETWEEN 50 and 100;



-- today's best deals

select d.*, di.image from tbl_dish d
join tbl_dish_image di on di.dish_id=d.id
GROUP BY d.id order by d.price desc limit 3;

-- show all category
select * from tbl_category;


-- category wise all product listing 
-- filter by price
select  d.* from tbl_dish d
join tbl_category c on c.id=d.category_id
where c.id=4 and price between 300 and 500
GROUP BY d.id order by price;

SELECT image from tbl_dish_image WHERE dish_id=4 GROUP BY dish_id;

-- time wise filter
select d.* from tbl_dish d
join tbl_category c on c.id=d.category_id
where c.id=4 and time_format(d.min_time, '%i')>=20 and time_format(d.max_time, '%i')<=40;


select d.*,c.name as category_name, u.id, u.name,u.image, r.review from tbl_dish d
join tbl_category c on c.id=d.category_id
join tbl_dish_review r on r.dish_id=d.id
join tbl_user u on r.user_id=u.id
 where d.id=4;

-- displaying ingrediants
select * from tbl_ingrediants;


-- displaying cart
select d.*, cd.quantity, (d.price*cd.quantity) as total_price from tbl_cart_detail cd
join tbl_dish d on d.id=cd.dish_id
join tbl_cart c on c.id=cd.cart_id
where c.user_id=3 and c.is_active=1;




select * from tbl_order;
select id,order_no, user_id, total_amount, delivery_charges, ((total_amount*total_qty)+delivery_charges) as grand_total from tbl_order where user_id=1;

select cd.* from tbl_card_details cd join tbl_order o on o.id=cd.order_id where o.user_id=3;

-- favourite dish 
select d.* from tbl_dish_like dl join tbl_dish d on d.id=dl.dish_id join tbl_user u on u.id=dl.user_id where u.id=1;


-- like query
SELECT *,IFNULL((SELECT(CASE WHEN l.dish_id !='' THEN 1 ELSE 0 END) from tbl_dish_like l where l.dish_id=d.id AND l.user_id=1),0) as is_like FROM tbl_dish d;



SELECT * from tbl_ingrediants;