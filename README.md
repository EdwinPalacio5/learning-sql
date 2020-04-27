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
