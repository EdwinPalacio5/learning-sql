------------------------------------------------------------------------------------------------------
-------- Uso de las funciones de conversión y Expresiones condicionales ------------------------------
------------------------------------------------------------------------------------------------------


------------------------------------------------------------------------------------------------------
----------------------------- Funcion TO_CHAR --------------------------------------------------------

-- Fecha a Char

-- to_char(fecha, 'modelo')

-- YEAR     : Año enunciado (en ingles)
-- YYYY     : Año completo en numero
-- YY       : Valor de 2 digitos para el año

-- MONTH    : Nombre completo del mes
-- MON      : Abreviatura de 3 letras del mes 
-- MM       : Valor de 2 digitos del mes

-- DAY      : Nombre completo del día de la semana
-- DY       : Abreviatura de 3 letras del día de la semana
-- DD       : Valor de 2 digitos del día del mes
-- DDSPTH   : Escribe el numero del día en letras

 -- Tiempo
 
 -- HH24:MI:SS AM          -> 15:45:32 PM
 
-- Concatenar caracteres
 
-- DD "of" MONTH           -> 12 of OCTOBER


Ejemplo: 

Select last_name, to_char(hire_date, 'dd Mon yy') as "Fecha de Contrato"
 from employees;
 
-- fm       : elimina los espacios en blanco rellenados o suprime ceros
--            a la izquierda
 
Select last_name, to_char(hire_date, 'fm dd Mon yy') as "Fecha de Contrato"
 from employees;
 
-- Numero a char

-- 9    : representa un numero
-- 0    : Obliga a un cero para que se muestre
-- $    : Coloca un signo de dolar a un flotante
-- L    : Utiliza el simbolo de moneda local
-- .    : Imprime un punto decimal
-- ,    : Inprime una coma como indicador de miles

Select last_name, to_char(salary,'$99,999.99') as "Salario"
from employees;

------------------------------------------------------------------------------------------------------
----------------------------- Funcion TO_DATE --------------------------------------------------------
 
Select last_name, hire_date
From employees
WHERE hire_date < to_date('01-Ene-08','DD Mon RR');

-- Nota: RR interpreta la parte del año de la fecha de 1950 a 1999

------------------------------------------------------------------------------------------------------
----------------------------- Funcion TO_NUMBER -------------------------------------------------------

Select last_name, salary
From employees
WHERE salary < to_number('$2,230.87','$99,999.00');

------------------------------------------------------------------------------------------------------
---------------------------- Funciones Generales -----------------------------------------------------

------------- NVL (expr1_a_evaluar, valor_a_tomar_si_es_null) ----------------------------------------
-- Convierte un valor nulo a un valor real

Select last_name, nvl(commission_pct,0) as comision
from employees;

-- aplicación: en este caso, para que no se devuelve null el resultado, si es null
-- se convierte a cero.

Select last_name, salary, nvl(commission_pct,0) as comision, 
    (salary + salary*nvl(commission_pct,0)) as "Salario Final"
from employees;

--- NVL2 (expr1_a_evaluar, valor_a_tomar_sino_es_null,valor_a_tomar_si_es_null) -----------------------
-- evalua una expresión y permite dar un varo si es nula, o dar otro valor si no lo es

Select last_name, salary, commission_pct, 
    nvl2(commission_pct,'Posee comision', 'No posee comisión') as comision
from employees;

--- NULLIF (expr1_a_evaluar,expr2_a_evaluar,valor_a_tomar_si_son_iguales) ------------------------------
-- evalua dos expresiones, y devuelve null si son iguales o el primer valor si 
-- son distintos.

Select first_name, length(first_name) as "longitud fn", 
       last_name, length(last_name) as "longitud ln",
    nullif(length(first_name),length(last_name)) as "nullif"
from employees;

-- COALESCE (expr1_a_evaluar,expr2_a_evaluar, valor_a_mostrar_si_ambas_son_null) ----------------------
-- Evalua dos expresiones, y si las dos son nulas se reemplaza el valor por el valor
-- dado en el segundo parametro

Select last_name, commission_pct, manager_id,
    coalesce(to_char(commission_pct), to_char(manager_id),'NO posee comision ni manager')
from employees;

--Nota: los parametro enviados a coalesce, deben ser de tipo char

------------------------------------------------------------------------------------------------------
---------------------------- Expresiones condicionales -----------------------------------------------

-- Sirven para proporcionar 

 