CREATE DATABASE ArtGallery;

USE ArtGallery;

-- Table for storing user information
CREATE TABLE tbl_user (
    id bigint AUTO_INCREMENT PRIMARY KEY,
    fullname VARCHAR(50) NOT NULL,
	email VARCHAR(100) UNIQUE NOT NULL,
    password text(255) NOT NULL, 
    is_active boolean default '1' COMMENT '1=active,0=deactive',
    is_delete boolean default '0' comment '1=delete 0=not_delete',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp
);

-- Table for storing creator information
drop table tbl_creators;
CREATE TABLE tbl_creator (
	id bigint AUTO_INCREMENT PRIMARY KEY,
    fullname VARCHAR(50) NOT NULL,
	email VARCHAR(100) UNIQUE NOT NULL,
    password text(255) NOT NULL, 
    biography text,
    is_active boolean default '1' COMMENT '1=active,0=deactive',
    is_delete boolean default '0' comment '1=delete 0=not_delete',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp
);

-- Table for storing artwork information
CREATE TABLE tbl_artwork (
    id bigint AUTO_INCREMENT PRIMARY KEY,
    creator_id bigint,
    title VARCHAR(100) NOT NULL,
    description TEXT,
    image1 VARCHAR(255) NOT NULL,
    image2 VARCHAR(255) NOT NULL,
    image3 VARCHAR(255),
    price DECIMAL(8,2) NOT NULL,
	is_active boolean default '1' COMMENT '1=active,0=deactive',
    is_delete boolean default '0' comment '1=delete 0=not_delete',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    FOREIGN KEY (creator_id) REFERENCES tbl_creator(id)
);

-- Table for storing bid history
CREATE TABLE tbl_bid (
    id bigint AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT,
    artwork_id bigint,
    bid_price DECIMAL(8,2) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES tbl_user(id),
    FOREIGN KEY (artwork_id) REFERENCES tbl_artwork(id)
);

-- Table for storing favorite artworks
CREATE TABLE tbl_favourite (
    id bigint AUTO_INCREMENT PRIMARY KEY,
    user_id bigint,
    artwork_id bigint,
    FOREIGN KEY (user_id) REFERENCES tbl_user(id),
    FOREIGN KEY (artwork_id) REFERENCES tbl_artwork(id)
);


CREATE table tbl_history(
	id bigint AUTO_INCREMENT PRIMARY KEY,
    user_id bigint,
    artwork_id bigint,
    bid_price FLOAT(8,2),
    FOREIGN KEY (user_id) REFERENCES tbl_user(id),
    FOREIGN KEY (artwork_id) REFERENCES tbl_artwork(id)
);


select aw.*,c.fullname as creator_name,c.biography as  creator_biography  from tbl_artwork aw join tbl_creator as c on aw.creator_id=c.id where aw.is_active=1 and aw.is_delete=0;


select b.*, u.fullname, a.title from tbl_bid b
 join tbl_user u on u.id=b.user_id
 join tbl_artwork a on a.id=b.artwork_id
 where b.artwork_id=4;
 
 
 select * from tbl_favourite;
 
 select a.*,c.fullname,c.biography  from tbl_favourite f 
 join tbl_artwork a on a.id=f.artwork_id
 join tbl_creator c on c.id=a.creator_id where f.user_id=1; 