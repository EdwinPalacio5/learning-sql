# Learning-SQL

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
**Nota:** cuando es más de una palabra es necesario escribir el alias en comillas

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
**Nota:** en textos se debe buscar con comillas: 'texto', en fecha es formato DD-MM-AA

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
 
