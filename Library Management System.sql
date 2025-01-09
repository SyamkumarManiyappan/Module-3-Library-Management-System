-- create the database
create database Library;
use library;
-- create branch table
create table branch ( 
branch_no int primary key,
manager_id int not null,
branch_address varchar(50) );

Insert into Branch(branch_no,Manager_id,Branch_address)
values 
(01,101,'Alappuzha'),
(02,102,'Kollam'),
(03,103,'Eranakulam'),
(04,104,'Malapuram');



-- Create the employee table

create table Employee (
Emp_id int primary key,
Emp_name varchar(20),
Position varchar(50),
Salary decimal(10,2),
manager_id int,
Branch_no int, foreign key (branch_no) references Branch(Branch_no) );

Insert into Employee (emp_id,Emp_name,position,Salary,Branch_no)
Values 
(101,'Arun Kumar','Manager',15000,01),
(02,'Akshay','Accountant',45000,01),
(103,'Akhil',' Manager',15000,02),
(04,'Amal','Accountant',51000,02),
(05,'Vimal','Security',10000,01),
(06,'Barun','Security',10000,02),
(07,'Basanthi','Accountant',50000,03),
(08,'Athulya','Library assistant',15000,03),
(09,'Aswagosh','Library assistant',15000,04),
(10,'Sahad','Accountant',50500,04),
(11,' Surya','Library assistant',15000,03),
(102,'Rahul','Manager',45000,03),
(13,'Pradeep','Library assistant',15000,03),
(14,' Sugunan','Library assistant',15000,03),
(15,'Roma','Accountant',45000,03),
(16,'Roopesh','Library assistant',15000,03);


-- create the books table
create table Books (
ISBN int primary key,
book_title varchar(100),
category varchar(50),
Rental_price decimal(10,2),
Status varchar(3) check (status IN('Yes','NO')),
Author varchar(30),
Publisher varchar(50));



insert into books (ISBN,book_title,category,Rental_price,status,Author,Publisher)
Values 
(201, 'Kunthalatha', 'Novel', 20.00, 'Yes', 'Appu Nedungadi', 'DC Books'),
(202, 'Indhulegha', 'Novel', 25.00, 'Yes', 'O. Chandu Menon', 'Current Books'),
(203, 'Goatlife', 'Fiction', 30.00, 'No', 'Benoy Thomas', 'DC Books'),
(204, 'Randamuzham', 'Mythology', 35.00, 'Yes', 'M.T. Vasudevan Nair', 'DC Books'),
(205, 'Vayalar Kavithakal', 'Poetry', 15.00, 'Yes', 'Vayalar Ramavarma', 'Poorna Publications'),
(206, 'Pathummas goat', 'Satire', 22.00, 'No', 'Vaikom Muhammad Basheer', 'National Book Stall'),
(207, 'Happy Be Happy', 'Fiction', 28.00, 'Yes', 'O.V. Vijayan', 'Current Books'),
(208, 'History of Life', 'Religion', 18.00, 'Yes', 'Fr. Abel', 'DC Books'),
(209, 'The ABCs of Black History', 'Short Stories', 20.00, 'Yes', 'Rio Cortez', 'Sahitya Pravarthaka Sangam'),
(210, 'Tomorrow', 'Science Fiction', 25.00, 'Yes', 'Narayanan', 'Green Books');


-- create the customer table
create table Customer(
Customer_id int primary Key ,
Customer_name varchar(15),
Customer_Address varchar(25),
Reg_date datetime );

insert into Customer (Customer_id,Customer_name,Customer_Address,Reg_date)
values 
(101,'Manu','Cherthala','2017-08-09'),
(102,'Rahul','Malapuram','2017-09-10'),
(103,'Geetha','Alappuzha','2017-10-10'),
(104,'Gokul','Eranakulam','2017-12-10'),
(105,'Sanu','Kottayam','2017-12-11'),
 (106,'Ammu','Kottayam','2023-12-11'),
 (107,'Sethu','Kollam','2023-07-07');

-- Create the table issue status table.

Create table issuestatus (
Issue_id int primary Key,
issued_cust int,
Issued_book_Name varchar(100),
Issue_date date,
Isbn_book int,
foreign key (issued_cust) references customer(customer_id), 
foreign key (isbn_book) references Books(ISBN));

insert into issuestatus (Issue_id,issued_cust,Issued_book_Name,Issue_date,Isbn_book)
values 
( 01,101,'The ABCs of Black History','2017-12-10',209),
(02,105,'Vayalar Kavithakal','2017-10-10',205),
 (03,106,'Randamuzham','2023-06-11',204),
 (04,107,'History of Life','2023-07-06',208),
 ( 05,102,'Kunthalatha','2023-06-06',201);

-- create the return status table

create table ReturnStatus (
Return_id int primary key,
return_cust int,
return_book_name varchar(100),
Return_date date,
isbn_book2 int,
foreign key (isbn_book2) references Books(ISBN) );

insert into ReturnStatus (Return_id,return_cust,return_book_name,Return_date,isbn_book2)
Values 
( 01,101,'The ABCs of Black History','2017-12-10',209),
( 05,102,'Kunthalatha','2023-06-06',201);
 
 
 -- retrive the book title , category and rental price of all availabe books.
 
 
 select book_title,Category,rental_price 
 from  Books where status ='Yes';
 
 --  List the employee names and their respective salaries in descending order of salary.
 select Emp_name ,salary
 From Employee
 order by Salary Desc;
 
 -- Retrieve the book titles and the corresponding customers who have issued those books.
 
 select B.book_title,C.Customer_name
 from Books B
 Join IssueStatus i on B.ISBN = i.isbn_book
 Join Customer C on i.issued_cust = C.Customer_id;
 
 -- Display the total count of books in each category.
 
 Select Category, count(*) as Total_books
 from Books group by Category;
 
 --  Retrieve the employee names and their positions for the employees whose salaries are above Rs.50,000.
 
 select Emp_name,position 
 from Employee where Salary >50000;
 
 -- List the customer names who registered before 2022-01-01 and have not issued any books yet.
 
 select c.customer_name
 from customer C 
 left join issueStatus I on c.customer_id = i.Issued_cust
 where C.reg_date <'2022-01-01' and i.issue_id is null;
 
 -- Display the branch numbers and the total count of employees in each branch
 

 select branch_no, count(*) as total_Employees
 from Employee group by branch_no;
 
 -- Display the names of customers who have issued books in the month of June 2023.
 
 select distinct c.customer_name
 from Customer C
 join issuestatus i on C.Customer_id = i.Issued_cust
 where month(i.issue_date) = 6 and year(i.Issue_date) =2023;
 
--  Retrieve book_title from book table containing the word "History".

select book_title from Books where book_title like '%History%';

-- Retrieve the branch numbers along with the count of employees for branches having more than 5 employees.
select branch_no, Count(*) as Total_Employees 
from Employee 
Group by Branch_no Having count(*) >5;

-- . Retrieve the names of employees who manage branches and their respective branch addresses.

Select E.emp_name, B.Branch_address
from Employee E
join branch b on e.Emp_id =b.Manager_ID;

-- Display the names of customers who have issued books with a rental price higher than Rs. 25.

select distinct c.customer_name
from customer C
join issuestatus I on c.customer_id = i.Issued_cust
join Books B on i.Isbn_book = B.Isbn
where B.Rental_price >25;


