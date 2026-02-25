# Actividades de la unidad 5

!!! info "Bases de datos recursos"

    Aquí tienes los enlaces a las bases de datos de recursos para esta unidad:

    - [Sakila](bd/sakila/sakila.md)
    - [NetflixDB](bd/netflix/netflix.md)
    - [Universidad](../04/res/UniversidadA.md)
    - [LigaFutbol](../04/res/liga_futbol.md)

### 📈 Consultas agregadas y funciones de resumen

---

#### **AC501: Consultas agregadas básicas**

??? "Actividad AC501"

    | Criterios de Evaluación | Ponderación |
    | ----------------------- | ----------- |
    | RABD.3 // CE3e //       | 3p          |

    **Concepto**: Funciones de agregación (`COUNT`, `SUM`, `AVG`, `MIN`, `MAX`) aplicadas a la totalidad de la tabla o bajo condiciones simples.

    Sobre la base de datos **Sakila**, realiza las siguientes consultas:

    1. Obtener el número total de películas que hay en la base de datos.
    2. Obtener la duración de la película más corta y de la más larga.
    3. Calcular el coste de reemplazo (`replacement_cost`) medio de todas las películas.
    4. Obtener la suma total de todos los pagos recibidos en la empresa.
    5. Utiliza `COUNT(original_language_id)` y `COUNT(*)` en una misma consulta. Explica por qué devuelven valores diferentes basándote en los datos de la tabla `film`.
    6. Calcular cuántos valores distintos de `rating` (clasificación) existen en la tabla de películas.
    7. Obtener la duración media de las películas que tienen una clasificación de 'PG-13'.

#### **AC502: Agrupamiento de registros (GROUP BY)**

??? "Actividad AC502"

    | Criterios de Evaluación | Ponderación |
    | ----------------------- | ----------- |
    | RABD.3 // CE3e //       | 4p          |

    **Concepto**: La cláusula `GROUP BY`, agrupaciones por múltiples columnas y el uso de `WITH ROLLUP`.

    Sobre la base de datos **Sakila**, realiza las siguientes consultas progresivas:

    1. **Agrupación básica**: Listar cuántas películas hay para cada "rating" (clasificación).
    2. **Agrupación con JOIN**: Mostrar el nombre de cada categoría y la cantidad de películas que pertenecen a ella (requiere unir `category` y `film_category`).
    3. **Múltiples columnas**: Obtener la cantidad de clientes por cada tienda (`store_id`) y su estado de actividad (`active`).
    4. **Agregación con LEFT JOIN**: Listar todos los actores (nombre y apellidos) y cuántas películas han realizado. Asegúrate de que si un actor no ha hecho ninguna película, aparezca con un 0 (usa `COUNT` con la columna adecuada).
    5. **Uso de ROLLUP**: Obtener el total de ingresos por cada empleado (`staff_id`) y cada tienda (`store_id`), incluyendo filas de subtotales y el gran total acumulado (`WITH ROLLUP`).



#### **AC503: Consultas de resumen**

