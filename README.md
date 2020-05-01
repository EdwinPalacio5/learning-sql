# Learning-SQL Database ORACLE 12 c

## Tabla de contenido


- [Accediendo a los datos mediante Select](#accediendo-a-los-datos-mediante-select).
   - [Select](#select)
   - [Expreciones Aritméticas](#expresiones-aritmeticas)
   - [Alias](#alias)
   - [Operadores de Concatenación](#operadores-de-concatenacion)
   - [Distinct](#distinct)
- [Restringiendo y ordenando datos](#restringiendo-y-ordenando-datos)
   - [Cláusula Where](#where)
   - [Operadores](#operadores)
   - [Condicionales](#operadores-condicionales-and-or-not)
   - [Cláusula Order By](#operador-order-by)
   - [Variables de Sustitución](#variables-de-sustitucion)
   - [Define e Undefine](#define--undefine)
   - [Set Verify On](#set-verify-on)
- [Funciones de Conversión](#funciones-de-conversion)
   - [Función TO_CHAR](#funcion-to_char)
      - [Fecha a Char](#fecha-a-char)
      - [Numero a Char](#numero-a-char)
   - [Función TO_DATE](#funcion-to_date)
   - [Función TO_NUMBER](#funcion-to_number)
- [Funciones Generales](#funciones-generales)
   - [NVL 1](#nvl-expr1_a_evaluar-valor_a_tomar_si_es_null)
   - [NVL 2](#nvl2-expr1_a_evaluar-valor_a_tomar_sino_es_nullvalor_a_tomar_si_es_null)
   - [NULLIF](#nullif-expr1_a_evaluarexpr2_a_evaluar)
   - [COALESCE](#coalesce-expr1_a_evaluarexpr2_a_evaluar-valor_a_mostrar_si_ambas_son_null)
- [Expresiones Condicionales](#expresiones-condicionales)
   - [CASE](#la-expresión-case)
   - [DECODE](#la-función-decode)
- [Funciones de una sola fila](#funciones-de-una-sola-fila)
   - [Funciones de Caracter](#funciones-de-caracter)
     - [Funciones de manipulación de caracteres](#funciones-de-manipulación)
     - [Anidamiento de funciones](#anidamiento-de-funciones)
   - [Funciones Numéricas](#funciones-numericas)
   - [Funciones de Fecha](#funciones-fecha)
     - [Función SYSDATE](#funcion-sysdate)
     - [Aritmetica de fechas](#aritmetica-de-fechas)
     - [Funciones de manipulación de fechas](#funciones-de-manipulacion)
- [Funciones de grupo](#informes-de-datos-agregados-utilizando-las-funciones-de-grupo)
   - [MIN y MAX](#uso-de-min-y-max-en-fecha)
   - [COUNT](#count)
   - [AVG](#avg)
   - [Cláusula GROUP BY](#group-by-en-funciones-de-grupo)
   - [Cláusula HAVING](#clausula-having-para-restringir-grupos)
- [JOINS](#mostrar-datos-de-múltiples-tablas-usando-joins)
   - [Tipos de join](#tipos-de-join)
   - [Sintaxis](#sintaxis)
   - [Natural Join](#natural-join)
   - [Join Using](#using)
   - [Join On](#on)
   - [Self Join](#self-join)
   - [Nonequijoins](#nonequijoins)
   - [OuterJoin](#outer-join)
      - [Left Outer Join](#left-outer-join)
      - [Right Outer Join](#right-outer-join)
      - [Full Outer Join](#full-outer-join)
   - [Cross Join](#cross-join)
- [Uso de Subconsultas](#uso-de-subconsultas)
   - [Tipos de Subconsulta](#tipos-de-subconsulta)
      - [Subconsulta de una sola fila](#subconsulta-de-una-sola-fila)
      - [Subconsulta de multiples filas](#subconsulta-de-multiples-filas)
   - [Operador Exists y Not Exists](#operador-exists-not-exists)
- [Operadores de Conjunto](#operadores-conjuntos)
   - [Union](#operador-union)
   - [Union All](#union-all)
   - [Intersect](#intersect)
   - [Minus](#minus)
   - [Articio: Coincidir Conjuntos](#artificio-coincidir-conjuntos-sentencias-select)
   - [Order By en Subconjuntos](#order-by-en-conjuntos)
- [DML Lenguaje de Manipulación de Datos](#dml-lenguaje-de-manipulación-de-datos)
   - [Insert](#insert)
   - [Update](#update)
   - [Delete](#delete)
   - [Savepoint](#savepoint)
   - [Rollback](#rollback-a-un-punto-en-especifico)
   - [Commit](#commit)
   - [For Update](#for-update)
- [DDl Lenguaje de Definición de Datos](#ddl-lenguaje-de-definición-de-datos)
   - [Alter table](#alter-table)
   - [Drop table](#drop-table-name_table)
   - [Create table](#create)
   - [Constraint](#constraint)
      - [Sintaxis](#sintaxis-de-constraint)
      - [Foraneas](#foraneas)
- []()
   - []()
   - []()
   - []()
   - []()
   - []()
   - []()
   - []()
   - []()
   - []()
   - []()
   - []()
   - []()
   - []()
   - []()
   - []()
   
   
# Accediendo a los datos mediante Select

## SELECT

Muestra la estructura de la tabla departments

```
describe departments;
```

Seleccionar todos los registros de la tabla departamento

```
Select * 
from departments;
```

Seleccionar solo los campos department_id y location_id de todos los registros de la tabla departamento

```
Select department_id , location_id 
from departments;
```
## EXPRESIONES ARITMETICAS

Salario calculado con la regla 12*salario+100

```
Select last_name, salary, (12*salary+100) 
from employees;
```

Salario calculado con la regla 12*(salario+100)

```
Select last_name, salary, 12*(salary+100) 
from employees;
```

Resultado null al hacer operaciones con un dato nulo en este caso el campo comission_pct tiene valores nulos

```
Select last_name, 12*salary*commission_pct 
from employees;
```
## ALIAS
 
Haciendo uso de "as" se puede dar un alias a la columna. 

```
Select last_name as name, salary*12 as salario_anual 
from employees; 
```

Tambien funciona al solo colocar el alias seguidamente de la columna. 

**Nota:** cuando es más de una palabra es necesario escribir el alias en comillas dobles

```
Select last_name name, salary*12  "salario anual" 
from employees; 
```
## OPERADORES DE CONCATENACION 

con el operador **||** se logra concatenar el contenido de dos o más columnas

```
Select last_name || job_id as "Employees" 
from employees;
```

Además, podemos agregar texto a las concatenaciones

```
Select ('Name: ' || last_name || ' Codigo: ' || job_id) as "Employee Details"
from employees;
```

Operador alternativo: este permite agregar cadenas de caracteres que tienen comillas. Ejemplo: q'[ text's ]'

```
Select (department_name || q'[ Department's Manager Id: ]' || manager_id)
    as "Department and manager"
from departments;
```

**Nota:** Se puede usar como delimitador tanto llaves, cohchetes o parentesis ([],{},())

## DISTINCT 

Distinct permite eliminar resultados repetidos, para el ejemplo se hace la consulta en la tabla employees, para everiguar que 
departamentos tienen empleados.

```
Select distinct department_id 
from employees;
```

# RESTRINGIENDO Y ORDENANDO DATOS 

## WHERE 

Where: permite agregar una condición, para que solo sean devueltas las filas que cumplen dicha condición
**Nota:** en textos se debe buscar con comillas simples: 'texto', en fecha es formato DD-MM-AA

```
Select employee_id, last_name, job_id, department_id
from employees
WHERE last_name = 'Whalen';

Select employee_id, last_name, hire_date
from employees
WHERE hire_date = '17-JUN-03';
```

## OPERADORES 

| Operador | condición |
| ----- | ---- |
| =    | Igual que |
| >    | Mayor que |
| >=   | Mayor o igual que |
| <    | Menor que |
| <=   | Menor o igual que |
| <>   | No igual que |
| BETWEEN ... AND ...  | Entre dos valores (ambos inclusive)
| IN(SET)  | Conincidir con cualquiera de los elementos que se pasan por parametro
| LIKE     | Coincider con el modelo de carácter
| IS NULL | Es un valo nulo

Usando el operador **<** se consultan los empleados que poseen salarios menores a 3000

```
Select last_name, salary
from employees
where salary <3000;
```

Usando el operador de **between** se consulta los empleados que se su salario se encuentra en el rango especificado
**Nota:** para negar es **NOT BETWEEN**

```
Select last_name, salary
from employees
where salary between 1000 and 2500;
```

Usando el operador **in** se consultan los empleados cuyo manager_id conincida con algunos de los valores especificados
**Nota:** para negar es **NOT IN**

```
Select last_name, manager_id
from employees
where manager_id in (100,101);
```
Usando el operador **like** en este ejemplo se consultan los empleados cuyo job_id contenga en su segundo caracter un I, y que adelante posea cero o más carácteres.

```
Select last_name, job_id 
from employees
where job_id like '_I%';
```

Usando el operador **is null** se consultan los empleador cuyo manager_id es nulo
**Nota:** para negar es **IS NOT NULL**

```
Select last_name, manager_id
from employees
where manager_id is null;
```

## OPERADORES CONDICIONALES AND, OR, NOT 

usando el operador **not** se consultan los empleador cuyo manager_id no son nulo

```
Select last_name, manager_id
from employees
where manager_id is not null;
```
**and** devuelve true solamente si ambas condiciones son ciertas

```
select employee_id, last_name, job_id, salary
from employees
WHERE salary >= 10000
AND job_id LIKE '%K%';
```
**or** devuelve true si al menos una de sus condiciones es cierta

```
select last_name, job_id, salary
from employees
WHERE salary >= 10000
OR job_id LIKE '%K%';
```

## OPERADOR ORDER BY

Ordena según el campo que se indique, por ejemplo: se ordenan por la fecha en que se contrataron.

**Nota:**  
  **ASC:** por defecto order by los ordena de manera ascendente, 
   

```
Select last_name, hire_date
from employees
order by hire_date;
```

  **DESC:** si se desea ordenar de manera descendente
   
```
Select last_name, hire_date
from employees
order by hire_date desc;
```

  **Nº de columna en el select:** si se coloca 'oder by 1', los registros se ordenaran de acuerdo a la columna 1
```
Select last_name,hire_date
from employees
order by 1;
```
## VARIABLES DE SUSTITUCION 

Se utilizan para almacenar temporalmente los valores de sustitución con un solo signo ampersand (&) y el doble ampersand (&&)

- Se utilizan como complemento de:
  - Condiciones where
  - Clausulas Order by
  - expresiones de columna
  - nombres de tabla
  - sentencias enteras select

**Ejemplo 1: (un solo ampersand)** la siguiente consulta se emplea &employeed_num, esto permitirá que se despliegue una ventana para solicitar esa variable.

```
Select employee_id, last_name
from employees
where employee_id = &employeed_num;

Select employee_id, last_name
from employees
where last_name LIKE '%&last_name_sustitucion%';
```
**Nota:** No olvide que al utilizar variables de sustitución de tipo texto o fecha, estas deben de poner entre comillas

**Ejemplo 2 (dos ampersand)** se consultan los registros de la tabla employees, y mediante la variable &&column_name se despliega una sola vez la ventana para solicitar el valor de esa variable y se ocupa tanto para seleccionar la columna en el select y hacer el ordenamiento mediante esa columna

```
Select employee_id, last_name, &&column_name
from employees
order by &column_name;
```

## DEFINE , UNDEFINE

Ejemplo:

**Nota** No olvide que al utilizar la variable creada por define, se debe de utilizar el signo ampersand
```
define employee_define = 100

Select employee_id, last_name
from employees
where employee_id = &employee_define;

undefine employee_define
```
 
## SET VERIFY ON 
Muestra la consulta antes y después de hacer el cambio de variable. Por ejemplo: 

```
SET VERIFY ON

Select employee_id, last_name
from employees
where employee_id = &id;
```
Resultado
```
Antiguo:Select employee_id, last_name
from employees
where employee_id = &id
Nuevo:Select employee_id, last_name
from employees
where employee_id = 102

 EMPLOYEE_ID     LAST_NAME                
-------------  ------------------------
     102         De Haan 
```

# FUNCIONES DE CONVERSION 

## Funcion TO_CHAR 

### Fecha a Char

to_char(fecha, 'modelo')

| Formato | Valor |
| --- | --- |
| YEAR     | Año enunciado (en ingles)|
| YYYY     | Año completo en numero|
| YY       | Valor de 2 digitos para el año|
| MONTH    | Nombre completo del mes|
| MON      | Abreviatura de 3 letras del mes| 
| MM       | Valor de 2 digitos del mes|
| DAY      | Nombre completo del día de la semana|
| DY       | Abreviatura de 3 letras del día de la semana|
| DD       | Valor de 2 digitos del día del mes|
| DDSPTH   | Escribe el numero del día en letras|
| HH24:MI:SS AM |  15:45:32 PM |
 
Concatenar caracteres
``` 
DD "of" MONTH      -> 12 of OCTOBER
```

Ejemplo: 

``` 
Select last_name, to_char(hire_date, 'dd Mon yy') as "Fecha de Contrato"
 from employees;
 
Select last_name, to_char(hire_date, 'fm dd Mon yy') as "Fecha de Contrato"
 from employees;
  ```
 
 **Nota:** fm elimina los espacios en blanco rellenados o suprime ceros a la izquierda
 
### Numero a char
| Formato | Valor |
| ---| --- |
| 9    | representa un numero |
| 0    | Obliga a un cero para que se muestre |
| $    | Coloca un signo de dolar a un flotante|
| L    | Utiliza el simbolo de moneda local|
| .    | Imprime un punto decimal|
| ,    | Inprime una coma como indicador de miles|

Ejemplo:
 ```
Select last_name, to_char(salary,'$99,999.99') as "Salario"
from employees;
 ```
## Funcion TO_DATE 

 ```
Select last_name, hire_date
From employees
WHERE hire_date < to_date('01-Ene-08','DD Mon RR');
 ```
**Nota:** RR interpreta la parte del año de la fecha de 1950 a 1999

## Funcion TO_NUMBER

 ```
Select last_name, salary
From employees
WHERE salary < to_number('$2,230.87','$99,999.00');
 ```
 
# Funciones Generales 

## NVL (expr1_a_evaluar, valor_a_tomar_si_es_null) 

Convierte un valor nulo a un valor real

```
Select last_name, nvl(commission_pct,0) as comision
from employees;
```

**Aplicación:** en este caso, para que no se devuelve null el resultado, si es null se convierte a cero.

```
Select last_name, salary, nvl(commission_pct,0) as comision, 
    (salary + salary*nvl(commission_pct,0)) as "Salario Final"
from employees;
```

## NVL2 (expr1_a_evaluar, valor_a_tomar_sino_es_null,valor_a_tomar_si_es_null)
evalua una expresión y permite dar un varo si es nula, o dar otro valor si no lo es

```
Select last_name, salary, commission_pct, 
    nvl2(commission_pct,'Posee comision', 'No posee comisión') as comision
from employees;
```

## NULLIF (expr1_a_evaluar,expr2_a_evaluar) 

evalua dos expresiones, y devuelve null si son iguales o el primer valor si son distintos.

```
Select first_name, length(first_name) as "longitud fn", 
       last_name, length(last_name) as "longitud ln",
       nullif(length(first_name),length(last_name)) as "nullif"
from employees;
```

## COALESCE (expr1_a_evaluar,expr2_a_evaluar, valor_a_mostrar_si_ambas_son_null) 

Evalua dos expresiones, y si las dos son nulas se reemplaza el valor por el valor dado en el segundo parametro

```
Select last_name, commission_pct, manager_id,
    coalesce(to_char(commission_pct), to_char(manager_id),'NO posee comision ni manager')
from employees;
```
**Nota:** Los parametro enviados a coalesce, deben ser de tipo char

# Expresiones condicionales 

Sirven para proporcionar el uso de la logica IF-THEN-ELSE dentro de una sentencia SQL.

## La expresión case 

```
Select last_name, job_id, salary,
    case job_id
        when 'IT_PROG'  then 1.10*salary
        when 'ST_CLERK' then 1.15*salary
        when 'SA_REP'   then 1.20*salary
        else salary
    end
    as "Revision de Salario"
from employees;
```

## La función decode

```
Select last_name, job_id, salary,
    decode(job_id,'IT_PROG',  1.10*salary,
                  'ST_CLERK', 1.15*salary,
                  'SA_REP',   1.20*salary,
           salary) 
    as "Revision de Salario"
from employees;
```

# FUNCIONES DE UNA SOLA FILA 

## FUNCIONES DE CARACTER 

Funciones de caracter: lower, upper, initcap

| FUNCION | Resultado |
| ---     | ---        |
| LOWER(' Curso SQL ')        | curso sql |
| INITCAP(' Curso SQL ')      | Curso Sql |
| UPPER(' Curso SQL ')        | CURSO SQL |

### lower

```
Select lower(last_name) as "apellido en minuscula"
from employees
where lower(last_name) = 'higgins';
``` 

### upper

```
Select upper(last_name) as "apellido en mayuscula"
from employees
where upper(last_name) = 'HIGGINS';
```

### initcap

```
Select initcap(first_name || ' ' || last_name) 
    as "Nombre Completo con iniciales mayusculas"
from employees
where last_name = 'Higgins';
```

## Funciones de Manipulación

|  FUNCION                           |  Resultado|
|       ---                          |  ---        |
|  CONCAT('Hello', 'World')           | HelloWorld |
|  TRIM('H' FROM 'HelloWorld')        | elloWorld |
|  SUBSTR('HelloWorld',1,5)           | Hello |
|  LENGTH('HelloWorld')               | 10 |
|  INSTR('HelloWorld', 'W')           | 6 |
|  LPAD(salary,10,'*')               | *****24000 |
|  RPAD(salary, 10, '*')               | 24000***** |
|  REPLACE('JACK and JUE','J','BL')    | BLACK and BLUE |

```
Select employee_id, concat(first_name, last_name) as name, job_id, 
    length(last_name), instr(last_name, 'a') as "Posición de a"
from employees
where substr(job_id,4) = 'REP';
```

**Nota1:** substr(job_id,4) solo se indica a apartir de cual caracter se desea cobtener
**Nota2:** instr(last_name, 'a') devolverá cero, si last_name no contiene a, y devolverá la posición de la ultima a encontrada

## ANIDAMIENTO DE FUNCIONES 

**Paso 1:** Obtener del apellido los caracteres de la posicion 1 a la 3
```
Select substr(last_name,1,3) 
from employees
where department_id = 60;
```
**Paso 2:** Concatenar los primeros 3 caracteres del apellido con '_US'
```
Select concat(substr(last_name,1,3), '_US' )
from employees
where department_id = 60;
```

**Paso 3:** Convertir a mayúsculas
```
Select upper(concat(substr(last_name,1,3), '_US' )) 
from employees
where department_id = 60; 
```

## FUNCIONES NUMERICAS 

### Round

```
Select round(45.923,2), round(45.923,0),round(45.923,-1)
from dual;
```

**Nota:** al poner -1 (Aproxima a la decena cercana)
          al poner 1 o más (Aproxima a la cantidad de digitos especificados)
          al poner 0 (Aproxima a la unidad cercana)

### Trunc

```
Select trunc(45.923,2),trunc(45.923,0),trunc(45.923,-1),trunc(45.923)
from dual;
```

**Nota:** al poner -1 (corta a la decena en que se encuentra. NO aproxima)
          al poner 1 o más (Corta a la cantidad de digitos especificados, sin aproximar)
          al poner 0 (Coloca el numero en su unidad entera)

### Mod

Devuelve el residuo de una división. Ejemplo: mod(1600, 500) = 100

```
Select last_name, salary, mod(salary, 5000)
From employees
where job_id = 'SA_REP';
```

## FUNCIONES FECHA 

El formato de fecha por defecto es **DD-MON-RR**.

Formatos de fecha RR y YY

| Año actual    |  Fecha Especificada    |  Formato RR     | Formato YY|
| ---           |   ---                  |   ---           |  ---  |
|  1995         |   27-OCT-95            |   1995          |  1995 |
|  1995         |   27-OCT-17            |   2017          |  1917 |
|  2001         |   27-OCT-17            |   2017          |  2017 |
|  2001         |   27-OCT-95            |   1995          |  2095 |

### FUNCION SYSDATE 

devuelve la fecha actual

```
Select sysdate
from dual;
```

### ARITMETICA DE FECHAS 

Ejemplo: calcular las semanas de contratacion de un empleado desde su contratacion

```
Select last_name, (sysdate-hire_date)/7 as "Semanas de trabajo"
from employees
where department_id = 90;
```

**Nota:** la resta devuelve el numero de días

### FUNCIONES DE MANIPULACION 

| Funcion                   | Resultado  |
| ---                       | --- |
| MONTHS_BETWEEN            |   Número de meses entre dos fechas |
| ADD_MONTHS                |   Agrega mes calendario hasta la fecha |
| NEXT_DAY                  |   Día de la semana de la fecha especificada |
| LAST_DAY                  |  Último día del mes |
| ROUND                     |   Fecha redondeada  |
| TRUNC                     |   Fecha truncada  |

```
Select MONTHS_BETWEEN('01-abr-2020','01-Ene-2020')
from dual;

Resultado : 3
```


```
Select add_months('04-Ene-2020',5)
from dual;

Resultado : 04/06/20
```

```
Select next_day('01-abr-2020','Miércoles')
from dual;

Resultado : 08/04/20, exactamente el próximo miercoles será 08/04
```

```

Select last_day('01-abr-2020')
from dual;

Resultado : 30/04/20
```

### Round fechas 

```
Define micumple = '16-06-2020'

Select to_date('&micumple'), 
        round(to_date('&micumple'),'MONTH'), 
        round(to_date('&micumple'),'YEAR')
from dual;

UNDEFINE micumple

-- TO_DATE      ROUND(mes)   ROUND(año)
------------    --------     --------
-- 16/06/20     01/07/20     01/01/20
```

### Trunc fechas 

```
Define micumple = '16-06-2020'

Select to_date('&micumple'), 
        trunc(to_date('&micumple'),'MONTH'), 
        trunc(to_date('&micumple'),'YEAR')
from dual;

UNDEFINE micumple

-- TO_DATE      TRUNC(mes)   TRUNC(año)
------------    --------     --------
-- 16/06/20     01/06/20     01/01/20

```

**Nota:** Trunc y Round recibe obligadamente el parametro en tipo fecha

# Informes de datos agregados utilizando las funciones de grupo 

Operan en un conjunto de filas para devolver un solo resultado por grupo

| Operación | Resultado|
| ---       | ---      |
| AVG | Devuelve el Promedio |
| COUNT | Cuenta los registros |
| MAX | Devuelve el máximo |
| MIN | Devuelve el mínimo |
| SUM | Devuelve la suma |

```
Select AVG(salary), MAX(salary), MIN(salary), COUNT(salary), SUM(salary)
from employees
where job_id like '%REP%';
```

## Uso de MIN y MAX en fecha

```
Select MIN(hire_date), MAX(hire_date)
from employees;
```

## Count

Count (*) 

devuelve el número de filas de una tabla

```
Select count(*)
from employees;
```
Count (columna(s)) devuelve el número de filas con valores no nulos

```
Select count(commission_pct)
from employees;
```

Count(Distinct expresion): devuelve el número de distintos valores no nulos de expresión

```
Select count(distinct department_id)
from employees;
```
## AVG 
**Importante:** al  promediar es vital considerar que las funciones de grupo ignoran los valores nulos en la columna

```
Select avg(commission_pct)
from employees;

Resultado: 0.22285
```

Forzando el uso de datos nulos en las funciones de grupo utilizando la función NVL para incluir nulos(recordar que NVL remmplaza el valor del primer parametro por el segundo, si al caso este es nulo)

```
Select avg(nvl(commission_pct,0))
from employees;

-- Resultado: 0.07289
```

 ## Group by en Funciones de Grupo 

Es importante aclarar que los group by es una solución para cuando se quieren agregar columnas, que no son de agregación (que no son el resultado de un conjunto como las funciones de grupo)

En el presente caso se obtiene el salario promedio por departamento, al agregar department_id, este se agrega en el group by. Si no se agrega será tratado como un error

```
Select department_id, AVG(salary)
from employees
group by department_id
order by department_id;
```

**Nota:** Al agregar más de alguna columna en el select, estas deben ser agregadas también en el group by

```
Select  department_id, job_id, SUM(salary)
from employees
group by department_id, job_id
order by department_id;
```

## Clausula HAVING para restringir grupos 

Having es utilizado para realizar restricciones despues de haber agrupado registros, cosa que con Where no se puede, ya que este lo hace antes de agrupar

Ejemplo 1: Obtener el salario máximo por departamento, pero solo aquellos que son mayor a 10,000

```
Select department_id, max(salary)
from employees
group by department_id
having max(salary) > 10000;
```

ejemplo 2: Para este caso se pretende mostrar el orden en que se colucan las clausulas: 
                  **GROUP BY -> HAVING -> ORDER BY**

```
Select job_id, sum(salary)
from employees
where job_id like '%REP%'
group by job_id
having sum(salary) > 10000
order by job_id;
```

# Mostrar datos de múltiples tablas usando Joins 

## Tipos de Join 

Los Join son compatibles con SQL: El Estandar 1999 incluye los siguientes

| Join                 | Clausula   |
|  ---                 |  ---       |
| Natural Join         | NATURAL JOIN  |
| JOIN                 | JOIN USING    |
| JOIN                 | JOIN ON       |
| Outer joins          | LEFT OUTER JOIN, RIGHT OUTER JOIN y FULL OUTER JOIN |
| Cross Join           | CROSS JOIN |

## Sintaxis

```
 Select   table1.column, table2.column
 From     table1
 [NATURAL JOIN table2]   |
 [JOIN table2 USING (column_name)]    |
 [JOIN table2 ON    (table1.column = table2.column)]  |
 [LEFT|RIGHT|FULL OUTER JOIN table2 ON (table1.column = table2.column)]   |
 [CROSS JOIN table2];
```

## NATURAL JOIN
Se basa en todas las columnas de las dos tablas que tienen el mismo nombre, seleccionando las filas de las dos tablas que tienen valores iguales en todas las columnas coincidentes. 
**Nota:** Si las columnas que tienen los mismos nombre son de diferente tipo, se devuelve un error. 

```
Select employee_id, last_name, department_id, department_name
From employees
    Natural Join departments;
```

## USING

Para especificar las columnas con las que se desea hacer la unión
```
Select employee_id, last_name, department_id, department_name
From employees
    Join departments using (department_id);
```

**Observación 1:** No cualificar una columna que se utiliza en la clausula USING. Si se quiere utilizar una columna cualificada no se debe ocupar el alias. por ejemplo: **location_id** 

```
Select l.city, d.department_name
From  locations l
    Join departments d using (location_id)
where location_id = 1400;
```

**Observación 2:** la columna cualificada no tendrá alias ni en el where, ni el select ni ninguna otra parte

```
Select e.employee_id, e.last_name, department_id, d.department_name
From employees e
    Join departments d using (department_id)
Where department_id = 30;
```

## ON

Sirve para especificar las condiciones arbitrarias o especificar columnas a unirse

```
Select e.employee_id, e.last_name, e.department_id , d.department_id, d.department_name
From employees e
    Join departments d
    On (e.department_id = d.department_id);
```

Si deseamos añadir condiciones se podría mediante AND o WHERE. Ambas devuelven el mismo resultado, pero en terminos de performance es recomendable AND.

Utilizando AND

```
Select e.employee_id, e.last_name, e.department_id , d.department_id, d.department_name
From employees e
    Join departments d
    On (e.department_id = d.department_id)
    And e.department_id=30
    And e.salary > 10000;
```

Utilizando WHERE

```
Select e.employee_id, e.last_name, e.department_id , d.department_id, d.department_name
From employees e
    Join departments d
    On (e.department_id = d.department_id)
    Where e.department_id=30 and e.salary > 10000;
```

Al realizar JOIN en más de una tabla

```
Select  e.last_name, d.department_name, l.city
From employees e
    Join departments d
    On (e.department_id = d.department_id)
    
    Join locations l
    On (l.location_id = d.location_id);
```

## SELF JOIN

No es una clausula más, más bien, es el hecho de hacer join con la misma tabla. Por ejemplo:

```
Select empleado.last_name, jefe.last_name
From employees empleado
    Join employees jefe
    On (empleado.manager_id = jefe.employee_id);
```

## Nonequijoins

En este caso la unión de tablas no corresponge a llaves primarias con llaves foraneas, sino en base a otros criterios, como por ejemplo:

```
 Select e.last_name, e.salary, j.grade_level
 From employees e
    Join job_grades j
    On (e.salary BETWEEN j.lowest_sal and j.highest_sal);
```

## Outer Join

### LEFT OUTER JOIN

Una combinación entre dos tablas que devuelve los resultados de la INNER join así como las filas no coincidentes de la izquierda 

```
Select e.last_name, d.department_name
From employees e
    Left outer Join departments d
    On (e.department_id = d.department_id);
``` 
**Nota:** En este caso se mostrara el Inner Join y además los empleados que no estan asignados a un departamento

### RIGHT OUTER JOIN

Una combinación entre dos tablas que devuelve los resultados de la INNER join así como las filas no coincidentes de la derecha

```
Select e.last_name, d.department_name
From employees e
    Right outer Join departments d
    On (e.department_id = d.department_id);
``` 
**Nota:** En este caso se mostrara el Inner Join y además los departamentos que no tienen asignado ningún empleado

### FULL OUTER JOIN

Una combinación entre dos tablas que devuelve los resultados de la INNER join así como las filas no coincidentes de la izquierda y de la derecha.

```
Select e.last_name, d.department_name
From employees e
    Full outer Join departments d
    On (e.department_id = d.department_id);
``` 
 **Nota:** En este caso se mostrara el Inner Join y además los departamentos que no tienen asignado ningún empleado y los empleados que no estan asignados a un departamento
    
## CROSS JOIN 

Produce el producto cruz o producto cartesiano entre dos tablas

```
Select e.last_name, d.department_name
From employees e
    Cross Join departments d;
```
Lo que es similar a hacer: 

```
Select e.last_name, d.department_name
From employees e, departments d;
```

# Uso de subconsultas 

**Ejemplo:** Mostrar los empleados que tienen un salario mayor al de Abel

**Paso 1:** Consultamos el salario de Abel 
```
Select salary
From employees
Where last_name='Abel';
```

**Paso 2:** Utilizar subconsulta 

```
Select last_name as "Emp con mayor sal ", salary
From employees
Where salary >  (Select salary
                From employees
                Where last_name='Abel');
```

## Tipos de SubConsulta

### Subconsulta de una sola fila

Se utilizan los operadores: =, <> , > , < , >= , <=

```
Select last_name as "Empleados con salario min", salary
From employees
Where salary = (Select min(salary)
                From employees);
```

Primero se hace la subconsulta y despues la consulta mayor

```
Select department_id, min(salary)
From employees
Group by department_id
Having min(salary) > (Select min(salary)
                      From employees
                      Where department_id = 50);
```

### Subconsulta de multiples filas

Al obtener más de una fila, se utilizan los siguientes operadores

| Operador     |  Significado   |
|  ---         |     ---        |
| IN           |  Igual a cualquier miembro de la lista  |
| ANY          |  Debe ir precedido de =,! =,>, <, <=,> =. Devuelve TRUE si existe al menos un elemento en el conjunto de resultados de la subconsulta para que la relación sea TRUE |
|ALL           |  Debe ir precedido de =,! =,>, <, <=,> =. Devuelve TRUE si la relación es cierto para todos los elementos en el conjunto de resultados de la subconsulta |

#### IN

Devuelve los empleados cuyo salario sea IGUAL A CUALQUIERA de los devueltos en la subconsulta

```
Select  last_name, job_id, salary
From    employees
Where   salary In (Select salary
                      From   employees
                      Where job_id = 'IT_PROG');
```

#### ANY

Devuelve los empleados cuyo salario sea menor a CUALQUIERA de los devueltos en la subconsulta

```
Select  last_name, job_id, salary
From    employees
Where   salary < Any (Select salary
                      From   employees
                      Where job_id = 'IT_PROG');
```                      
**Nota:** La diferencia más marcada entre Any e In, es que con Any se pueden utilizar no solo =, sino todos los demás operadores de <> , > , < , >= , <=
                      
#### ALL

Devuelve los empleados cuyo salario sea menor a TODOS de los devueltos en la subconsulta

```
Select  last_name, job_id, salary
From    employees
Where   salary < All (Select salary
                      From   employees
                      Where job_id = 'IT_PROG');
````

## Operador Exists, Not Exists

Devuelve true, si la subconsulta devuelve al menos un resultado

```
Select *
From departments
Where not exists (Select * 
                  From employees
                  Where employees.department_id = departments.department_id);
```                  
**Importante:** Valores Nulos

Si uno de los valores es nulo, la subconsulta no retornara ninguna fila, por lo que se debe tener especial cuidado en esto. En este caso consultamos todos aquellos empleados que no son manager

```
Select last_name
From employees 
Where employee_id NOT IN (Select manager_id
                          From employees 
                          where manager_id is not null);
```                                 
**Duda:** Al quitar el not, no es necesario hacer la validación, ¿por qué?

# Operadores Conjuntos 

## Operador Union

Devuelve las filas de ambas consultas después de la eliminación de tuplas

```
Select  employee_id, job_id
From    employees
UNION
Select  employee_id, job_id
From    job_history;
```
## Union All

Igual que union pero no elimina filas duplicadas

```
Select  employee_id, job_id
From    employees
UNION ALL
Select  employee_id, job_id
From    job_history;
```
## Intersect

Devuelve las filas que son comunes entre las consultas

```
Select  employee_id, job_id
From    employees
INTERSECT
Select  employee_id, job_id
From    job_history;
```
## Minus

Devuelve todas las filas seleccionadas por la primera consulta que no están presentes en el segundo conjunto

```
Select  employee_id
From    employees
MINUS
Select  employee_id
From    job_history;
```
##  Artificio: Coincidir Conjuntos Sentencias Select

Es importante destacar que en estas operaciones de conjunto, ambos conjuntos deben de tener la misma estructura y tipo de datos. Habrá ocasiones en que se quiera coincider dos conjuntos que no son compatibles, para eso se muestra el siguiente artificio:

```
Select  location_id, department_name    "Department", TO_CHAR(NULL) "Warehouse location"
From    departments
UNION
Select  location_id, TO_CHAR(NULL)      "Department", state_province
From locations;
```

En este caso, las columnas no compatibles se sustituyeron por: TO_CHAR(NULL)
**Nota:** Los nombres de las columnas serán dados por el primer conjunto

## Order By en Conjuntos

la clausula order by solo será admitida en la ultima sentencia.

```
Select  employee_id, job_id
From    employees
UNION
Select  employee_id, job_id
From    job_history
order by job_id;
```

# DML Lenguaje de Manipulación de Datos 

 |            Funcion           |             Descripcion                     |
 |            ---               |                  ---                        |
 | INSERT                       | Agrega una nueva fila a la tabla            |
 | UPDATE                       | Modifica las filas existentes               |
 | DELETE                       | Elimina las filas existentes                |
 | TRUNCATE                     | Elimina todas las filas de una tabla        |
 | COMMIT                       | Hace los cambios pedientes en permanentes   |
 | SAVEPONT                     | Marca un punto de salvaguarda               |
 | ROLLBACK                     | Descarta los cambios pendientes de datos    |
 | FOR UPDATE en clausula SELECT| Bloquea las filas identificadas en el SELECT|



## Insert

 *Insert implícito: Se omiten columnas que no son obligatorias*

```
Insert into departments (department_id, department_name)
                values  (280, 'QA');
```

*Insert explicito: No se especifican lo campos, poy lo que el insert espera todos los campos, por lo que los campos que no se deseen agregar se pueden poner nulos*

```
Insert into departments 
                values (290, 'Testing', NULL, NULL);
```
                
 *Copiando fila con otra tabla: En este caso la clausula **values NO** se agrega*

```
Insert into departments (department_id, department_name, manager_id, location_id)
       (Select 300, last_name, manager_id, 1000 
        From employees
        Where employee_id = 127);
```
## Update

```
Update departments
    set department_name = 'Documentadores'
where department_id = 300;
```

*Update con sub consulta*

```
Update departments
    set (department_name, manager_id) = (Select  last_name, manager_id 
                                         From employees
                                         Where employee_id = 122)
Where department_id = 300;
````

## Delete

```
Delete 
From departments
Where department_id = 300;
````

## Savepoint

```
savepoint punto;
```

## Rollback a un punto en especifico

```
rollback to punto;
```

## Rollback de todos los cambios pendientes

```
rollback;
```

## Commit

```
commit;
```
## For Update

```
Select * 
From employees
Where department_id = 50
For update;
```

# DDL Lenguaje de Definición de Datos 

## ALTER TABLE

### Alter table ADD
 Permite agregar una columna

```
Alter table author 
Add (LASTNAME varchar(50) Not Null);
```

### Alter table MODIFY
 Permite modificar la definición de una columna

```
Alter table author 
Modify (LASTNAME varchar(40));
```

### Alter table DROP
 Permite eliminar una columna

```
Alter table author
Drop (LASTNAME);
```

### Alter table RENAME COLUMN
 Permite renombrar una columna

```
Alter table author
Rename column LASTNAME to LAST_NAME;
```

### Alter table READ ONLY
 Permite configurar una tabla en solo lectura

```
Alter table author 
Read Only;
```

### Alter table READ WRITE
 Permite configurar una tabla en lectura y escritura

```
Alter table author
Read Write;
```

## Drop table name_table

Permite eliminar una tabla, al agregar **PURGE** se eliminan todos sus datos también

```
Drop table user_role;
```

## Create

```
Create table Editorial(
    editorial_id        number(8)   not null,
    editorial_name      varchar(50) not null
);
```

*Crear una table en base a otra (una consulta)*
```
Create table editorials as (
    Select * 
    from editorial
);

Describe Editorials;
```

En el siguiente caso se decide las columnas y el nombre de las columnas que se tendrá y además los datos obtenidos en la consulta se agregan en la base que estamos creando:

```
create table dpto80 as (
    Select last_name as apellido, salary*12 as "salario_anual"
    From employees
    Where department_id = 80
);

Describe dpto80;
````

## Constraint
 
### Sintaxis de constraint: 
```
constraint name_constraint [primary key | not null | Unique | check] (editorial_id)
 
Create table Editorial(
    editorial_id        number(8)   not null,
    editorial_name      varchar(50) not null,
    constraint edi_id_pk primary key(editorial_id)
);

```

*Constrain check: se puede agregar operadores between, in, etc.*

```
Alter table employees
add constraint salary_check check (SALARY > 0);
```

### Foraneas

En este caso vamos a añadir primero el atributo que será foranea en la tabla secundaria book

```
Alter table book
add (editorial_id       number(8)   not null);
````

Ahora vamos a hacer el constraint que nos permita crear la referencia de foreign key

```
Alter table book
add (constraint edi_id_fk Foreign Key (editorial_id) 
     references editorial(editorial_id));
```  

Y tambien podemos configurar el borrado, ya sea en cascada o set null, para ello primero borraremos la constraint 

```
Alter table book
drop constraint edi_id_fk;

Alter table book
add (constraint edi_id_fk Foreign Key (editorial_id) 
     references editorial(editorial_id)
     on delete cascade); 
     
Describe book;

```

# Vistas del Diccionario de datos 

Los diccionarios de datos es la metadata, es decir la deficion de todo lo que tenemos en nuestra base de datos.

La estructura de una diccionario de datos consiste en:
   - Tablas base
   - Vistas accesibles al usuario 

## Prefijo

- User: Vista del usuario (lo que está en su esquema). 
- ALL: Vista ampliada del usuario (los que se tiene en su propio esquema y los que esquemas que otros usuarios han dado acceso).
- DBA: Lo que está en los esquemas de todo el mundo.
- V$: Los datos relacionados con el rendimiento.


## Dictionary 

contiene los nombres y descripciones de las tablas de diccionario y puntos de vista

```
Describe dictionary;

Select *
From dictionary
where table_name = 'USER_OBJECTS';
```

## Objetos

```
Select  object_name, object_type, created, status
From    user_objects
order by object_type;
```

Ver aquellas tablas que son de mi usuario

```
Describe user_tables;

Select table_name
From user_tables;
```

Ver columnas de una tabla en específico

```
Describe user_tab_columns;

Select table_name, column_name
From user_tab_columns
where table_name = 'BOOK'
Order by table_name;
```

Ver los constraint de mi usuario, en una tabla x

```
Describe user_constraints;

Select constraint_name, constraint_type, search_condition, r_constraint_name, delete_rule, status
from user_constraints
where table_name = 'BOOK'
Order By constraint_type;
```

Ver constraint y en que columna se aplicó

```
Describe user_cons_columns;

Select  constraint_name, column_name
From    user_cons_columns
Where   table_name = 'BOOK';
```

## Comentarios 

Añadir comentarios al diccionario de una tabla

```
comment on table book 
        is 'Libros';
```

Añadir comentarios al diccionario de una columna

```
comment on column book.title
        is 'Titulo del libro';
 ```       

Ver comentarios de las tablas, y de los comentarios

```
Describe user_tab_comments;

Select table_name, comments
From user_tab_comments
Where table_name = 'BOOK';

Describe user_col_comments;

Select column_name, comments
From user_col_comments
Where table_name = 'BOOK';
```

**Nota:** En los ejemplos anteriores solo se utilizó el prefijo **user**.

# Secuencias

Secuencia: Genera valores numericos
   - Puede generar de forma automatica números únicos
   - Es un objteto compatible
   - Se puede utilizar para crear un valor de clave principal (para esto se ocupa normalmente)
   - Reemplaza el código de aplicación
   - Acelera el rendimiento de acceso a valores de secuencia cuando se almacena en caché en la memoria.

## Sintaxis de Sequence

```
Create sequence name_sequence
        increment  by   10
        start with      10
        maxvalue        10000
        minvalue        10
        nocache
        nocycle
        order;
```
**Nota:** puede ser nocache o cache integer, nocycle o cycle, noorder o order.                


Para acceder a los valores de sequence se puede: **Nextval**(siguiente) y **Currval**(actual)


## Aplicacion: Columna por defecto de SQL usando una secuencia

   - Sintaxis SQL para columnas que permitan valor por defecto <sequence>.nextval, <sequence>.currval como una columan SQL expresión por defecto para columnas numéricas, donde <sequence> es una secuencia de base de datos Oracle.

   - La expresión DEFAULT puede incluir la secuencia con seudo columnas CURRVAL y NEXTVAL, mientras exista la secuencia y usted tenga los privilegios necesarios para acceder a ella.


Ejemplo1: crear secuencia incremental de 1 en 1
```
Create sequence sequence_emp_id
                start with 1;
```

Vincular secuencia con una tabla, para generar id 

```
Create table emp(
        id_emp      number      default sequence_emp_id.nextval     not null,
        name_emp    varchar(50) 
);
```

Probar inserciones

```
Insert into emp(name_emp)
        values ('Edwin');
        
Insert into emp(name_emp)
        values ('Joel');
```        

Verificamos

```
Select *
From emp;


Resultado

    ID_EMP NAME_EMP                                          
---------- --------------------------------------------------
         1 Edwin                                             
         2 Joel  
```

## Los valores de secuencia Caching

   - Almacenamiento en caché de valores de secuencia en la memoria da un acceso más rápido a esos valores.

   - Pueden ocurrir lagunas o vacíos en valores de secuencia cuando: una reversión se produce, los fallos del sistema, una secuencia se utiliza en otra tabla.


## Modificando una sequence: Alter Sequence

 Reglas para la modificación de una secuencia

- Usted debe ser el propietario o tener el privilegio ALTER para la secuencia
- Sólo los números de secuencia futuros se ven afectados.
- La secuencia debe caer y volver a crear al reiniciar la secuencia en un número diferente.
- En algunos se relaiza validación.
- Para eliminar una secuencia, utilice la sentencia DROP:

```
Alter sequence sequence_emp_id
                nocache
                nocycle;
```

## Eliminar Sequence : Drop Sequence

```
Drop sequence name_sequence;
```

## Obtener información de sequence

```
Describe user_sequences;

Select *
From  user_sequences;
```

# SINONIMOS  
Da nombres alternativos a los objetos.

- Es un objeto de base de datos
- Puede ser creado para dar un nombre alternativo para una tabla o a otro objeto de base de datos
- No requiere almacenamiento que no sea su definición en el diccionario de datos
- Es útil para oculta la identidad y la ubicación de un objeto de esquema subyacente

## Creación de un sinónimo de un objeto

Simplificar el acceso a los objetos la creación de un sinónimo (otro nombre para un objeto). Con sinónimos, puede:

- Crear una referencia más fácil a una tabla que es propiedad de otro usuario.
- Acortar largos nombres del objeto

```
CREATE [Public] SYNONYM synonym
FOR    object;

Create synonym sinonimo_sequence_id
For sequence_emp_id;
```

## Consultar información de sinonimos

```
Describe user_synonyms;

Select *
From user_synonyms;
```

## Eliminar sinonimo
```
Drop synonym sinonimo_sequence_id;
```

# Indice 

Mejora el rendimiento de las consultas en la recuperación de datos

- Es un objeto de esquema.
- Puede ser utilizado por el servidor de Oracle para acelerar la recuperación de filas mediante el uso de un puntero.
- Puede reducir la entrada/salida de disco (E/S) mediante el uso de un método de acceso ruta rápida para localizar datos de forma rápida.
- Es dependiente los indices de las tablas.
- Se usa y se mantiene de forma automática por el servidor Oracle.

## ¿Cómo se crean los indices?

- Automaticamente: Un indice único se crea automáticamente cuando se define una restricción de CLAVE PRIMARIA o UNIQUE en una definición de tabla

- Manualmente: Se puede crear un índice único o no único en las columnas para acelerar el acceso a las filas.

## Sintaxis de Index

```
Create [UNIQUE] [BITMAP] INDEX name_index
On table (column1,...);
```

Ejemplo:
```
Create Index emp_last_name_idx
On employees(last_name);
```

## Aplicación: Crear índice con el Create Table

```
Create Table NEW_EMP
(
employee_id     number(6)
                primary key using index
                (Create index emp_id_idx
                 On NEW_EMP(employee_id)),
first_name      varchar2(20),
last_name       varchar2(20));
```

## Consultar indice
```
Describe user_indexes;

Select index_name, table_name
From user_indexes
Where table_name = 'NEW_EMP';

-- User_ind_columns

Describe user_ind_columns;

Select index_name, column_name
From user_ind_columns
Where table_name = 'departments';
```

## Los índices de función-base

- Un indice basado en las funciones se basa en expresiones.

- La expresión de índice se construye a partir de columnas de tabla, constantes, funciones de SQL y funciones definidas por el usuario.

Ejemplo: Este indice lo que hará que el nombre del departamento lo vuelva mayúscula, entonces al hacer consultas esto va a mejorar el rendimiento.

```
Create index upper_dept_name_idx
On departments(UPPER(department_name));

Select *
From    departments
Where   UPPER(department_name) = 'SALES';
```

## Creación de varios indices en el mismo conjunto de columnas

- Puede crear varios índices en el mismo conjunto de columnas.
- Múltiples índices se pueden crear en el mismo conjunto de columnas sí:
   - Los índices son de diferentes tipos
   - Los índices utilizan diferentes particionamiento
   - Los índices tienen diferentes propiedades de unicidad

Ejemplo: para este caso hacemos alter en emp_id_name_idx1 haciendolo invisible para así poder crear el otro indice bajo el mismo conjunto de columnas

```
Create index emp_id_name_idx1
On employees(employee_id, first_name);

Alter index emp_id_name_idx1 invisible;

Create bitmap index emp_id_name_idx2 
On employees(employee_id, first_name);
```

## Directrices de la creación de indice

Cree un índice cuando:

- Una columna contiene una amplia gama de valores
- una columna contine un gran número de valores nulos
- Una o más columnas se utilizan con frecuencia juntos en una cláusula WHERE o una condición de unión
- La tabla es grande y se espera que la mayoría de las consultas para recuperar menos de 2% a 4% de las filas de la tabla.

No cree un índice cuando:

- Las columnas no se utilizan a menudo como un condición en la consulta.
- La tabla es pequeña o se espera que la mayoría de consultas para recuperar más de un 2% a un 4% de las filas de la tabla.
- La tabla se actualiza con frecuencia
- las columnas indexadas se hace referencia como parte de una expresión.

# Vistas 

Lógicamente representa subconjunto de los datos de unas o más tablas
 
## Ventajas
 
 - Para restringir acceso a datos
 - Para proporcionar independencia de datos
 - Para hacer consultas complejas fáciles
 - Para representar diferencres vistas de los mismos datos
 
## Vistas simple y complejas
 
 |           Caracteristica              |   Vistas simples  |   Vistas complejas    |  
 |               ---                     |       ---         |       ---             |
 | Numeros de tablas                     |       Uno         |   Uno o más           |
 | Contiene funciones                    |       No          |   Si                  |
 | Contiene grupos de datos              |       No          |   Si                  |
 | Operaciones DML a través de una vista |       Si          |   No siempre          |  
 
## Sintaxis de vista

```
  CREATE [OR REPLACE] [FORCE | NOFORCE] VIEW view
    [(alias,...)]
  AS Subquery
  [WITH CHECK  OPTION [CONSTRAINT constraint]]
  [WITH READ ONLY [CONSTRAINT constraint]];
```
La subconsulta puede contener sintaxis SELECT complejo.
 
**Nota:** antes de crear vistas, le daremos permisos para crealas al usuario hr, con el usuario SYSTEM
 
 ```
 grant create synonym to hr;
 grant create view to hr;
 ```
 
 ## Creación de vistas simples
 
 ```
 Create view empvu80
 As (Select employee_id, last_name, salary
     From   employees
     Where  department_id = 80);
     
Describe empvu80;

 Resultado
  Nombre      ¿Nulo?   Tipo         
 ----------- -------- ------------ 
 EMPLOYEE_ID NOT NULL NUMBER(6)    
 LAST_NAME   NOT NULL VARCHAR2(25) 
 SALARY               NUMBER(8,2)
 ```
 
## Recuperando datos de una vista
 
 ```
 Select *
 From empvu80;
 ```
 
## Modificando una vista
 
 En este caso, se le asignaran alias a la vista, en vez de usar los que trae la tabla originalmente
 
 ```
 Create or Replace View empvu80
    (id_number, name, sal, department_id)
 As (Select employee_id, first_name || ' ' || last_name, salary, department_id
     From employees
     Where department_id = 80);
 ```
 
## Creación de vistas complejasç
 
 Utilizando funciones de agregación, joins, etc.
 ```
 Create Or Replace View dept_sum_vu
    (name, minsal, maxsal, avgsal)
 As (Select d.department_name, min(e.salary), max(e.salary), avg(e.salary)
     From employees e 
     Join departments d Using(department_id)
     group by d.department_name);
     
Select *
From dept_sum_vu;
```

## Ver información de las vistas
```
Describe user_views;
     
Select view_name, text
From user_views;
```

## Reglas para realización de operaciones DML en una vista

Generalmente, usted puede realizar operaciones DML en vistas simples

No se puede eliminar una fila si la vista contine lo siguiente:
    - Funciones de grupo
    - Una clausula GROUP BY
    - La palabra clave DISTINCT
    - La palabra reservada ROWNUM

No se puede modificar los datos en una vista si contiene
    - Funciones de grupo
    - Una clausula GROUP BY
    - La palabra clave DISTINCT
    - La palabra reservada ROWNUM
    - Columnas definidas por expresiones

No se pueden agregar datos a través de una vista si la vista incluye
    - Funciones de grupo
    - Una clausula GROUP BY
    - La palabra clave DISTINCT
    - La palabra reservada ROWNUM
    - Columnas definidas por expresiones
    - Columnas NOT NULL sin valor por defecto en las tablas de base que no están señeccionados por la vista

## Uso de la cláusula WITH CHECK OPTION

Puede asegurar de que las operaciones de DML se realizaron en la estancia de la vista en el dominio de la vista mediante la cláusula WITH CHECK OPTION

```
Create or replace view empvu20
as (Select  *
    From    employees
    Where   department_id = 20)
    WITH CHECK OPTION constraint empvu20_ck;
```   
 **Nota:** Cualquier intento de de insertar una fila con un department_id diferente de 20 o para actualizar el número de departamento para cualqueir fila en la vista falla porque viola la restricción WITH CHECK OPTION.

## Denegar Operaciones DML

- Puede asegurar de que no hayan operaciones de DML ocurran mediante la adición de la opción **WITH READ ONLY** para su definición de la vista.
- Cualquier intento de realizar una operación de DML en cualquier fila de la vista da resultados de error en el servidor Oracle.

## Eliminar vista
```
Drop view empvu80;
```

# SubConsulta 

## Subsonsutas Escalares

Es una subconsulta que devuelve exactamente un valor de columna de una fila

## Subconsultas Par

```
Select  employee_id, manager_id, department_id
From    employees
Where   (manager_id, department_id) IN (Select manager_id, department_id
                                        From employees
                                        Where first_name = 'John')
    And first_name <> 'John'
    order by employee_id;
```
  
## Subconsulta no par    

```                                        
Select  employee_id, first_name, manager_id, department_id
From    employees
Where   (manager_id) IN (Select manager_id
                                        From employees
                                        Where first_name = 'John')
    And (department_id) IN (Select department_id
                                        From employees
                                        Where first_name = 'John')
    And first_name <> 'John'
    order by employee_id;
 ```   
    
## Sub consulta en CASE
```
Select employee_id, first_name,
    (case 
        when  department_id = (Select department_id
                                From departments
                                Where location_id = 1800) 
            then 'Canada'
        else 'USA'
    end) as "location"
From employees;
```
## Subconsultas en Order by
```
Select  employee_id, last_name
From    employees e
order by (Select department_name
            From departments d
            Where e.department_id = d.department_id);
```

## Subconsultas Correlacionadas

Subconsultas correlacionadas se utilizan para el procesamiento de fila por fila. Cada subconsulta se ejecuta una vez por cada fila de la columna externa

En este ejemplo, por cada fila se hace la consulta del salario promedio de su departamento, para así hacer la respectiva evaluación
Es decir, que cada vez que una fila de la consulta externa se procesa, se evalúa la consulta interna

```
Select last_name, salary, department_id
From    employees tabla_externa
Where   salary > (Select AVG(salary)
                    From    employees tabla_interna
                    Where   tabla_interna.department_id = tabla_externa.department_id);
```

## Operador Exists en Subconsultas

Prueba la existencia de filas en el conjunto de resultados de la subconsulta

Si un valor de la fila de la subconsulta se encuentra:
   - La busqueda no se continúa en la consulta interna
   - La condición se encuentra en valor VERDADERO

Si un vslor de la fila de la subconsulta **NO** se encuentra:
   - La busqueda se continúa en la consulta interna
   - La condición se encuentra en valor FALSO

Ejemplo: Consultar empleados que son manager
```
Select employee_id, last_name, job_id, department_id
From    employees tabla_externa
Where   EXISTS ( Select 'X'
                From    employees tabla_interna
                Where   tabla_interna.manager_id = tabla_externa.employee_id);
```

## Operador Not Exists en Subconsultas

Ejemplo: Obtener departamentos que no tienen empleados

```
Select department_id, department_name
From    departments tabla_externa
Where NOT EXISTS (Select 'X'
                    From employees tabla_interna
                    Where tabla_interna.department_id = tabla_externa.department_id); 
```

## Clausula WITH

- El uso de cláusula WITH, puede usar el mismo bloque de consulta en una sentencia SELECT cuando se presenta más de una vez dentro de una consulta compleja

- La cláusula WITH recupera los resultados de un bloque de consulta y lo almacena en tablas temporales del usuario

- la cláusula WITH puede mejorar el rendimiento

- Divide y venceras

En la siguiente consulta
   - Costo_departamento:  suma de salario por departamento
   - costo promedio: salario promedio de los totales de departamento
   - En el select se muestran aquellos departamentos cuya suma de salarios sea mayor al promedio

```
With

costo_departamento As (Select d.department_name, SUM(e.salary) as total_dep
                        From employees e 
                        Join departments d
                        On (e.department_id = d.department_id)
                        group by d.department_name),

costo_promedio     As (Select (SUM(total_dep)/ COUNT(*)) as promedio_dep  
                        From costo_departamento)

Select *
From costo_departamento
Where total_dep > (Select promedio_dep
                            From costo_promedio)
Order By department_name;
```

## WITH Recursiva

- permite la formulación de consultas recursivas
- crea una consulta con un nombre, llamado el WITH nombre del elemento recursivo
- Continene dos tipos de miembros de bloque de consulta: un ancla y un recursivo
- Es compatible con ANSI

# Controlando el acceso a Usuarios 

## Crear Usuarios
```
alter session set "_ORACLE_SCRIPT" = true;

Create user edwin identified by pass;
```
## Crear Role
```
Create Role tester;
```
## Dar privilegios a usuarios o roles

Sintaxis: 
```
 Grant privilegio 
 to user;

Grant create session, create table, create sequence, create view
to edwin;

Grant create table, create view
to tester;
```

## Otorgar Role a Usuario
```
Grant tester to edwin;
```
## Cambiar la contraseña de usuario
```
Alter user edwin identified by newpass;
```
## Consultar privilegios Otorgados mediante la vista del diccionarios de datos

|   Vista del Diccionarioo de datos  |                           Descripción                       |
|    ---                             |                            ---                              |
|   ROLE_SYS_PRIVS                   | Privilegios de Sistema otorgado a roles                     |
|   ROLE_TAB_PRIVS                   | Privilegios de tabla otorgado a roles                       |
|   USER_ROLE_PRIVS                  | Roles accesibles por el usuario                             | 
|   USER_SYS_PRIVS                   | Privilegios de sistema otorgado a los usuarios              |
|   USER_TAB_PRIVS_MADE              | Privilegios de objetos otorgados en los objetos de usuarios |
|   USER_TAB_PRIVS_RECD              | Privilegios de objetos otorgados al usuario                 |
|   USER_COL_PRIVS_MADE              | Privilegios de objetos otorgados sobre las columnas de objetos de usuarios |     
|   USER_COL_PRIVS_RECD              | Privilegios de objeto otorgados a laos usuarios sobre específicas columnas |


# ANALITIC SQL FOR DATA WAREHOUSING 

Oracle ha introducido muchas operaciones SQL para realizar operaciones analíticas  en la base de datos.

 - Estas operaciones incluyen clasificación, promedios móviles, sumas acumulativas, ratios-informes y comparaciones de período a período.
 - Aunque anteriormente algunos de estos cálculo eran posibles utilizando SQL, esta sintaxis ofrece un rendimiento mucho mejor.
 Group By con los operadores ROLLUP y CUBE
 - Use ROLLUP o CUBE con Group BY para producir filas superagregadas mediante columnas de referencias cruzadas.
  
##  ROLLUP
 
  - Produce un conjunto de resultados que contiene las filas agrupadas regulares y los valores de subtotal y total general
  - Es un extensión de la clausula GROUP BY
  - Use la operación ROLLUP para producir agregados acumulativos, como subtotales.
  - Utilizado, para hacer operaciones de agregación para múltiples niveles en una jerarquía
 
 ```
 SELECT department_id, job_id, SUM(salary)
 FROM   employees
 WHERE  department_id < 60
 Group by rollup (department_id, job_id);
 
 
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
 ```
 
 ### ROLLUP Equivalente ocupando Grouping Sets
 
 Nota: Grouping sets permite agregar más de un conjunto de agrupación al group by
 ```
 SELECT department_id, job_id, SUM(salary)
 FROM   employees
 WHERE  department_id < 60
 Group by grouping sets (
            (department_id, job_id),
            (department_id),
            ());
  ```          
 ### ROLLUP Equivalente ocupando Union All
 
 ```
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
 ```
 
## CUBE
 
 - Produce un conjunto de resultados que contiene las filas de ROLLUP y las de filas de tabulación cruzada.
 - CUBE es una extensión de la clásula GROUP BY
 - Puede usar el operador CUBE para generar valores de tabulación cruzada con una sola instrucción SELECT,
   es decir, produce el resultado conjunto de todas las combinaciones de los atributos específicados en el 
   GROUP BY.
   
   Ejemplo: Recuperar la suma de los salarios agrupados por todas las combinaciones de departamento y puesto
            de trabajo, así como obtener el gran total
            
Paso 1: Agrupamos

Select department_id, job_id, SUM(salary)
From employees
WHERE department_id < 60
Group by (department_id, job_id);

Paso 2: Aplicamos CUBE, que nos permitirá ver los subtotales por job_id, subtotales por departamento, subtotales  por departamento y job_id y el total global.

```
Select department_id, job_id, SUM(salary)
From employees
WHERE department_id < 60
Group by CUBE (department_id, job_id);

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
```

### CUBE Equivalente en GROUPING SETS
```
Select department_id, job_id, SUM(salary)
FROM employees
Where department_id < 60
Group by GROUPING SETS (
          (department_id,job_id),
          (department_id),
          (job_id),
          ()
        );
       
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
```

### CUBE Equivalente en UNION ALL
```
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
```


