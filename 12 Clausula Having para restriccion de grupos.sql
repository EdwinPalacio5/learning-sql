--------------------- Clausula HAVING para restringir grupos -----------------------------------

-- Es importante aclarar que having es utilizado para realizar restricciones despues de haber 
-- agrupado registros, cosa que con Where no se puede, ya que este lo hace antes de agrupar

-- Ejemplo 1: Obtener el salario máximo por departamento, pero solo aquellos que son mayor a 10,000

Select department_id, max(salary)
from employees
group by department_id
order by department_id;

-- ejemplo 2: Para este caso se pretende mostrar el orden en que se colucan las clausulas
--                  GROUP BY -> HAVING -> ORDER BY

Select job_id, sum(salary)
from employees
where job_id like '%REP%'
group by job_id
having sum(salary) > 10000
order by job_id;


