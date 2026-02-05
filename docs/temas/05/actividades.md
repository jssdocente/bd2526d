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

??? "Ejercicio AC501"

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

??? "Ejercicio AC502"

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

??? "Ejercicio AC503"

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

??? "Ejercicio AC504"

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

??? "Ejercicio AC505"

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

??? "Ejercicio AC506"

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

??? "Ejercicio AC507"

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

??? "Ejercicio AC508"

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

??? "Ejercicio AC509"

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

??? "Ejercicio AC510"

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