---------------------- ANALITIC SQL FOR DATA WAREHOUSING ----------------------------------------------
/*
 Oracle ha introducido muchas operaciones SQL para realizar operaciones analíticas  en la base de datos.
 - Estas operaciones incluyen clasificación, promedios móviles, sumas acumulativas, ratios-informes y comparaciones de período a péríodo.
 - Aunque anteriormente algunos de estos cálculo eran posibles utilizando SQL, esta sintaxis ofrece un rendimiento mucho mejor.

 Group By con los operadores ROLLUP y CUBE

 Use ROLLUP o CUBE con Group BY para producir filas superagregadas mediante columnas de referencias cruzadas.

  ROLLUP
 
  - Produce un conjunto de resultados que contiene las filas agrupadas regulares y los valores de subtotal y total general
  - Es un extensión de la clausula GROUP BY
  - Use la operación ROLLUP para producir agregados acumulativos, como subtotales.
  - Utilizado, para hacer operaciones de agregación para múltiples niveles en una jerarquía
 */
 
 SELECT department_id, job_id, SUM(salary)
 FROM   employees
 WHERE  department_id < 60
 Group by rollup (department_id, job_id);
 
 /*
 DEPARTMENT_ID JOB_ID     SUM(SALARY)
------------- ---------- -----------
           10 AD_ASST           4400
           10                   4400
           20 MK_MAN           13000
           20 MK_REP            6000
           20                  19000
           30 PU_MAN           11000
           30 PU_CLERK         13900
           30                  24900
           40 HR_REP            6500
           40                   6500
           50 ST_MAN           36400
           50 SH_CLERK         64300
           50 ST_CLERK         55700
           50                 156400
                              211200

    15 filas seleccionadas. 
 */
 
 -- Equivalente ocupando Grouping Sets
 
 -- Permite agregar más de un conjunto de agrupación al group by
 
 SELECT department_id, job_id, SUM(salary)
 FROM   employees
 WHERE  department_id < 60
 Group by grouping sets (
            (department_id, job_id),
            (department_id),
            ());
            
 -- Equivalente ocupando Union All
 
 SELECT department_id, job_id, SUM(salary)
 FROM   employees
 WHERE  department_id < 60
 Group by (department_id, job_id)
 
 UNION ALL
 
SELECT department_id, NULL , SUM(salary)
 FROM   employees
 WHERE  department_id < 60
 Group by (department_id)
 
 UNION ALL
 
  SELECT NULL, NULL, SUM(salary)
 FROM   employees
 WHERE  department_id < 60;
 
 
 
 
 