??? "Actividad AC503"

    | Criterios de Evaluación | Ponderación |
    | ----------------------- | ----------- |
    | RABD.3 // CE3e //       | 5p          |

    **Concepto**: Agregaciones y agrupamientos complejos sobre la base de datos Universidad.

    Sobre la base de datos **Universidad**, realiza las siguientes consultas:

    1. Devuelve el número total de alumnas que hay.
    2. Calcula cuántos alumnos nacieron en 1999.
    3. Calcula cuántos profesores hay en cada departamento. El resultado sólo debe mostrar dos columnas, una con el nombre del departamento y otra con el número de profesores que hay en ese departamento. El resultado sólo debe incluir los departamentos que tienen profesores asociados y deberá estar ordenado de mayor a menor por el número de profesores.
    4. Devuelve un listado con todos los departamentos y el número de profesores que hay en cada uno de ellos. Tenga en cuenta que pueden existir departamentos que no tienen profesores asociados. Estos departamentos también tienen que aparecer en el listado.
    5. Devuelve un listado con el nombre de todos los grados existentes en la base de datos y el número de asignaturas que tiene cada uno. Tenga en cuenta que pueden existir grados que no tienen asignaturas asociadas. Estos grados también tienen que aparecer en el listado. El resultado deberá estar ordenado de mayor a menor por el número de asignaturas.
    6. Devuelve un listado con el nombre de todos los grados existentes en la base de datos y el número de asignaturas que tiene cada uno, de los grados que tengan más de 40 asignaturas asociadas.
    7. Devuelve un listado que muestre el nombre de los grados y la suma del número total de créditos que hay para cada tipo de asignatura. El resultado debe tener tres columnas: nombre del grado, tipo de asignatura y la suma de los créditos de todas las asignaturas que hay de ese tipo. Ordene el resultado de mayor a menor por el número total de crédidos.
    8. Devuelve un listado que muestre cuántos alumnos se han matriculado de alguna asignatura en cada uno de los cursos escolares. El resultado deberá mostrar dos columnas, una columna con el año de inicio del curso escolar y otra con el número de alumnos matriculados.
    9. Devuelve un listado con el número de asignaturas que imparte cada profesor. El listado debe tener en cuenta aquellos profesores que no imparten ninguna asignatura. El resultado mostrará cinco columnas: id, nombre, primer apellido, segundo apellido y número de asignaturas. El resultado estará ordenado de mayor a menor por el número de asignaturas.

#### **AC504: Resumen y agrupamiento**

??? "Actividad AC504"

    | Criterios de Evaluación | Ponderación |
    | ----------------------- | ----------- |
    | RABD.3 // CE3c, CE3e // | 5p          |

    **Concepto**: Agregaciones, cláusula `GROUP BY` y filtrado con `HAVING` sobre el modelo de la Liga.

    Sobre la base de datos **LigaFutbol**, realiza las siguientes consultas:

    1. **Presupuesto total**: Calcula la suma total de los presupuestos de todos los equipos de la liga.
    2. **Capacidad media**: Obtén la capacidad media de los estadios situados en la ciudad de 'Madrid'.
    3. **Jugadores por equipo**: Lista el nombre de cada equipo y la cantidad de jugadores que tiene en plantilla.
    4. **Máximos goleadores**: Obtén el nombre y apellidos de los jugadores y el total de goles que han marcado en todos sus partidos.
    5. **Equipos con solera**: Para cada equipo, muestra su nombre y la edad media de sus jugadores.
    6. **Sedes concurridas**: Lista las ciudades que han acogido más de 5 partidos en total.
    7. **Patrocinios potentes**: Para cada equipo, calcula el monto total recibido por patrocinios. Muestra solo aquellos equipos que reciban más de 50.000.000€ en total.
    8. **Dorsales repetidos**: Obtén qué dorsales se utilizan más de 3 veces en toda la liga, indicando el número de dorsal y cuántas veces aparece.
    9. **Asistencia por Estadio**: Lista el nombre de los estadios y la asistencia total acumulada en todos los partidos jugados en ellos, ordenado de mayor a menor asistencia.

#### **AC505: Filtrado de grupos**

??? "Actividad AC505"

    | Criterios de Evaluación | Ponderación |
    | ----------------------- | ----------- |
    | RABD.3 // CE3e //       | 3p          |

    **Concepto**: El uso de la cláusula `HAVING` para filtrar los resultados después de realizar la agrupación.

    Sobre la base de datos **Sakila**, realiza las siguientes consultas:

    1. **Filtrado simple**: Obtener los identificadores de los actores que han participado en más de 30 películas.
    2. **Filtrado por media**: Mostrar las categorías de películas cuya duración media sea superior a 120 minutos.
    3. **Combinación WHERE y HAVING**: Para cada cliente, calcular el total gastado, pero solo teniendo en cuenta los pagos individuales superiores a 5€. Filtrar el resultado para mostrar solo aquellos clientes cuyo gasto total "de lujo" sea superior a 100€.
    4. **Dificultad avanzada**: Obtener los países que tienen más de 10 ciudades registradas. Ordenar el resultado de mayor a menor cantidad de ciudades.


#### **AC506: Desafíos de consolidación**

