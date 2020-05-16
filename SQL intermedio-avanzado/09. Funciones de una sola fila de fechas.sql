---------------------------------------------------------------------------------------
----------------------- FUNCIONES DE UNA SOLA FILA ------------------------------------

------------------------------ FUNCIONES FECHA ----------------------------------------

-- Formatos de fecha RR y YY

--  Año actual      Fecha Especificada      Formato RR      Formato YY
---------------------------------------------------------------------------
--  1995            27-OCT-95               1995            1995
--  1995            27-OCT-17               2017            1917
--  2001            27-OCT-17               2017            2017
--  2001            27-OCT-95               1995            2095

------------------------------ FUNCION SYSDATE --------------------------------------

-- devuelve la fecha actual

Select sysdate
from dual;

--------------------------- ARITMETICA DE FECHAS ------------------------------------

-- Ejemplo: calcular las semanas de contratacion de un empleado desde su contratacion

Select last_name, (sysdate-hire_date)/7 as "Semanas de trabajo"
from employees
where department_id = 90;

-- Nota: la resta devuelve el numero de días

------------------------- FUNCIONES DE MANIPULACION ---------------------------------

--  Funcion                     Resultado
-----------------------------------------------------------------------------
-- MONTHS_BETWEEN               Número de meses entre dos fechas
-- ADD_MONTHS                   Agrega mes calendario hasta la fecha
-- NEXT_DAY                     Día de la semana de la fecha especificada
-- LAST_DAY                     Último día del mes
-- ROUND                        Fecha redondeada
-- TRUNC                        Fecha truncada


Select MONTHS_BETWEEN('01-abr-2020','01-Ene-2020')
from dual;

-- Resultado : 3

Select add_months('04-Ene-2020',5)
from dual;

-- Resultado : 04/06/20

Select next_day('01-abr-2020','Miércoles')
from dual;

-- Resultado : 08/04/20, exactamente el próximo viernes será 08/04

Select last_day('01-abr-2020')
from dual;

-- Resultado : 30/04/20

------------------------------- Round fechas -------------------------------------

Define micumple = '16-06-2020'

Select to_date('&micumple'), 
        round(to_date('&micumple'),'MONTH'), 
        round(to_date('&micumple'),'YEAR')
from dual;

UNDEFINE micumple

-- TO_DATE      ROUND(mes)   ROUND(año)
------------    --------     --------
-- 16/06/20     01/07/20     01/01/20


------------------------------- Trunc fechas -------------------------------------

Define micumple = '16-06-2020'

Select to_date('&micumple'), 
        trunc(to_date('&micumple'),'MONTH'), 
        trunc(to_date('&micumple'),'YEAR')
from dual;

UNDEFINE micumple

-- TO_DATE      TRUNC(mes)   TRUNC(año)
------------    --------     --------
-- 16/06/20     01/06/20     01/01/20

-- Nota: Trunc y Round recibe obligadamente el parametro en tipo fecha








