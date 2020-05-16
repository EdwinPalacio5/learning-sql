---------------------------DML Lenguaje de Manipulación de Datos ------------------------------------

-- |            Funcion           |             Descripcion                     |
-- |            ---               |                                             |
-- | INSERT                       | Agrega una nueva fila a la tabla            |
-- | UPDATE                       | Modifica las filas existentes               |
-- | DELETE                       | Elimina las filas existentes                |
-- | TRUNCATE                     | Elimina todas las filas de una tabla        |
-- | COMMIT                       | Hace los cambios pedientes en permanentes   |
-- | SAVEPONT                     | Marca un punto de salvaguarda               |
-- | ROLLBACK                     | Descarta los cambios pendientes de datos    |
-- | FOR UPDATE en clausula SELECT| Bloquea las filas identificadas en el SELECT|

Describe Departments;

-- Insert

-- Insert implícito: Se omiten columnas que no son obligatorias

Insert into departments (department_id, department_name)
                values  (280, 'QA');

-- Insert explicito: No se especifican lo campos, poy lo que el insert espera todos los campos, 
--                   por lo que los campos que no se deseen agregar se pueden poner nulos

Insert into departments 
                values (290, 'Testing', NULL, NULL);
                
-- Copiando fila con otra tabla
-- En este caso la clausula **values** no se agrega


Insert into departments (department_id, department_name, manager_id, location_id)
       (Select 300, last_name, manager_id, 1000 
        From employees
        Where employee_id = 127);

-- Update

Update departments
    set department_name = 'Documentadores'
where department_id = 300;

-- Update con sub consulta

Update departments
    set (department_name, manager_id) = (Select  last_name, manager_id 
                                         From employees
                                         Where employee_id = 122)
Where department_id = 300;

-- Delete

Delete 
From departments
Where department_id = 300;

Select * From departments;

-- Savepoint

savepoint punto;

-- Rollback a un punto en especifico

rollback to punto;

-- Rollback de todos los cambios pendientes

rollback;

-- Commit

commit;

-- For Update

Select * 
From employees
Where department_id = 50
For update;



                

