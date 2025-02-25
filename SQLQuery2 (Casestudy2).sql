create database SQLcase_study_2
use SQLcase_study_2

CREATE TABLE LOCATION (
Location_ID INT PRIMARY KEY,
City VARCHAR(50))

INSERT INTO LOCATION (Location_ID, City)
VALUES 
(122, 'New York'),
(123, 'Dallas'),
(124, 'Chicago'),
(167, 'Boston');

select * from location

--00000000000000000000000000000000000000000000000000000000000000000000000000000

CREATE TABLE DEPARTMENT (
Department_Id INT PRIMARY KEY,
Name VARCHAR(50),
Location_Id INT,
FOREIGN KEY (Location_Id) REFERENCES LOCATION(Location_ID))

INSERT INTO DEPARTMENT (Department_Id, Name, Location_Id)
VALUES
(10, 'Accounting', 122),
(20, 'Sales', 124),
(30, 'Research', 123),
(40, 'Operations', 167)
select * from Department

--00000000000000000000000000000000000000000000000000000000000000000000000000000000

CREATE TABLE JOB
(JOB_ID INT PRIMARY KEY,
DESIGNATION VARCHAR(20))

INSERT  INTO JOB VALUES
(667, 'CLERK'),
(668,'STAFF'),
(669,'ANALYST'),
(670,'SALES_PERSON'),
(671,'MANAGER'),
(672, 'PRESIDENT')
select * from Job

--000000000000000000000000000000000000000000000000000000000000000000000000000000

CREATE TABLE EMPLOYEE
(EMPLOYEE_ID INT,
LAST_NAME VARCHAR(20),
FIRST_NAME VARCHAR(20),
MIDDLE_NAME CHAR(1),
JOB_ID INT FOREIGN KEY
REFERENCES JOB(JOB_ID),
MANAGER_ID INT,
HIRE_DATE DATE,
SALARY INT,
COMM INT,
DEPARTMENT_ID  INT FOREIGN KEY
REFERENCES DEPARTMENT(DEPARTMENT_ID))

INSERT INTO EMPLOYEE VALUES
(7369,'SMITH','JOHN','Q',667,7902,'17-DEC-84',800,NULL,20),
(7499,'ALLEN','KEVIN','J',670,7698,'20-FEB-84',1600,300,30),
(7505,'DOYLE','JEAN','K',671,7839,'04-APR-85',2850,NULl,30),
(7506,'DENNIS','LYNN','S',671,7839,'15-MAY-85',2750,NULL,30),
(7507,'BAKER','LESLIE','D',671,7839,'10-JUN-85',2200,NULL,40),
(7521,'WARK','CYNTHIA','D',670,7698,'22-FEB-85',1250,500,30)
select * from Employee

--00000000000000000000000000000000000000000000000000000000000000000000000000000000000
                            -- SIMPLE QUERIES: --

-- 1- List all the employee details
Select * from EMPLOYEE

-- 2- List all the department details.
Select * from DEPARTMENT

-- 3- List all job details.
Select * from JOB

-- 4-  List all the locations.
Select * from Location

-- 5- List out the First Name, Last Name, Salary, Commission for all Employees.
Select first_name, last_name, Salary, Comm from Employee

-- 6- List out the Employee ID, Last Name, Department ID for all employees and 
    -- alias
    -- Employee ID as "ID of the Employee", Last Name as "Name of the
    -- Employee", Department ID as "Dep_id
select Employee_ID as 'ID_of_the_Employee',
       Last_name as 'Name_of_the_Employee',
	   Department_ID as 'Dep_id' 
from employee

-- 7- List out the annual salary of the employees with their names only.
Select CONCAT(First_name, ' ', Last_name) as Name,
Salary 
from Employee

                              -- WHERE CONDITIONS --

-- 1- List the details about "Smith".
Select * from employee 
where last_name = 'Smith'

-- 2- List out the employees who are working in department 20.
Select * from Employee
where Department_ID = 20

-- 3- List out the employees who are earning salary between 2000 and 3000.
Select * from employee
where salary between 2000 and 3000

-- 4-  List out the employees who are working in department 10 or 20.
select * 
FROM employee 
WHERE department_id = 10 
OR department_id = 20

