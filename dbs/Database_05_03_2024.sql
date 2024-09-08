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
	('mayur','9876543210','mayur@gmail.com','mayur123','23.0752323','72.5231027','user','sola'),
    ('abdul','6776543210','abdul@gmail.com','abdul123','23.1008967','72.5229621','vendor','gota'),
    ('abhi','9123443210','abhi@gmail.com','abhi123','23.2281517','72.4609524','user','kalol'),
    ('devarsh','8796543210','devarsh@gmail.com','devarsh123','22.8050519','70.8155953','vendor','morbi'),
    ('foram','98213543210','foram@gmail.com','foram123','22.6958742','72.7807841','user','nadiad');
    
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
	(2, 2, 'Walmart', 'Grocery and Shopping', 'Sarkhej - Gandhinagar Hwy, Thaltej, Ahmedabad, Gujarat 380054', '+91 9876543210', 'walmart@gmail.com', 'Thaltej', '23.0546803', '72.5202359'),
    (1, 4, 'D-Mart', 'Household', 'near Block-I,Samarpan Residency, Pratap Pura Village, Kalol, Gujarat 382721', '+91 9172543340', 'dmart@gmail.com', 'Kalol', '23.2499588', '72.4823743'),
    (4, 2, 'Apollo Pharmacy', 'Pharmacy', '19, Shayona Silver Estate, near Silver Oak College, Gota, Ahmedabad, Gujarat 382481', '+91 9846527235', 'apollo@gmail.com', 'Gota', '23.0828815', '72.5107924'),
    (3, 4, 'Royaloak Furniture', 'Furniture', 'Rangat Signature, Near Gota Bridge, Sarkhej - Gandhinagar Hwy, opp. Rangat Green Memories, Gota, Ahmedabad, Gujarat 380081', '+91 924657235', 'royaloak@gmail.com', 'Gota', '23.1060626', '72.528525'),
    (2, 2, 'Dominos Pizza', 'Grocery', 'G-2 , GROUND FLOOR, Astron Tech Park, opp. FUN REPUBLIC COMPLEX, near ISKO, Satellite, Ahmedabad, Gujarat 380054', '+91 98765567', 'dominos@gmail.com', 'Iskon', '23.0277458', '72.4860224');
    
    
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
update tbl_user set password='abhi1442' where (phone_number='9123443210' or email='abhi@gmail.com') and is_active=1;

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





