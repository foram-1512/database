create database exam_social_media;
use exam_social_media;

create table tbl_user(
	id bigint PRIMARY key AUTO_INCREMENT,
    name varchar(128),
    username varchar(128) UNIQUE,
    country_code VARCHAR(8) DEFAULT '+91',
    phone BIGINT(12) UNIQUE,
    email varchar(256)UNIQUE,
    password text,
    image text,
    bio text,
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
	is_active boolean default '1' COMMENT '1=active,0=inactive'
);
insert into tbl_user (name, username, phone, email, password, image,  bio) values 
('Abhi', 'abhi1442', 9876543210, 'abhi@gmail.com', 'abhi123', 'abhi_image.jpg', 'Lorem Ipsum'),
('Mayur', 'mayur8278', 9876543311, 'mayur@gmail.com', 'mayur123', 'mayur_image.jpg', 'Lorem Ipsum lorem'),
('Viral', 'viral123', 7972543810, 'viral@gmail.com', 'viral123', 'viral_image.jpg', 'Lorem Ipsum'),
('Foram', 'foram123', 7234243819, 'foram@gmail.com', 'foram123', 'foram_image.jpg', 'Lorem Ipsum impsum'),
('Abdul', 'abdul123', 7124321922, 'abdul@gmail.com', 'abdul123', 'abdul_image.jpg', 'Lorem impsum lorem')
;


create table tbl_post (
	id bigint PRIMARY KEY AUTO_INCREMENT,
    user_id bigint,
    media TEXT,
    headline varchar(256),
    description text,
    link TEXT,
    total_like int DEFAULT 0,
    total_comment int DEFAULT 0,
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
	is_active boolean default '1' COMMENT '1=active,0=inactive',
    foreign key(user_id)references tbl_user(id)
);

insert into tbl_post (user_id, media, headline, description, link) values 
(1, 'media1223.jpg', 'Same as it Ever Was… But Worse', 'Every time I tell people about the 80/20 rule of headlines they seem shocked. Remember that one?', null),
(2, 'media456.mp4', 'What’s the Reward for Reading?', 'he first thing to keep in mind is that a headline is a promise.', null),
(3, null, null, null, 'https://copyblogger.com/twitter-headlines/'),
(4, null, 'To People Who Want To Quit Work Someday', '76 Reasons Why It Would Have Paid You To Use Social Media A Few Months Ago', null),
(5, 'media1223.mp4', 'How to Win Friends and Influence People', 'Every time I tell people about the 80/20 rule of headlines they seem shocked', null);


create table tbl_post_media(
	id bigint PRIMARY key AUTO_INCREMENT,
    post_id bigint,
    media varchar(128),
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
	is_active boolean default '1' COMMENT '1=active,0=deactive',
	foreign key(post_id)references tbl_post(id)
);

insert into tbl_post_media (post_id, media) values 
(1, 'media900.jpg'),
(1, 'media901.jpg'),
(1, 'media902.jpg'),
(2, 'video2332.mp4'),
(2, 'video2333.mp4'),
(2, 'image234.jpg'),
(5, 'image1229.jpg'),
(5, 'image1230.jpg'),
(5, 'video121.mp4'),
(5, 'video1212.mp4')
;

create table tbl_post_like (
	id bigint primary key auto_increment,
    user_id bigint,
    post_id bigint,
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
	foreign key(post_id)references tbl_post(id),
    foreign key(user_id)references tbl_user(id)
);

insert into tbl_post_like (user_id, post_id) values 
(1,2),
(1,3),
(1,4),
(2,1),
(2,3),
(3,1),
(3,2),
(3,4),
(3,5),
(4,1),
(4,5),
(5,2),
(5,1),
(5,4);




create table tbl_post_comment (
	id bigint primary key auto_increment,
    parent_id BIGINT,
    user_id bigint,
    post_id bigint,
    comment text,
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
	is_active boolean default '1' COMMENT '1=active,0=deactive',
    foreign key(parent_id)references tbl_post_comment(id),
	foreign key(post_id)references tbl_post(id),
    foreign key(user_id)references tbl_user(id)
);

create table tbl_comment_like(
	id bigint PRIMARY key AUTO_INCREMENT,
    user_id bigint,
    comment_id bigint,
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
	is_active boolean default '1' COMMENT '1=active,0=deactive',
	foreign key(comment_id)references tbl_post_comment(id),
    foreign key(user_id)references tbl_user(id)
);


create table tbl_following (
	id bigint primary key auto_increment,
    user_id bigint,
    follow_id bigint,
    status enum('requested', 'accepted', 'rejected'),
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    is_active boolean default '1' COMMENT '1=active,0=deactive',
	foreign key(follow_id)references tbl_user(id),
    foreign key(user_id)references tbl_user(id)
);


create table tbl_block(
	id bigint AUTO_INCREMENT PRIMARY key,
    user_id BIGINT,
    block_id bigint,
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
	foreign key(block_id)references tbl_user(id),
    foreign key(user_id)references tbl_user(id)
);

create table tbl_post_report(
	id bigint PRIMARY key AUTO_INCREMENT,
    post_id bigint,
    user_id bigint,
    report_status enum ('It\'s spam', 'It\'s inappropriate', 'other'),
    description text,
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
	foreign key(post_id)references tbl_post(id),
	foreign key(user_id)references tbl_user(id)
);




-- login Query
select * from tbl_user where username='abhi1442' and password='abhi123' and is_active=1;

