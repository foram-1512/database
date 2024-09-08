create database redeemo;
use redeemo;
drop database redeemo;

create table tbl_user (
	id bigint primary key auto_increment,
    social_id bigint,
    fname varchar(32),
    lname varchar(32),
    profile_image varchar(64),
    country_code varchar(8) default '+91',
    mobile bigint unique,
    email varchar(32) unique,
    password varchar(64),
    date_of_birth date,
    gender enum('male', 'female'),
    address text,
    interests varchar(32),
    latitude varchar(64),
    longitude varchar(64),
    role enum('user', 'owner'),
	login_type enum('S', 'I', 'F') default 's' comment 's-simple, f-facebook, i-instagram',
    otp_code int(8) default'0',
    otp_verification boolean default '0' comment '0=Unverified 1=Verified',
    is_active boolean default '1' COMMENT '1=active,0=deactive',
    is_delete boolean default '0' comment '1=delete 0=not_delete',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp
);


insert into tbl_user (fname, lname, profile_image, mobile, email, password, date_of_birth, gender, address, latitude, longitude, role ) values
	('abhi', 'makwana', 'ab.jpg', '9087654321', 'abhi@gmail.com', 'abhi123', '2002-04-14', 'male', 'kalol' , '23.2281517', '72.4609524', 'user'),
	('foram', 'panchal', 'fp.jpg', '9345654321', 'foram@gmail.com', 'foram123', '2001-01-14', 'female', 'nadiad' , '22.6958742', '72.7807841', 'owner'),
	('gayatri', 'patil', 'gn.jpg', '9098764321', 'gayu@gmail.com', 'gayu123', '2003-01-01', 'female', 'sola' , '23.0752323', '72.5231027', 'owner'),
    ('devarsh', 'panchal', 'dv.jpg', '7387654321', 'devarsh@gmail.com', 'devarsh123', '2002-07-29', 'male', 'gota' , '23.1008967', '70.8155953', 'user'),
    ('mayur', 'mori', 'ma.jpg', '9387654321', 'mayur@gmail.com', 'mayur123', '2002-06-16', 'male', 'morbi' , '22.8050519', '70.8155953', 'user');
    


create table tbl_intrests (
	id bigint primary key auto_increment,
    intrests varchar(64),
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp
);

insert into tbl_intrests (intrests) values 
('Archery'),
('Theatre'),
('travelling'),
('Video Games'),
('Sports'),
('Reading'),
('Photography'),
('Painting'),
('Events'),
('Dancing'),
('Camping'),
('Technology'),
('Art'),
('Fitness Club'),
('Restaurants'),
('Volunteer Work'),
('Club or Social'),
('Roller skating'),
('Leisure Clubs');


create table tbl_category (
	id bigint primary key auto_increment,
    image text,
    name varchar(64), 
	is_active boolean default '1' COMMENT '1=active,0=deactive',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp
    
);
insert into tbl_category (name, image) values 
('Restaurants', 'restaurant.jpg'),
('Staycations', 'staycations.jpg'),
('Fitness & health', 'Fitness & health.jpg'),
('Spa', 'spa.jpg'),
('Salons', 'spSalons.jpg'),
('Leisure clubs', 'Leisure clubs.jpg');


create table tbl_merchants (
	id bigint primary key auto_increment,
    category_id bigint,
    name varchar(64),
	country_code varchar(8) default '+91',
    mobile bigint unique,
    email varchar(32) unique,
	avg_rating float(5,1) default '0',
    about text,
	address text,
    latitude varchar(64),
    longitude varchar(64),
    is_active boolean default '1' COMMENT '1=active,0=deactive',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key (category_id) references tbl_category(id)
);

