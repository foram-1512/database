CREATE DATABASE if not exists practise; 
use  practise;

create table product_line(
	id bigint primary key,
    text_description text,
    html_desctiption text,
    image varchar(255),
    is_active boolean default '1',
    created_at timestamp default current_timestamp,
    update_at timestamp default current_timestamp on update current_timestamp 
);

drop table products;

create table products(
	id bigint primary key,
    product_name varchar(64),
    product_line_id bigint,
    product_scale varchar(64),
    product_vendor varchar(64),
    product_description text,
    quantity_in_stock int,
    buy_price int,
    msrp int,
    is_active boolean default '1',
    created_at timestamp default current_timestamp,
    update_at timestamp default current_timestamp on update current_timestamp,
    foreign key (product_line_id) references product_line(id)
);

create table order_details(
	id bigint primary key,
    product_id bigint,
    quantity_ordered int,
    price_each int,
    order_line_number varchar(64),
    is_active boolean default '1',
    created_at timestamp default current_timestamp,
    update_at timestamp default current_timestamp on update current_timestamp,
    foreign key (product_id) references products(id)
);

create table offices(
	id bigint primary key,
    city varchar(64),
    phone varchar(16),
    address_line1 text,
    address_line2 text,
    state varchar(64),
    country varchar(64),
    postal_code varchar(16),
    terriotry varchar(64),
    is_active boolean default '1',
    created_at timestamp default current_timestamp,
    update_at timestamp default current_timestamp on update current_timestamp
);

create table employees(
	id bigint primary key,
    first_name varchar(16),
    last_name varchar(16),
	middle_name varchar(16),
    extension varchar(32),
    email varchar(64),
    office_id bigint,
    reports_to bigint,
    job_title varchar(64),
    is_active boolean default '1',
    created_at timestamp default current_timestamp,
    update_at timestamp default current_timestamp on update current_timestamp,
	foreign key (office_id) references offices(id),
    foreign key (reports_to) references employees(id)
);



create table customers(
	id bigint primary key,
    customer_first_name varchar(16),
    customer_last_name varchar(16),
	customer_middle_name varchar(16),
    phone varchar(16),
    address_line1 text,
    address_line2 text,
    city varchar(32),
    state varchar(32),
    country varchar(32),
    postal_code varchar(16),
    sales_rep_emp_num bigint,
    credit_limit int,
    office_id bigint,
    reports_to bigint,
    job_title varchar(64),
    is_active boolean default '1',
    created_at timestamp default current_timestamp,
    update_at timestamp default current_timestamp on update current_timestamp,
	foreign key (sales_rep_emp_num) references employees(id)
);




create table orders(
	id bigint primary key,
    order_date date,
    required_date date,
    shipped_date date,
    order_status enum('Delivered','Pending', 'Cancelled', 'On the way') default 'pending',
    comments text,
    customer_id bigint,
    is_active boolean default '1',
    created_at timestamp default current_timestamp,
    update_at timestamp default current_timestamp on update current_timestamp,
    foreign key (customer_id) references customers(id)
);


create table payments(
	customer_id bigint,
    check_number bigint primary key,
    payment_date date,
    amount int,
    is_active boolean default '1',
    created_at timestamp default current_timestamp,
    update_at timestamp default current_timestamp on update current_timestamp,
    foreign key (customer_id) references customers(id)
);

ALTER TABLE product_line modify id bigint auto_increment;

ALTER TABLE products  modify id bigint auto_increment;

ALTER TABLE order_details  modify id bigint auto_increment;

ALTER TABLE offices  modify id bigint auto_increment;

ALTER TABLE employees  modify id bigint auto_increment;

ALTER TABLE customers  modify id bigint auto_increment;

ALTER TABLE orders  modify id bigint auto_increment;

select * from product_line;