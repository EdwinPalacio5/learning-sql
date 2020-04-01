---------------------------------------------------------------------------------------
----------------------- FUNCIONES DE UNA SOLA FILA ------------------------------------

--------------------------- FUNCIONES DE CARACTER -------------------------------------

-- funciones de caracter: lower, upper, initcap

--  FUNCION                     Resultado
------------------------------------------
--  LOWER(' Curso SQL ')        curso sql
--  INITCAP(' Curso SQL ')      Curso Sql
--  UPPER(' Curso SQL ')        CURSO SQL

--lower

Select lower(last_name) as "apellido en minuscula"
from employees
where lower(last_name) = 'higgins';

--upper

Select upper(last_name) as "apellido en mayuscula"
from employees
where upper(last_name) = 'HIGGINS';

--initcap

Select initcap(first_name || ' ' || last_name) 
    as "Nombre Completo con iniciales mayusculas"
from employees
where last_name = 'Higgins';

-- Funciones de Manipulación

--  FUNCION                             Resultado
--------------------------------------------------
--  CONCAT('Hello', 'World')            HelloWorld
--  TRIM('H' FROM 'HelloWorld')         elloWorld
--  SUBSTR('HelloWorld',1,5)            Hello 
--  LENGTH('HelloWorld')                10
--  INSTR('HelloWorld', 'W')            6
--  LPAD(salary,10,'*')                 *****24000
--  RPAD(salary, 10, '*')               24000*****
--  REPLACE('JACK and JUE','J','BL')    BLACK and BLUE

Select employee_id, concat(first_name, last_name) as name, job_id, 
    length(last_name), instr(last_name, 'a') as "Posición de a"
from employees
where substr(job_id,4) = 'REP';

-- Nota1: substr(job_id,4) solo se indica a apartir de cual caracter se desea cobtener
-- NOta2: instr(last_name, 'a') devolverá cero, si last_name no contiene a, y devolverá
--        la posición de la ultima a encontrada

------------------------- ANIDAMIENTO DE FUNCIONES ---------------------------------

Select substr(last_name,1,3) 
from employees
where department_id = 60;

Select concat(substr(last_name,1,3), '_US' )
from employees
where department_id = 60;

Select upper(concat(substr(last_name,1,3), '_US' )) 
from employees
where department_id = 60;
