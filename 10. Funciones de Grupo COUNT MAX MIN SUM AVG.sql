-----------------------------------------------------------------------------------------------
----------------- Informes de datos agregados utilizando las funciones de grupo ---------------
-----------------------------------------------------------------------------------------------

-- Operan en un conjunto de filas para devolver un solo resultado por grupo

-- AVG : Devuelve el Promedio
-- COUNT : Cuenta los registros
-- MAX : Devuelve el máximo
-- MIN : Devuelve el mínimo
-- SUM : Devuelve la suma

Select AVG(salary), MAX(salary), MIN(salary), COUNT(salary), SUM(salary)
from employees
where job_id like '%REP%';

--Uso de MIN y MAX en fecha

Select MIN(hire_date), MAX(hire_date)
from employees;

-Count (*) devuelve el número de filas de una tabla

Select count(*)
from employees;

--Count (columna(s)) devuelve el número de filas con valores no nulos

Select count(commission_pct)
from employees;

-- Count(Distinct expresion): devuelve el número de distintos valores no nulos de expresión

Select count(distinct department_id)
from employees;

-- AVG 
--Importante: al  promediar es vital considerar los siguientes aspectos

-- Las funciones de grupo ignoran los valores nulos en la columna

Select avg(commission_pct)
from employees;

-- Resultado: 0.22285

-- Forzando el uso de datos nulos en las funciones de grupo utilizando la función NVL para incluir nulos:
-- (recordar que NVL remmplaza el valor del primer parametro por el segundo, si al caso este es nulo)
Select avg(nvl(commission_pct,0))
from employees;

-- Resultado: 0.07289


