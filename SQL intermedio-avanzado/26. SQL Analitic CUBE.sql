/*CUBE
 
 - Produce un conjunto de resultados que contiene las filas de ROLLUP y las de filas de tabulación cruzada.
 - CUBE es una extensión de la clásula GROUP BY
 - Puede usar el operador CUBE para generar valores de tabulación cruzada con una sola instrucción SELECT,
   es decir, produce el resultado conjunto de todas las combinaciones de los atributos específicados en el 
   GROUP BY.
   
   Ejemplo: Recuperar la suma de los salarios agrupados por todas las combinaciones de departamento y puesto
            de trabajo, así como obtener el gran total
            
*/

-- Paso 1: Agrupamos

Select department_id, job_id, SUM(salary)
From employees
WHERE department_id < 60
Group by (department_id, job_id);

-- Paso 2: Aplicamos CUBE, que nos permitirá ver los subtotales por job_id, subtotales por departamento,
--         subtotales  por departamento y job_id y el total global.

Select department_id, job_id, SUM(salary)
From employees
WHERE department_id < 60
Group by CUBE (department_id, job_id);

/*

DEPARTMENT_ID JOB_ID     SUM(SALARY)
------------- ---------- -----------
                              211200    GRAN TOTAL
              HR_REP            6500
              MK_MAN           13000
              MK_REP            6000
              PU_MAN           11000
              ST_MAN           36400    TOTAL POR JOIB_ID
              AD_ASST           4400
              PU_CLERK         13900
              SH_CLERK         64300
              ST_CLERK         55700
           10                   4400
           10 AD_ASST           4400    TOTAL POR JOB_ID  Y DEPARTAMENTO
           20                  19000
           20 MK_MAN           13000
           20 MK_REP            6000
           30                  24900    TOTAL POR DEPARTAMENTO
           30 PU_MAN           11000
           30 PU_CLERK         13900
           40                   6500
           40 HR_REP            6500
           50                 156400
           50 ST_MAN           36400
           50 SH_CLERK         64300
           50 ST_CLERK         55700

24 filas seleccionadas. 

*/
-- Equivalente en GROUPING SETS

Select department_id, job_id, SUM(salary)
FROM employees
Where department_id < 60
Group by GROUPING SETS (
          (department_id,job_id),
          (department_id),
          (job_id),
          ()
        );

/*        
DEPARTMENT_ID JOB_ID     SUM(SALARY)
------------- ---------- -----------
           40 HR_REP            6500
           20 MK_MAN           13000
           20 MK_REP            6000
           30 PU_MAN           11000
           50 ST_MAN           36400
           10 AD_ASST           4400
           30 PU_CLERK         13900
           50 SH_CLERK         64300
           50 ST_CLERK         55700
              HR_REP            6500
              MK_MAN           13000
              MK_REP            6000
              PU_MAN           11000
              ST_MAN           36400
              AD_ASST           4400
              PU_CLERK         13900
              SH_CLERK         64300
              ST_CLERK         55700
           10                   4400
           20                  19000
           30                  24900
           40                   6500
           50                 156400
                              211200

24 filas seleccionadas.

*/

-- Equivalente en UNION ALL

Select department_id, job_id, SUM(salary)
FROM employees
Where department_id < 60
Group by (department_id, job_id)

UNION ALL

Select department_id, NULL, SUM(salary)
FROM employees
Where department_id < 60
Group by (department_id)

UNION ALL

Select NULL, job_id, SUM(salary)
FROM employees
Where department_id < 60
Group by (job_id)

UNION ALL

Select NULL, NULL, SUM(salary)
FROM employees
Where department_id < 60;

/*
DEPARTMENT_ID JOB_ID     SUM(SALARY)
------------- ---------- -----------
           50 ST_CLERK         55700
           50 ST_MAN           36400
           30 PU_CLERK         13900
           50 SH_CLERK         64300
           20 MK_MAN           13000
           30 PU_MAN           11000
           10 AD_ASST           4400
           20 MK_REP            6000
           40 HR_REP            6500
           30                  24900
           20                  19000
           50                 156400
           40                   6500
           10                   4400
              ST_MAN           36400
              PU_MAN           11000
              AD_ASST           4400
              SH_CLERK         64300
              PU_CLERK         13900
              MK_MAN           13000
              MK_REP            6000
              ST_CLERK         55700
              HR_REP            6500
                              211200

24 filas seleccionadas.
*/