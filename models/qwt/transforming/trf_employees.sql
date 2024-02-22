{{
    config(
        materialized='table', schema='Transforming'
    )
}}
 
WITH Employee AS
(SELECT
EMPID, LASTNAME, FIRSTNAME, TITLE, HIREDATE, OFFICE, REPORTSTO, YEARSALARY
FROM {{ ref('stg_employee')}}
)
, Office AS
(
    SELECT office, officecity
    from {{ ref('stg_office')}}
)
, employeedetails AS
(
   
select e.EMPID, e.LASTNAME, e.FIRSTNAME, e.TITLE, e.HIREDATE, o.officecity,
 e1.LASTNAME||','||e1.FIRSTNAME as REPORTSTO, e.YEARSALARY
 from Employee e
JOIN Office o ON o.office = e.office
LEFT JOIN Employee e1 on e1.empid =e.REPORTSTO
 
)
select * from employeedetails order by 1