-- 
alter session set "_ORACLE_SCRIPT" = true;
-- creacion de usuario hr con contraseña hrpass
create user hr identified by hrpass;
-- se dan permisos a user hr
grant connect, resource to hr;
-- se dan persimos para insertar datos
alter user hr QUOTA unlimited on USERS;



