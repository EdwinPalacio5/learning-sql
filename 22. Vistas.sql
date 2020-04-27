-------------------------------------------- Vistas --------------------------------------------------

-- Lógicamente representa subconjunto de los datos de unas o más tablas
 
-- Ventajas
 
 -- Para restringir acceso a datos
 -- Para proporcionar independencia de datos
 -- Para hacer consultas complejas fáciles
 -- Para representar diferencres vistas de los mismos datos
 
-- Vistas simple y complejas
 
 -- |           Caracteristica              |   Vistas simples  |   Vistas complejas    |  
 -- |               ---                     |       ---         |       ---             |
 -- | Numeros de tablas                     |       Uno         |   Uno o más           |
 -- | Contiene funciones                    |       No          |   Si                  |
 -- | Contiene grupos de datos              |       No          |   Si                  |
 -- | Operaciones DML a través de una vista |       Si          |   No siempre          |  
 
-- Sintaxis

 -- CREATE [OR REPLACE] [FORCE | NOFORCE] VIEW view
 --   [(alias,...)]
 -- AS Subquery
 -- [WITH CHECK  OPTION [CONSTRAINT constraint]]
 -- [WITH READ ONLY [CONSTRAINT constraint]];

 -- la subconsulta puede contener sintaxis SELECT complejo
 
 -- antes le daremos permisos para crear vistas al usuario hr, con el usuario SYSTEM
 
 grant create synonym to hr;
 grant create view to hr;
 
 -- Creación de vistas simples
 
 Create view empvu80
 As (Select employee_id, last_name, salary
     From   employees
     Where  department_id = 80);
     
Describe empvu80;

 -- Resultado
 -- Nombre      ¿Nulo?   Tipo         
 ------------- -------- ------------ 
 --EMPLOYEE_ID NOT NULL NUMBER(6)    
 --LAST_NAME   NOT NULL VARCHAR2(25) 
 --SALARY               NUMBER(8,2)
 
 -- Recuperando datos de una vista
 
 Select *
 From empvu80;
 
 -- Modificando una vista
 -- En este caso, se le asignaran alias a la vista, en vez de usar los que trae la tabla originalmente
 
 Create or Replace View empvu80
    (id_number, name, sal, department_id)
 As (Select employee_id, first_name || ' ' || last_name, salary, department_id
     From employees
     Where department_id = 80);
    
 -- Creación de vistas complejasç
 
 -- Utilizando funciones de agragación, joins, etc.
 
 Create Or Replace View dept_sum_vu
    (name, minsal, maxsal, avgsal)
 As (Select d.department_name, min(e.salary), max(e.salary), avg(e.salary)
     From employees e 
     Join departments d Using(department_id)
     group by d.department_name);
     
Select *
From dept_sum_vu;

-- Ver información de las vistas

Describe user_views;
     
Select view_name, text
From user_views;

-- Reglas para realización de operaciones DML en una vista

-- Generalmente, usted puede realizar operaciones DML en vistas simples

-- No se puede eliminar una fila si la vista contine lo sieguiente:
--          - Funciones de grupo
--          - Una clausula GROUP BY
--          - La palabra clave DISTINCT
--          - La palabra reservada ROWNUM

-- No se puede modificar los datos en una vista si contiene
--          - Funciones de grupo
--          - Una clausula GROUP BY
--          - La palabra clave DISTINCT
--          - La palabra reservada ROWNUM
--          - Columnas definidas por expresiones

-- No se pueden agregar datos a través de una vista si la vista incluye
--          - Funciones de grupo
--          - Una clausula GROUP BY
--          - La palabra clave DISTINCT
--          - La palabra reservada ROWNUM
--          - Columnas definidas por expresiones
--          - Columnas NOT NULL sin valor por defecto en las tablas de base que no están señeccionados por la vista

-- Uso de la cláusula WITH CHECK OPTION

 -- Puede asegurar de que las operaciones de DML se realizaron en la estancia de la vista en el dominio de la vista mediante la cláusula WITH CHECK OPTION

Create or replace view empvu20
as (Select  *
    From    employees
    Where   department_id = 20)
    WITH CHECK OPTION constraint empvu20_ck;
    
 -- Cualquier intento de de insertar una fila con un department_id diferente de 20 o para actualizar el número de departamento para cualqueir fila en la vista falla porque viola la restricción WITH CHECK OPTION.

-- Denegar Operaciones DML

-- Puede asegurar de que no hayan operaciones de DML ocurran mediante la adición de la opción WITH READ ONLY para su definición de la vista.
-- Cualquier intento de realizar una operación de DML en cualquier fila de la vista da resultados de error en el servidor Oracle.

-- Eliminar vista

Drop view empvu80;