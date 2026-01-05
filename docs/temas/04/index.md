# **DML. Consultas Básicas**

!!! info "Información de la unidad"

    === "Contenidos"

        Realización de consultas:

        - Proyección, selección y ordenación de registros.
        - Operadores. Operadores de comparación. Operadores lógicos.
        - Composiciones internas.
        - Composiciones externas.
        - Consultas de resumen.
        - Agrupamiento de registros.

        Bases de datos relacionales:

        - Vistas.
  
    === "Propuesta didáctica"

          Una vez conocido el modelo relacional, en esta unidad vamos a comenzar a trabajar el RA3 "**Consulta la información almacenada en una base de datos empleando asistentes, herramientas gráficas y el lenguaje de manipulación de datos.**",

          Criterios de evaluación

        - **CE3a**: Se han identificado las herramientas y sentencias para realizar consultas.
        - **CE3b**: Se han realizado consultas simples sobre una tabla.
        - **CE3c**: Se han realizado consultas sobre el contenido de varias tablas mediante composiciones internas.
        - **CE3d**: Se han realizado consultas sobre el contenido de varias tablas mediante composiciones externas.definición y control de datos.
        - **CE3e**: Se han realizado consultas resumen.
        - **CE2f**: Se han creado vistas.


!!! info "Bases de datos recursos"

    Aquí tienes los enlaces a las bases de datos de recursos para esta unidad:

    - [Liga de Fútbol](res/liga_futbol.md)
    - [Gestión de Ventas](res/gestion_ventas.md)
    - [Jardinería](res/jardineria.md)
    - [Universidad A](res/UniversidadA.md)
    - [Universidad B](res/UniversidadB.md)


## Álgebra Relacional

El álgebra relacional es un lenguaje formal utilizado para realizar consultas y operaciones sobre bases de datos relacionales. Fue propuesto por _Edgar F. Codd_ en 1970 como parte de su trabajo en la teoría de bases de datos relacionales. En lugar de ser un lenguaje de programación como SQL, es un conjunto de operaciones matemáticas que permiten manipular conjuntos de datos (relaciones o tablas) de una manera lógica y estructurada.

### Operaciones

Las operaciones que podemos realizar son:

| Operación | Notación | Descripción |
| --- | --- | --- |
| **Selección** | **σ**<sub>condición</sub>(Relación) | Selecciona las tuplas que cumplen una condición específica. |
| **Proyección** | **π**<sub>atributos</sub>(Relación) | Devuelve una nueva relación con solo las columnas seleccionadas. |
| **Unión** | Relación1 **∪** Relación2 | Combina las tuplas de dos relaciones con el mismo esquema. |
| **Intersección** | Relación1 **∩** Relación2 | Devuelve las tuplas que están en ambas relaciones. |
| **Diferencia** | Relación1 **−** Relación2 | Devuelve las tuplas que están en la primera relación pero no en la segunda. |
| **Producto cartesiano** | Relación1 **×** Relación2 | Combina cada tupla de la primera relación con cada tupla de la segunda. |
| **Renombrar** | **ρ**<sub>nuevoNombre</sub>(Relación) | Cambia el nombre de una relación o de sus atributos. |
| **Join natural** | Relación1 **⨝** Relación2 | Une dos relaciones en función de un atributo común de forma implícita. |
| **Join equi** | Relación1 **⨝**<sub>condición</sub> Relación2 | Une dos relaciones en función de una condición, normalmente una igualdad. |

**Ejemplos Prácticos**

A continuación se muestran ejemplos detallados de cada operación. Utilizaremos las siguientes tablas de datos como punto de partida:

#### Datos de Referencia

=== "Empleados"
    | ID | Nombre | DeptID | Salario |
    |--- |--- |--- |--- |
    | 1 | Ana | 10 | 2500 |
    | 2 | Luis | 10 | 3000 |
    | 3 | Eva | 20 | 2800 |
    | 4 | Juan | 30 | 2200 |

=== "Departamentos"
    | DeptID | NombreDept |
    |--- |--- |
    | 10 | Ventas |
    | 20 | Marketing |
    | 30 | Logística |

=== "GrupoA"
    *(Para operaciones de conjuntos)*

    | ID | Nombre |
    |--- |--- |
    | 1 | Ana |
    | 2 | Luis |

=== "GrupoB"
    *(Para operaciones de conjuntos)*

    | ID | Nombre |
    |--- |--- |
    | 2 | Luis |
    | 5 | Pedro |

---

#### Operaciones simples

##### Operaciones Básicas y de Esquema

=== "Selección (**σ**)"
    *Objetivo:* Obtener los empleados con un salario superior a 2600.

    **σ**<sub>Salario > 2600</sub>(Empleados)

    | ID | Nombre | DeptID | Salario |
    |--- |--- |--- |--- |
    | 2 | Luis | 10 | 3000 |
    | 3 | Eva | 20 | 2800 |

=== "Proyección (**π**)"
    *Objetivo:* Mostrar solo el nombre y el salario de los empleados.

    **π**<sub>Nombre, Salario</sub>(Empleados)

    | Nombre | Salario |
    |--- |--- |
    | Ana | 2500 |
    | Luis | 3000 |
    | Eva | 2800 |
    | Juan | 2200 |

=== "Renombrar (**ρ**)"
    *Objetivo:* Cambiar el nombre de la relación `Departamentos` a `Areas` y sus columnas a `Cod` y `Desc`.

    **ρ**<sub>Areas(Cod, Desc)</sub>(Departamentos)

    | Cod | Desc |
    |--- |--- |
    | 10 | Ventas |
    | 20 | Marketing |
    | 30 | Logística |

##### Operaciones de Conjuntos

=== "Unión (**∪**)"
    *Objetivo:* Unir los integrantes del GrupoA y GrupoB (sin duplicados).

    GrupoA **∪** GrupoB

    | ID | Nombre |
    |--- |--- |
    | 1 | Ana |
    | 2 | Luis |
    | 5 | Pedro |

=== "Intersección (**∩**)"
    *Objetivo:* Encontrar quiénes están en ambos grupos.

    GrupoA **∩** GrupoB

    | ID | Nombre |
    |--- |--- |
    | 2 | Luis |

=== "Diferencia (**−**)"
    *Objetivo:* Personas que están en el GrupoA pero **no** en el GrupoB.

    GrupoA **−** GrupoB

    | ID | Nombre |
    |--- |--- |
    | 1 | Ana |

    *(Luis se elimina porque está en ambos)*

=== "Producto Cartesiano (**×**)"
    *Objetivo:* Combinar cada fila del GrupoA con cada fila de Departamentos.
    *(Total filas = 2 filas GrupoA × 3 filas Departamentos = 6 filas)*

    GrupoA **×** Departamentos

    | ID | Nombre | DeptID | NombreDept |
    |--- |--- |--- |--- |
    | 1 | Ana | 10 | Ventas |
    | 1 | Ana | 20 | Marketing |
    | 1 | Ana | 30 | Logística |
    | 2 | Luis | 10 | Ventas |
    | 2 | Luis | 20 | Marketing |
    | 2 | Luis | 30 | Logística |

##### Composiciones

=== "Join Natural (**⨝**)"
    *Objetivo:* Unir `Empleados` y `Departamentos` usando la columna común `DeptID`.

    Empleados **⨝** Departamentos

    | ID | Nombre | Salario | DeptID | NombreDept |
    |--- |--- |--- |--- |--- |
    | 1 | Ana | 2500 | 10 | Ventas |
    | 2 | Luis | 3000 | 10 | Ventas |
    | 3 | Eva | 2800 | 20 | Marketing |
    | 4 | Juan | 2200 | 30 | Logística |

