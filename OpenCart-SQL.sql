create database OpenCart;
use OpenCart;

-- Customers: id, first_name, last_name, email, telephone, address, payment_methods, history_date_added, reward_points
create table Customer
(
id int not null auto_increment primary key,
first_name varchar (50) not null,
last_name varchar (50) not null,
email varchar (50) not null unique,
telephone varchar (15) not null, 
address varchar (50) not null,
payment_methods varchar (15) not null,
history_date_added varchar (15) not null,
reward_points int
);
desc Customer;
rename table Customer to Customers;

-- Products: product_id, product_name, model, price, quantity
create table Products
(
product_id int not null auto_increment primary key,
product_name varchar (50) not null, 
model varchar (100) not null, 
price decimal (12,2) not null,
quantity int check (quantity<2147483647) not null
);
desc Products;

-- Orders: order_id, customer_id, product_id, status_order, total, date_added, date_modified
create table Orders
(
order_id int not null auto_increment primary key,
customer_id int not null,
product_id int not null,
status_order varchar (15) not null,
total decimal (12,2) not null,
date_added datetime not null,
date_modified datetime not null,
foreign key (customer_id) references Customers(id),
foreign key (product_id) references Products(product_id)
);
desc Orders;

-- Return_orders: return_id, order_id, customer_id, product_id, model, status_order, date_added, date_modified
create table Return_orders
(
return_id int not null auto_increment primary key,
order_id int not null,
customer_id int not null,
product_id int not null,
model varchar(50) not null,
status_order varchar (15) not null,
date_added datetime not null,
date_modified datetime not null,
foreign key (order_id) references Orders(order_id),
foreign key (customer_id) references Customers(id),
foreign key (product_id) references Products(product_id)
);
desc Return_orders;

alter table Return_orders modify date_added date;
alter table Return_orders modify date_modified date;
alter table Return_orders drop column status_order;
alter table Return_orders add column status_order varchar(15) not null;
alter table Return_orders change status_order statusorder varchar(15);
alter table Return_orders change statusorder status_order varchar(15);

drop table Return_orders;

insert into Customers(id, last_name, first_name, email, telephone, address, payment_methods, history_date_added, reward_points)
values
(1, "Popescu", "Razvan", "popescu@gmail.com", "0722555887", "Strada Crizantemelor nr 13", "Credit Card", "2024-01-15", 10),
(2, "Bud", "MARia", "maria.b@yahoo.com", "0745654987", "BD Unirii nr 14/1", "Cash", "2024-01-15", "3"),
(3, "Martinache", "MARia", "marmar@yahoo.com", "0741235444", "BD Traian nr 4/33", "Cash", "2024-01-16", 15),
(4, "Klaus", "Goran", "mymail@gmail.com", "0722458789", "Strada Luncii nr 8", "Cash", "2024-02-02", "10");
select * from Customers;

insert into Products(product_id, product_name, model, price, quantity) values(1, "I-Pod", "Nano", "100", "1000");
insert into Products(product_id, product_name, model, price, quantity) values(2, "I-Pod", "Shuffle", "100", "5000");
insert into Products(product_id, product_name, model, price, quantity) values(3, "I-Phone", "14Pro", "101", "120");
insert into Products(product_id, product_name, model, price, quantity) values(4, "Camera_Canon", "EOS5D", "80", "155");
insert into Products(product_id, product_name, model, price, quantity) values(5, "Monitor_Apple", "Cinema30", "90", "90");
insert into Products(product_id, product_name, model, price, quantity) values(6, "Phone_HTC", "TouchHD", "100", "66");
select * from Products;

alter table Orders add column ordered_quantity int;
insert into Orders(order_id, customer_id, product_id, ordered_quantity, status_order, total, date_added, date_modified) values(1,4,2,15,"Complete",1500,"2024-01-03","2024-01-03");
insert into Orders(order_id, customer_id, product_id, ordered_quantity, status_order, total, date_added, date_modified) values(2,4,4,5,"Pending",775,"2024-02-15","2024-02-15");
insert into Orders(order_id, customer_id, product_id, ordered_quantity, status_order, total, date_added, date_modified) values(3,3,5,4,"Pending",360,"2024-02-08","2024-02-08");
insert into Orders(order_id, customer_id, product_id, ordered_quantity, status_order, total, date_added, date_modified) values(4,2,1,1,"Processing",100,"2024-02-08","2024-02-09");
insert into Orders(order_id, customer_id, product_id, ordered_quantity, status_order, total, date_added, date_modified) values(5,1,2,1,"Processing",100,"2024-02-03","2024-02-04");
select * from Orders;

alter table Return_orders drop column date_modified;
desc Return_orders;
insert into Return_orders(return_id, order_id, customer_id, product_id, model, status_order, date_added) values(1,5,1,2,"Shuffle","Canceled","2024-02-08");
insert into Return_orders(return_id, order_id, customer_id, product_id, model, status_order, date_added) values(2,2,4,4,"Shuffle","EOS5D","2024-02-15");
select * from Return_orders;

SET SQL_SAFE_UPDATES=0;
select * from Customers  where  last_name = 'Bud';
select * from Customers where first_name = 'MARia' and email = 'maria.b@yahoo.com';
select * from Customers where first_name = 'MARia' or first_name = 'Goran';
update  Customers set first_name = upper(first_name);
select * from Customers where first_name like "%MAR%";
select * from Customers;

select * from Products order by price desc;
select * from Products where price < 100;
select sum(price) from Products;
delete from Products where product_id = 3;
select group_concat(product_name separator '  , ') from Products;
select * from Products;

select * from Customers left join Orders on Customers.id=Orders.order_id;
select * from Products inner join Return_orders on Products.product_id=Return_orders.return_id;


