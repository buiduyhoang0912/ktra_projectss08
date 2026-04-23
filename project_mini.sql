drop database if exists ktra;
create database ktra;
use ktra;

create table department(
    dept_id int primary key auto_increment not null,
    dept_name varchar(100) not null,
    location varchar(100)
);

create table employee(
    emp_id int primary key auto_increment not null,
    emp_name varchar(100) not null,
    gender int default 1,
    birth_date date not null,
    salary decimal (10,2) check ( salary >= 0 ),
    dept_id int not null,
    foreign key (dept_id) references department(dept_id) on update cascade
);

create table project(
    project_id int primary key auto_increment not null,
    project_name varchar(100) not null,
    emp_id int not null,
    foreign key (emp_id) references employee(emp_id),
    start_date date default(current_date),
    end_date date 
);

alter table employee 
add email varchar(100) not null;

alter table project 
modify column project_name varchar(200);

alter table project 
add constraint check_project_date check ( end_date >= start_date );

insert into department(dept_name, location) 
values 
    ('it', 'ha noi'),
    ('hr', 'hcm'),
    ('marketing', 'da nang');

insert into employee(emp_id, emp_name, gender, birth_date, salary, dept_id, email)
values
    (1, 'nguyen van a', 1, '1990-01-15', 1500, 1, 'a@gmail.com'),
    (2, 'tran thi b', 0, '1995-05-20', 1200, 1, 'b@gmail.com'),
    (3, 'le minh c', 1, '1988-10-10', 2000, 2, 'c@gmail.com'),
    (4, 'pham thi d', 0, '1992-12-05', 1800, 3, 'd@gmail.com');

insert into project (project_id, project_name, emp_id, start_date, end_date) 
values
    (101, 'website redesign', 1, '2024-01-01', '2024-06-01'),
    (102, 'recruitment system', 3, '2024-02-01', '2024-08-01'),
    (103, 'marketing campaign', 4, '2024-03-01', '2024-12-31'); 

update employee set salary = salary + 100 where dept_id = 1;

select emp_name, email,
    case 
        when gender = 1 then 'nam'
        when gender = 0 then 'nu'
        else 'khac'
    end as gender_name
from employee;

select
    upper(emp_name) as ho_ten, 
    (2026 - year(birth_date)) as tuoi 
from employee;

select e.emp_name, e.salary, d.dept_name
from employee e
inner join department d on e.dept_id = d.dept_id;

select * from employee
order by salary desc
limit 2;

select d.dept_name, count(e.emp_id) as so_luong
from department d
join employee e on d.dept_id = e.dept_id
group by d.dept_name
having count(e.emp_id) >= 2;

select * from employee
where salary > (select avg(salary) from employee);

select * from employee
where emp_id in (select emp_id from project);

select * from employee e1
where salary = (
    select max(salary) 
    from employee e2 
    where e2.dept_id = e1.dept_id
);