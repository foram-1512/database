create database deals_on_demand;
use deals_on_demand;
create table tbl_user (
	id bigint primary key auto_increment,
    fname varchar(32),
    lname varchar(32),
    username varchar(32),
    profile_image varchar(64),
    country_code varchar(8) default '+91',
    mobile bigint unique,
    email varchar(32) unique,
    password varchar(64),
    bio text,
    referral_code varchar(16) unique,
    address text,
    latitude varchar(64),
    longitude varchar(64),
    role enum('user', 'owner'),
    is_primieum boolean default '0' comment '0-primieum user, 1-simple user',
    is_active boolean default '1' COMMENT '1=active,0=deactive',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp
	

);

insert into tbl_user (fname, lname, username, profile_image, mobile, email, password, bio, referral_code, address, latitude, longitude, role ) values
    ('abhi', 'makwana', 'abhi-123', 'abhi.jpg', 9565432109, 'abhi@gmail.com', 'mayur123', 'my name is abhi.', 'YEND563HD', 'kalol', '23.2281517', '72.4609524',  'owner'),
    ('mayur', 'mori', 'mayur-123', 'mayur.jpg', 8765432109, 'mayur@gmail.com', 'mayur123', 'my name is mayur.', 'YSG5373H', 'morbi', '22.8050519', '70.8155953',  'user'),
    ('foram', 'panchal', 'foram-123', 'foram.jpg', 7890432109, 'foram@gmail.com', 'foram123', 'my name is foram.', 'TDUDB536', 'nadiad', '72.7807841', '70.8155953',  'Owner'),
    ('gayatri', 'patil', 'gayu-123', 'gayu.jpg', 7805432109, 'gayu@gmail.com', 'gayu123', 'my name is gayu.', 'TEYB1342T', 'ahemedabad', '23.1008967', '72.5229621',  'User');
    

   
create table tbl_category (
	id bigint primary key auto_increment,
    name varchar(64),
    image varchar(32),
	is_active boolean default '1' COMMENT '1=active,0=deactive',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp

);

insert into tbl_category (name, image) values
	('footware', 'ft.jpg'),
    ('clothing', 'cl.jpg'),
    ('kids', 'kids.jpg'),
    ('food', 'fd.jpg'),
    ('drinks', 'dk.jpg'),
    ('beauty', 'bt.jpg'),
    ('electronics', 'electronics.jpg');




create table tbl_deal (
	id bigint primary key auto_increment,
    category_id bigint,
    owner_id bigint,
    name varchar(256),
    image varchar(32),
    link varchar(128),
    deal_date date,
    description text,
    avg_rating float(5,1) default '0',
    is_active boolean default '1' COMMENT '1=active,0=deactive',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key(category_id)references tbl_category(id),
    foreign key(owner_id)references tbl_user(id)
);

insert into tbl_deal (category_id, owner_id, name , image, link, deal_date, description) values 
	(1, 1, 'Buy one get 1 free', 'footware.jpg', 'https://www.ajio.com/s/footwear-4792-56591', '2024-03-11', 'Lorem ipsum dolor sit amet consectetur, adipisicing elit'),
	(2, 1, '50% off on shopping of more than 6000', 'mens_cloth.jpg', 'https://www.ajio.com/s/clothing-4461-74581', '2024-03-21', 'Lorem ipsum dolor sit amet consectetur, adipisicing elit'),
	(3, 1, '10% discount on shopping of more than 3000', 'kids_cloth.jpg', 'https://www.ajio.com/shop/kids', '2024-03-17', 'Lorem ipsum dolor sit amet consectetur, adipisicing elit'),
	(4, 1, '15% discount on shopping of more than 3000', 'kids_cloth.jpg', 'https://www.ajio.com/shop/kids', '2024-03-17', 'Lorem ipsum dolor sit amet consectetur, adipisicing elit'),
	(5, 3, 'Buy two get one free', 'street-food.jpg', 'https://www.zomato.com/ahmedabad/ks-charcoal-bodakdev', '2024-03-23', 'Lorem ipsum dolor sit amet consectetur, adipisicing elit'),
	(6, 3, '30% off on any Beverages ', 'drinks.jpg', 'https://snackzack.com/collections/home-delivery-beverages-online-in-gujarat/red-bull', '2024-03-10', 'Lorem ipsum dolor sit amet consectetur, adipisicing elit'),
	(7, 5, 'flat 4500 of on laptop over 50000', 'laptop.jpg', 'https://www.amazon.in/gp/browse.html?node=1375424031&ref_=nav_em_sbc_mobcomp_laptops_0_2_8_15', '2024-03-29', 'Lorem ipsum dolor sit amet consectetur, adipisicing elit')
    ;




create table tbl_hashtag (
	id bigint primary key auto_increment,
    deal_id BIGINT,
    name varchar(32),
    is_active boolean default '1' COMMENT '1=active,0=deactive',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key(deal_id)references tbl_deal(id)
);

-- insert into tbl_hashtag (name) values
-- 	(1, '#design'),
--     ('#fashion'),
--     ('#women'),
--     ('#womenfashion'),
--     ('#trend'),
--     ('#newpost'),
--     ('#men'),
--     ('#electronics');





