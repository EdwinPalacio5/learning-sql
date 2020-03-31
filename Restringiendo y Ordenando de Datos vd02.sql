-- -------------------------------------------------------------------------------
-- ------------------------ RESTRINGIENDO Y ORDENANDO DATOS ----------------------

-- -------------------------------- WHERE ----------------------------------------
-- Where: permite agregar una condición, para que solo sean devueltas las 
-- filas que cumplen dicha condición
-- Nota: en textos se debe buscar con comillas: 'texto', 
-- en fecha es formato DD-MM-AA

Select employee_id, last_name, job_id, department_id
from employees
WHERE last_name = 'Whalen';

Select employee_id, last_name, hire_date
from employees
WHERE hire_date = '17-JUN-03';

-- --------------------------------- OPERADORES ----------------------------------
-- =    : Igual que
-- >    : Mayor que
-- >=   : Mayor o igual que
-- <    : Menor que 
-- <=   : Menor o igual que
-- <>   : No igual que
-- BETWEEN ... AND ...  : Entre dos valores (ambos inclusive)
-- IN(SET)  : Conincidir con cualquiera de los elementos que se pasan por parametro
-- LIKE     : Coincider con el modelo de carácter
-- IS NULL  : Es un valo nulo

-- usando el operado 'menor que' se consultan los empleados que poseen salarios 
-- menores a 3000
Select last_name, salary
from employees
where salary <3000;

-- usando el operador de 'between' se consulta los empleados que se su salario se
-- encuentra en el rango especificado
-- Nota: para negar es NOT BETWEEN
Select last_name, salary
from employees
where salary between 1000 and 2500;

-- usando el operador 'in' se consultan los empleados cuyo manager_id conincida con
-- algunos de los valores especificados
-- Nota: para negar es NOT IN
Select last_name, manager_id
from employees
where manager_id in (100,101);

-- usando el operador 'like' se consultan los empleados cuyo job_id contenga en su
-- segundo caracter un I, y que adelante poseea cero o más carácteres.
Select last_name, job_id 
from employees
where job_id like '_I%';

-- usando el operador 'is null' se consultan los empleador cuyo manager_id es nulo
-- Nota: para negar es IS NOT NULL
Select last_name, manager_id
from employees
where manager_id is null;

--------------------- Operadores condicionales AND, OR, NOT ------------------------ 
-- usando el operador 'not' se consultan los empleador cuyo manager_id no son nulo
Select last_name, manager_id
from employees
where manager_id is not null;

select employee_id, last_name, job_id, salary
from employees
WHERE salary >= 10000
AND job_id LIKE '%K%';

select last_name, job_id, salary
from employees
WHERE salary >= 10000
OR job_id LIKE '%K%';

----------------------------------------------------------------------------------
----------------------------OPERADOR ORDER BY-------------------------------------

-- ordena según el campo que se indique, por ejemplo: se ordenan por la fecha en que
-- se contrataron.
-- Nota:
-- ASC: por defecto order by los ordena de manera ascendente, 
-- DESC: si se desea ordenar de manera descendente
-- # de columna en el select: si se coloca 'oder by 1', los registros se ordenaran 
-- de acuerdo a la columna 1

Select last_name, hire_date
from employees
order by hire_date;

Select last_name, hire_date
from employees
order by hire_date desc;

Select last_name,hire_date
from employees
order by 1;

----------------------------------------------------------------------------------
----------------------------VARIABLES DE SUSTITUCION -----------------------------

-- Se utilizan para almacenar temporalmente los valores de sustitución con un solo
-- signo ampersand (&) y el doble ampersand (&&)

-- Se utilizan como complemento de:
-- Condiciones where
-- Clausulas Order by
-- expresiones de columna
-- nombres de tabla
-- sentencias enteras select

-- Ejemplo 1: (un solo ampersand) la siguiente consulta se emplea &employeed_num, esto permitirá que se
-- se despliegue una ventana para solicitar esa variable.

Select employee_id, last_name
from employees
where employee_id = &employeed_num;

Select employee_id, last_name
from employees
where last_name LIKE '%&last_name_sustitucion%';

-- Ejemplo 2: (dos ampersand) se consultan los registros de la tabla employees, y 
-- mediante la variable &&column_name se despliega una sola vez la ventana para 
-- solicitar el valor de esa variable y se ocupa tanto para seleccionar la columna 
-- en el select y hacer el ordenamiento mediante esa columna

Select employee_id, last_name, &&column_name
from employees
order by &column_name;

----------------------------------------------------------------------------------
----------------------------DEFINE , UNDEFINE ------------------------------------
define employee_define = 100

Select employee_id, last_name
from employees
where employee_id = &employee_define;

undefine employee_define

----------------------------------------------------------------------------------
------------------------------ SET VERIFY ON  ------------------------------------
-- Muestra la sonsulta antes y después de hacer el cambio de variable

--Por ejemplo: 

SET VERIFY ON

Select employee_id, last_name
from employees
where employee_id = &id;

--Resultado

--Antiguo:Select employee_id, last_name
--from employees
--where employee_id = &id
--Nuevo:Select employee_id, last_name
--from employees
--where employee_id = 102

--EMPLOYEE_ID LAST_NAME                
------------- -------------------------
--        102 De Haan 