=== "Join Equi (**⨝**)"
    *Objetivo:* Unir tablas especificando la igualdad explícitamente (ej: `Empleados.DeptID = Departamentos.DeptID`).
    *Nota: A diferencia del natural, el equi-join estándar suele conservar ambas columnas de unión.*

    Empleados **⨝**<sub>Empleados.DeptID = Departamentos.DeptID</sub> Departamentos

    | ID | Nombre | DeptID | Salario | DeptID | NombreDept |
    |--- |--- |--- |--- |--- |--- |
    | 1 | Ana | 10 | 2500 | 10 | Ventas |
    | 2 | Luis | 10 | 3000 | 10 | Ventas |
    | 3 | Eva | 20 | 2800 | 20 | Marketing |
    | 4 | Juan | 30 | 2200 | 30 | Logística |

##### Operaciones Combinadas

=== "Selección y Proyección"
    *Objetivo:* Obtener solo el nombre de los empleados del departamento 10.
    *Lógica:* Primero seleccionamos (**σ**) las filas y de ese resultado, nos quedamos (**π**) con la columna nombre.

    **π**<sub>Nombre</sub>(**σ**<sub>DeptID = 10</sub>(Empleados))

    *Paso 1: Selección (DeptID = 10)*
    
    | ID | Nombre | DeptID | Salario |
    |--- |--- |--- |--- |
    | 1 | Ana | 10 | 2500 |
    | 2 | Luis | 10 | 3000 |

    *Paso 2: Proyección (Nombre)*

    | Nombre |
    |--- |
    | Ana |
    | Luis |

=== "Join y Selección"
    *Objetivo:* Obtener los datos completos de empleados del departamento 'Ventas'.
    *Lógica:* Primero unimos (**⨝**) las tablas para tener toda la info, y luego filtramos (**σ**) por el nombre del departamento.

    **σ**<sub>NombreDept = 'Ventas'</sub>(Empleados **⨝** Departamentos)

    *Paso 1: Join Natural* (Resultado intermedio)

    | ID | Nombre | Salario | DeptID | NombreDept |
    |--- |--- |--- |--- |--- |
    | 1 | Ana | 2500 | 10 | Ventas |
    | 2 | Luis | 3000 | 10 | Ventas |
    | 3 | Eva | 2800 | 20 | Marketing |
    | 4 | Juan | 2200 | 30 | Logística |

    *Paso 2: Selección (NombreDept = 'Ventas')*

    | ID | Nombre | Salario | DeptID | NombreDept |
    |--- |--- |--- |--- |--- |
    | 1 | Ana | 2500 | 10 | Ventas |
    | 2 | Luis | 3000 | 10 | Ventas |


Estas operaciones forman la base teórica de cómo las bases de datos relacionales manipulan los datos y son fundamentales para comprender el funcionamiento de lenguajes como SQL.

### Consultas SQL

En el tema anterior estudiamos tanto la parte DDL del lenguaje. En este tema y las siguientes nos vamos a centrar en las consultas, que formarían parte de DML, y más en concreto de DQL (_Data Query Language_). Para ello, utilizaremos la sentencia `SELECT` definiendo consultas que pueden ocupar una línea o varias decenas, que acceden a una única tabla (o vista), o a múltiples tablas combinadas mediante el uso de _joins_, e incluso que utiliza diversos esquemas dentro de la misma base de datos.