create table tbl_deal_rating (
	id bigint primary key auto_increment,
    user_id bigint,
    deal_id bigint,
    rating float(5,1),
    is_active boolean default '1' COMMENT '1=active,0=deactive',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key(deal_id)references tbl_deal(id),
    foreign key(user_id)references tbl_user(id)
);

insert into tbl_deal_rating (user_id, deal_id, rating) values 
(2,1,4.5),
(4,1,4),
(6,1,3.5),
(2,2,5),
(4,2,4),
(6,2,5),
(2,3,4),
(4,3,3),
(6,3,3.4),
(2,4,5),
(4,4,3.2),
(6,4,3.1),
(2,5,4),
(4,5,2.5),
(6,5,5),
(2,6,4),
(4,6,2.5),
(6,6,5),
(2,7,4),
(4,7,4.5),
(6,6,4)
;
TRUNCATE table tbl_deal_rating;


create  table tbl_deal_comment (
	id bigint primary key auto_increment,
    deal_id bigint,
    user_id bigint,
    comments text,
	is_active boolean default '1' COMMENT '1=active,0=deactive',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key(deal_id)references tbl_deal(id),
    foreign key(user_id)references tbl_user(id)
);


create table tbl_report_deal (
	id bigint primary key auto_increment,
    user_id bigint,
    deal_id bigint,
	reports enum ('It\'s spam', 'It\'s inappropriate', 'Other'),
    description text,
    is_active boolean default '1' COMMENT '1=active,0=deactive',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key(deal_id)references tbl_deal(id),
    foreign key(user_id)references tbl_user(id)
);


create table tbl_follow_user (
	id bigint primary key auto_increment,
    user_id bigint,
    follow_id bigint,
    is_active boolean default '1' COMMENT '1=active,0=deactive',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key(follow_id)references tbl_user(id),
    foreign key(user_id)references tbl_user(id)
);

create table tbl_post (
	id bigint primary key auto_increment,
    user_id bigint,
    image varchar(64),
    title varchar(32),
    description text,
    tag_id bigint,
    location text,
    latitude varchar(32),
    longitude varchar(32),
    url_website varchar(32),
    business_id bigint,
    is_active boolean default '1' COMMENT '1=active,0=deactive',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key(tag_id)references tbl_hashtags(id),
    foreign key(user_id)references tbl_user(id)
);


create table tbl_looking_for (
	id bigint primary key auto_increment,
    user_id bigint,
    category_id bigint,
    title varchar(32),
    description text,
    address text,
    total_comments int default '0',
    is_active boolean default '1' COMMENT '1=active,0=deactive',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key(user_id)references tbl_user(id),
    foreign key(category_id)references tbl_category(id)
);
drop table tbl_looking_for;


create table tbl_looking_comments (
	id bigint primary key auto_increment,
    user_id bigint,
    looking_for_id bigint,
    comments text,
	is_active boolean default '1' COMMENT '1=active,0=deactive',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key(looking_for_id)references tbl_looking_for(id),
    foreign key(user_id)references tbl_user(id)
);


create table tbl_business (
	id bigint primary key auto_increment,
	category_id bigint,
    owner_id bigint,
    logo varchar(32),
    name varchar(32),
	is_active boolean default '1' COMMENT '1=active,0=deactive',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key(category_id)references tbl_category(id),
    foreign key(owner_id)references tbl_user(id)
);

insert into tbl_business (category_id, owner_id, logo, name) values
	(1, 1, 'bsf.jpg', 'Blue Star Fashion'),
    (2, 3, 'rsf.jpg', 'Red Star Fashion'),
    (3, 5, 'ysf.jpg', 'Yellow Star Fashion'),
    (4, 1, 'fsf.jpg', 'Five Star Fashion');


create table tbl_bookmark (
	id bigint primary key auto_increment,
    deal_id bigint,
    user_id bigint,
    is_active boolean default '1' COMMENT '1=active,0=deactive',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key(deal_id)references tbl_deal(id),
    foreign key(user_id)references tbl_user(id)
);

insert into tbl_bookmark (deal_id, user_id) values
	(1, 6),
	(2, 5),
	(3, 3),
	(4, 1),
	(5, 6),
	(6, 1),
	(7, 1);



create table tbl_notification (
	id bigint primary key auto_increment,
    user_id bigint,
    title varchar(128),
    description text, 
    is_read TINYINT(1) DEFAULT 0,
	is_active boolean default '1' COMMENT '1=active,0=deactive',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key(user_id)references tbl_user(id)
);
TRUNCATE table tbl_notification;
insert into tbl_notification (user_id, title, description) values
	(1, 'Lorem, ipsum dolor.', 'Lorem ipsum dolor sit amet consectetur  elit. Eveniet!'),
    (3, 'ipsum dolor.', 'Lorem ipsum dolor sit amet  adipisicing elit. Eveniet!'),
    (5, 'Lorem dolor.', ' ipsum dolor sit amet consectetur adipisicing elit. !'),
    (6, 'dolor.', ' ipsum dolor sit  consectetur adipisicing elit. Eveniet!');
    
    
    
    
    

