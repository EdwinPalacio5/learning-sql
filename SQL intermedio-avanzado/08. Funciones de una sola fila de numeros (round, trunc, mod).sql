---------------------------------------------------------------------------------------
----------------------- FUNCIONES DE UNA SOLA FILA ------------------------------------

---------------------------- FUNCIONES NUMERICAS --------------------------------------

--  Round

Select round(45.923,2), round(45.923,0),round(45.923,-1)
from dual;

-- Nota: al poner -1 (Aproxima a la decena cercana)

--       al poner 2 (Aproxima a la dos digitos)

--       al poner 0 (Aproxima a la unidad cercana)

-- Trunc

Select trunc(45.923,2),trunc(45.923,0),trunc(45.923,-1),trunc(45.923)
from dual;

-- Nota: al poner -1 (corta a la decena en que se encuentra. NO aproxima)

--       al poner 2 (Corta a dos digitos sin aproximar)

--       al poner 0 (Coloca el numero en su unidad entera)

-- Mod: Devuelve el valor restante despues de haber dividido un numero bajo la 
--      cantidad indicada. Ejemplo: mod(1600, 1000) = 600

Select last_name, salary, mod(salary, 5000)
From employees
where job_id = 'SA_REP';