Así pues, entremos en detalle en la sentencia **`SELECT ... FROM`**. Su sintaxis completa, con las opciones más frecuentes, tanto para [MariaDB](https://mariadb.com/kb/en/select/) como para _PostgreSQL_ es:

```sql
SELECT {* | [DISTINCT] {columna | expresión} [[AS] alias], ... } 
FROM tabla 
    [WHERE condición] 
    [GROUP BY col1 [, col2] ...] 
    [HAVING predicado grupo] 
    [ORDER BY col-n| pos-n [ASC|DESC] , col-m| pos-m [ASC|DES]…] 
    [LIMIT {[offset,] row_count | row_count OFFSET offset}];
```

En todo consulta siempre deberemos indicar qué datos queremos recuperar y de dónde lo haremos. Tras ejecutar una consulta obtendremos una tabla de datos, que puede tener una o varias columnas y ninguna, una o varias filas.

!!! info "Formato"
    A la hora de escribir una consulta, podemos dividirla en varias líneas para facilitar su legibilidad. Recuerda que hasta que no encuentre el carácter de `;`, el intérprete SQL no ejecutará la consulta.

    Además, podemos utilizar espacios o tabuladores para indentar el código:

    ```sql
    -- Todo en una línea 
    select nombre, apellido, fechaNacimiento from Jugador order by fechaNacimiento desc; 
    
    -- En líneas separadas 
    select nombre, apellido, fechaNacimiento 
    from Jugador 
    order by fechaNacimiento desc; 
    
    -- En líneas separadas, con atributos en diversas líneas 
    select nombre, 
        apellido, 
        fechaNacimiento 
    from Jugador 
    order by fechaNacimiento desc;
    ```


### Proyección

Para seleccionar campos utilizaremos bien **`*`** para indicar que queremos todas las columnas, o indicaremos de uno en uno el nombre de los campos que queremos recuperar;

Para renombrar las columnas obtenidas, tras cada columna, mediante **`as`** podemos indicarle un alias a cada una de ellas:

```sql
SELECT nombre AS Nombre_Completo, añoFundacion AS Fundado FROM Equipo LIMIT 3;
```

| Nombre_Completo | Fundado |
| :--- | :--- |
| Real Madrid CF | 1902 |
| FC Barcelona | 1899 |
| Atletico de Madrid | 1903 |

#### Duplicados

Si realizamos la siguiente consulta sobre la tabla `Jugador`, obtendremos todos las posiciones de los jugadores. Como podéis observar, aparecen repetidas, porque obtenemos una fila por jugador existente en la tabla:

```sql
SELECT posicion FROM Jugador LIMIT 7;
```

| posicion |
| :--- |
| Portero |
| Defensa |
| Defensa |
| Defensa |
| Centrocampista |
| Delantero |
| Centrocampista |

Si nos interesa recuperar datos que no contengan repetidos, podemos emplear **`distinct`**:

```sql
SELECT DISTINCT posicion FROM Jugador;
```

| posicion |
| :--- |
| Portero |
| Defensa |
| Centrocampista |
| Delantero |

#### Operaciones aritméticas

Cada vez que hacemos referencia a un campo o un valor, también podemos realizar operaciones aritméticas sobre el valor de los campos (`+`, `-`, `*`, `/`, `%`, ...)

Por ejemplo, mediante la siguiente consulta podemos obtener de cada jugador, su nombre y altura, y su altura en centímetros (multiplicando por 100):

```sql
SELECT nombre, altura, altura * 100 AS Altura_CM FROM Jugador LIMIT 3;
```

| nombre | altura | Altura_CM |
| :--- | :--- | :--- |
| Thibaut | 2.00 | 200 |
| Daniel | 1.73 | 173 |
| Eder | 1.86 | 186 |

Además, podemos hacer cálculos sobre cálculos de otras columnas previas, utilizando asignaciones. Para ello, asignamos el resultado de una expresión a una variable a la que anteponemos el símbolo `@`. De esta forma, podemos usar dicha variable a lo largo de nuestra consulta:

```sql
SELECT @max_peso := MAX(peso) FROM Jugador;
SELECT nombre, peso FROM Jugador WHERE peso = @max_peso;
```

| nombre | peso |
| :--- | :--- |
| Thibaut | 96 |

!!! info "El operador CASE"

    El operador [CASE](https://mariadb.com/kb/en/case-operator/) permite agregar a la proyección la estructura lógica condicional de `if/else`. Su sintaxis es la siguiente:

    ```sql
    CASE campo 
        WHEN [valor1] THEN resultado 
        [WHEN [valor2] THEN resultado ...] 
        [ELSE resultado] 
    END 

    CASE 
        WHEN [condición] THEN resultado 
        [WHEN [condición] THEN resultado ...] 
        [ELSE resultado] 
    END
    ```

    Por ejemplo, a la hora de mostrar los jugadores, si queremos que cuando el mentor no esté asignado muestre `Sin Mentor` haríamos:

    ```sql
    SELECT nombre, CASE WHEN mentorID IS NULL THEN 'Sin Mentor' ELSE mentorID END AS Mentor_Status FROM Jugador LIMIT 3;
    ```

    | nombre | Mentor_Status |
    | :--- | :--- |
    | Thibaut | Sin Mentor |
    | Daniel | Sin Mentor |
    | Eder | Sin Mentor |

    Veamos otro ejemplo. En el caso de las temporadas, la columna `esActiva` indica si la temporada está en curso. Si quisiéramos mostrar la frase `En Curso` o `Finalizada` para estos casos haríamos:

    ```sql
    SELECT nombre, CASE WHEN esActiva THEN 'En Curso' ELSE 'Finalizada' END AS Estado_Temporada FROM Temporada;
    ```

    | nombre | Estado_Temporada |
    | :--- | :--- |
    | 2022-2023 | Finalizada |
    | 2023-2024 | Finalizada |
    | 2024-2025 | En Curso |

### Funciones

A la hora de recuperar o filtrar datos, es muy común utilizar [funciones](https://mariadb.com/kb/en/built-in-functions/) que facilitan el trabajo con cadenas, cálculos numéricos, etc.. Como ya has estudiado en el módulo profesional de _Programación_, las funciones reciben uno o más datos de entrada, también conocidos como parámetros (aunque existen algunas funciones que no reciben ninguno), y devuelven un resultado en base a los datos de entrada.

Cabe destacar que las funciones no están completamente estandarizadas entre los diferentes SGBD, así pues, conviene revisar la sintaxis exacta en el caso de migrar de un sistema a otro.

#### Funciones agregadas

Se emplean para realizar cálculos sobre el total de elementos de la consulta (o agrupación). Tras el `SELECT` indicaremos la función (o funciones) a realizar sobre el total de elementos devueltos por la consulta.

Vamos a comenzar contando la cantidad de filas mediante la función [`COUNT(expr)`](https://mariadb.com/kb/en/count/) pasándole como expresión `*`, lo cual indica que utilice todas las columnas, independientemente de su valor:

```sql
SELECT COUNT(*) FROM Jugador;
```

| COUNT(*) |
| :--- |
| 150 |

Si queremos recuperar cuantos elementos diferentes tenemos de un campo, en la expresión usaremos `DISTINCT`:

```sql
SELECT COUNT(DISTINCT posicion) FROM Jugador;
```

| COUNT(DISTINCT posicion) |
| :--- |
| 4 |

Otras funciones de agregación que podemos emplear son:

- [`SUM(expr)`](https://mariadb.com/kb/en/sum/): Suma todos los valores de una expresión/columna
- [`MIN(expr)`](https://mariadb.com/kb/en/min/) / [`MAX(expr)`](https://mariadb.com/kb/en/max/): Mínimo o máximo de una expresión/columna
- [`AVG(expr)`](https://mariadb.com/kb/en/avg/): Valor medio de una expresión/columna

```sql
SELECT SUM(peso) as Total, MIN(peso) as Minimo, MAX(peso) as Maximo, AVG(peso) as Media FROM Jugador;
```

| Total | Minimo | Maximo | Media |
| :--- | :--- | :--- | :--- |
| 11250 | 60 | 96 | 75 |

En la próxima unidad estudiaremos como podemos [agregar datos](https://aitor-medrano.github.io/bd/07sql-group.html#agregaciones) por algunas columnas y realizar cálculos sobre ellas, lo que nos permitirá obtener información del tipo _"Altura media de los equipos"_, _"Peso medio por posición"_, etc...

#### Cadenas

Mediante [funciones de cadenas de texto](https://mariadb.com/kb/en/string-functions/) podemos realizar múltiples operaciones:

- [`CONCAT(cadena1, cadena2, …)`](https://mariadb.com/kb/en/concat/): permite unir/concatenar cadenas
- [`LOWER(cadena)` / `LCASE(cadena)`](https://mariadb.com/kb/en/lower/): transforma `cadena` a minúsculas
- [`UPPER(cadena)` / `UCASE(cadena)`](https://mariadb.com/kb/en/upper/): transforma `cadena` en MAYÚSCULAS
- [`LEFT(cadena, longitud)`](https://mariadb.com/kb/en/left/) / [`RIGHT`](https://mariadb.com/kb/en/right/): devuelve los `longitud` caracteres de más a la izquierda/derecha de la `cadena`
- [`TRIM(cadena)`](https://mariadb.com/kb/en/trim/) / [`LTRIM`](https://mariadb.com/kb/en/ltrim/) / [`RTRIM`](https://mariadb.com/kb/en/rtrim/): elimina los espacios en blanco por delante y por detrás, o solamente los de delante/izquierda (_L_) o los de detrás/derecha (_R_)

Algunos ejemplos de su uso:

```sql
SELECT CONCAT(nombre, ' ', apellido) AS Jugador, UPPER(nombre), LENGTH(apellido) FROM Jugador LIMIT 3;
```

| Jugador | UPPER(nombre) | LENGTH(apellido) |
| :--- | :--- | :--- |
| Thibaut Courtois | THIBAUT | 8 |
| Daniel Carvajal | DANIEL | 8 |
| Eder Militao | EDER | 7 |

Otras funciones que podemos utilizar son `CHAR_LENGTH(cadena)` para obtener el tamaño, [`LOCATE(subcadena, cadena)`](https://mariadb.com/kb/en/locate/) para encontrar una subcadena en una cadena, REPLACE(cadena, cadenaOrigen, cadenaDestino)`para sustituir una subcadena por otra o`REVERSE(cadena)\` para invertir una cadena.

#### Fecha / Hora

Si trabajamos con campos de tipo fecha, podemos emplear las siguientes [funciones](https://mariadb.com/kb/en/date-time-functions/):

- [`NOW()` / `CURRENT_TIMESTAMP`](https://mariadb.com/kb/en/now/): fecha y hora actual del sistema.
- [`CURDATE()`](https://mariadb.com/kb/en/curdate/): fecha actual en formato `yyyy-mm-dd` o `yyyymmdd`.
- [`DATEDIFF(fecha1, fecha2)`](https://mariadb.com/kb/en/datediff/): diferencia de días entre dos fechas.
- [`TIMESTAMPDIFF(unidad, fecha1, fecha2)`](https://mariadb.com/kb/en/timestampdiff/): diferencia medida en `unidad` entre dos fechas.
- [`DATE_ADD(fecha, INTERVAL expresión Tipo)`](https://mariadb.com/kb/en/date_add/) / [`DATE_SUB`](https://mariadb.com/kb/en/date_sub/), pudiendo utilizar los siguientes [tipos](https://mariadb.com/kb/en/date-and-time-units/).

```sql
SELECT NOW(), CURDATE(), DATEDIFF(fechaFin, fechaInicio) AS Dias_Temporada FROM Temporada WHERE esActiva = TRUE;
```

| NOW() | CURDATE() | Dias_Temporada |
| :--- | :--- | :--- |
| 2026-01-04 12:00:00 | 2026-01-04 | 319 |

```sql
SELECT nombre, fechaNacimiento, TIMESTAMPDIFF(YEAR, fechaNacimiento, CURDATE()) AS Edad FROM Jugador LIMIT 3;
```

| nombre | fechaNacimiento | Edad |
| :--- | :--- | :--- |
| Thibaut | 1992-05-11 | 33 |
| Daniel | 1992-01-11 | 33 |
| Eder | 1998-01-18 | 27 |

Por otro lado, además de operaciones sobre campos fecha, también podemos realizar transformaciones sobre fecha para obtener una parte o información relativa a la misma:

- [`YEAR(fecha)`](https://mariadb.com/kb/en/year/): año en formato `aaaa`
- [`MONTH(fecha)`](https://mariadb.com/kb/en/month/): mes en formato `mm`
- Otras funciones útiles son `SECOND`, `MINUTE`, `HOUR`, `DAY`, `WEEK`, `DAYOFWEEK` …

```sql
SELECT fechaNacimiento, YEAR(fechaNacimiento), MONTH(fechaNacimiento) FROM Jugador LIMIT 3;
```

| fechaNacimiento | YEAR(fechaNacimiento) | MONTH(fechaNacimiento) |
| :--- | :--- | :--- |
| 1992-05-11 | 1992 | 5 |
| 1992-01-11 | 1992 | 1 |
| 1998-01-18 | 1998 | 1 |

Por último, para formatear un campo de tipo fecha y mostrarla conforme necesitemos, podemos hacer uso de [`DATE_FORMAT(fecha, formato)`](https://mariadb.com/kb/en/date_format/) para obtener información similar a la anterior (le podemos pasar un tercer parámetro con el _locale_ para configurar el idioma de salida y sobrescribir el del sistema):

```sql
SELECT fechaNacimiento, DATE_FORMAT(fechaNacimiento, '%d-%m-%Y') as FechaES FROM Jugador LIMIT 3;
```

| fechaNacimiento | FechaES |
| :--- | :--- |
| 1992-05-11 | 11-05-1992 |
| 1992-01-11 | 11-01-1992 |
| 1998-01-18 | 18-01-1998 |

Finalmente, otra función muy importante a la hora de trabajar con fechas es la función [`CAST(expr as tipo)`](https://mariadb.com/kb/en/cast/) que realiza la conversión de tipos de datos.

De esta manera podemos convertir una expresión de cadena en un tipo fecha:

```sql
SELECT CAST("2024-12-9" AS DATE);
```

#### Condicionales y Nulos

De forma similar al operador [`CASE`](https://aitor-medrano.github.io/bd/06sql.html#CASE), si preferimos, podemos hacer uso de la función [`IF(expr,V,F)`](https://mariadb.com/kb/en/if-function/).

Por ejemplo, podemos reescribir la misma consulta vista anteriormente:

```sql
SELECT nombre, CASE WHEN mentorID IS NULL THEN "Sin Mentor" ELSE mentorID END AS Mentor_Status FROM Jugador;
```

por otra que utilice la función `IF` mejorando la legibilidad:

```sql
SELECT nombre, IF(mentorID IS NULL, 'Sin Mentor', mentorID) as Mentor_Status FROM Jugador LIMIT 3;
```

| nombre | Estatura |
| :--- | :--- |
| Thibaut | Alto |
| Daniel | Normal |
| Eder | Alto |

Cuando trabajamos con nulos también podemos emplear las funciones:

- [`IFNULL(campo, valor)`](https://mariadb.com/kb/en/ifnull/): devuelve `valor` si `campo` es nulo
- [`COALESCE(campo1, campo2, ...)`](https://mariadb.com/kb/en/coalesce/): devuelve el primer valor no nulo de la lista de parámetros.

Dicho esto, las siguientes consultas obtienen el mismo resultado:

```sql
SELECT nombre, IFNULL(mentorID, 'Sin Mentor') FROM Jugador LIMIT 3;
```

| nombre | IFNULL(mentorID, 'Sin Mentor') |
| :--- | :--- |
| Thibaut | Sin Mentor |
| Daniel | Sin Mentor |
| Eder | Sin Mentor |

#### Otras

También tenemos funciones [matemáticas](https://mariadb.com/kb/en/numeric-functions/) como:

- [`ABS(num)`](https://mariadb.com/kb/en/abs/): obtiene el valor absoluto de `num`
- [`SQRT(num)`](https://mariadb.com/kb/en/sqrt/), [`POW(base, exponente)`](https://mariadb.com/kb/en/pow/): raíz cuadrada de `num`, potencia de `base` elevado a `exponente`
- [`RAND()`](https://mariadb.com/kb/en/rand/): obtiene un número aleatorio
- [`ROUND(num)`](https://mariadb.com/kb/en/round/) / [`FLOOR(num)`](https://mariadb.com/kb/en/floor/) / [`CEILING(num)`](https://mariadb.com/kb/en/ceiling/): redondea un número, por exceso o por defecto
- [`TRUNCATE(num,d)`](https://mariadb.com/kb/en/abs/): trunca `num` con `d` decimales

Veamos unos ejemplos de redondeo de cantidades:

```sql
SELECT altura, ROUND(altura, 1), TRUNCATE(altura, 0) FROM Jugador LIMIT 3;
```

| altura | ROUND(altura, 1) | TRUNCATE(altura, 0) |
| :--- | :--- | :--- |
| 2 | 2.0 | 2 |
| 1.73 | 1.7 | 1 |
| 1.86 | 1.9 | 1 |

Otra función muy empleada es [`FORMAT(numero, decimales)`](https://mariadb.com/kb/en/format/) para formatear los números con separadores de miles y cantidad de decimales:

```sql
SELECT nombre, FORMAT(presupuesto, 2) FROM Equipo LIMIT 3;
```

| nombre | FORMAT(presupuesto, 2) |
| :--- | :--- |
| Real Madrid CF | 750,000,000.00 |
| FC Barcelona | 600,000,000.00 |
| Atletico de Madrid | 300,000,000.00 |

También podemos emplear funciones para [encriptar o comprimir](https://mariadb.com/kb/en/encryption-hashing-and-compression-functions/), así como para trabajar con [coordenadas geográficas](https://mariadb.com/kb/en/geographic-functions/).


### Ordenando y Limitando

Es muy común tener que ordenar el resultado de una consulta para darle más importancia a unos campos que otros, e incluso, reducir el número de tuplas recuperadas.

Así pues, para ordenar mediante la cláusula [`ORDER BY {campo | pos} [ASC|DESC]`](https://mariadb.com/kb/en/order-by/), indicando los diferentes campos separados por coma.

```sql
SELECT nombre, añoFundacion FROM Equipo ORDER BY añoFundacion ASC LIMIT 3;
```

| nombre | añoFundacion |
| :--- | :--- |
| Sevilla FC | 1890 |
| Athletic Club | 1898 |
| FC Barcelona | 1899 |

Por defecto, la ordenación se realiza de forma ascendente. Por lo tanto, la consulta anterior y la siguiente son similares:

```sql
SELECT nombre, añoFundacion FROM Equipo ORDER BY añoFundacion DESC LIMIT 3;
```

| nombre | añoFundacion |
| :--- | :--- |
| Girona FC | 1930 |
| Villarreal CF | 1923 |
| Valencia CF | 1919 |

Algunos desarrolladores prefieren explicitar el orden de `ORDER BY` para evitar ambigüedades. Otros, en cambio, prefieren obviar la opción `ASC` para reducir el tamaño de las consultas.

Por otro lado, tal como hemos comentado previamente, podemos ordenar por más de una columna, indicando para cada una de ellas diferentes tipos de ordenaciones:

```sql
SELECT equipoID, dorsal, nombre FROM Jugador ORDER BY equipoID ASC, dorsal ASC LIMIT 5;
```

| equipoID | dorsal | nombre |
| :--- | :--- | :--- |
| 1 | 1 | Thibaut |
| 1 | 2 | Daniel |
| 1 | 3 | Eder |
| 1 | 4 | David |
| 1 | 5 | Jude |

Rendimiento

Hay que tener en cuenta que ordenar los resultados de una consulta requiere colocar todos los datos en memoria, y dependiendo de la cantidad, puede ser una operación computacionalmente compleja.

Finalmente, a la hora de indicar el nombre de las columnas de ordenación, también podemos un número indicando la posición de la columna (en el siguiente ejemplo, 1 referencia a `NomEmp` y 2 a `NifEmp`):

```sql
SELECT nombre, añoFundacion FROM Equipo ORDER BY 2 ASC LIMIT 3;
```

| nombre | añoFundacion |
| :--- | :--- |
| Sevilla FC | 1890 |
| Athletic Club | 1898 |
| FC Barcelona | 1899 |

Además, si queremos restringir y limitar el número de resultados de la consulta usaremos [`LIMIT cantidad`](https://mariadb.com/kb/en/limit/):

```sql
SELECT nombre FROM Jugador LIMIT 3;
```

| nombre |
| :--- |
| Thibaut |
| Daniel |
| Eder |

Reduciendo el tráfico

En ocasiones, cuando queremos obtener una muestra de los datos, en vez de hacer una consulta `select * from ...` para comprobar qué datos almacena una determinada tabla, es mucho mejor acostumbrarse a realizar un `select * from ... LIMIT 10`. De este modo, no sobrecargamos el servidor ni incrementamos el tráfico de datos.

Si no queremos coger los primeros elementos, podemos hacer uso [`LIMIT inicio, cantidad`](https://mariadb.com/kb/en/limit/), teniendo en cuenta que `inicio` referencia al desplazamiento, es decir, la cantidad de filas que se ignorarán.

```sql
SELECT nombre FROM Jugador LIMIT 5, 5;
```

| nombre |
| :--- |
| Vinicius |
| Federico |
| Kylian |
| Luka |
| Rodrygo |

Por último, podemos expresar lo mismo mediante [`LIMIT cantidad OFFSET inicio`](https://mariadb.com/kb/en/limit/), sólo que cambiamos el orden de los parámetros:

```sql
SELECT nombre FROM Jugador LIMIT 5 OFFSET 5;
```

| nombre |
| :--- |
| Vinicius |
| Federico |
| Kylian |
| Luka |
| Rodrygo |

### Selección

La selección en SQL permite filtrar filas de una tabla en función de condiciones específicas. Esto se logra mediante la cláusula `WHERE`, que define los criterios de filtrado.

Para filtrar los datos y realizar una selección de tuplas, podemos emplear tanto [funciones como operadores](https://mariadb.com/kb/en/function-and-operator-reference/) dentro del `WHERE`. Para realizar las comparaciones, se expresan mediante `expresion1 operador expresion2`, pudiendo utilizar los operadores relacionales `<`, `<=`, `>`, `>=`, `=`, `!=`, así como los operadores lógicos como `and`, `or`, `not`, etc...

```sql
SELECT nombre, posicion FROM Jugador WHERE posicion = 'Portero' LIMIT 3;
```

| nombre | posicion |
| :--- | :--- |
| Thibaut | Portero |
| Marc-Andre | Portero |
| Inaki | Portero |

Como puede observarse, no es necesario que el o los atributos que usemos en la selección luego aparezcan en la proyección, ni viceversa.

#### Rangos

Supongamos que queremos recuperar los equipos fundados entre el año 1900 y 1920. Podemos hacerlo haciendo uso de una conjunción entre dos comparaciones:

```sql
SELECT nombre, añoFundacion FROM Equipo WHERE añoFundacion >= 1900 AND añoFundacion <= 1920;
```

| nombre | añoFundacion |
| :--- | :--- |
| Real Madrid CF | 1902 |
| Atletico de Madrid | 1903 |
| Real Sociedad | 1909 |
| Real Betis Balompie | 1907 |
| Valencia CF | 1919 |

Si el conjunto de valores a comparar forma parte de un rango numérico, es mejor utilizar [`BETWEEN .. AND`](https://mariadb.com/kb/en/between-and/), siguiendo la sintaxis `expresión1 [NOT] BETWEEN expresión2 AND expresión3`:

```sql
SELECT nombre, añoFundacion FROM Equipo WHERE añoFundacion BETWEEN 1900 AND 1920;
```

| nombre | añoFundacion |
| :--- | :--- |
| Real Madrid CF | 1902 |
| Atletico de Madrid | 1903 |
| Real Sociedad | 1909 |
| Real Betis Balompie | 1907 |
| Valencia CF | 1919 |

Así pues, la misma consulta la podemos reescribir así:

```sql
SELECT nombre, añoFundacion FROM Equipo WHERE añoFundacion BETWEEN 1900 AND 1920;
```

| nombre | añoFundacion |
| :--- | :--- |
| Real Madrid CF | 1902 |
| Atletico de Madrid | 1903 |
| Real Sociedad | 1909 |
| Real Betis Balompie | 1907 |
| Valencia CF | 1919 |

También podemos negar la cláusula o usarla con fechas:

```sql
SELECT nombre, fechaNacimiento FROM Jugador WHERE fechaNacimiento NOT BETWEEN '1990-01-01' AND '1999-12-31' LIMIT 3;
```

| nombre | fechaNacimiento |
| :--- | :--- |
| Luka | 1985-09-09 |
| Vinicius | 2000-07-12 |
| Jude | 2003-06-29 |

#### Conjuntos

Si en vez de un rango, queremos comprobar si el resultado de la expresión coincide con uno de entre una lista de valores (los cuales deben coincidir en su tipo de datos), usaremos el operador [`IN`](https://mariadb.com/kb/en/in/) con la sintaxis `exp1 [NOT] IN (const1 [,const2])`

```sql
SELECT nombre, ciudad FROM Estadio WHERE ciudad IN ('Madrid', 'Sevilla');
```

| nombre | ciudad |
| :--- | :--- |
| Santiago Bernabeu | Madrid |
| Civitas Metropolitano | Madrid |
| Benito Villamarin | Sevilla |
| Ramon Sanchez-Pizjuan | Sevilla |

#### Patrón texto

Cuando tenemos campos de tipo texto, lo normal no es comparar por todo el valor exacto, sino por una subcadena existente. Para ello, usaremos el operador [`LIKE`](https://mariadb.com/kb/en/like/) acompañado de un patrón, siguiendo la sintaxis `columna [NOT] LIKE patrón`.

En el patrón de búsqueda, podemos emplear los comodines `_` para indicar que ocupa un carácter y `%` para cero o más caracteres.

```sql
SELECT nombre FROM Jugador WHERE nombre LIKE 'J%' LIMIT 3;
```

| nombre |
| :--- |
| Jude |
| Jules |
| Jan |

Expresiones regulares

Si la lógica a comprobar es más compleja, podemos hacer uso de expresiones regulares, mediante la cláusula [`REGEXP`](https://mariadb.com/kb/en/regexp/). Algunos ejemplos:

- Jugadores cuyo nombre empieza por vocal (`^` comienza y entre corchetes ponemos todos los posibles valores, es decir, por una vocal en mayúsculas o minúsculas)
    
    ```sql
    SELECT nombre FROM Jugador WHERE nombre REGEXP '^[AEIOU]' LIMIT 3;
    ```

    | nombre |
    | :--- |
    | Eder |
    | Aurelien |
    | Arda |
    
- Equipos cuyo nombre contiene exactamente dos palabras (`^[^ ]+` una o más letras al inicio, y `[^ ]+$` una o más letras al final)
    
    ```sql
    SELECT nombre FROM Equipo WHERE nombre REGEXP '^[[:alpha:]]+ [[:alpha:]]+$';
    ```

    | nombre |
    | :--- |
    | FC Barcelona |
    | Athletic Club |
    | Real Sociedad |
    | Sevilla FC |
    | Valencia CF |
    | Villarreal CF |
    | Girona FC |
    

#### Valor nulo

Para comprobar si un campo contiene valores nulos (o si queremos saber si tiene algún valor, sea cual sea) usaremos el operador [`IS NULL`](https://mariadb.com/kb/en/is-null/) con la sintaxis `columna IS [NOT] NULL`:

```sql
SELECT nombre, mentorID FROM Jugador WHERE mentorID IS NULL LIMIT 3;
```

| nombre | mentorID |
| :--- | :--- |
| Thibaut | NULL |
| Daniel | NULL |
| Eder | NULL |

#### Operadores lógicos

Respecto a las condiciones compuestas, podemos unir operadores mediante `AND` (conjunción), `OR` (disyunción) y `NOT` (negación).

```sql
SELECT nombre, altura, peso FROM Jugador WHERE (posicion='Delantero' OR posicion='Defensa') AND altura > 1.90 LIMIT 3;
```

| nombre | altura | peso |
| :--- | :--- | :--- |
| Alexander | 1.95 | 90 |
| Mikel | 1.91 | 85 |
| Rafa | 1.91 | 86 |

Prioridad de los operadores

Conviene recordar la [prioridad de los operadores](https://mariadb.com/kb/en/operator-precedence/) a la hora de evaluar una expresión:

- Se evalúa la multiplicación (`*`) y la división (`/`) al mismo nivel.
- A continuación sumas (`+`) y restas (`-`).
- Todas las comparaciones (`<`, `>`, …).
- Después se evalúan los operadores `IS NULL`, `IN`, `LIKE`
- `BETWEEN`...
- `NOT`.
- `AND`.
- `OR`.


## Uniendo Tablas

Hasta ahora nos hemos dedicaod a realizar consultas sobre uno o más atributos de una determinada tabla. El modelo relacional se basa en la relación de una o más tablas, y por lo tanto, necesitamos de un mecanismo que nos permite obtener información de tablas que están relacionadas.

Dicho esto, para unir varias tablas (realizar un [_join_](https://mariadb.com/kb/en/join-syntax/)) tenemos diferentes [formas](https://mariadb.com/kb/en/join-syntax/) de hacerlo:

- _cross join_: producto cartesiano entre dos tablas
- _inner join_: une dos tablas por campos que coinciden en valor.
- _natural join_: une dos tablas por campos que se llaman igual
- _outer join_: une dos tablas, recuperando todos los elementos que están en una de ellas y de la segunda los que coinciden en valor. En este caso, podemos distinguir entre _left join_ o _right join_ dependiendo que tabla es la que aporta todos los elementos.

En el siguiente gráfico tienes resumidas de forma visual todas las combinaciones posibles:

![](images/06joins-sql.svg "Joins en SQL - De GermanX - Trabajo propio, CC BY-SA 4.0, https://commons.wikimedia.org/w/index.php?curid=55878387")

Joins en SQL - De GermanX - Trabajo propio, CC BY-SA 4.0, https://commons.wikimedia.org/w/index.php?curid=55878387

Veamos estas operaciones en detalle.

### Producto cartesiano

El producto cartesiano (_cross join_) de dos tablas son todas las combinaciones de las filas de una tabla unidas a las filas de la otra tabla. Es decir, cada fila de A se cruza con todas las de B.

```sql
SELECT e.nombre, en.nombre FROM Equipo e CROSS JOIN Entrenador en LIMIT 3;
```

| nombre | nombre |
| :--- | :--- |
| Real Madrid CF | Carlo |
| FC Barcelona | Carlo |
| Atletico de Madrid | Carlo |

Otra forma de expresar lo mismo es mediante `cross join`:

```sql
SELECT NomEmp, NomDep FROM empleado CROSS JOIN departamento;
```

### Composición interna

La operación `[INNER] JOIN` combina registros de dos tablas siempre que existan valores coincidentes en un campo común (clave ajena con clave primaria). Para ello, se indica una tabla seguida (opcionalmente con el prefijo `INNER`) de `JOIN` con la segunda tabla, y tras `ON`, igualamos la clave ajena con la primaria:

```sql
SELECT NomEmp, NomDep FROM empleado JOIN departamento ON empleado.CodDep=departamento.CodDep;
```

```sql
SELECT en.nombre, e.nombre FROM Entrenador en JOIN Equipo e ON en.equipoID=e.id LIMIT 3;
```

| nombre | nombre |
| :--- | :--- |
| Carlo | Real Madrid CF |
| Hansi | FC Barcelona |
| Diego | Atletico de Madrid |

Es conveniente, y realmente más cómodo, poner un alias a las tablas (normalmente la inicial del nombre de la tabla tras el propio nombre de la misma):

```sql
SELECT en.nombre AS Entrenador, e.nombre AS Equipo FROM Entrenador en JOIN Equipo e ON en.equipoID=e.id LIMIT 3;
```

| Entrenador | Equipo |
| :--- | :--- |
| Carlo | Real Madrid CF |
| Hansi | FC Barcelona |
| Diego | Atletico de Madrid |ep;`

En versiones antiguas de SQL era más común indicar las [tablas separadas por coma](https://mariadb.com/kb/en/comma-vs-join/) y realizar el _join_ en el `WHERE`, uniendo la clave ajena con la clave primaria de la tabla a la que referencia. Aunque a nivel funcional el resultado es el mismo, es recomendable utilizar la sintaxis `JOIN ... ON` por legibilidad, y es probable, que el optimizador de consultas del SGBD funcione mejor:



```sql
--- SQL 86 (ejemplo de sintaxis antigua);
--- SQL 92 (ejemplo de sintaxis moderna); 
SELECT NomEmp, NomDep 
FROM empleado e JOIN departamento d ON e.CodDep=d.CodDep;
```

Cuando coincide el nombre de los atributos podemos emplear la cláusula `USING (listaDeColumnas)` para simplificar la consulta:

```sql
SELECT j.nombre, e.nombre FROM Jugador j JOIN Equipo e USING(id) LIMIT 3;
```

| nombre | nombre |
| :--- | :--- |
| Thibaut | Real Madrid CF |
| Daniel | FC Barcelona |
| Eder | Atletico de Madrid |

> **Nota**: En este caso, al usar `USING(id)`, estamos uniendo el Jugador con ID 1 con el Equipo con ID 1. **No es una relación lógica real** (Thibaut juega en el Real Madrid, pero Daniel NO juega en el Barça, juega en el Madrid, su ID es 2 y el equipo ID 1), simplemente coincide el ID. Para relaciones reales, usad `ON`.

#### Natural join

Forma parte del estándar SQL desde SQL:1999, y se trata de una especialización de `INNER JOIN`, ya que simplifica la unión entre dos tablas al basarse automáticamente en las columnas con nombres coincidentes en ambas tablas.

La tabla resultante contiene sólo una columna por cada par de columnas con el mismo nombre.

```sql
SELECT j.nombre, e.nombre FROM Jugador j NATURAL JOIN Equipo e LIMIT 3;
```

| nombre | nombre |
| :--- | :--- |
| Thibaut | Real Madrid CF |
| Daniel | FC Barcelona |
| Eder | Atletico de Madrid |

> **Nota**: Al igual que con `USING`, `NATURAL JOIN` une por columnas con el mismo nombre (`id` en este caso). El resultado es sintácticamente correcto pero semánticamente erróneo para nuestra lógica de negocio.

#### Consultas sobre varias tablas

Cuando necesitamos información que está en diferentes tablas, o necesitamos que los datos obtenidos dependan de las relaciones en las que participan, deberemos emparejar los campos que han de tener valores iguales (FKs con PKs)

Algunos aspectos a tener en cuenta:

- Pueden combinarse tantas tablas como se desee.
- El criterio de combinación puede estar formado por más de una pareja de columnas.
- En la cláusula `SELECT` pueden citarse columnas de ambas tablas, coincidan o no con la combinación.
- Si hay columnas con el mismo nombre en las distintas tablas, deben identificarse especificando la tabla de procedencia o utilizando un alias de tabla.

Veamos algunos ejemplos. Antes ya hemos visto cómo recuperar el nombre de los equipos donde juega cada jugador. Si también queremos obtener el nombre del estadio, necesitamos unir las tres tablas:

```sql
SELECT j.nombre, e.nombre, es.nombre FROM Jugador j JOIN Equipo e ON j.equipoID = e.id JOIN Estadio es ON e.estadioID = es.id LIMIT 3;
```

| nombre | nombre | nombre |
| :--- | :--- | :--- |
| Thibaut | Real Madrid CF | Santiago Bernabeu |
| Daniel | Real Madrid CF | Santiago Bernabeu |
| Eder | Real Madrid CF | Santiago Bernabeu |

Si además, queremos el entrenador del equipo, necesitamos volver a unir con Entrenador para obtener su nombre:

```sql
SELECT j.nombre, e.nombre, en.nombre AS Entrenador FROM Jugador j JOIN Equipo e ON j.equipoID = e.id JOIN Entrenador en ON en.equipoID = e.id LIMIT 3;
```

| nombre | nombre | Entrenador |
| :--- | :--- | :--- |
| Thibaut | Real Madrid CF | Carlo |
| Daniel | Real Madrid CF | Carlo |
| Eder | Real Madrid CF | Carlo |

En todo momento, podemos añadir filtros sobre una composición. Por ejemplo, recuperaremos los nombres de los jugadores y equipos, de aquellos equipos fundados antes de 1900:

```sql
SELECT j.nombre, e.nombre FROM Jugador j JOIN Equipo e ON j.equipoID = e.id WHERE e.añoFundacion < 1900 LIMIT 3;
```

| nombre | nombre |
| :--- | :--- |
| Marc-Andre | FC Barcelona |
| Pau | FC Barcelona |
| Alejandro | FC Barcelona |

#### Composición reflexiva

Cuando tenemos una relación reflexiva de una tabla consigo misma, para obtener los datos, hemos de realizar una join de la tabla con otra instancia de sí misma.

Por ejemplo, en la tabla `Jugador`, la columna `mentorID` referencia al jugador que le hace de mentor; aquellos que tenga como valor `NULL`, no tienen mentor y podríamos decir que son jugadores experimentados.

```sql
SELECT nombre, mentorID FROM Jugador WHERE mentorID IS NOT NULL LIMIT 3;
```

| nombre | mentorID |
| :--- | :--- |
| Arda | 9 |
| Endrick | 6 |
| Inaki | 16 |

Así pues, si queremos recuperar todos los pupilos, así como el nombre de su mentor necesitamos referencias a la tabla `Jugador` mediante un _join_ consigo misma. Para ello, es imperativo utilizar un alias descriptivo para identificar el rol de la tabla en cada caso (en nuestro caso, `j` como jugador (pupilo) y `m` para los mentores):

```sql
SELECT j.nombre AS Jugador, m.nombre AS Mentor FROM Jugador j JOIN Jugador m ON j.mentorID = m.id LIMIT 3;
```

| Jugador | Mentor |
| :--- | :--- |
| Arda | Kylian |
| Endrick | Vinicius |
| Inaki | Nahuel |


### Composición externa

Cuando efectuamos una combinación interna los registros que se quedan sin emparejar en la otra tabla no aparecen en el resultado.

En ocasiones no queremos únicamente los registros que están conectados, sino que nos interesa recuperarlos todos (conectados y no conectados) y de los conectados, sus datos. En otras ocasiones, queremos recuperar todos los que no están conectados... Para ello, necesitamos hacer uso de las composiciones externas.

Mediante una combinación externa, aparecerán los datos emparejados más los que no están relacionados, ya sea por la:

- Izquierda: `LEFT [OUTER] JOIN` – Todos los de la tabla de la izquierda, y de la derecha los relacionados.
- Derecha: `RIGHT [OUTER] JOIN` – Los de la izquierda los relacionados, y de la derecha todos los datos.

Veamos con un ejemplo qué datos obtenemos. Primero realizamos un _join_ entre jugadores y sus estadísticas de partido para obtener los jugadores que han jugado (obtenemos registros repetidos por jugador si han jugado más de un partido):

```sql
SELECT j.nombre, ep.goles FROM Jugador j JOIN EstadisticaPartido ep ON j.id = ep.jugadorID LIMIT 3;
```

| nombre | goles |
| :--- | :--- |
| Robert | 2 |
| Lamine | 0 |
| Hugo | 1 |

Si en cambio queremos recuperar todos los jugadores, y si han jugado, sus estadísticas, haríamos un _left join_. Ahora se muestran todos los jugadores, y además, aquel que tenga estadísticas, aparecerá tantas veces como partidos haya jugado. En cambio, de los que no han jugado aparecerá `NULL` en las columnas correspondientes:

```sql
SELECT j.nombre, ep.goles FROM Jugador j LEFT JOIN EstadisticaPartido ep ON j.id = ep.jugadorID LIMIT 3;
```

| nombre | goles |
| :--- | :--- |
| Thibaut | NULL |
| Daniel | NULL |
| Eder | NULL |



```sql
SELECT j.nombre, ep.goles FROM Jugador j RIGHT JOIN EstadisticaPartido ep ON j.id = ep.jugadorID LIMIT 3;
```

| nombre | goles |
| :--- | :--- |
| Robert | 2 |
| Lamine | 0 |
| Hugo | 1 |

No obstante, si cambiamos el orden de las tablas en el _join_, sí que tiene sentido hacer un _right join_:

```sql
SELECT j.nombre, ep.goles FROM EstadisticaPartido ep RIGHT JOIN Jugador j ON j.id = ep.jugadorID LIMIT 3;
```

| nombre | goles |
| :--- | :--- |
| Thibaut | NULL |
| Daniel | NULL |
| Eder | NULL |

¿Y si tenemos tres tablas? Vamos a unir las estadísticas de los jugadores con los partidos (seguimos recuperando registros de jugadores que han jugado):

```sql
SELECT j.nombre, p.codigo, ep.goles FROM Jugador j JOIN EstadisticaPartido ep ON j.id = ep.jugadorID JOIN Partido p ON ep.partidoID = p.id;
```

| nombre | codigo | goles |
| :--- | :--- | :--- |
| Robert | P2425-04 | 2 |
| Lamine | P2425-04 | 0 |
| Hugo | P2425-04 | 1 |

Si quiero recuperar todos los jugadores y los datos del partido si han jugado, tenemos que hacer un _left join_:

```sql
SELECT j.nombre, p.codigo, ep.goles FROM Jugador j LEFT JOIN EstadisticaPartido ep ON j.id = ep.jugadorID LEFT JOIN Partido p ON ep.partidoID = p.id LIMIT 3;
```

| nombre | codigo | goles |
| :--- | :--- | :--- |
| Thibaut | NULL | NULL |
| Daniel | NULL | NULL |
| Eder | NULL | NULL |

¿Qué ha pasado? ¿Por qué faltan registros? Al realizar el segundo _join_, ha eliminado aquellos registros que tienen el `partidoID` nulo (porque el join con Partido exige coincidencia).

Pero ¿cómo lo solucionamos? Primero vamos a unir los partidos y estadísticas, y luego hacemos el _join_ por la derecha con todos los jugadores:

```sql
SELECT j.nombre, p.codigo, ep.goles FROM Jugador j RIGHT JOIN EstadisticaPartido ep ON j.id = ep.jugadorID LEFT JOIN Partido p ON ep.partidoID = p.id;
```

| nombre | codigo | goles |
| :--- | :--- | :--- |
| Robert | P2425-04 | 2 |
| Lamine | P2425-04 | 0 |
| Hugo | P2425-04 | 1 |

Veamos otro ejemplo. Ahora quiero recuperar todas las estadísticas, y si lo hay, el jugador al que pertenecen. En este caso, pongo a la izquierda las estadísticas y hago dos _left joins_:

```sql
SELECT j.nombre, ep.goles FROM EstadisticaPartido ep LEFT JOIN Jugador j ON ep.jugadorID = j.id LIMIT 3;
```

| nombre | goles |
| :--- | :--- |
| Robert | 2 |
| Lamine | 0 |
| Hugo | 1 |

La misma consulta con sólo una consulta externa sería:

```sql
SELECT j.nombre, ep.goles FROM EstadisticaPartido ep RIGHT JOIN Jugador j ON ep.jugadorID = j.id LIMIT 3;
```

| nombre | goles |
| :--- | :--- |
| Thibaut | NULL |
| Daniel | NULL |
| Eder | NULL |


#### Antijoin

Se conoce como _antijoin_ los registros obtenidos de una tabla que no se combinan con otra. Es decir, son los registros que no se seleccionan al realizar un _inner join_, y de ahí el prefijo _anti_.

Para aprender su uso, vamos a recuperar los jugadores que no han jugado ningún partido:

![](images/06antijoin.png "Antijoin entre jugadores sin jugar")

Antijoin entre jugadores sin jugar

Pero antes, volvamos al ejemplo anterior donde obteníamos los jugadores que han jugado:

```sql
SELECT j.nombre, ep.goles FROM Jugador j JOIN EstadisticaPartido ep ON j.id = ep.jugadorID LIMIT 3;
```

| nombre | goles |
| :--- | :--- |
| Robert | 2 |
| Lamine | 0 |
| Hugo | 1 |

¿Y cómo hago para obtener los jugadores que no han jugado? Si realizamos un _join_ por la izquierda, sí que aparecerán los jugadores que no han jugado (además de los que sí):

```sql
SELECT j.nombre FROM Jugador j LEFT JOIN EstadisticaPartido ep ON j.id = ep.jugadorID LIMIT 3;
```

| nombre |
| :--- |
| Thibaut |
| Daniel |
| Eder |

Así pues, si sobre el _left join_, nos quedamos con los que tienen la clave primaria referenciada nula, obtendremos justo los jugadores que no han jugado (operación que se conoce como _anti-join_):

```sql
SELECT j.nombre FROM Jugador j LEFT JOIN EstadisticaPartido ep ON j.id = ep.jugadorID WHERE ep.partidoID IS NULL LIMIT 3;
```

| nombre |
| :--- |
| Thibaut |
| Daniel |
| Eder |

#### Full Outer Join

Aunque no está soportado por _MariaDB_, conviene conocer la combinación externa completa, aunque su uso es muy limitado (por la propia restricción de integridad referencial). Su resultado presenta los resultados de la tabla de la izquierda y de la tabla de la derecha aunque no tengan correspondencia en la otra tabla.

Es decir, la tabla combinada contendrá entonces todos los registros de ambas tablas y presentará valores nulos para registros sin pareja.

Si necesitamos dicho resultado, podemos simularlo haciendo una unión entre un _left join_ y un _right join_. De esta manera obtendríamos todos los registros de T1 y los valores de T2 relacionados o nulos en los que no, y en una segunda consulta, los valores de T1 relacionados o nulos en los que no, y todos los valores de T2:

```sql
SELECT * FROM t1 LEFT JOIN t2 ON t1.id = t2.id 
UNION 
SELECT * FROM t1 RIGHT JOIN t2 ON t1.id = t2.id
```

### Operadores de conjuntos

Los operadores de conjuntos no operan sobre tipos de datos simples, sino sobre los resultados de dos o más consultas, las cuales deben tener la misma estructura, es decir, que la cantidad y los tipos de datos deben ser los mismos.

Los operadores de conjuntos son:

- [`UNION`](https://mariadb.com/kb/en/union/): Devuelve el conjunto de filas resultante de la unión de las dos consultas, sin duplicados.
- `UNION ALL`: Devuelve el conjunto de filas resultante de la unión de las dos consultas, incluyendo los duplicados.
- [`INTERSECT`](https://mariadb.com/kb/en/intersect/): Devuelve la intersección entre los dos conjuntos de filas.
- [`EXCEPT`](https://mariadb.com/kb/en/except/): Devuelve todas aquellas filas de la primera consulta que no estén en la segunda.

![](images/06union.png "Operadores de conjuntos")

Operadores de conjuntos - https://jsmshaktisingh.medium.com/set-theory-for-sql-joins-9739b6943eb3

Veamos unos ejemplos sobre:

```sql
SELECT nombre FROM Equipo 
UNION 
SELECT nombre FROM Estadio LIMIT 5;
```

| nombre |
| :--- |
| Real Madrid CF |
| FC Barcelona |
| Atletico de Madrid |
| Athletic Club |
| Real Sociedad |
