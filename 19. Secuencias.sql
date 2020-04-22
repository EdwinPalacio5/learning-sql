------------------------------------- Secuencias ---------------------------------------------------

-- Secuencia: Genera valores numericos
-- Puede generar de forma automatica números únicos
-- Es un objteto compatible
-- Se puede utilizar para crear un valor de clave principal (para esto se ocupa normalmente)
-- Reemplaza el código de aplicación
-- Acelera el rendimiento de acceso a valores de secuencia cuando se almacena en caché en la memoria.

-- Sintaxis

Create sequence name_sequence
        increment  by   10
        start with      10
        maxvalue        10000
        minvalue        10
        nocache
        nocycle
        order;

-- Nota: puede ser nocache o cache integer
--                 nocycle o cycle
--                 noorder o order                

-- Para acceder a los valores de sequence se puede: Nextval(siguiente) y Currval(actual)


-- Columna por defecto de SQL usando una secuencia

-- * Sintaxis SQL para columnas que permitan valor por defecto <sequence>.nextval, <sequence>.currval
--   como una columan SQL expresión por defecto para columnas numéricas, donde <sequence> es una 
--   secuencia de base de datos Oracle.

-- * La expresión DEFAULT puede incluir la secuencia con seudo columnas CURRVAL y NEXTVAL, mientras
--   exista la secuencia y usted tenga los privilegios necesarios para acceder a ella.

--   Ejemplo1: crear secuencia incremental de 1 en 1

Create sequence sequence_emp_id
                start with 1;

--   Vincular secuencia con una tabla, para generar id 

Create table emp(
        id_emp      number      default sequence_emp_id.nextval     not null,
        name_emp    varchar(50) 
);

--   Probar inserciones

Insert into emp(name_emp)
        values ('Edwin');
        
Insert into emp(name_emp)
        values ('Joel');
        
--   Verificamos

Select *
From emp;

-- Resultado

--    ID_EMP NAME_EMP                                          
------------ --------------------------------------------------
--         1 Edwin                                             
--         2 Joel  


-- Los valores de secuencia Caching

-- * Almacenamiento en caché de valores de secuencia en la memoria da un acceso más rápido a esos 
--   valores.

-- * Pueden ocurrir lagunas o vacíos en valores de secuencia cuando: una reversión se produce, los 
--   fallos del sistema, una secuencia se utiliza en otra tabla.


-- Modificando una sequence: Alter Sequence

-- Reglas para la modificación de una secuencia

-- * Usted debe ser el propietario o tener el privilegio ALTER para la secuencia
-- * Sólo los números de secuencia futuros se ven afectados.
-- * La secuencia debe caer y volver a crear al reiniciar la secuencia en un número diferente.
-- * En algunos se relaiza validación.
-- * Para eliminar una secuencia, utilice la sentencia DROP:

Alter sequence sequence_emp_id
                nocache
                nocycle;
                
-- Eliminar Sequence : Drop Sequence

Drop sequence name_sequence;

-- Obtener información de sequence

Describe user_sequences;

Select *
From  user_sequences;


