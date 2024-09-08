create database fitness_app;
use fitness_app;


create table tbl_user(
	id bigint AUTO_INCREMENT PRIMARY KEY,
    fullname varchar(128),
    email varchar(128) UNIQUE,
    password text,
    weight FLOAT(8,1),
    height float(8,1),
    fitness_goal int, 
	is_active boolean default '1' COMMENT '1=active,0=deactive',
    is_delete boolean default '0' comment '1=delete 0=not_delete',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp
);
-- drop table tbl_user;

create table tbl_daily_activity(
	id bigint AUTO_INCREMENT PRIMARY key,
    user_id bigint,
    steps int,
    distance float(8,1),
    date date,
    burned_kcal varchar(255),
    is_active boolean default '1' COMMENT '1=active,0=deactive',
    is_delete boolean default '0' comment '1=delete 0=not_delete',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key (user_id) references tbl_user(id)
);

create table tbl_nutrition_tracking(
	id BIGINT AUTO_INCREMENT PRIMARY key,
    user_id bigint,
    intake_time enum('breakfast', 'lunch', 'dinner'),
    date date,
    food_item VARCHAR(100),
    intake_kcal varchar(255),
	is_active boolean default '1' COMMENT '1=active,0=deactive',
    is_delete boolean default '0' comment '1=delete 0=not_delete',
    created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key (user_id) references tbl_user(id)
);

CREATE TABLE tbl_workout (
    id bigint AUTO_INCREMENT PRIMARY KEY,
    user_id bigint,
    date DATE,
    workout_type VARCHAR(100),
    duration INT, -- in minutes
    burned_kcal INT,
    foreign key (user_id) references tbl_user(id)
);
drop table workout;




-- -----------------------------------------


CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    password VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    age INT,
    gender ENUM('Male', 'Female', 'Other'),
    -- Other profile information as needed
);

CREATE TABLE ActivityTracking (
    activity_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    date DATE,
    steps INT,
    distance FLOAT,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

CREATE TABLE WorkoutLog (
    workout_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    date DATE,
    workout_type VARCHAR(100),
    duration INT, -- in minutes
    calories_burned INT,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

CREATE TABLE NutritionTracking (
    nutrition_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    date DATE,
    food_item VARCHAR(100),
    calories INT,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

CREATE TABLE tbl_goal (
    id bigint AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT,
    goal_type enum('walking', 'running', 'swimming'),
    target_value INT,
    foreign key (user_id) references tbl_user(id)
);





