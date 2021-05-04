-- ######################################################################
-- Order Management Schema
-- ######################################################################
-- ----------------------------------------------------------------------
-- Create schema
-- ----------------------------------------------------------------------
create schema myapp;
set search_path to myapp;

-- ----------------------------------------------------------------------
-- Create tables
-- ----------------------------------------------------------------------
create table products(product_id integer, product_name varchar(30));
create table customers(customer_id integer, customer_name varchar(30));
create table workers(worker_id integer, worker_name varchar(30));
create table orders(order_id integer, order_time timestamp, customer_id integer,product_id integer, processed char(1), worker_id integer, processed_time timestamp );

-- ----------------------------------------------------------------------
-- Create sequences
-- ----------------------------------------------------------------------
create sequence product_id;
create sequence customer_id;
create sequence worker_id;
create sequence order_id;

-- ----------------------------------------------------------------------
-- Create views
-- ----------------------------------------------------------------------
create view open_orders as select * from orders where processed='N' order by order_id;

create view closed_orders as select * from orders where processed='Y' order by order_id;

create view orders_by_product as 
select b.product_id, a.product_name, b.cnt 
from products a, (select product_id, count(1) cnt from orders group by product_id order by product_id) b
where a.product_id=b.product_id;

create view orders_by_customer as 
select b.customer_id, a.customer_name, b.cnt 
from customers a, (select customer_id, count(1) cnt from orders group by customer_id order by customer_id) b
where a.customer_id=b.customer_id;

create view orders_by_worker as 
select b.worker_id, a.worker_name, b.cnt 
from workers a, (select worker_id, count(1) cnt from orders group by worker_id order by worker_id) b
where a.worker_id=b.worker_id;

create view orders_by_status as 
select processed, count(1) cnt 
from orders 
group by processed 
order by processed;

create view orders_by_date as
select date_trunc('day',order_time), count(1) cnt 
from orders 
group by date_trunc('day',order_time) 
order by date_trunc('day',order_time);

-- ----------------------------------------------------------------------
-- Insert Seed products Data
-- ----------------------------------------------------------------------
insert into products values (nextval('product_id'), 'PRODUCT-'||substr(md5(random()::text), 1, 20));
insert into products values (nextval('product_id'), 'PRODUCT-'||substr(md5(random()::text), 1, 20));
insert into products values (nextval('product_id'), 'PRODUCT-'||substr(md5(random()::text), 1, 20));
insert into products values (nextval('product_id'), 'PRODUCT-'||substr(md5(random()::text), 1, 20));
insert into products values (nextval('product_id'), 'PRODUCT-'||substr(md5(random()::text), 1, 20));
insert into products values (nextval('product_id'), 'PRODUCT-'||substr(md5(random()::text), 1, 20));
insert into products values (nextval('product_id'), 'PRODUCT-'||substr(md5(random()::text), 1, 20));
insert into products values (nextval('product_id'), 'PRODUCT-'||substr(md5(random()::text), 1, 20));
insert into products values (nextval('product_id'), 'PRODUCT-'||substr(md5(random()::text), 1, 20));
insert into products values (nextval('product_id'), 'PRODUCT-'||substr(md5(random()::text), 1, 20));

-- ----------------------------------------------------------------------
-- Insert Seed customers Data
-- ----------------------------------------------------------------------
insert into customers values (nextval('customer_id'), 'CUSTOMER-'||substr(md5(random()::text), 1, 20));
insert into customers values (nextval('customer_id'), 'CUSTOMER-'||substr(md5(random()::text), 1, 20));
insert into customers values (nextval('customer_id'), 'CUSTOMER-'||substr(md5(random()::text), 1, 20));
insert into customers values (nextval('customer_id'), 'CUSTOMER-'||substr(md5(random()::text), 1, 20));
insert into customers values (nextval('customer_id'), 'CUSTOMER-'||substr(md5(random()::text), 1, 20));
insert into customers values (nextval('customer_id'), 'CUSTOMER-'||substr(md5(random()::text), 1, 20));
insert into customers values (nextval('customer_id'), 'CUSTOMER-'||substr(md5(random()::text), 1, 20));
insert into customers values (nextval('customer_id'), 'CUSTOMER-'||substr(md5(random()::text), 1, 20));
insert into customers values (nextval('customer_id'), 'CUSTOMER-'||substr(md5(random()::text), 1, 20));
insert into customers values (nextval('customer_id'), 'CUSTOMER-'||substr(md5(random()::text), 1, 20));