-- login query :-----------------------------
select * from tbl_user where username='abhi-123' and password='abhi123' and is_active=1;


-- forgot password :---------------------------
select * from tbl_user where email='abhi@gmail.com' or username='abhi@gmail.com' and is_active=1;
update tbl_user set password='abhi789' where id=2 and is_active=1;


-- sign up page :-----------------------
insert into tbl_user set fname='Harry', lname='Shukla' ,username='harry-123', mobile='95625345890', email='harry@gmail.com', 
			password='harry123', referral_code='HDFG521SW' , profile_image='chirag.jpg', bio='hello all my name is harry and i am from kalol.';
            


select * from tbl_user where id=1;
select * from tbl_category;
select * from tbl_deal;       



-- show particular deals and  owner details of this deal
select d.*, u.id, u.fname, u.lname, u.created_at, group_concat(h.name) as hashtag ,
	(select count(id) from tbl_deal_comment) as total_comments 
	from tbl_deal d 
    join tbl_user u on d.owner_id=u.id 
	join tbl_hashtag h on h.deal_id=d.id
    where d.id=7;
    
    
-- category wise deals count :=19
select c.id, c.image, c.name, (select count(id) from tbl_deal d where d.category_id=c.id) as total_deals 
	from tbl_category c 
	join tbl_deal d on d.category_id=c.id group by d.category_id;
    
    
-- show particular category inside the deals := 21
select  u.fname as owner_name, u.profile_image as owner_image, d.* ,
	(select count(id) from tbl_deal_comment dc where dc.deal_id=d.id) as total_comment
	from tbl_deal d 
	join tbl_category c on d.category_id=c.id 
	join tbl_user u on d.owner_id=u.id
    where c.id=3;


-- particular deal comments := 22
select d.*,  dc.id, group_concat(dc.comments)as deal_comment from tbl_deal d join tbl_deal_comment dc on dc.deal_id=d.id where d.id=2;
    

-- notification := 24
select * from tbl_notification where user_id=1;


-- report deal :=25
select * from tbl_report_deal;


-- profile 
select u.* , d.image as deal_images, b.id as business_id, b.name as business_name,
	(select count(id) from tbl_follow_user where follow_id=3) as following ,
    (select count(id) from tbl_follow_user where user_id=3) as followers
	from tbl_user u 
	join tbl_deal d on d.owner_id=u.id 
    join tbl_business b on b.owner_id=u.id
	where u.id=3
    group by u.id;
    
    
    
-- people looking for deals
select lf.*, c.name , (select count(id) from tbl_looking_comments lc where lc.looking_for_id=lf.id) as total_comments
	from tbl_looking_for lf 
	join tbl_category c on lf.category_id=c.id;
    
    
-- show particular looking for deals := 36
select lf.*, c.name ,(select count(id) from tbl_looking_comments lc where lc.looking_for_id=lf.id) as total_comments
	from tbl_looking_for lf 
		join tbl_category c on lf.category_id=c.id where lf.id=1;
        
        
-- looking for deals comments := 38
select lf.id as deal_id, lf.title, lc.id as comment_id, lc.comments, lc.created_at, u.id as user_id, u.profile_image, u.fname, u.address, u.latitude, u.longitude 
	from tbl_looking_comments lc 
	join tbl_looking_for lf on lf.id=lc.looking_for_id
    join tbl_user u on u.id=lc.user_id
    where lf.id=1;
    

-- filtering KM and show particular category's deals := 39
select d.*, c.id, c.image, c.name,
	 (6371 * acos( cos( radians(u.latitude) ) 
		* cos( radians (p.latitude) )
        * cos( radians (p.longitude) - radians(u.longitude))
        + sin( radians(u.latitude))
        * sin( radians (p.latitude) ) ) ) as distance_in_killometers
	from tbl_user u 
	join tbl_deal d on d.owner_id=u.id
    join tbl_category c on c.id=d.category_id
    where d.category_id=1 or d.category_id=4
    having distance_in_killometers between 10 and 60; 
    
    
-- edit profile := 43 
select * from tbl_user where id =2;
update tbl_user set bio='hello all i am from kalol.', mobile=987678906 where id=2;
    
    
-- edit business info := 47
select * from tbl_business where id=2;
update tbl_business set name='Red Star Business' where id=2;

    
-- bookmark(saved) deals :=49
select u.id as user_id, u.profile_image, u.fname, d.* ,
	(select count(id) from tbl_deal_comment dc where dc.deal_id=b.deal_id) as total_comment
	from tbl_bookmark b 
	join tbl_user u on b.user_id=u.id 
    join tbl_deal d on d.id=b.deal_id
	where u.id=1;
    


-- list out following := 54
select u.id, u.profile_image, u.fname
	from tbl_follow_user fu 
	join tbl_user u on fu.user_id=u.id 
	where fu.follow_id=1;


-- list out followers := 53
select u.id, u.profile_image, u.fname 
	from tbl_follow_user fu 
	join tbl_user u on fu.follow_id=u.id 
    where fu.user_id=1;
