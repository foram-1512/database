create database practise2;
use practise2;

drop table addresses;

create table addresses(
	id bigint primary key auto_increment,
    address_details text,
	is_active boolean default '1' comment '1 for active, 0 for deactive',
    created_at timestamp default current_timestamp,
    update_at timestamp default current_timestamp on update current_timestamp 
);


create table schools(
	id bigint primary key auto_increment,
    address_id bigint,
    school_name	varchar(64),
    school_principal varchar(64),
    other_school_details varchar(128),
	is_active boolean default '1' comment '1 for active, 0 for deactive',
    created_at timestamp default current_timestamp,
    update_at timestamp default current_timestamp on update current_timestamp, 
    foreign key (address_id) references addresses(id)
    );
    
    
create table teacher(
	id bigint primary key auto_increment,
    school_id bigint,
    gender enum('male', 'female'),
    first_name varchar(16),
    middle_name varchar(16),
    last_name varchar(16),
    other_teacher_details varchar(64),
	is_active boolean default '1' comment '1 for active, 0 for deactive',
    created_at timestamp default current_timestamp,
    update_at timestamp default current_timestamp on update current_timestamp, 
    foreign key (school_id) references schools(id)
    );
    
    
    create table subjects(
	id bigint primary key auto_increment,
    subject_name varchar(64),
	is_active boolean default '1' comment '1 for active, 0 for deactive',
    created_at timestamp default current_timestamp,
    update_at timestamp default current_timestamp on update current_timestamp
    );
    
    create table classes(
	id bigint primary key auto_increment,
    subject_id bigint,
    teacher_id bigint,
    class_code varchar(32),
    class_name varchar(32),
    date_from date,
    date_to date,
	is_active boolean default '1' comment '1 for active, 0 for deactive',
    created_at timestamp default current_timestamp,
    update_at timestamp default current_timestamp on update current_timestamp, 
    foreign key (subject_id) references subjects(id),
    foreign key (teacher_id) references teacher(id)
    );
    
    
    create table students(
	id bigint primary key auto_increment,
    gender enum('male', 'female'),
    first_name varchar(16),
    middle_name varchar(16),
    last_name varchar(16),
    date_of_birth date,
    other_student_details varchar(64),
	is_active boolean default '1' comment '1 for active, 0 for deactive',
    created_at timestamp default current_timestamp,
    update_at timestamp default current_timestamp on update current_timestamp
    );
    
    create table student_classes(
	student_id bigint,
    class_id bigint,
    date_from date primary key,
    date_to date,
	is_active boolean default '1' comment '1 for active, 0 for deactive',
    created_at timestamp default current_timestamp,
    update_at timestamp default current_timestamp on update current_timestamp,
    foreign key (student_id) references students(id),
    foreign key (class_id) references classes(id)
    );
    
    
    create table reports(
	id bigint primary key auto_increment,
    student_id bigint,
    date_created date,
    report_content text,
    teacher_comments text,
    other_report_details text,
	is_active boolean default '1' comment '1 for active, 0 for deactive',
    created_at timestamp default current_timestamp,
    update_at timestamp default current_timestamp on update current_timestamp,
    foreign key (student_id) references students(id)
    );
    
    create table homework(
	id bigint primary key auto_increment,
    student_id bigint,
    date_created date,
    homework_content text,
    grade enum('A', 'B', 'C', 'D', 'E', 'F'),
    other_homework_details text,
	is_active boolean default '1' comment '1 for active, 0 for deactive',
    created_at timestamp default current_timestamp,
    update_at timestamp default current_timestamp on update current_timestamp,
    foreign key (student_id) references students(id)
    );
    
    
    create table student_address(
	student_id bigint,
    address_id bigint,
    date_from date primary key,
    date_to date,
    address_details text,
	is_active boolean default '1' comment '1 for active, 0 for deactive',
    created_at timestamp default current_timestamp,
    update_at timestamp default current_timestamp on update current_timestamp,
    foreign key (student_id) references students(id),
    foreign key (address_id) references addresses(id)
    );
    
	create table parents(
	id bigint primary key auto_increment,
    gender enum('male', 'female'),
    first_name varchar(16),
    middle_name varchar(16),
    last_name varchar(16),
    other_parent_details text,
	is_active boolean default '1' comment '1 for active, 0 for deactive',
    created_at timestamp default current_timestamp,
    update_at timestamp default current_timestamp on update current_timestamp
    );
    
    drop table parents;
    
    create table parents_addresses(
	parent_id bigint,
    address_id bigint,
    date_address_from date primary key,
    date_address_to date,
	is_active boolean default '1' comment '1 for active, 0 for deactive',
    created_at timestamp default current_timestamp,
    update_at timestamp default current_timestamp on update current_timestamp,
    foreign key (parent_id) references parents(id),
    foreign key (address_id) references addresses(id)
    );
    
    
    create table student_parent(
	student_id bigint,
    parent_id bigint,
	is_active boolean default '1' comment '1 for active, 0 for deactive',
    created_at timestamp default current_timestamp,
    update_at timestamp default current_timestamp on update current_timestamp,
    foreign key (student_id) references students(id),
    foreign key (parent_id) references parents(id)
    );
    
    
    create table families(
	id bigint primary key auto_increment,
    head_of_family_parent_id bigint,
    family_name varchar(32),
	is_active boolean default '1' comment '1 for active, 0 for deactive',
    created_at timestamp default current_timestamp,
    update_at timestamp default current_timestamp on update current_timestamp,
    foreign key (head_of_family_parent_id) references parents(id)
    );
    
    
    create table family_members(
	id bigint primary key auto_increment,
    family_id bigint,
    parent_or_student_member varchar(32),
    parent_id bigint,
    student_id bigint,
	is_active boolean default '1' comment '1 for active, 0 for deactive',
    created_at timestamp default current_timestamp,
    update_at timestamp default current_timestamp on update current_timestamp,
    foreign key (family_id) references families(id),
    foreign key (parent_id) references parents(id),
    foreign key (student_id) references students(id)
    );
    
    
    
    




    
    