??? "Actividad AC506"

    | Criterios de Evaluación | Ponderación |
    | ----------------------- | ----------- |
    | RABD.3 // CE3c, CE3e // | 6p          |

    **Versa sobre**: Integración de múltiples conceptos (agregados, joins, having, lógica condicional y funciones de fecha) para resolver problemas de analítica de negocio.

    Sobre la base de datos **Sakila**, resuelve los siguientes retos:

    1. **El Valor del Actor**: Para cada actor, obtén su nombre completo (en una sola columna), el total de películas en las que ha participado y la duración de la película más larga en la que ha trabajado. Filtra para mostrar solo aquellos actores con más de 30 películas y cuya película más larga supere las 3 horas (180 min).
    2. **Rentabilidad de Alquileres Largos**: Calcula los ingresos totales por categoría de película, pero contando únicamente aquellos alquileres cuya devolución se realizó más de 7 días después de la fecha de alquiler (usa `DATEDIFF`). Muestra solo aquellas categorías que, bajo esa condición, hayan generado más de 500€ de ingresos.
    3. **Fidelización y Alcance**: Identifica a los clientes (nombre y apellidos) que han alquilado películas en todas las categorías disponibles (es decir, el número de categorías distintas que ha alquilado es igual al número total de categorías en la tabla `category`). Requiere un uso avanzado de `COUNT(DISTINCT)`.
    4. **Análisis de Localidad y Gasto**: Muestra el nombre de las ciudades que tienen 2 o más clientes "VIP". Un cliente es "VIP" si ha realizado más de 30 alquileres y ha gastado más de 150€. El resultado debe mostrar la ciudad y el número de clientes VIP que residen en ella.
    5. **Eficiencia de Devolución**: Por cada clasificación (`rating`), calcula el número total de alquileres y el número de alquileres que fueron devueltos **antes** de la fecha esperada (aquellos donde `DATEDIFF(return_date, rental_date)` es menor que la columna `rental_duration` de la tabla `film`).

---

## 🪟 Funciones ventana

#### **AC507: Análisis con funciones ventana**

??? "Actividad AC507"

    | Criterios de Evaluación | Ponderación |
    | ----------------------- | ----------- |
    | RABD.3 // CE3e //       | 5p          |

    **Versa sobre**: El uso de `OVER`, `PARTITION BY`, `ROW_NUMBER`, `RANK` y funciones de valor como `LAG/LEAD`.

    Sobre la base de datos **Sakila**, realiza las siguientes consultas:

    1. **Particionado básico**: Mostrar el título de la película, su categoría y cuántas películas hay en total en esa misma categoría (sin contraer filas).
    2. **Numeración**: Listar todas las películas ordenadas alfabéticamente y asignarles un número de fila secuencial dentro de su clasificación (`rating`).
    3. **Ranking**: Obtener el ranking de las 3 películas más largas dentro de cada categoría. Si hay empates, deben ocupar la misma posición.
    4. **Comparación (LAG)**: Para cada pago realizado por un cliente, mostrar la fecha del pago, el importe y cuánto pagó en su transacción inmediatamente anterior.
    5. **Cálculo acumulativo**: Para cada pago, mostrar el importe total que lleva acumulado ese cliente hasta ese momento (suma progresiva).

#### **AC508: Análisis avanzado**

??? "Actividad AC508"

    | Criterios de Evaluación | Ponderación |
    | ----------------------- | ----------- |
    | RABD.3 // CE3e //       | 5p          |

    **Versa sobre**: Funciones ventana aplicadas a la gestión deportiva y estadísticas de competición.

    Sobre la base de datos **LigaFutbol**, realiza las siguientes consultas:

    1. **Ranking de Altura**: Lista el nombre de los jugadores, su posición y su altura. Añade una columna que indique qué posición ocupa el jugador en un ranking de altura dentro de su propia demarcación (ej: el defensa más alto, el segundo más alto...).
    2. **Dorsales por Equipo**: Para cada jugador, muestra su equipo y su dorsal. Añade una columna `num_jugador` que numere a los jugadores de cada equipo de forma correlativa según su dorsal.
    3. **Presupuesto Comparativo**: Lista el nombre de los equipos y su presupuesto. Añade una columna que muestre el presupuesto del equipo que está inmediatamente por encima en la tabla de presupuestos (ordenados de mayor a menor).
    4. **Goleadores Internos**: Para cada jugador que haya marcado goles en un partido, muestra su nombre, el equipo y la fecha del partido. Añade un ranking que identifique al máximo goleador de cada equipo considerando todos los partidos registrados.
    5. **Evolución de Asistencia**: Para cada partido jugado en un estadio, muestra la fecha y la asistencia. Añade una columna que calcule la diferencia de asistencia respecto al partido anterior jugado en ese mismo estadio.

