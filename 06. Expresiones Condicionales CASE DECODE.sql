------------------------------------------------------------------------------------------------------
---------------------------- Expresiones condicionales -----------------------------------------------

-- Sirven para proporcionar el uso de la logica IF-THEN-ELSE dentro de una sentencia SQL.

-- La expresi�n case 

Select last_name, job_id, salary,
    case job_id
        when 'IT_PROG'  then 1.10*salary
        when 'ST_CLERK' then 1.15*salary
        when 'SA_REP'   then 1.20*salary
        else salary
    end
    as "Revision de Salario"
from employees;

-- La funci�n decode

Select last_name, job_id, salary,
    decode(job_id,'IT_PROG',  1.10*salary,
                  'ST_CLERK', 1.15*salary,
                  'SA_REP',   1.20*salary,
           salary) 
    as "Revision de Salario"
from employees;
