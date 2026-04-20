Create database RetailSalesDB;
use RetailSalesDB;
Create table Customers(
	customer_id int PRIMARY KEY AUTO_INCREMENT,
    name varchar(80) NOT NULL,
    city varchar(50) NOT NULL
);

Create table Products(
	product_id int PRIMARY KEY AUTO_INCREMENT,
    name varchar(80) NOT NULL,
    category varchar(50) NOT NULL,
    price DECIMAL(10,2) NOT NULL
);
Create table Orders(
	order_id int PRIMARY KEY AUTO_INCREMENT,
    customer_id int NOT NULL,
    date DATE NOT NULL,
	foreign key (customer_id) REFERENCES Customers(customer_id)
);

Create table Order_items(
	order_id int  NOT NULL,
    product_id int NOT NULL,
    quantity int NOT NULL,
    PRIMARY KEY(order_id,product_id),
    foreign key (order_id) references Orders(order_id),
    foreign key (product_id) references Products(product_id)
);


insert into Customers (name,city) values
("Guna","gurugram"),
("Advaith","Noida"),
("Jashwanth","Chennai"),
("Hrushi","Hyderabad"),
("Praneeth","Hyderabad"),
("Varun","Mumbai"),
("Karan","Hyderabad"),
("Charith","Pune"),
("Tulasi","Banglore");


Select * from Customers;

insert into Products (name,category,price) values
("Desktop","Electronics",18000),
("Laptop","Electronics",60000),
("Mobile","Electronics",45000),
("Table","Furniture",9000),
("Tshirt","Fashion",2000),
("Chair","Furniture",8500),
("Bed","Furniture",13000),
("Speakers","Electronics",6000),
("Sneakers","Fashion",1300),
("Keyboard","Electronics",4000),
("Watch","Fashion",3000);

Select * from Products;

insert into Orders(customer_id,date) values
(1,'2025-01-20'),
(3,'2025-01-23'),
(6,'2025-03-01'),
(4,'2025-06-19'),
(8,'2025-07-16'),
(4,'2026-01-09'),
(2,'2026-01-12'),
(5,'2026-02-15'),
(9,'2026-02-21'),
(7,'2026-03-23'),
(3,'2026-03-31');

Select * from Orders;



insert into Order_items values
(1,2,1),
(2,3,1),
(1,6,2),
(3,1,1),
(4,4,1),
(2,10,1),
(3,8,2),
(5,5,2),
(7,3,1),
(7,9,2),
(4,7,1),
(6,2,1),
(6,11,1),
(8,6,1),
(9,1,1),
(8,4,1),
(9,10,1),
(11,2,1),
(10,7,1),
(11,8,1),
(10,5,1);


-- Queries 


-- Top-Selling Products
select Products.name,SUM(Order_items.quantity)
From Order_items
inner join Products	
on Order_items.product_id=Products.product_id
group by Products.product_id,Products.name
order by sum(quantity) DESC
LIMIT 1;

-- Most Valuable Customers
select Customers.name,SUM(Products.price*Order_items.quantity)
From Customers
join Orders
on Customers.customer_id=Orders.customer_id
join Order_items
on Orders.order_id=Order_items.order_id
join Products
on Order_items.product_id=Products.product_id
group by Customers.customer_id,Customers.name
order by SUM(Products.price*Order_items.quantity) DESC;





-- Monthly revenue calculation
select month(Orders.date) as month,sum(Products.price*Order_items.quantity)
from Orders
join Order_items 
on Orders.order_id=Order_items.order_id
join Products 
on Order_items.product_id=Products.product_id
group by month(Orders.date)
Order by month;


-- Category-wise sales analysis
select Products.category,SUM(Products.price*Order_items.quantity)
From Order_items
join Products	
on Order_items.product_id=Products.product_id
group by Products.category;



--  Detect inactive customers
select Customers.name
from Customers
left join Orders
on Customers.customer_id=Orders.customer_id
where Orders.order_id is NULL;


