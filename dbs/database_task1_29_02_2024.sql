create database practise6;
drop database practise6;
use practise6;

CREATE TABLE User (
  ID int NOT NULL AUTO_INCREMENT,
  Name varchar(255) NOT NULL,
  mobile_number varchar(10) NOT NULL,
  role enum('customer','supplier') NOT NULL,
  is_active boolean default '1' comment'1 -> for is active, 2-> for deactive',
  created_at timestamp default current_timestamp,
  update_at timestamp default current_timestamp on update current_timestamp,
  PRIMARY KEY (ID)
);

CREATE TABLE Product (
  id int NOT NULL AUTO_INCREMENT,
  product_name varchar(255) NOT NULL,
  supplier_id int NOT NULL,
  quantity int NOT NULL,
  price decimal(10,2) NOT NULL,
  is_active boolean default '1' comment'1 -> for is active, 2-> for deactive',
  created_at timestamp default current_timestamp,
  update_at timestamp default current_timestamp on update current_timestamp,
  PRIMARY KEY (id),
  FOREIGN KEY (supplier_id) REFERENCES User(ID)
);


CREATE TABLE Orders(
  id int NOT NULL AUTO_INCREMENT,
  order_id int NOT NULL,
  customer_id int NOT NULL,
  product_id int NOT NULL,
  shipper_id int NOT NULL,
  order_date date NOT NULL,
  status enum('Pending','Delivered','Cancelled') NOT NULL,
  is_active boolean default '1' comment'1 -> for is active, 2-> for deactive',
  created_at timestamp default current_timestamp,
  update_at timestamp default current_timestamp on update current_timestamp,
  PRIMARY KEY (id),
  FOREIGN KEY (customer_id) REFERENCES User(ID),
  FOREIGN KEY (product_id) REFERENCES Product(id),
  FOREIGN KEY (shipper_id) REFERENCES User(ID)
);

-- user table
insert into user (name,mobile_number,role) values('Abhi',9876543210,'customer');
insert into user (name,mobile_number,role) values('abhi',9876543221,'supplier');
insert into user (name,mobile_number,role) values('abdul',9998887776,'supplier');
insert into user (name,mobile_number,role) values('pathan',987654345,'customer');
insert into user (name,mobile_number,role) values('Zack',987654345,'customer');
insert into user (name,mobile_number,role) values('Matt',937654345,'supplier');

-- product table
insert into Product (product_name,supplier_id,quantity,Price) values('laptop',2,15,50555.500);
insert into Product (product_name,supplier_id,quantity,Price) values('tv',2,10,35000);
insert into Product (product_name,supplier_id,quantity,Price) values('phone',3,20,75000);
insert into Product (product_name,supplier_id,quantity,Price) values('earbuds',3,18,2500.500);
insert into Product (product_name,supplier_id,quantity,Price) values('charger',6,7,1000.500);
insert into Product (product_name,supplier_id,quantity,Price) values('watch',6,22,3500.500);

-- order table
insert into Orders (order_id,customer_id,product_id,Shipper_id,order_date,status) values(1,5,1,3,'2023-01-23','Delivered');
insert into Orders (order_id,customer_id,product_id,Shipper_id,order_date,status) values(2,1,2,2,'2022-10-03','Cancelled');
insert into Orders (order_id,customer_id,product_id,Shipper_id,order_date,status) values(3,5,3,3,'2019-03-05','Pending');
insert into Orders (order_id,customer_id,product_id,Shipper_id,order_date,status) values(4,3,4,4,'2018-02-20','Pending');
insert into Orders (order_id,customer_id,product_id,Shipper_id,order_date,status) values(5,6,5,4,'2014-03-01','Cancelled');
insert into Orders (order_id,customer_id,product_id,Shipper_id,order_date,status) values(6,4,6,4,'2022-07-21','Delivered');
insert into Orders (order_id,customer_id,product_id,Shipper_id,order_date,status) values(7,2,2,4,'2021-03-31','Delivered');


select * from user;
select * from Orders;
select * from Product;

-- 1. 2nd highest price product with subquery
select product_name, max(price) as second_highest_price from Product where price < (select max(price) from Product);

-- 2. Product details with supplier detsils
select p.*, p.supplier_id, u.name from Product p join User u on p.supplier_id=u.id; 

-- 3. Order details with customer name and shipper name
select u.name,o.* from Orders o join User u on o.shipper_id = u.id;

-- 4. Product wise order count query
select p.product_name,p.id, count(o.product_id) as number_of_orders from Product p join Orders o on  p.id = o.product_id group by product_name;

-- 5. Get list of order whose status not in Cancelled
select p.*,o.status from Product p join Orders o on p.id = o.product_id where o.status not in ('Cancelled');

-- 6. Get list of customer with total number of order
select u.*, count(o.customer_id) as total_orders from User u join Orders o on o.customer_id = u.id  where role='Customer' group by u.id; 

-- 7. Get list of customer with total number of order and count greater then 5
select u.*, count(o.customer_id) as total_orders, count(o.order_id)>1 as order_more_than_1 from User u join Orders o on o.customer_id = u.id  where role='Customer'  group by o.customer_id; 