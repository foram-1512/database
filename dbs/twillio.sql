create database twillio;
use twillio;
CREATE TABLE tbl_user (
    id bigint AUTO_INCREMENT PRIMARY KEY,
    fullname VARCHAR(50) NOT NULL,
	email VARCHAR(100) UNIQUE NOT NULL,
    password text(255) NOT NULL, 
    otp_code int(8),
    otp_verification tinyint(1),
    is_active boolean default '1' COMMENT '1=active,0=deactive',
    is_delete boolean default '0' comment '1=delete 0=not_delete',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp
);
select * from tbl_user;

create table tbl_meeting(
	id bigint AUTO_INCREMENT PRIMARY KEY,
    host_id bigint,
    user_id bigint,
    meeting_id VARCHAR(16),
    passcode TEXT,
    time DATETIME,
	is_active boolean default '1' COMMENT '1=active,0=deactive',
    is_delete boolean default '0' comment '1=delete 0=not_delete',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
     foreign key (host_id) references tbl_user(id),
     foreign key (user_id) references tbl_user(id)
);


create table message(
	id bigint AUTO_INCREMENT primary key,
    username varchar(128),
    message text
);

select m.*, u.fullname from tbl_meeting m join tbl_user u on u.id=m.host_id where m.user_id=2;
SELECT u.* FROM tbl_user u JOIN (SELECT email FROM tbl_user GROUP BY email HAVING COUNT(*) > 1) dup ON u.email = dup.email ORDER BY u.email;