---

## 🖼️ Vistas

#### **AC509: Gestión de Vistas**

??? "Actividad AC509"

    | Criterios de Evaluación | Ponderación |
    | ----------------------- | ----------- |
    | RABD.3 // CE2f //       | 5p          |

    **Concepto**: Definición de vistas para simplificar el acceso a datos complejos y seguridad.

    Sobre la base de datos **LigaFutbol**, realiza las siguientes tareas:

    1. **Vista de Infraestructura**: Crea una vista llamada `vista_grandes_estadios` que contenga el nombre, la ciudad y la capacidad de aquellos estadios que puedan albergar a más de 50.000 espectadores.
    2. **Vista de Relaciones Deportivas**: Diseña una vista llamada `vista_fichas_jugadores` que muestre en una sola tabla virtual: el nombre del equipo, el código del equipo, el nombre completo del jugador (Nombre + Apellido) y su posición.
    3. **Vista de Finanzas**: Crea una vista llamada `vista_patrocinios_activos` que recupere el nombre de la empresa patrocinadora, el nombre del equipo patrocinado y el monto total del contrato, pero solo para aquellos contratos que duren 2 años o más (24 meses).
    4. **Consulta combinada**: Utiliza la `vista_fichas_jugadores` para obtener cuántos 'Delanteros' tiene registrados el 'Real Madrid CF' (usa el nombre del equipo en la condición). No utilices las tablas base directamente.
    5. **Seguridad y Actualización**: Imagina que queremos ocultar los salarios de los entrenadores. Crea una vista `vista_staff_tecnico` que muestre todos los campos de la tabla `Entrenador` excepto el campo `salario` y `dni`. Intenta realizar un `UPDATE` del nombre de un entrenador a través de esta vista y verifica si los cambios se reflejan en la tabla original.

#### **AC510: Creación y gestión de vistas**

??? "Actividad AC510"

    | Criterios de Evaluación | Ponderación |
    | ----------------------- | ----------- |
    | RABD.3 // CE2f //       | 5p          |

    **Versa sobre**: Creación de vistas, consultas sobre vistas y comprensión de sus restricciones.

    Sobre la base de datos **Sakila**, realiza las siguientes tareas:

    1. **Vista de catálogo**: Crea una vista llamada `vista_peliculas_familiares` que contenga el título, la descripción y la clasificación de las películas clasificadas como 'G' o 'PG'. 
    2. **Vista de clientes TOP**: Crea una vista llamada `vista_mejores_clientes` que muestre el nombre, apellidos y el total gastado de aquellos clientes que hayan invertido más de 150€ en total.
    3. **Consulta sobre vista**: Utilizando `vista_peliculas_familiares`, obtén cuántas películas de ese tipo hay disponibles en la tienda número 1.
    4. **Gestión**: Muestra el comando para eliminar la vista `vista_mejores_clientes`.
    5. **Investigación**: Intenta realizar un `UPDATE` sobre una columna de la `vista_mejores_clientes` que contenga el cálculo del `SUM(amount)`. Explica qué ocurre y por qué, citando las restricciones de las vistas vistas en el tema.


Aquí tienes la continuación del fichero de actividades, centrado exclusivamente en el bloque de **Subconsultas y CTEs**. He seguido la numeración y el estilo del documento anterior (`AC510` fue el último, así que empezamos en `AC511`).

He diseñado las actividades para que cubran progresivamente los conceptos teóricos explicados, alternando entre las bases de datos disponibles (**Sakila**, **Universidad**, **LigaFutbol**) según qué esquema se adapte mejor a cada concepto.

---