-- 5- Find out the employees who are not working in department 10 or 30
select * 
FROM employee 
WHERE department_id != 10 
and department_id != 30

-- 6- List out the employees whose name starts with 'L'
select * from employee
where first_name like 'l%'

-- 7-  List out the employees whose name starts with 'L' and ends with 'E'.
Select * from employee
where first_name like 'L%E'

-- 8- List out the employees whose name length is 4 and start with 'J'.
Select * from employee
where first_name like 'J___'

-- 9- List out the employees who are working in department 30 and draw the salaries more than 2500.
Select * from employee
where department_id = 30
AND salary > 2500

-- 10-  List out the employees who are not receiving commission.
Select * from employee
where COMM is NULL

                                       -- ORDER BY Clause:--

-- 1-  List out the Employee ID and Last Name in ascending order based on the Employee ID.
select Employee_ID, Last_name from employee
order by Employee_ID asc

-- 2- List out the Employee ID and Name in descending order based on salary.
select Employee_ID, First_name, Last_name from employee
order by salary desc

-- 3- List out the employee details according to their Last Name in ascending-order.
Select * from employee 
order by last_name asc

-- 4-  List out the employee details according to their Last Name in ascending order and then Department ID in descending order.
Select * from employee 
order by Last_name asc,
Department_ID desc

                                         -- GROUP BY and HAVING Clause: --

-- 1- List out the department wise maximum salary, minimum salary and average salary of the employees
Select department_id,
max(SALARY) as maximum_salary,
min(SALARY) as minimum_salary,
avg(SALARY) as average_salary
from employee
group by department_id

-- 2- List out the job wise maximum salary, minimum salary and average salary of the employees.
Select Job_id,
max(SALARY) as maximum_salary,
min(SALARY) as minimum_salary,
avg(SALARY) as average_salary
from employee
group by job_id

-- 3- List out the number of employees who joined each month in ascending order.
SELECT 
DATEPART(MONTH, HIRE_DATE) AS Join_Month,
COUNT(*) AS Num_of_Employees
FROM EMPLOYEE
GROUP BY DATEPART(MONTH, HIRE_DATE)
ORDER BY DATEPART(MONTH, HIRE_DATE)

-- 4- List out the number of employees for each month and year in ascending order based on the year and month.
select Year(Hire_date) as Year,
Month(Hire_date) as month,
count(*) as num_of_employee_joined
from employee
group by Year(Hire_date),
Month(Hire_date)
order by Year, Month

-- 5- List out the Department ID having at least four employees.
SELECT DEPARTMENT_ID, COUNT(*) AS Num_of_Employees
FROM EMPLOYEE
GROUP BY DEPARTMENT_ID
HAVING COUNT(*) >= 4

-- 6- How many employees joined in February month.
SELECT COUNT(*) AS Num_of_Employees
FROM EMPLOYEE
WHERE MONTH(HIRE_DATE) = 2

-- 7- How many employees joined in May or June month.
select MONTH(HIRE_DATE) as hire_month, count(*) as num_of_Employees_joined_5_6
from employee
where MONTH(HIRE_DATE) in (5,6)
group by MONTH(HIRE_DATE)

-- 8- How many employees joined in 1985.
select Year(HIRE_DATE) as hire_year, count(*) as num_of_employee_joined_in_1985
from employee
where Year(HIRE_DATE) = 1985
group by Year(HIRE_DATE)
order by Year(HIRE_DATE)

select * from employee

-- 9 -How many employees joined each month in 1985.
Select MONTH(Hire_date) as month_in_Year_1985 , count(*) as num_of_employee_joined
from employee
where Year(Hire_date) = 1985
group by Month(Hire_date)

-- 10- How many employees were joined in April 1985?
select count(*) as num_of_employee_joined
from employee
where Year(Hire_date) = 1985 and
Month(Hire_date) = 4
group by Year(Hire_date), Month(Hire_date)

-- 11- Which is the Department ID having greater than or equal to 3 employees joining in April 1985?
select Department_ID, count(*) as num_of_employee_joined
from employee
where Year(Hire_date) = 1985 and
Month(Hire_date) = 4
group by Department_ID
Having count(*)>= 3

                                      --- Joins: ---

