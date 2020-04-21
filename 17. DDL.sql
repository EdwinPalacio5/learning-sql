---------------------------- Lenguaje de Definición de Datos DDL -----------------------------------
-- ALTER TABLE

-- Alter table ADD
-- Permite agregar una columna

Alter table author 
Add (LASTNAME varchar(50) Not Null);

-- Alter table MODIFY
-- Permite modificar la definición de una columna

Alter table author 
Modify (LASTNAME varchar(40));

-- Alter table DROP
-- Permite eliminar una columna

Alter table author
Drop (LASTNAME);

-- Alter table RENAME COLUMN
-- Permite renombrar una columna

Alter table author
Rename column LASTNAME to LAST_NAME;

-- Alter table READ ONLY
-- Permite configurar una tabla en solo lectura

Alter table author 
Read Only;

-- Alter table READ WRITE
-- Permite configurar una tabla en lectura y escritura
Alter table author
Read Write;

-- Drop table name_table
-- Permite eliminar una tabla, al agregar **PURGE** se eliminan todos sus datos también
Drop table user_role;

-- Create

Create table Editorial(
    editorial_id        number(8)   not null,
    editorial_name      varchar(50) not null
);

-- Crear una table en base a otra (una consulta)
Create table editorials as (
    Select * 
    from editorial
);

Describe Editorials;

-- En el siguiente caso se decide las columnas y el nombre de las columnas que se tendrá y además 
-- los datos obtenidos en la consulta se agregan en la base que estamos creando
create table dpto80 as (
    Select last_name as apellido, salary*12 as "salario_anual"
    From employees
    Where department_id = 80
);

Describe dpto80;

-- Constraint
-- Estructura: constraint name_constraint [primary key | not null | Unique check] (editorial_id)

Create table Editorial(
    editorial_id        number(8)   not null,
    editorial_name      varchar(50) not null,
    constraint edi_id_pk primary key(editorial_id)
);

-- Constrain check: se puede agregar operadores between, in, etc.

Alter table employees
add constraint salary_check check (SALARY > 0);

-- Foraneas

-- En este caso vamos a añadir primero el atributo que será foranea en la tabla secundaria book
Alter table book
add (editorial_id       number(8)   not null);

-- Ahora vamos a hacer el constraint que nos permita crear la referencia de foreign key

Alter table book
add (constraint edi_id_fk Foreign Key (editorial_id) 
     references editorial(editorial_id));
     
-- Y tambien podemos configurar el borrado, ya sea en cascada o set null, para ello primero 
-- borraremos la constraint 

Alter table book
drop constraint edi_id_fk;

Alter table book
add (constraint edi_id_fk Foreign Key (editorial_id) 
     references editorial(editorial_id)
     on delete cascade); 
     
Describe book;