## 📦 Subconsultas y CTE

#### **AC511: Subconsultas Escalares y de Fila**

??? "Actividad AC511"

    | Criterios de Evaluación | Ponderación |
    | ----------------------- | ----------- |
    | RABD.3 // CE3c //       | 4p          |

    **Concepto**: Subconsultas que devuelven un único valor (escalares) o un único registro (de fila) para comparaciones simples (`=`, `>`, `<`).

    Sobre la base de datos **Sakila**, realiza las siguientes consultas:

    1. **Por encima de la media**: Obtén el título y la duración de las películas que duran más que la duración promedio de todas las películas de la base de datos.
    2. **El cliente que más paga**: Muestra el identificador, nombre y apellidos del cliente que ha realizado el pago individual de mayor importe registrado en la tabla `payment`. (Usa una subconsulta para encontrar el `MAX(amount)`).
    3. **Mismo apellido**: Busca todos los actores que tengan el mismo apellido que el actor con `actor_id = 8`.
    4. **Subconsulta de fila**: Encuentra si existe algún cliente en la tabla `customer` que tenga el mismo nombre y apellido que el actor 'Jamie Waugh'.
    5. **Comparación de fechas**: Muestra los alquileres (`rental`) que se realizaron después del último alquiler registrado por el cliente con email 'JOYCE.EDWARDS@sakilacustomer.org'.

#### **AC512: Subconsultas de Lista (IN, NOT IN)**

??? "Actividad AC512"

    | Criterios de Evaluación | Ponderación |
    | ----------------------- | ----------- |
    | RABD.3 // CE3c //       | 4p          |

    **Concepto**: Filtrado de registros basándose en una lista de resultados devuelta por una subconsulta.

    Sobre la base de datos **Universidad**, realiza las siguientes consultas:

    1. **Matemáticos**: Devuelve el nombre y apellidos de los alumnos que se han matriculado en alguna asignatura del "Grado en Matemáticas (Plan 2010)".
        *   *Pista*: Necesitarás subconsultas anidadas o joins en la subconsulta para llegar desde `asignatura` hasta `grado`.
    2. **Profesores sin docencia**: Devuelve el listado de profesores (nombre y apellidos) que **no** imparten ninguna asignatura actualmente. Utiliza el operador `NOT IN`.
    3. **Asignaturas de Informática**: Muestra el nombre de las asignaturas que están asociadas a algún profesor del departamento de 'Informática'.
    4. **Alumnos sin beca (simulado)**: Supongamos que los alumnos con `id` 1, 3 y 5 tienen beca. Muestra todos los alumnos cuyo `id` **no** esté en esa lista fija `(1, 3, 5)` y que además sean mujeres.

#### **AC513: Operadores Avanzados (ANY, ALL)**

??? "Actividad AC513"

    | Criterios de Evaluación | Ponderación |
    | ----------------------- | ----------- |
    | RABD.3 // CE3c //       | 4p          |

    **Concepto**: Comparaciones cuantificadas contra conjuntos de valores.

    Sobre la base de datos **LigaFutbol**, realiza las siguientes consultas:

    1. **Gigantes económicos**: Muestra el nombre y presupuesto de los equipos cuyo presupuesto sea mayor que el de **todos** los equipos fundados antes de 1950.
    2. **Jugadores altos**: Obtén el nombre y la altura de los jugadores que sean más altos que **cualquier** (al menos uno) jugador del equipo con código 'RMA' (Real Madrid).
    3. **Salarios técnicos**: Muestra los entrenadores que cobran más que el salario promedio de los entrenadores de equipos cuyo estadio tiene una capacidad inferior a 30.000 espectadores (usa `ALL`).

#### **AC514-A: Subconsultas Correlacionadas y EXISTS**

