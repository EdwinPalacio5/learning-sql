------------------------------------------------ Indice ---------------------------------------------

-- mejora el rendimiento de las consultas en la recuperación de datos

-- Es un objeto de esquema
-- Puede ser utilizado por el servidor de Oracle para acelerar la recuperación de filas mediante el uso de un puntero
-- Puede reducir la entrada/salida de disco (E/S) mediante el uso de un método de acceso ruta rápida para localizar datos de forma rápida
-- Es dependiente los indices de las tablas
-- Se usa y se mantiene de forma automática por el servidor Oracle

-- ¿Cómo se crean los indices?

-- Automaticamente: Un indice único se crea automáticamente cuando se define una restricción de CLAVE PRIMARIA o UNIQUE en una definición de tabla

-- Manualmente: Se puede crear un índice único o no único en las columnas para acelerar el acceso a las filas.

-- Sintaxis

-- Create [UNIQUE] [BITMAP] INDEX name_index
-- On table (column1,...);

-- Ejemplo:

Create Index emp_last_name_idx
On employees(last_name);

-- Crear índice con el Create Table

Create Table NEW_EMP
(
employee_id     number(6)
                primary key using index
                (Create index emp_id_idx
                 On NEW_EMP(employee_id)),
first_name      varchar2(20),
last_name       varchar2(20));

-- Consultar indice
Describe user_indexes;

Select index_name, table_name
From user_indexes
Where table_name = 'NEW_EMP';

-- User_ind_columns

Describe user_ind_columns;

Select index_name, column_name
From user_ind_columns
Where table_name = 'departments';

-- Los índices de función-base

-- * Un indice basado en las funciones se basa en expresiones.

-- * La expresión de índice se construye a partir de columnas de tabla, constantes, funciones de SQL y funciones definidas por el usuario.

-- Ejemplo: Este indice lo que hará que el nombre del departamento lo vuelva mayúscula, entonces al hacer consultas esto va a mejorar el rendimiento.

Create index upper_dept_name_idx
On departments(UPPER(department_name));

Select *
From    departments
Where   UPPER(department_name) = 'SALES';

-- Creación de varios indices en el mismo conjunto de columnas

-- * Puede crear varios índices en el mismo conjunto de columnas.
-- * Múltiples índices se pueden crear en el mismo conjunto de columnas sí:
--              - Los índices son de diferentes tipos
--              - Los índices utilizan diferentes particionamiento
--              - Los índices tienen diferentes propiedades de unicidad

-- ejemplo: para este caso hacemos alter en emp_id_name_idx1 haciendolo invisible para así poder crear el otro indice bajo el mismo conjunto de columnas

Create index emp_id_name_idx1
On employees(employee_id, first_name);

Alter index emp_id_name_idx1 invisible;

Create bitmap index emp_id_name_idx2 
On employees(employee_id, first_name);

-- Directrices de la creación de indice

-- Cree un índice cuando:

-- Una columna contiene una amplia gama de valores
-- una columna contine un gran número de valores nulos
-- Una o más columnas se utilizan con frecuencia juntos en una cláusula WHERE o una condición de unión
-- La tabla es grande y se espera que la mayoría de las consultas para recuperar menos de 2% a 4% de las filas de la tabla.

-- No cree un índice cuando:

-- Las columnas no se utilizan a menudo como un condición en la consulta.
-- La tabla es pequeña o se espera que la mayoría de consultas para recuperar más de un 2% a un 4% de las filas de la tabla.
-- La tabla se actualiza con frecuencia
-- las columnas indexadas se hace referencia como parte de una expresión.

