-----------------------------------------------------------------------------------------------------
--------------------------------------- Uso de subconsultas -----------------------------------------
-----------------------------------------------------------------------------------------------------

-- Ejemplo: MOstrar los empleados que tienen un salario mayor al de Abel

-- Paso 1: Consultamos el salario de Abel 
Select salary
From employees
Where last_name='Abel';

--Paso 2: Utilizar subconsulta 

Select last_name as "Emp con mayor sal ", salary
From employees
Where salary >  (Select salary
                From employees
                Where last_name='Abel');

-- Tipos de SubConsulta

-- Subconsulta de una sola fila
-- Se utilizan los operadores: =, <> , > , < , >= , <=

Select last_name as "Empleados con salario min", salary
From employees
Where salary = (Select min(salary)
                From employees);

-- Primero se hace la subconsulta y despues la consulta mayor

Select department_id, min(salary)
From employees
Group by department_id
Having min(salary) > (Select min(salary)
                      From employees
                      Where department_id = 50);
                      
-- Subconsulta de multiples filas

-- Al obtener más de una fila, se utilizan los siguientes operadores

-- Operador     Significado
-- IN           Igual a cualquier miembro de la lista
-- ANY          Debe ir precedido de =,! =,>, <, <=,> =. Devuelve TRUE si existe al menos un elemento
--              en el conjunto de resultados de la subconsulta para que la relación sea TRUE.
-- ALL          Debe ir precedido de =,! =,>, <, <=,> =. Devuelve TRUE si la relación es cierto para 
--              todos los elementos en el conjunto de resultados de la subconsulta

-- IN
-- Devuelve los empleados cuyo salario sea IGUAL A CUALQUIERA de los devueltos en la subconsulta

Select  last_name, job_id, salary
From    employees
Where   salary In (Select salary
                      From   employees
                      Where job_id = 'IT_PROG');

-- ANY
-- Devuelve los empleados cuyo salario sea menor a CUALQUIERA de los devueltos en la subconsulta

Select  last_name, job_id, salary
From    employees
Where   salary < Any (Select salary
                      From   employees
                      Where job_id = 'IT_PROG');
                      
-- Nota: La diferencia más marcada entre Any e In, es que con Any se pueden utilizar no solo =, sino
--       todos los demás operadores de <> , > , < , >= , <=
                      
-- ALL
-- Devuelve los empleados cuyo salario sea menor a TODOS de los devueltos en la subconsulta

Select  last_name, job_id, salary
From    employees
Where   salary < All (Select salary
                      From   employees
                      Where job_id = 'IT_PROG');
                      
-- Operador Exists, Not Exists

-- Devuelve true, si la subconsulta devuelve al menos un resultado


Select *
From departments
Where not exists (Select * 
                  From employees
                  Where employees.department_id = departments.department_id);
                  
-- Importante: Valores Nulos

-- Si uno de los valores es nulo, la subconsulta no retornara ninguna fila, por lo que se debe tener
-- especial cuidado en esto

-- En este caso consultamos todos aquellos empleados que no son manager

Select last_name
From employees 
Where employee_id NOT IN (Select manager_id
                          From employees 
                          where manager_id is not null);
Select * From employees;
                                 
-- Duda: Al quitar el not, no es necesario hacer la validación, por qué?

                                   


                      