??? "Actividad AC514-A"

    | Criterios de Evaluación | Ponderación |
    | ----------------------- | ----------- |
    | RABD.3 // CE3c //       | 5p          |

    **Concepto**: Subconsultas dependientes de la consulta externa y verificación de existencia.

    Sobre la base de datos **Sakila**, realiza las siguientes consultas:

    1. **Superiores a su categoría**: Muestra el título, la duración y el `rating` de las películas que duran más que el promedio de duración **de su propio rating**.
    2. **Actores de Acción**: Utiliza `EXISTS` para listar el nombre y apellido de los actores que han participado en alguna película de la categoría 'Action'.
    3. **Películas olvidadas**: Utiliza `NOT EXISTS` para obtener el título de las películas que **jamás** han sido alquiladas (no aparecen en la tabla `rental` a través del inventario).
    4. **Clientes fieles**: Muestra los clientes que han realizado al menos un pago superior a 10$, pero usando `EXISTS` en lugar de un `JOIN` normal.
    5. **Doble correlación (Reto)**: Encuentra las películas (`film`) que tienen el mismo precio de alquiler (`rental_rate`) y la misma duración (`length`) que alguna otra película distinta (es decir, parejas de películas idénticas en precio y duración).

#### **AC514-B: Subconsultas Correlacionadas (Comparativas de Grupo)**

??? "Ejercicio AC514-B"

    | Criterios de Evaluación | Ponderación |
    | ----------------------- | ----------- |
    | RABD.3 // CE3c //       | 5p          |

    **Concepto**: Subconsultas que dependen de la fila actual para realizar cálculos estadísticos (medias, conteos) específicos para el grupo al que pertenece dicha fila. **No utilices `GROUP BY` en la consulta principal**, la lógica debe residir en la subconsulta.

    **Bloque A: Base de datos LigaFutbol**

    1.  **Jugadores destacados en su equipo**:
        Queremos encontrar a los "torres" de cada equipo. Muestra el nombre, apellido, altura y nombre del equipo de aquellos jugadores que son **más altos que la altura media de su propio equipo**.
        *   *Pista*: La subconsulta debe calcular `AVG(altura)` filtrando por el `equipoID` del jugador que se está procesando en ese momento.

    2.  **Partidos con alta asistencia local**:
        Muestra los partidos (fecha y equipos rivales) cuya asistencia fue superior a la **asistencia promedio de todos los partidos jugados en ese mismo estadio**.
        *   *Nota*: Esto permite ver qué partidos llenaron el estadio más de lo habitual para *ese* estadio en concreto.

    3.  **El partido más "duro" de cada árbitro**:
        Obtén el identificador del partido, la fecha y el nombre del árbitro de aquellos partidos donde se mostraron más tarjetas amarillas que en **ningún otro partido arbitrado por ese mismo árbitro**.
        *   *Pista*: Compara las tarjetas del partido actual con el `MAX(tarjetas)` de la subconsulta filtrada por ese árbitro.

    4.  **Cálculo en el SELECT (Escalar)**:
        Muestra una lista con el nombre de todos los equipos y, en una columna extra llamada `goles_a_favor_local`, muestra el total de goles que han marcado **solo cuando han jugado como local**.
        *   *Restricción*: No uses `JOIN`. Debes usar una subconsulta correlacionada dentro de la cláusula `SELECT`.

    **Bloque B: Base de datos Universidad**

    5.  **Asignaturas con mucha carga**:
        Devuelve el nombre de la asignatura, los créditos y el nombre del grado al que pertenece. La condición es que la asignatura debe tener **más créditos que el promedio de créditos de las asignaturas de ese mismo grado**.

    6.  **El benjamín del grupo**:
        Queremos saber quién es el alumno más joven de cada ciudad. Muestra el nombre, apellidos, ciudad y fecha de nacimiento de los alumnos cuya fecha de nacimiento coincida con la fecha más reciente (`MAX`) de los alumnos **de su misma ciudad**.

    7.  **Profesores con más carga que sus compañeros**:
        Muestra el nombre y apellido de los profesores que imparten más asignaturas que la **media de asignaturas que imparten los profesores de su mismo departamento**.
        *   *Nota*: Este es un ejercicio de doble nivel (conteo por profesor vs promedio del departamento).

---

#### **AC515: CTE (Common Table Expressions)**

