

CREATE TABLE Departments (
    dept_no varchar   NOT NULL,
    dept_name varchar   NOT NULL,
    CONSTRAINT pk_Departments PRIMARY KEY (
        dept_no
     )
);

CREATE TABLE employees (
    emp_no int   NOT NULL,
    birth_date date   NOT NULL,
    first_name varchar   NOT NULL,
    last_name varchar   NOT NULL,
    gender varchar   NOT NULL,
    hire_date date   NOT NULL,
    CONSTRAINT pk_employees PRIMARY KEY (
        emp_no
     )
);

CREATE TABLE dept_emp (
    emp_no int   NOT NULL,
    dept_no varchar   NOT NULL,
    from_date date   NOT NULL,
    to_date date   NOT NULL
);

CREATE TABLE dept_manager (
    dept_no varchar   NOT NULL,
    emp_no int   NOT NULL,
    from_date date   NOT NULL,
    to_date date   NOT NULL
);

CREATE TABLE salaries (
    emp_no int   NOT NULL,
    salary int   NOT NULL,
    from_date date   NOT NULL,
    to_date date   NOT NULL
);

CREATE TABLE titles (
    emp_no int   NOT NULL,
    title varchar   NOT NULL,
    from_date date   NOT NULL,
    to_date date   NOT NULL
);

ALTER TABLE dept_emp ADD CONSTRAINT fk_dept_emp_emp_no FOREIGN KEY(emp_no)
REFERENCES employees (emp_no);

ALTER TABLE dept_emp ADD CONSTRAINT fk_dept_emp_dept_no FOREIGN KEY(dept_no)
REFERENCES Departments (dept_no);

ALTER TABLE dept_manager ADD CONSTRAINT fk_dept_manager_dept_no FOREIGN KEY(dept_no)
REFERENCES Departments (dept_no);

ALTER TABLE dept_manager ADD CONSTRAINT fk_dept_manager_emp_no FOREIGN KEY(emp_no)
REFERENCES employees (emp_no);

ALTER TABLE salaries ADD CONSTRAINT fk_salaries_emp_no FOREIGN KEY(emp_no)
REFERENCES "employees" (emp_no);

ALTER TABLE titles ADD CONSTRAINT fk_titles_emp_no FOREIGN KEY(emp_no)
REFERENCES employees (emp_no);

-- 1. List the following details of each employee: employee number, last name, first name, gender, and salary.
select e.emp_no as "Employee Number", e.last_name as "Last Name", e.first_name as "First Name", e.gender as "Gender", s.salary as "Salary" 
from employees e
inner join salaries as s
on (e.emp_no = s.emp_no) limit 10

-- 2.List employees who were hired in 1986.
select first_name as "First Name", last_name as "Last Name", hire_date as "Hire Date" 
from employees 
where hire_date >= '1986-01-01' and hire_date < '1986-12-31'
order by "Hire Date" limit 12


-- 3.List the manager of each department with the following information: department number, department name, the 
-- manager's employee number, last name, first name, and start and end employment dates.

select dep.dept_no, dep.dept_name,depm.emp_no,e.last_name,e.first_name,depm.from_date,depm.to_date
from dept_manager depm
inner join employees e on (e.emp_no = depm.emp_no)
inner join "Departments" dep on (depm.dept_no = dep.dept_no)
limit 10

-- 4. List the department of each employee with the following information: employee number, last name, first name, and department name.

select e.emp_no as "Employee Number", e.last_name as "Last Name",e.first_name as "First Name", "Departments".dept_name as "Department"
from employees e
inner join dept_manager d on (d.emp_no = e.emp_no)
inner join "Departments" on ("Departments".dept_no = d.dept_no)
limit 10

-- 5. List all employees whose first name is "Hercules" and last names begin with "B."

select * from employees
where first_name = 'Hercules'
and
last_name like 'B%'
limit 10


-- 6. List all employees in the Sales department, including their employee number, last name, first name, and department name.
select e.emp_no as "Employee Number", e.last_name as "Last Name", e.first_name as "First Name", d.dept_name as "Department"
from employees e
inner join dept_manager  on (dept_manager.emp_no = e.emp_no)
inner join "Departments" d on (d.dept_no = d.dept_no)
where d.dept_name = 'Sales'
limit 10

-- 7. List all employees in the Sales and Development departments, including their employee number, last name, 
-- first name, and department name.
select e.emp_no as "Employee Number", e.last_name as "Last Name", e.first_name as "First Name", d.dept_name as "Department"
from employees e
inner join dept_manager  on (dept_manager.emp_no = e.emp_no)
inner join "Departments" d on (d.dept_no = d.dept_no)
where d.dept_name = 'Sales' or d.dept_name = 'Development'
limit 10


-- 8.In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.

select last_name as "Last Name", count(last_name) as "# Occurences" from employees
group by "Last Name"
order by "# Occurences" DESC
limit 10 