-- 1-List out employees with their department names.
Select top 1 * from EMPLOYEE
Select top 1 * from DEPARTMENT
Select top 1 * from JOB
Select top 1 * from LOCATION

Select E.* ,
D.NAME AS Department_name from Employee as E
Join Department as D
ON E.Department_ID = D.Department_ID

-- 2- Display employees with their designations.
Select E.*,
J.Designation as Designation
from Employee as E
Inner Join
Job as J
on
E.JOB_ID = J.JOB_ID

-- 3- Display the employees with their department names and city.
Select E.*,
D.Name as Department_Name,
L.City as City_name
From Employee as E
Join Department as D on
E.Department_ID = D.Department_ID
Inner Join Location as L on
D.Location_ID = L.Location_ID

--4-  How many employees are working in different departments? Display with department names.
Select D.Name as Department,
count(E.Employee_ID) as No_of_employees
from DEPARTMENT as D
 JOIN 
Employee as E on
D.Department_ID = E.Department_ID 
group by D.Name

-- 5- How many employees are working in the sales department
Select count(*) AS NumberOfEmployees
FROM employee as e
JOIN department as d 
ON e.DEPARTMENT_ID = d.Department_Id
WHERE d.Name = 'Sales'


-- 6- . Which is the department having greater than or equal to 3 employees and display the department names inascending order.

Select d.Name AS Department_Name, 
Count(e.employee_ID) AS Number_Of_Employees
FROM DEPARTMENT d
JOIN employee e ON d.Department_Id = e.DEPARTMENT_ID
GROUP BY d.Name
HAVING COUNT(e.EMPLOYEE_ID) >= 3
ORDER BY d.Name

-- 7- How many employees are working in 'Dallas'?
SELECT COUNT(*) AS NumberOfEmployees, 
l.City
FROM EMPLOYEE as e
JOIN DEPARTMENT as d ON e.DEPARTMENT_ID = d.Department_Id
JOIN LOCATION as l ON d.Location_Id = l.Location_ID
WHERE l.City = 'Dallas'
group by L.city

-- 8- Display all employees in sales or operation departments.
Select E.*, D.Name AS Department_Name
FROM EMPLOYEE as E
JOIN DEPARTMENT as D ON E.DEPARTMENT_ID = D.Department_Id
WHERE D.Name IN ('Sales', 'Operations')

--========================================================================================
--=========================================================================================

                                                                 CONDITIONAL STATEMENT--1- Display the employee details with salary grades. Use conditional statement to create a grade column.

SELECT 
e.EMPLOYEE_ID,
e.LAST_NAME,
e.FIRST_NAME,
e.MIDDLE_NAME,
e.JOB_ID,
e.MANAGER_ID,
e.HIRE_DATE,
e.SALARY,
e.COMM,
e.DEPARTMENT_ID, d.NAME AS DEPARTMENT_NAME,
l.CITY AS LOCATION_CITY,
j.DESIGNATION,
    CASE
        WHEN e.SALARY < 1500 THEN 'Grade C'
        WHEN e.SALARY BETWEEN 1500 AND 2500 THEN 'Grade B'
        ELSE 'Grade A'
    END AS SALARY_GRADE
FROM 
    Employee e
JOIN 
    Department d ON e.DEPARTMENT_ID = d.DEPARTMENT_ID
JOIN 
    Job j ON e.JOB_ID = j.JOB_ID
JOIN 
    Location l ON d.LOCATION_ID = l.LOCATION_ID;


--=============================================================================================
--que-2 - List out the number of employees grade wise. Use conditional statement to create a grade column.
SELECT 
    CASE
        WHEN SALARY < 1500 THEN 'Grade C'
        WHEN SALARY BETWEEN 1500 AND 2500 THEN 'Grade B'
        ELSE 'Grade A'
    END AS SALARY_GRADE,
    COUNT(*) AS NUMBER_OF_EMPLOYEES
FROM 
    Employee
GROUP BY 
    CASE
        WHEN SALARY < 1500 THEN 'Grade C'
        WHEN SALARY BETWEEN 1500 AND 2500 THEN 'Grade B'
        ELSE 'Grade A'
    END;