??? "Actividad AC515"

    | Criterios de Evaluación | Ponderación |
    | ----------------------- | ----------- |
    | RABD.3 // CE3c //       | 5p          |

    **Concepto**: Uso de `WITH` para estructurar consultas complejas y evitar subconsultas en el `FROM`.

    Sobre la base de datos **LigaFutbol**, realiza las siguientes consultas:

    1. **Presupuesto Medio**: 
        *   Crea una CTE llamada `medias_por_ciudad` que calcule el presupuesto medio de los equipos agrupados por la ciudad de su estadio.
        *   Usa esa CTE para mostrar las ciudades cuyo presupuesto medio supere los 50.000.000€.
    2. **Ranking de Goleadores**:
        *   Crea una CTE `goles_totales` que sume los goles de cada jugador en la tabla `EstadisticaPartido`.
        *   Muestra el nombre del jugador y sus goles, solo de aquellos que hayan marcado más de 10 goles en total.
    3. **Comparativa de Equipos**:
        *   Crea una primera CTE `resumen_equipos` que obtenga el nombre del equipo, el número total de jugadores y la altura media de su plantilla.
        *   Crea una segunda CTE `media_global` que calcule la altura media de todos los jugadores de la liga.
        *   Consulta final: Muestra los equipos cuya altura media sea superior a la `media_global`.

#### **AC516: Actividad Resumen (Universidad)**

??? "Actividad AC516"

    | Criterios de Evaluación | Ponderación |
    | ----------------------- | ----------- |
    | RABD.3 // CE3c, CE3e // | 6p          |

    **Concepto**: Consolidación de todos los tipos de subconsultas en un entorno académico.

    Sobre la base de datos **Universidad**, resuelve:

    1. **El estudiante más joven**: Devuelve todos los datos del alumno más joven de la universidad (Subconsulta escalar con `MAX` o `MIN` sobre fecha de nacimiento).
    2. **Departamentos vacíos**: Devuelve el nombre de los departamentos que no tienen profesores asociados. (Debes hacerlo obligatoriamente con `NOT EXISTS` o `NOT IN`).
    3. **Asignaturas masificadas**: Devuelve el nombre de las asignaturas que tienen un número de alumnos matriculados superior a la media de alumnos matriculados por asignatura. (Requiere contar matriculaciones primero).
    4. **Profesores polivalentes**: Muestra el nombre y apellidos de los profesores que imparten asignaturas en más de un grado diferente. (Puedes usar subconsultas o CTEs).
    5. **Créditos por tipo**: Usa una subconsulta en la cláusula `FROM` (o una CTE) para obtener una tabla temporal con la suma de créditos por cada `tipo` de asignatura, y luego muestra solo los tipos que suman más de 100 créditos totales.

#### **AC517: El Desafío Final (Sakila Avanzado)**

??? "Actividad AC517"

    | Criterios de Evaluación | Ponderación |
    | ----------------------- | ----------- |
    | RABD.3 // CE3c, CE3e // | 4p          |

    **Concepto**: Lógica de negocio compleja, CTEs múltiples y funciones de ventana.

    Sobre la base de datos **Sakila**:

    1. **Categorías abandonadas**: Queremos saber qué categorías de películas no han tenido ningún alquiler registrado en el último mes disponible en la base de datos (toma como referencia la fecha máxima de alquiler en toda la tabla `rental`).
    
    2. **El "Top 5" de cada tienda**: 
        *   Utiliza una CTE para calcular el total gastado por cada cliente.
        *   Utiliza funciones ventana (`RANK()` o `ROW_NUMBER()`) para asignar una posición a cada cliente dentro de su tienda (`store_id`) basándose en lo que han gastado.
        *   Filtra para mostrar únicamente los 5 mejores clientes de cada tienda.

    3. **Actores "Todoterreno" (División relacional)**: 
        *   Encuentra los actores que han actuado en películas de **todas** las categorías existentes.
        *   *Pista*: Un actor cumple esto si la cantidad de categorías distintas en las que ha trabajado es igual a la cantidad total de categorías en la tabla `category`.

    4. **Comparativa mensual (Growth Rate)**:
        *   Crea una CTE que agrupe los pagos por mes (Año-Mes) y sume el importe total.
        *   En la consulta final, muestra para cada mes: el total ingresado, el total del mes anterior (usando `LAG`) y la diferencia porcentual de crecimiento respecto al mes anterior.