-----------------------------------------------------------------------------------------------------
---------------------- Mostrar datos de múltiples tablas usando Joins -------------------------------
-----------------------------------------------------------------------------------------------------

------------------------------------- Tipos de Join -------------------------------------------------
-- Los Join son compatibles con SQL: El Estandar 1999 incluye los siguientes

-- Join                 Clausula
-- Natural Join         NATURAL JOIN
-- JOIN                 JOIN USING
-- JOIN                 JOIN ON
-- Outer joins          LEFT OUTER JOIN, RIGHT OUTER JOIN y FULL OUTER JOIN
-- Cross Join           CROSS JOIN

-- Sintaxis

-- Select   table1.column, table2.column
-- From     table1
-- [NATURAL JOIN table2]   |
-- [JOIN table2 USING (column_name)]    |
-- [JOIN table2 ON    (table1.column = table2.column)]  |
-- [LEFT|RIGHT|FULL OUTER JOIN table2 ON (table1.column = table2.column)]   |
-- [CROSS JOIN table2];

-- NATURAL JOIN
-- Se basa en todas las columnas de las dos tablas que tienen el mismo nombre, seleccionando las filas
-- de las dos tablas que tienen valores iguales en todas las columnas coincidentes. 
-- Nota: Si las columnas que tienen los mismos nombre son de diferente tipo, se devuelve un error. 

Select employee_id, last_name, department_id, department_name
From employees
    Natural Join departments;

-- USING
-- Para especificar las columnas con las que se desea hacer la unión

Select employee_id, last_name, department_id, department_name
From employees
    Join departments using (department_id);

-- Nota: No cualificar una columna que se utiliza en la clausula USING. Si se quiere utilizar una 
--       columna cualificada no se debe ocupar el alias. 

Select l.city, d.department_name
From  locations l
    Join departments d using (location_id)
where location_id = 1400;

-- Nota: la columna cualificada no tendrá alias ni en el where, ni el select ni ninguna otra parte

Select e.employee_id, e.last_name, department_id, d.department_name
From employees e
    Join departments d using (department_id)
Where department_id = 30;

-- ON
-- Sirve para especificar las condiciones arbitrarias o especificar columnas a unirse

Select e.employee_id, e.last_name, e.department_id , d.department_id, d.department_name
From employees e
    Join departments d
    On (e.department_id = d.department_id);

-- Si deseamos añadir condiciones se podría mediante AND o WHERE. Ambas devuelven el mismo resultado,
-- pero en terminos de performance es recomendable AND.
    
Select e.employee_id, e.last_name, e.department_id , d.department_id, d.department_name
From employees e
    Join departments d
    On (e.department_id = d.department_id)
    And e.department_id=30
    And e.salary > 10000;
    
Select e.employee_id, e.last_name, e.department_id , d.department_id, d.department_name
From employees e
    Join departments d
    On (e.department_id = d.department_id)
    Where e.department_id=30 and e.salary > 10000;
    
-- Al realizar en varias tablas

Select  e.last_name, d.department_name, l.city
From employees e
    Join departments d
    On (e.department_id = d.department_id)
    
    Join locations l
    On (l.location_id = d.location_id);
    
-- SELF JOIN

-- No es una clausula más, más bien, es el hecho de hacer join con la misma tabla. Por ejemplo:

Select empleado.last_name, jefe.last_name
From employees empleado
    Join employees jefe
    On (empleado.manager_id = jefe.employee_id);

-- Nonequijoins

-- En este caso la unión de tablas no corresponge a llaves primarias con llaves foraneas, sino en base a 
-- otros criterios, como por ejemplo:

-- Select e.last_name, e.salary, j.grade_level
-- From employees e
--    Join job_grades j
--    On (e.salary BETWEEN j.lowest_sal and j.highest_sal);

-- Outer Join

-- LEFT OUTER JOIN

-- Una combinación entre dos tablas que devuelve los resultados de la INNER join así como las filas 
-- no coincidentes de la izquierda 

Select e.last_name, d.department_name
From employees e
    Left outer Join departments d
    On (e.department_id = d.department_id);
    
    -- Nota: En este caso se mostrara el Inner Join y además los empleados que no estan asignados
    --       a un departamento

-- RIGHT OUTER JOIN

-- Una combinación entre dos tablas que devuelve los resultados de la INNER join así como las filas 
-- no coincidentes de la derecha

Select e.last_name, d.department_name
From employees e
    Right outer Join departments d
    On (e.department_id = d.department_id);
    
    -- Nota: En este caso se mostrara el Inner Join y además los departamentos que no tienen asignado
    --       ningún empleado

-- FULL OUTER JOIN

-- Una combinación entre dos tablas que devuelve los resultados de la INNER join así como las filas 
-- no coincidentes de la izquierda y de la derecha.

Select e.last_name, d.department_name
From employees e
    Full outer Join departments d
    On (e.department_id = d.department_id);
    
    -- Nota: En este caso se mostrara el Inner Join y además los departamentos que no tienen asignado
    --       ningún empleado y los empleados que no estan asignados a un departamento
    
-- CROSS JOIN 

-- Produce el producto cruz o producto cartesiano entre dos tablas

Select e.last_name, d.department_name
From employees e
    Cross Join departments d;
    
    -- Lo que es similar a hacer: 
    
Select e.last_name, d.department_name
From employees e, departments d;