---========================================================================================================

--que--3- Display the employee salary grades and the number of employees between 2000 to 5000 range of salary.
SELECT 
    CASE
        WHEN SALARY < 2500 THEN 'Grade B'
        ELSE 'Grade A'
    END AS SALARY_GRADE,
    COUNT(*) AS NUMBER_OF_EMPLOYEES
FROM 
    Employee
WHERE 
    SALARY BETWEEN 2000 AND 5000
GROUP BY 
    CASE
        WHEN SALARY < 2500 THEN 'Grade B'
        ELSE 'Grade A'
    END;

--==================================================================================================
-===================================================================================================

                                                 Subqueries:
--1-- 1. Display the employees list who got the maximum salary.SELECT 
EMPLOYEE_ID,
LAST_NAME,
FIRST_NAME,
MIDDLE_NAME,
JOB_ID,
MANAGER_ID,
HIRE_DATE,
SALARY,
COMM,
DEPARTMENT_ID
FROM 
    Employee
WHERE 
    SALARY = (SELECT MAX(SALARY) FROM Employee)

-========================================================================================================

-2----  Display the employees who are working in the sales department.
SELECT * FROM 
Employee
WHERE 
    DEPARTMENT_ID = (
        SELECT DEPARTMENT_ID
        FROM Department
        WHERE NAME = 'Sales'
		);

--========================================================================================================

-3--- 3. Display the employees who are working as 'Clerk'.SELECT *FROM 
Employee
WHERE 
    JOB_ID = (
        SELECT JOB_ID
        FROM Job
        WHERE DESIGNATION = 'CLERK'
		);

--=========================================================================================================

--4--Display the list of employees who are living in 'Boston'.SELECT * FROM Employee e
JOIN 
Department d ON e.DEPARTMENT_ID = d.DEPARTMENT_ID
JOIN 
Location l ON d.LOCATION_ID = l.LOCATION_ID
WHERE l.CITY = 'Boston'-==========================================================================================================--5-- Find out the number of employees working in the sales department.SELECT 
    COUNT(*) AS Number_of_Employees
FROM 
    Employee
WHERE 
    DEPARTMENT_ID = (
        SELECT DEPARTMENT_ID
        FROM Department
        WHERE NAME = 'Sales'
    );

-==========================================================================================================
--6- Update the salaries of employees who are working as clerks on the basis of 10%.
UPDATE Employee
SET SALARY = SALARY * 1.10
WHERE JOB_ID = (
    SELECT JOB_ID
    FROM Job
    WHERE DESIGNATION = 'CLERK'
);
-===========================================================================================================

--7- 7. Display the second highest salary drawing employee details.SELECT * FROM 
Employee
WHERE 
    SALARY = (
        SELECT MAX(SALARY)
        FROM Employee
        WHERE SALARY < (
            SELECT MAX(SALARY)
            FROM Employee
        )
    );
-===========================================================================================================--8-- List out the employees who earn more than every employee in department 30.SELECT * FROM  Employee
WHERE 
    SALARY > (
        SELECT MAX(SALARY)
        FROM Employee
        WHERE DEPARTMENT_ID = 30
    );---======================================================================================================--9--Find out which department has no employees.SELECT 
d.DEPARTMENT_ID,
d.NAME AS DEPARTMENT_NAME,
d.LOCATION_ID
FROM 
Department d
LEFT JOIN 
Employee e ON d.DEPARTMENT_ID = e.DEPARTMENT_ID
WHERE 
e.EMPLOYEE_ID IS NULL

--=============================================================================================

--10- Find out the employees who earn greater than the average salary for their department.
SELECT * FROM Employee e
JOIN 
    (
        SELECT 
            DEPARTMENT_ID,
            AVG(SALARY) AS AVG_SALARY
        FROM 
            Employee
        GROUP BY 
            DEPARTMENT_ID
    ) avg_salary_per_dept
ON 
    e.DEPARTMENT_ID = avg_salary_per_dept.DEPARTMENT_ID
WHERE 
    e.SALARY > avg_salary_per_dept.AVG_SALARY;


--==========================================================================================
-============================================================================================
-=============================================================================================