-- ----------------------------------------------------------------------
-- Insert Seed workers Data
-- ----------------------------------------------------------------------
insert into workers values (nextval('worker_id'), 'WORKER-'||substr(md5(random()::text), 1, 20));
insert into workers values (nextval('worker_id'), 'WORKER-'||substr(md5(random()::text), 1, 20));
insert into workers values (nextval('worker_id'), 'WORKER-'||substr(md5(random()::text), 1, 20));
insert into workers values (nextval('worker_id'), 'WORKER-'||substr(md5(random()::text), 1, 20));
insert into workers values (nextval('worker_id'), 'WORKER-'||substr(md5(random()::text), 1, 20));
insert into workers values (nextval('worker_id'), 'WORKER-'||substr(md5(random()::text), 1, 20));
insert into workers values (nextval('worker_id'), 'WORKER-'||substr(md5(random()::text), 1, 20));
insert into workers values (nextval('worker_id'), 'WORKER-'||substr(md5(random()::text), 1, 20));
insert into workers values (nextval('worker_id'), 'WORKER-'||substr(md5(random()::text), 1, 20));
insert into workers values (nextval('worker_id'), 'WORKER-'||substr(md5(random()::text), 1, 20));

-- ----------------------------------------------------------------------
-- Sample insert statement to make orders
-- ----------------------------------------------------------------------
insert into orders values (nextval('order_id'), clock_timestamp(), floor(random()*(10)+1), floor(random()*(10)+1), 'N', null, null);
insert into orders values (nextval('order_id'), clock_timestamp(), floor(random()*(10)+1), floor(random()*(10)+1), 'N', null, null);
insert into orders values (nextval('order_id'), clock_timestamp(), floor(random()*(10)+1), floor(random()*(10)+1), 'N', null, null);
insert into orders values (nextval('order_id'), clock_timestamp(), floor(random()*(10)+1), floor(random()*(10)+1), 'N', null, null);
insert into orders values (nextval('order_id'), clock_timestamp(), floor(random()*(10)+1), floor(random()*(10)+1), 'N', null, null);
insert into orders values (nextval('order_id'), clock_timestamp(), floor(random()*(10)+1), floor(random()*(10)+1), 'N', null, null);
insert into orders values (nextval('order_id'), clock_timestamp(), floor(random()*(10)+1), floor(random()*(10)+1), 'N', null, null);
insert into orders values (nextval('order_id'), clock_timestamp(), floor(random()*(10)+1), floor(random()*(10)+1), 'N', null, null);
insert into orders values (nextval('order_id'), clock_timestamp(), floor(random()*(10)+1), floor(random()*(10)+1), 'N', null, null);
insert into orders values (nextval('order_id'), clock_timestamp(), floor(random()*(10)+1), floor(random()*(10)+1), 'N', null, null);

-- ----------------------------------------------------------------------
-- Sample update statement to process orders
-- ----------------------------------------------------------------------
update orders set processed='Y', worker_id = floor(random()*(10)+1), processed_time=clock_timestamp() 
where order_id = (select order_id from orders where processed='N' limit 1);

-- ----------------------------------------------------------------------
-- Queries on tables/views
-- ----------------------------------------------------------------------
select * from products;
select * from customers;
select * from workers;
select * from orders;

select * from orders_by_product ; 
select * from orders_by_customer ; 
select * from orders_by_worker ; 
select * from orders_by_status ; 
select * from orders_by_date ;
--
-- ######################################################################
-- end of file
-- ######################################################################