INSERT INTO tbl_merchants (category_id, name, email, mobile, address, latitude, longitude, about)
VALUES 
    (1, 'Punjabiyat by Jassi De Parathe', 'jassideparathe@gmail.com',9687271313, 'FF - 9,10, Time Square - II, Near Avlon Hotel, Sindhubhavan Rd, Thaltej,', '23.0447531', '72.506916','Lorem ipsum is placeholder text commonly used in the graphic'),
    (1, 'Bayleaf', 'bayleaf@gmail.com', 7966185000, 'Courtyard by Marriott, Ramdevnagar Crossroad, Satellite Road', '23.0276755', '72.5122376', 'Lorem ipsum is placeholder text commonly used in the graphic'),
    (2, 'Radhe Upavan Resort', 'radhei@gmail.com',9925136262, 'Jashoda Mehmdabad Highway, Hathijan', '22.9353984', '72.6785586', 'Lorem ipsum is placeholder text commonly used in the graphic'),
    (2, 'The House of MG', 'mg@gmail.com', 7925506946, 'Bhadra Rd, Opp. Sidi, Old City, Gheekanta, Lal Darwaja', '23.0273756', '72.5816205','Lorem ipsum is placeholder text commonly used in the graphic'),
    (3, 'Prime Health Club & Gym', 'prime@gmail.com', 9173860233, 'Kalindi Park, KK Nagar Rd, near patidar chowk, Ghatlodiya', '23.0720312', '72.5505724', 'Lorem ipsum is placeholder text commonly used in the graphic'),
    (3, 'Anytime Fitness', 'anytime@gmail.com', 9725333222, 'Iskcon Circle, No 216 & 219, 2nd Floor, Shivalik Shilp Bhopal, Ambli Rd', '23.0272255', '72.5067256', 'Lorem ipsum is placeholder text commonly used in the graphic'),
    (4, 'A9 Spa ', 'a9spa@gmail.com', 7071808120, '1st floor , Wide angle multiplex,iscon cross road', '23.0244486', '72.5069469', 'Lorem ipsum is placeholder text commonly used in the graphic'),
    (4, 'Prakrutik spa', 'prakruti@gmail.com', 9313330602, '124 Landmark Complex, First Floor Anandnagar, prahladnagar', '23.0129318', '72.5221689','Lorem ipsum is placeholder text commonly used in the graphic'),
    (5, 'Enrich Salon', 'enrich@gmail.com', 9099473000, 'Ground Floor, Krishna Complex, A/3-4 & 5-6, Satellite road', '23.0321907', '72.5109125', 'Lorem ipsum is placeholder text commonly used in the graphic'),
    (5, 'HAIRTRIX Lorial SALON', 'hairtrixi@gmail.com', 9824099175, 'Shop no.4 and 5, oppsite NATIONAL HANDLOOM', '23.0281829', '72.5592308','Lorem ipsum is placeholder text commonly used in the graphic'),
    (6, 'Bounce Up ', 'bounceup@gmail.com', 9033503604, 'Opp Skydeck Select, Ambli Bopal Road', '23.0266754', '72.4885387','Lorem ipsum is placeholder text commonly used in the graphic'),
    (6, 'Iceberg SnowWorld', 'iceberg@gmail.com',7940091310, 'Dev Arc Mall, Devarc Mall, B-101-3, Sarkhej - Gandhinagar Hwy', '23.025795', '72.5076339', 'Lorem ipsum is placeholder text commonly used in the graphic');

create table tbl_merchant_image (
	id bigint primary key auto_increment,
    merchant_id bigint,
    image text,
	is_active boolean default '1' COMMENT '1=active,0=deactive',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key (merchant_id) references tbl_merchants(id)
);
insert into tbl_merchant_image (merchant_id, image) values
(1, 'punjabiyat1.jpg'),
(1, 'punjabiyat2.jpg'),
(2, 'bayleaf1.jpg'),
(2, 'bayleaf2.jpg'),
(3, 'radheupvan1.jpg'),
(3, 'radheupvan2.jpg'),
(4, 'the house of mg1.jpg'),
(4, 'the house of mg2.jpg'),
(5, 'prime health club gym1.jpg'),
(5, 'prime health club gym2.jpg'),
(6, 'Anytime fitness1.jpg'),
(6, 'Anytime fitness2.jpg'),
(7, 'A9 spa1.jpg'),
(7, 'A9 spa2.jpg'),
(8, 'prakruti spa2.jpg'),
(8, 'prakruti spa2.jpg'),
(9, 'Enrich salon1.jpg'),
(9, 'Enrich salon2.jpg'),
(10, 'Hairtrix salon1.jpg'),
(10, 'Hairtrix salon2.jpg'),
(11, 'Bounce up1.jpg'),
(11, 'Bounce up2.jpg'),
(12, 'Iceberg1.jpg'),
(12, 'Iceberg2.jpg');


create table tbl_merchant_review_rating (
	id bigint primary key auto_increment,
    user_id bigint,
    merchant_id bigint,
    rating float(5,1),
    review text,
    is_active boolean default '1' COMMENT '1=active,0=deactive',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key (merchant_id) references tbl_merchants(id),
    foreign key (user_id) references tbl_user(id)
);

