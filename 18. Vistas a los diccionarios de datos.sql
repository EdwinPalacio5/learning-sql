---------------------------- Vistas del Diccionario de datos -------------------------------------

-- Los diccionarios de datos es la metadata, es decir la deficion de todo lo que tenemos en nuestra
-- base de datos.

-- La estructura de una diccionario de datos consiste en:
--              -> Tablas base
--              -> Vistas accesibles al usuario 

-- Prefijo

-- User: Vista del usuario (lo que está en su esquema)
-- ALL: Vista ampliada del usuario (los que se tiene en su propio esquema y los que esquemas que otros
--      usuarios han dado acceso)
-- DBA: Lo que está en los esquemas de todo el mundo
-- V$ : Los datos relacionados con el rendimiento


-- Dictionary contiene los nombres y despreciones de las tablas de diccionario y puntos de vista
Describe dictionary;

Select *
From dictionary
where table_name = 'USER_OBJECTS';

-- Ver objetos
Select  object_name, object_type, created, status
From    user_objects
order by object_type;

-- Aquellas tablas que son de mi usuario
Describe user_tables;

-- Ver tablas
Select table_name
From user_tables;

Describe user_tab_columns;

-- Ver columnas de una tabla en específico
Select table_name, column_name
From user_tab_columns
where table_name = 'BOOK'
Order by table_name;

Describe user_constraints;

-- ver los constraint de mi usuario, en una tabla x
Select constraint_name, constraint_type, search_condition, r_constraint_name, delete_rule, status
from user_constraints
where table_name = 'BOOK'
Order By constraint_type;

Describe user_cons_columns;

-- ver constraint y en que columna se aplicó 
Select  constraint_name, column_name
From    user_cons_columns
Where   table_name = 'BOOK';

-- Añadir comentarios al diccionario de una tabla
comment on table book 
        is 'Libros';


-- Añadir comentarios al diccionario de una columna
comment on column book.title
        is 'Titulo del libro';
        
-- ver comentarios de las tablas, y de los comentarios

Describe user_tab_comments;

Select table_name, comments
From user_tab_comments
Where table_name = 'BOOK';

Describe user_col_comments;

Select column_name, comments
From user_col_comments
Where table_name = 'BOOK';

-- Nota: En los ejemplos anteriores solo se utilizó el prefijo **user**.