---------------------------------- SubConsulta -----------------------------------------------

-- Subsonsutas Escalares

-- Es una subconsulta que devuelve exactamente un valor de columna de una fila

 -- Subconsultas Par

Select  employee_id, manager_id, department_id
From    employees
Where   (manager_id, department_id) IN (Select manager_id, department_id
                                        From employees
                                        Where first_name = 'John')
    And first_name <> 'John'
    order by employee_id;

 -- Subconsulta no par    
                                        
Select  employee_id, first_name, manager_id, department_id
From    employees
Where   (manager_id) IN (Select manager_id
                                        From employees
                                        Where first_name = 'John')
    And (department_id) IN (Select department_id
                                        From employees
                                        Where first_name = 'John')
    And first_name <> 'John'
    order by employee_id;
    
    
-- Sub consulta en CASE

Select employee_id, first_name,
    (case 
        when  department_id = (Select department_id
                                From departments
                                Where location_id = 1800) 
            then 'Canada'
        else 'USA'
    end) as "location"
From employees;

 -- Subconsultas en Order by
Select  employee_id, last_name
From    employees e
order by (Select department_name
            From departments d
            Where e.department_id = d.department_id);
            
-- Subconsultas Correlacionadas

-- Subconsultas correlacionadas se utilizan para el procesamiento de fila por fila. Cada subconsulta se ejecuta una vez por cada fila de la columna externa

-- en este ejemplo, por cada fila se hace la consulta del salario promedio de su departamento, para así hacer la respectiva evaluación
-- Es decir, que cada vez que una fila de la consulta externa se procesa, se evalúa la consulta interna

Select last_name, salary, department_id
From    employees tabla_externa
Where   salary > (Select AVG(salary)
                    From    employees tabla_interna
                    Where   tabla_interna.department_id = tabla_externa.department_id);
                    
-- Operador Exists

-- Prueba la existencia de filas en el conjunto de resultados de la subconsulta

-- Si un vslor de la fila de la subconsulta se encuentra:
--      - La busqueda no se continúa en la consulta interna
--      - La condición se encuentra en valor VERDADERO

-- Si un vslor de la fila de la subconsulta NO se encuentra:
--      - La busqueda se continúa en la consulta interna
--      - La condición se encuentra en valor FALSO

-- Consultar empleados que son manager

Select employee_id, last_name, job_id, department_id
From    employees tabla_externa
Where   EXISTS ( Select 'X'
                From    employees tabla_interna
                Where   tabla_interna.manager_id = tabla_externa.employee_id);

-- Operador Not Exists

-- departamentos que no tienen empleados

Select department_id, department_name
From    departments tabla_externa
Where NOT EXISTS (Select 'X'
                    From employees tabla_interna
                    Where tabla_interna.department_id = tabla_externa.department_id); 
                    
-- Clausula WITH

-- El uso de cláusula WITH, puede usar el mismo bloque de consulta en una sentencia SELECT cuando se presenta más de una vez dentro de una consulta compleja

-- La cláusula WITH recupera los resultados de un bloque de consulta y lo almacena en tablas temporales del usuario

-- la cláusula WITH puede mejorar el rendimiento

-- Divide y venceras

-- En la siguiente consulta
-- Costo_departamento:  suma de salario por departamento
-- costo promedio: salario promedio de los totales de departamento
-- El el select se muestran aquellos departamentos cuya suma de salarios sea mayor al promedio

With

costo_departamento As (Select d.department_name, SUM(e.salary) as total_dep
                        From employees e 
                        Join departments d
                        On (e.department_id = d.department_id)
                        group by d.department_name),

costo_promedio     As (Select (SUM(total_dep)/ COUNT(*)) as promedio_dep  
                        From costo_departamento)

Select *
From costo_departamento
Where total_dep > (Select promedio_dep
                            From costo_promedio)
Order By department_name;

-- WITH Recursiva

-- permite la formulación de consultas recursivas
-- crea una consulta con un nombre, llamado el WITH nombre del elemento recursivo
-- Continene dos tipos de miembros de bloque de consulta: un ancla y un recursivo
-- Es compatible con ANSI