insert into tbl_merchant_review_rating (user_id, merchant_id, rating, review) values
(1, 1, 4.2, 'Lorem ipsum'),
(1, 2, 3.5, 'Lorem ipsum'),
(1, 4, 4.1, 'Lorem ipsum'),
(2, 8, 3.1, 'Lorem ipsum'),
(2, 10, 4.1, 'Lorem ipsum'),
(2, 3, 3.3, 'Lorem ipsum'),
(3, 3, 4.1, 'Lorem ipsum'),
(4, 1, 4.3, 'Lorem ipsum'),
(3, 5, 4.3, 'Lorem ipsum'),
(4, 5, 2.3, 'Lorem ipsum'),
(5, 1, 1.3, 'Lorem ipsum'),
(5, 6, 4.3, 'Lorem ipsum'),
(5, 9, 4.2, 'Lorem ipsum'),
(1, 10, 4.1, 'Lorem ipsum'),
(2, 12, 5, 'Lorem ipsum'),
(1, 3, 5, 'Lorem ipsum'),
(2, 5, 4.4, 'Lorem ipsum'),
(3, 1, 5, 'Lorem ipsum'),
(4, 11, 5, 'Lorem ipsum'),
(2, 8, 3.3, 'Lorem ipsum'),
(2, 7, 2.3, 'Lorem ipsum'),
(3, 7, 5, 'Lorem ipsum'),
(3, 9, 3.3, 'Lorem ipsum');


create table tbl_merchant_like (
	id bigint primary key auto_increment,
    user_id bigint,
    merchant_id bigint,
     is_active boolean default '1' COMMENT '1=active,0=deactive',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key (merchant_id) references tbl_merchants(id),
    foreign key (user_id) references tbl_user(id)
);
insert into tbl_merchant_like (user_id, merchant_id) values
	(1, 3),
    (1, 2),
    (1, 5),
    (1, 6),
    (2, 3),
    (2, 10),
    (2, 5),
    (2, 2),
    (3, 3),
    (3, 4),
    (3, 10),
    (4, 12),
    (4, 1),
    (4, 3),
    (4, 6),
    (5, 3),
    (5, 11),
    (5, 10);



create table tbl_amenities (
	id bigint primary key auto_increment,
    image text,
    name varchar(128),
    is_active boolean default '1' COMMENT '1=active,0=deactive',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp
);

INSERT INTO tbl_amenities (image,name) VALUES
('parking.jpg','Parking'),
('wifi.jpg','Free Wifi'),
('pool.jpg','Pool'),
('Accessories.jpg','Exercise fecilities and Accessories'),
('salon.jpg','Salon'),
('Bathrobes.jpg','Fancy Bathrobes'),
('Bedding.jpg','Premium Bedding'),
('Fridge.jpg','Mini-Fridge');


-- create combination table of amenities and merchant


create table tbl_merchant_amenities (
	id bigint primary key auto_increment,
    merchant_id bigint,
	amenities_id bigint,
     is_active boolean default '1' COMMENT '1=active,0=deactive',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key (merchant_id) references tbl_merchants(id),
    foreign key (amenities_id) references tbl_amenities(id)  
);
INSERT INTO tbl_merchant_amenities (merchant_id, amenities_id) VALUES
(1, 1),
(1, 2),
(2, 3),
(2, 4),
(3, 5),
(3, 6),
(4, 7),
(4, 8),
(5, 1),
(5, 2),
(6, 3),
(6, 4),
(7, 5),
(7, 6),
(8, 7),
(8, 8),
(9, 1),
(9, 2),
(10, 3),
(10, 4),
(11, 5),
(11, 6),
(12, 7),
(12, 8);


create table tbl_banner (
	id bigint primary key AUTO_INCREMENT,
    merchant_id bigint,
    image text,
    is_active boolean default '1' COMMENT '1=active,0=deactive',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key (merchant_id) references tbl_merchants(id)
);
INSERT INTO tbl_banner (merchant_id, image) VALUES
(1, 'image1.jpg'),
(1, 'image2.jpg'),
(2, 'image3.jpg'),
(2, 'image4.jpg'),
(3, 'image5.jpg'),
(3, 'image6.jpg'),
(4, 'image7.jpg'),
(4, 'image8.jpg'),
(5, 'image9.jpg'),
(5, 'image10.jpg'),
(6, 'image11.jpg'),
(6, 'image12.jpg'),
(7, 'image13.jpg'),
(7, 'image14.jpg'),
(8, 'image15.jpg'),
(8, 'image16.jpg'),
(9, 'image17.jpg'),
(9, 'image18.jpg'),
(10, 'image19.jpg'),
(10, 'image20.jpg'),
(11, 'image21.jpg'),
(11, 'image22.jpg'),
(12, 'image23.jpg'),
(12, 'image24.jpg');

