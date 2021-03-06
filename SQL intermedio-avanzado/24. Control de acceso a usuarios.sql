----------------------------- Controlando el acceso a Usuarios ---------------------------------------

-- Crear Usuarios

alter session set "_ORACLE_SCRIPT" = true;

Create user edwin identified by pass;

-- Crear Role

Create Role tester;

-- Dar privilegios a usuarios o roles

-- Sintaxis: 
-- Grant privilegio 
-- to user;

Grant create session, create table, create sequence, create view
to edwin;

Grant create table, create view
to tester;

-- Otorgar Role a Usuario

Grant tester to edwin;

-- Cambiar la contraseña de usuario

Alter user edwin identified by newpass;

-- Consultar privilegios Otorgados mediante la vista del diccionarios de datos

-- |   Vista del Diccionarioo de datos  |                           Descripción                       |
-- |    ---                             |                            ---                              |
-- |   ROLE_SYS_PRIVS                   | Privilegios de Sistema otorgado a roles                     |
-- |   ROLE_TAB_PRIVS                   | Privilegios de tabla otorgado a roles                       |
-- |   USER_ROLE_PRIVS                  | Roles accesibles por el usuario                             | 
-- |   USER_SYS_PRIVS                   | Privilegios de sistema otorgado a los usuarios              |
-- |   USER_TAB_PRIVS_MADE              | Privilegios de objetos otorgados en los objetos de usuarios |
-- |   USER_TAB_PRIVS_RECD              | Privilegios de objetos otorgados al usuario                 |
-- |   USER_COL_PRIVS_MADE              | Privilegios de objetos otorgados sobre las columnas de objetos de usuarios |     |
-- |   USER_COL_PRIVS_RECD              | Privilegios de objeto otorgados a laos usuarios sobre específicas columnas |
--



