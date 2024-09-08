create database db_usershop;
use db_usershop;
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
	('mayur', 'mori', 'mayur-123', 'mayur.jpg', 8765432109, 'mayur@gmail.com', 'mayur123', 'my name is mayur.', 'YSG5373H', 'morbi', '22.8050519', '70.8155953',  'user'),
    ('abhi', 'makwana', 'abhi-123', 'abhi.jpg', 9565432109, 'abhi@gmail.com', 'abhi123', 'my name is abhi.', 'YEND563HD', 'kalol', '23.2281517', '72.4609524',  'owner'),
    ('foram', 'panchal', 'foram-123', 'foram.jpg', 7890432109, 'foram@gmail.com', 'foram123', 'my name is foram.', 'TDUDB536', 'nadiad', '72.7807841', '70.8155953',  'user'),
    ('gayatri', 'patil', 'gayu-123', 'gayu.jpg', 7805432109, 'gayu@gmail.com', 'gayu123', 'my name is gayu.', 'TEYB1342T', 'ahemedabad', '23.1008967', '72.5229621',  'owner');
    

   
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
    ('beauty', 'bt.jpg');



create table tbl_deal (
	id bigint primary key auto_increment,
    category_id bigint,
    owner_id bigint,
    name varchar(256),
    image varchar(32),
    link varchar(128),
    deals_date date,
    description text,
    avg_rating float(5,1) default '0',
    is_active boolean default '1' COMMENT '1=active,0=deactive',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key(category_id)references tbl_category(id),
    foreign key(owner_id)references tbl_user(id)

);


insert into tbl_deal (category_id, owner_id, name, image, link, deals_date, description) values
	(1, 2, 'Buy one get one free', 'ftware.jpg', 'https://www.ajio.com/s/footwear-4792-56591', '2024-03-18', 'Lorem ipsum dolor sit amet consectetur adipisicing elit. , inventore.'),
    (2, 4, 'Buy one get one free', 'clothing.jpg', 'https://www.ajio.com/s/clothing-4461-74581', '2024-02-18', 'Lorem   sit amet consectetur adipisicing elit. Assumenda, inventore.'),
    (4, 2, 'Womens Day Gift Hamper ', 'women.jpg', 'https://www.grabon.in/deals/?14515', '2024-03-08', ' ipsum  sit amet consectetur adipisicing elit. Assumenda, inventore.'),
    (3, 2, 'Kids Wear Online Store', 'kids.jpg', 'https://www.myntra.com/kids?f=Brand%3AH%26M', '2024-03-28', 'Lorem ipsum dolor sit amet  . Assumenda, inventore.'),
    (5, 4, 'WAIT! CAN\'T FIND WHAT YOU\'RE LOOKING FOR?', 'drnks.jpg', 'https://snackzack.com/collections/beverages', '2024-04-08', ' ipsum dolor sit amet consectetur adipisicing elit. , inventore.'),
    (6, 2, 'beaytu on fiew.!', 'kids.jpg', 'https://www.ajio.com/s/beauty-5269-65820', '2024-02-28', 'Lorem ipsum  sit amet  adipisicing elit. Assumenda, inventore.'),
    (1, 4, 'runnning on firing.!!!!', 'runner.jpg', 'https://www.ajio.com/s/footwear-4792-56591', '2024-04-18', '  dolor sit amet consectetur adipisicing elit. Assumenda, .');




create table tbl_hashtag (
	id bigint primary key auto_increment,
    deal_id bigint,
    name varchar(32),
    is_active boolean default '1' COMMENT '1=active,0=deactive',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key(deal_id)references tbl_deal(id)

);
insert into tbl_hashtag (deal_id, name) values
	(1, '#design'),
    (2, '#fashion'),
    (3, '#women'),
    (3, '#womenfashion'),
    (4, '#trend'),
    (5, '#ShopLocal'),
    (5, '#SaleAlert'),
    (2, '#DealLoot'),
    (3, '#OnlineShopping'),
    (4, '#ShopTillupYou'),
    (1, '#FashionsFinds'),
    (5, '#ReatilTheraoy'),
    (1, '#men');



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


create table tbl_looking_for (
	id bigint primary key auto_increment,
    user_id bigint,
    category_id bigint,
    title varchar(32),
    description text,
    total_comments int default '0',
    is_active boolean default '1' COMMENT '1=active,0=deactive',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key(user_id)references tbl_user(id),
    foreign key(category_id)references tbl_category(id)

);