create table tbl_vouchers (
	id bigint primary key auto_increment,
    merchant_id bigint,
    image text,
    title varchar(64),
    description text,
    code varchar(16) unique,
    expiry_date date,
    is_active boolean default '1' COMMENT '1=active,0=deactive',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key (merchant_id) references tbl_merchants(id)
);
-- Insert sample voucher data into tbl_vouchers for merchants up to ID 12
INSERT INTO tbl_vouchers (merchant_id, image, title, description, code, expiry_date)
VALUES
    (1, 'voucher_image_1.jpg', '50% off on Punjabiyat Specials', 'Enjoy 50% off on Punjabiyat Special dishes', 'PUNJAB50', '2024-04-30'),
    (2, 'voucher_image_2.jpg', 'Free Dessert on Every Meal', 'Get a free dessert with every meal at Punjabiyat by Jassi De Parathe', 'DESSERTFREE', '2024-05-15'),
    (3, 'voucher_image_3.jpg', '25% off on Indian Cuisine', 'Avail 25% discount on Indian delicacies at Bayleaf', 'BAYLEAF25', '2024-06-01'),
    (4, 'voucher_image_4.jpg', 'Complimentary Drink', 'Receive a complimentary drink with your meal at Bayleaf', 'COMPDRIINK', '2024-07-10'),
    (5, 'voucher_image_5.jpg', 'Weekend Stay Package', 'Book a weekend stay and get exclusive offers at Radhe Upavan Resort', 'WEEKENDGET', '2024-08-20'),
    (6, 'voucher_image_6.jpg', 'Spa Discount', 'Enjoy a special discount on spa treatments at The House of MG', 'SPADISCOUNT', '2024-09-01'),
    (7, 'voucher_image_7.jpg', 'Health Club Membership Offer', 'Get a discount on membership at Prime Health Club & Gym', 'MEMBERDISC', '2024-09-15'),
    (8, 'voucher_image_8.jpg', 'Fitness Training Session', 'Receive a free fitness training session at Anytime Fitness', 'FITTRAIN', '2024-10-01'),
    (9, 'voucher_image_9.jpg', 'Spa Treatment Discount', 'Avail discount on spa treatments at A9 Spa', 'SPA25OFF', '2024-10-15'),
    (10, 'voucher_image_10.jpg', 'Massage Session', 'Get a free massage session at Prakrutik Spa', 'MASSAGEFREE', '2024-11-01'),
    (11, 'voucher_image_11.jpg', 'Salon Discount', 'Enjoy a discount on salon services at Enrich Salon', 'SALONDISC', '2024-11-15'),
    (12, 'voucher_image_12.jpg', 'Haircut Offer', 'Get a haircut at discounted rates at HAIRTRIX Lorial SALON', 'HAIRCUT50', '2024-12-01');


create table tbl_voucher_like(
	id bigint primary key auto_increment,
    user_id bigint,
    voucher_id bigint,
	is_active boolean default '1' COMMENT '1=active,0=deactive',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key (voucher_id) references tbl_vouchers(id),
    foreign key (user_id) references tbl_user(id)
);


insert into tbl_voucher_like (user_id, voucher_id) values
	(1, 1),
    (1, 3),
    (1, 2),
    (1, 3),
    (2, 1),
    (2, 3),
    (2, 4),
    (2, 5),
    (3, 2),
    (3, 4),
    (3, 1),
    (4, 5),
    (4, 1),
    (4, 2),
    (4, 3),
    (5, 5),
    (5, 4),
    (5, 12),
    (5, 11),
    (1, 10),
    (1, 11),
    (3, 7),
    (3, 8),
    (3, 9),
    (4, 5),
    (5, 5),
    (5, 3),
    (5, 4),
    (2, 12),
    (2, 11),
    (2, 10),
    (5, 2);



-- searching
SELECT m.* from tbl_category c 
join tbl_merchants m on c.id=m.category_id
join tbl_merchant_amenities  ma on m.id=ma.merchant_id
join tbl_amenities a on a.id=ma.amenities_id group by m.id;
-- where c.name like "" or m.name like "" or a.name like "%parking%" ;


-- merchant name with voucher

select m.*,v.title from tbl_merchants m
join tbl_vouchers v on v.merchant_id=m.id
 where m.id=1;
 
 
 select a.name from tbl_merchant_amenities ma
 join tbl_amenities a on ma.amenities_id=a.id
 where merchant_id=1;
 
 
 select u.id,u.fname,u.profile_image,r.* from tbl_merchant_review_rating r 
 join tbl_user u on u.id=r.user_id where r.merchant_id=1;
 
 
 select v.* from tbl_voucher_like vl join tbl_vouchers v on vl.voucher_id=v.id where vl.user_id=1;
 
 SELECT m.*, ROUND(
      (6371 * acos( cos( radians(u.latitude) ) 
      * cos( radians (m.latitude) )
      * cos( radians (m.longitude) - radians(u.longitude))
      + sin( radians(u.latitude))
      * sin( radians (m.latitude) ) ) ), 1) as distance_in_killometers,a.name as amenities from tbl_category c 
        join tbl_merchants m on c.id=m.category_id
        join tbl_merchant_amenities  ma on m.id=ma.merchant_id
        join tbl_user u on u.id= 1
        join tbl_amenities a on a.id=ma.amenities_id
        order by avg_rating desc;
        -- GROUP BY m.id;