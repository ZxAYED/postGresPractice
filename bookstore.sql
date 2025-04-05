

CREATE TABLE books (
    id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    author VARCHAR(100),
    price  int NOT NULL CHECK (price >= 0),
    stock int ,
    published_year int
);
SELECT current_database();
select * from books;

create table customers (
    id serial PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    joined_date TIMESTAMP
)


select * from customers;

 create TABLE orders (
    id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(id) NOT NULL,
    book_id int REFERENCES  books(id) NOT NULL,
   
    quantity int not null CHECK(quantity > 0),
     order_date TIMESTAMP DEFAULT NOW()
 )

 INSERT INTO books (id, title, author, price, stock, published_year)
VALUES
(1, 'The Pragmatic Programmer', 'Andrew Hunt', 40.00, 10, 1999),
(2, 'Clean Code', 'Robert C. Martin', 35.00, 5, 2008),
(3, 'You Dont Know JS', 'Kyle Simpson', 30.00, 8, 2014),
(4, 'Refactoring', 'Martin Fowler', 50.00, 3, 1999),
(5, 'Database Design Principles', 'Jane Smith', 20.00, 0, 2018),
(6, 'JavaScript: The Good Parts', 'Douglas Crockford', 25.00, 12, 2008),
(7,'Design Patterns: Elements of Reusable Object-Oriented Software', 'Erich Gamma', 55.00, 2, 1994),
(8,'The Clean Coder', 'Robert C. Martin', 40.00, 6, 2011),
(9,'Introduction to Algorithms', 'Thomas H. Cormen', 70.00, 0, 2009),
(10,'The Mythical Man-Month', 'Frederick P. Brooks', 32.00, 15, 1975),
(11,'Code Complete', 'Steve McConnell', 60.00, 7, 2004),
(12,'The Art of Computer Programming', 'Donald E. Knuth', 150.00, 0, 1968),
(13,'The Pragmatic Programmer', 'Andrew Hunt', 40.00, 11, 1999),
(14,'Refactoring: Improving the Design of Existing Code', 'Martin Fowler', 52.00, 9, 1999),
(15,'The Design of Everyday Things', 'Don Norman', 45.00, 3, 1988);



alter table books rename COLUMN  publish_year to  published_year

ALTER TABLE books ALTER COLUMN stock TYPE INT ;
 drop table books;
 drop TABLE orders;



INSERT INTO customers (name, email, joined_date) VALUES
('Alice', 'alice@email.com', '2023-01-10'),
('Bob', 'bob@email.com', '2022-05-15'),
('Charlie', 'charlie@email.com', '2023-06-20'),
('David', 'david@email.com', '2022-11-05'),
('Eve', 'eve@email.com', '2021-07-14'),
('Frank', 'frank@email.com', '2023-03-25'),
('Grace', 'grace@email.com', '2022-09-10'),
('Hannah', 'hannah@email.com', '2022-12-01'),
('Ivan', 'ivan@email.com', '2023-02-18'),
('Jack', 'jack@email.com', '2021-10-22');



INSERT INTO orders (customer_id, book_id, quantity, order_date) VALUES
(1, 2, 1, '2024-03-10'),
(2, 1, 1, '2024-02-20'),
(1, 3, 2, '2024-03-05'),
(3, 4, 3, '2024-03-12'),
(4, 5, 1, '2024-02-15');
INSERT INTO orders (customer_id, book_id, quantity, order_date) VALUES
(1, 10, 12, '2024-03-10'),
(2, 12, 1, '2024-02-20'),
(7, 3, 2, '2024-03-05'),
(8, 4, 3, '2024-03-12'),
(9, 15, 1, '2024-02-15');

select * from  orders ;
select * from  customers ;

select * from books ;


-- 1️⃣ Find books that are out of stock.
select title from books  where stock <=0 ;

--  i can use where clause to find books based on my logic of out of stock


-- 2️⃣ Retrieve the most expensive book in the store.

select   * from books where price = (select max(price) from books) ;

--selecting the whole row using * &  using () to query the most expensive book in the store

-- 3️⃣ Find the total number of orders placed by each customer.
select  customers.name ,count(orders.id) as total_orders from customers join  orders on orders.customer_id = customers.id group by customers.name;

-- using count function to find the total number of orders placed by each customer used join to join two tables and show customer name and total orders

-- 4️⃣ Calculate the total revenue generated from book sales.


select sum(books.price * orders.quantity) as total_revenue  from books   join orders on orders.book_id = books.id;

-- using sum function to calculate total revenue and join two tables to get the book price and order quantity and multiply them to get total revenue

-- 5️⃣ List all customers who have placed more than one order.
select  customers.name ,count(orders.id) as orders_count   from customers  join  orders on orders.customer_id = customers.id group by customers.name having count(orders.id)>1;

-- using count function to find the total number of orders placed by each customer used join to join two tables and show customer name and total orders

-- 6️⃣ Find the average price of books in the store.
select avg(books.price) as avg_book_price from books ;

-- using avg function to calculate average book price


-- 7️⃣ Increase the price of all books published before 2000 by 10%
update books set price = 1.1 * price where published_year <2000;

-- used update and set method to update price ,using  where clasue i can add condition to update the price
select * from books ;

-- 8️⃣ Delete customers who haven't placed any orders.
delete  from customers where id not in ( select customer_id from orders);

-- delete all customers who haven't placed any orders using where and not in clause 
select * from customers ;