-- forgot password
select * from tbl_user where email='abhi@gmail.com';


--  display newest post 
select p.*, u.id,u.username,u.image,
CASE 
        WHEN TIMESTAMPDIFF(MINUTE, p.created_at, NOW()) < 60 THEN CONCAT(TIMESTAMPDIFF(MINUTE, p.created_at, NOW()), ' Minutes ago')
        WHEN TIMESTAMPDIFF(HOUR, p.created_at, NOW()) < 24 THEN CONCAT(TIMESTAMPDIFF(HOUR, p.created_at, NOW()), ' Hours ago')
        WHEN TIMESTAMPDIFF(DAY, p.created_at, NOW()) < 30 THEN CONCAT(TIMESTAMPDIFF(DAY, p.created_at, NOW()), ' Days ago')
        ELSE CONCAT(DATEDIFF(CURDATE(), p.created_at), ' month ago')
    END AS posted_ago,
    IFNULL((select(CASE when l.post_id !='' then 1 else 0 END) 
	from tbl_post_like l where l.post_id=p.id AND l.user_id=1),0) as is_like  
from tbl_post p 
join tbl_following f on f.follow_id = p.user_id
join tbl_user u on u.id=p.user_id
WHERE f.user_id=1 and f.status='accepted' and f.is_active=1 order by p.created_at desc;





-- popular  post
select p.*, u.id,u.username,u.image,
CASE 
        WHEN TIMESTAMPDIFF(MINUTE, p.created_at, NOW()) < 60 THEN CONCAT(TIMESTAMPDIFF(MINUTE, p.created_at, NOW()), ' Minutes ago')
        WHEN TIMESTAMPDIFF(HOUR, p.created_at, NOW()) < 24 THEN CONCAT(TIMESTAMPDIFF(HOUR, p.created_at, NOW()), ' Hours ago')
        WHEN TIMESTAMPDIFF(DAY, p.created_at, NOW()) < 30 THEN CONCAT(TIMESTAMPDIFF(DAY, p.created_at, NOW()), ' Days ago')
        ELSE CONCAT(DATEDIFF(CURDATE(), p.created_at), ' month ago')
    END AS posted_ago
from tbl_post p 
join tbl_following f on f.follow_id = p.user_id
join tbl_user u on u.id=p.user_id
WHERE f.user_id=1 and f.status='accepted' and f.is_active=1 and total_like>5 order by total_like desc;


-- display like on particular post
select count(id) as total_likes from tbl_post_like where post_id=2;
select u.id, u.name, u.username, u.image from tbl_post_like l
join tbl_user u on u.id=l.user_id
 where post_id=2; 
 
 
 -- display comment on particular post
 
 select count(id) as total_comments from tbl_post_comment where post_id=2;
select u.id, u.name, u.username, u.image, c.parent_id,c.comment, c.total_like from tbl_post_comment c
join tbl_user u on u.id=c.user_id
 where c.post_id=2; 
 

-- replies page

select u.id, u.name, u.username, u.image, c.parent_id,c.comment, c.total_like,
	(select count(c.id) from tbl_post_comment c
	join tbl_user u on u.id=c.user_id
	where c.post_id=2 and c.parent_id!=0) as total_replies
	from tbl_post_comment c
	join tbl_user u on u.id=c.user_id
	where c.post_id=2 and c.parent_id=0; 
 
 
 -- replies
select u.id, u.name, u.username, u.image, c.parent_id,c.comment, c.total_like from tbl_post_comment c
join tbl_user u on u.id=c.user_id
 where c.post_id=2 and c.parent_id!=0; 
 
 
 -- feed details page
 
select p.*, u.id,u.username,u.image,
CASE 
        WHEN TIMESTAMPDIFF(MINUTE, p.created_at, NOW()) < 60 THEN CONCAT(TIMESTAMPDIFF(MINUTE, p.created_at, NOW()), ' Minutes ago')
        WHEN TIMESTAMPDIFF(HOUR, p.created_at, NOW()) < 24 THEN CONCAT(TIMESTAMPDIFF(HOUR, p.created_at, NOW()), ' Hours ago')
        WHEN TIMESTAMPDIFF(DAY, p.created_at, NOW()) < 30 THEN CONCAT(TIMESTAMPDIFF(DAY, p.created_at, NOW()), ' Days ago')
        ELSE CONCAT(DATEDIFF(CURDATE(), p.created_at), ' month ago')
    END AS posted_ago,
    IFNULL((select(CASE when l.post_id !='' then 1 else 0 END) 
	from tbl_post_like l where l.post_id=p.id AND l.user_id=1),0) as is_like  
from tbl_post p 
join tbl_following f on f.follow_id = p.user_id
join tbl_user u on u.id=p.user_id
WHERE p.id=2 and f.user_id=1 and f.status='accepted' and f.is_active=1;

 
 
 
 
 -- my profile section
 SELECT u.*, 
(select count(id) from tbl_post where user_id=1 and is_active=1) as posts, 
(select count(id) from tbl_following where follow_id=1 and status='accepted' and is_active=1)as followers,
(select count(id) from tbl_following where user_id=1 and status='accepted' and is_active=1) as following,
IF( ( SELECT f.id FROM tbl_following f WHERE f.user_id = 5 AND f.follow_id = u.id ), 'Following', 'Follow' ) AS is_follow
from tbl_user u
where u.id=1
group by u.id;