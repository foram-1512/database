create database healthcare;
use healthcare;

create table tbl_patient(
	id bigint AUTO_INCREMENT PRIMARY KEY,
    fname varchar(128),
    lname varchar(128),
    email varchar(128) UNIQUE,
    gender enum('male','female'),
    password text,
    age int,
    address text,
    date_of_birth date,
	is_active boolean default '1' COMMENT '1=active,0=deactive',
    is_delete boolean default '0' comment '1=delete 0=not_delete',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp
);


create table tbl_doctor(
	id bigint AUTO_INCREMENT PRIMARY KEY,
    fname varchar(128),
    lname varchar(128),
    email varchar(128) UNIQUE,
    password text,
    date_of_birth date,
    speciality set('cardiology', 'orthopedics', 'dermatology', 'surgeon'),
	is_active boolean default '1' COMMENT '1=active,0=deactive',
    is_delete boolean default '0' comment '1=delete 0=not_delete',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp
);

create table tbl_doctor_availability(
	id BIGINT PRIMARY key AUTO_INCREMENT,
    doctor_id bigint,
    available_date date,
    is_active boolean default '1' COMMENT '1=active,0=deactive',
    is_delete boolean default '0' comment '1=delete 0=not_delete',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key (doctor_id) references tbl_doctor(id)
);

create table tbl_schedule_appointment(
	id BIGINT AUTO_INCREMENT PRIMARY KEY,
    patient_id BIGINT,
    doctor_id bigint,
    appointment_date date,
    reason text,
	is_active boolean default '1' COMMENT '1=active,0=deactive',
    is_delete boolean default '0' comment '1=delete 0=not_delete',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key (patient_id) references tbl_patient(id),
    foreign key (doctor_id) references tbl_doctor(id)
);

create table tbl_record(
	id bigint AUTO_INCREMENT PRIMARY KEY,
    patient_id BIGINT,
    record_date date,
    diagnosis varchar(255),
    medications varchar(255),
    notes text,
    is_active boolean default '1' COMMENT '1=active,0=deactive',
    is_delete boolean default '0' comment '1=delete 0=not_delete',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key (patient_id) references tbl_patient(id)
);


create table tbl_doctor_avl(
	id bigint AUTO_INCREMENT PRIMARY key,
    doctor_id bigint,
    available_day varchar(255),
    is_active boolean default '1' COMMENT '1=active,0=deactive',
    is_delete boolean default '0' comment '1=delete 0=not_delete',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key (doctor_id) references tbl_doctor(id)
);


select date_format(curdate(), '%W') as today from  tbl_doctor_avl where available_day='Tuesday,Saturday';
SELECT * FROM tbl_doctor_avl WHERE available_day = DATE_FORMAT(CURDATE(), '%W');
SELECT * FROM tbl_doctor_avl WHERE FIND_IN_SET(date_format(curdate(), '%W'), available_day) and doctor_id=12;



select date_format('2024/06/05', '%W'); 


select date_format(curdate(), '%W') as today from  tbl_doctor_avl where find_in_set(available_day,'Saturday');