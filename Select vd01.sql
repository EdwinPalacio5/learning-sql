-- muestra la estructura de la tabla departments
describe departments;

-- seleccionar todos los registros de la tabla departamento
Select * 
from departments;

-- seleccionar solo los campos department_id y location_id 
-- de todos los registros de la tabla departamento
Select department_id , location_id 
from departments;

-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
-- %%%%%%%%%%%%%% EXPRECIONES ARITMETICAS %%%%%%%%%%%%%%%%
-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

--salario calculado con la regla 12*salario+100
Select last_name, salary, (12*salary+100) 
from employees;

--salario calculado con la regla 12*(salario+100)
Select last_name, salary, 12*(salary+100) 
from employees;

-- resultado null al hacer operaciones con un dato nulo
-- en este caso el campo comission_pct tiene valores nulos
Select last_name, 12*salary*commission_pct 
from employees;

-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
-- %%%%%%%%%%%%%%%%%%%%%%% ALIAS %%%%%%%%%%%%%%%%%%%%%%%%%
-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

-- Haciendo uso de "as" se puede dar un alias a la columna
Select last_name as name, salary*12 as salario_anual 
from employees; 

-- Tambien funciona colocar el alias al solo colocar el alias seguidamente
-- de la columna. Nota: cuando es más de una palabra es necesario escribir 
-- el alias en comillas
Select last_name name, salary*12  "salario anual" 
from employees; 

-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
-- %%%%%%%%%%% OPERADORES DE CONCATENACION %%%%%%%%%%%%%%%
-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

-- con el operador "||" se logra concatenar el contenido de dos o más columnas
Select last_name || job_id as "Employees" 
from employees;

-- además, podemos agregar texto a las concatenaciones
Select ('Name: ' || last_name || ' Codigo: ' || job_id) as "Employee Details"
from employees;

-- Operador alternativo: este permite agregar cadenas de caracteres que tienen
-- comillas. q'[ texto ]'
Select (department_name || q'[ Department's Manager Id: ]' || manager_id)
    as "Department and manager"
from departments;

-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
-- %%%%%%%%%%%%%%%%%%%%%%% DISTINCT %%%%%%%%%%%%%%%%%%%%%%
-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

--Distinct permite eliminar resultados repetidos, para el ejemplo
--se hace la consulta en la tabla employees, para evareguar que 
--departamentos tienen empleados.
Select distinct department_id 
from employees;




