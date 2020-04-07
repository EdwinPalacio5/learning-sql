-------------------------- Group by en Funciones de Grupo ----------------------------------------

-- Es importante aclarar que los group by es una solución para cuando se quieren agregar columnas,
-- que no son de agregación (que no son el resultado de un conjunto como las funciones de grupo)

--  En el presente caso se obtiene el salario promedio por departamento, al agregar department_id,
-- este se agrega en el group by. Si no se agrega será tratado como un error

Select department_id, AVG(salary)
from employees
group by department_id
order by department_id;

-- Importante: Al agregar más de alguna columna en el select, estas deben ser agregadas también en 
-- el group by
Select  department_id, job_id, SUM(salary)
from employees
group by department_id, job_id
order by department_id;