insert into tbl_looking_for (user_id, category_id, title, description) values
	(1, 1, 'nike', 'Lorem ipsum dolor sit amet consectetur adipisicing elit. , inventore.'),
    (3, 2, 'clothing', ' ipsum dolor dipisicing elit. , inventore.'),
    (5, 5, 'sprite', '  dolor sit amet  adipisicing elit. , inventore.'),
    (6, 6, 'fach wash', '  dolor sit amet consectetur elit. , inventore.');

truncate table tbl_looking_for;

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
insert into tbl_looking_comments (user_id, looking_for_id, comments) values
		(6, 1, 'nice'),
        (5, 2, 'dolor sit'),
        (3, 3, 'Lorem ipsum'),
        (1, 4, 'good looking for our choice'),
        (6, 1, 'this deals for clening');
truncate table tbl_looking_comments;

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
	(1, 2, 'bsf.jpg', 'Blue Star Fashion'),
    (2, 4, 'rsf.jpg', 'Red Star Fashion'),
    (3, 4, 'ysf.jpg', 'Yellow Star Fashion'),
    (4, 2, 'fsf.jpg', 'Five Star Fashion');



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

insert into tbl_notification (user_id, title, description) values
	(1, 'Lorem, ipsum dolor.', 'Lorem ipsum dolor sit amet consectetur  elit. Eveniet!'),
    (3, 'ipsum dolor.', 'Lorem ipsum dolor sit amet  adipisicing elit. Eveniet!'),
    (5, 'Lorem dolor.', ' ipsum dolor sit amet consectetur adipisicing elit. !'),
    (6, 'dolor.', ' ipsum dolor sit  consectetur adipisicing elit. Eveniet!');

 
 
-- login query :-----------------------------
select * from tbl_user where username='mayur-123' and password='mayur123' and is_active=1;


-- forgot password :---------------------------
select * from tbl_user where email='abhi@gmail.com' or username='abhi@gmail.com' and is_active=1;
update tbl_user set password='abhi789' where id=2 and is_active=1;


-- sign up page :-----------------------
insert into tbl_user set fname='kanzariya', lname='chirag' ,username='chirag-123', mobile='9567567890', email='chirag@gmail.com', 
			password='chirag123', referral_code='HDFG526SG' , profile_image='chirag.jpg', bio='hello all my name is chirag and i from halvad.';
            

-- show all category and deals for particular user id := 16
select * from tbl_user where id=1;
select * from tbl_category;
select * from tbl_deal;       



-- show particular deals and this deals owner details :=18
SELECT d.*, u.id, u.fname, u.lname, u.created_at, 
          GROUP_CONCAT(h.name) AS hashtag,
          (SELECT COUNT(id) FROM tbl_deal_comment WHERE deal_id = d.id) AS total_comments
      FROM tbl_deal d
      JOIN tbl_user u ON d.owner_id = u.id
      JOIN tbl_hashtag h ON h.deal_id = d.id
      WHERE d.id = 3;
    
    
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
    where c.id=1;

-- particular deal comments := 22
select d.*,  dc.id, group_concat(dc.comments) from tbl_deal d join tbl_deal_comment dc on dc.deal_id=d.id where d.id=1;
    

-- notification := 24
select * from tbl_notification where user_id=1;


-- report deal :=25
select * from tbl_report_deal;


-- profile := 26 / 27
select u.* , d.image as deal_images, b.id as business_id, b.name as business_name,
	(select count(id) from tbl_follow_user where follow_id=2 ) as following ,
    (select count(id) from tbl_follow_user where user_id=2) as followers,
    IF( ( SELECT f.id FROM tbl_follow_user f WHERE f.user_id = 1 AND f.follow_id = u.id ), 'Following', 'Follow' ) AS is_follow
	from tbl_user u 
	join tbl_deal d on d.owner_id=u.id 
    join tbl_business b on b.owner_id=u.id
	where u.id=2 group by u.id;
    
    
-- people looking for deals..:= 35
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
	ROUND( (6371 * acos( cos( radians(23.0752323) ) 
		* cos( radians (u.latitude) )
        * cos( radians (u.longitude) - radians(72.5231027))
        + sin( radians(23.0752323))
        * sin( radians (u.latitude) ) ) ), 1) as distance_in_killometers 
	from tbl_user u 
	join tbl_deal d on d.owner_id=u.id
    join tbl_category c on c.id=d.category_id
    where d.category_id=1 or d.category_id=4
    having distance_in_killometers between 10 and 20; 
    
    
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
    
