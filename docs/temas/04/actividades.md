# Actividades 

### **AC401**

??? "Ejercicio AC401"

    | Criterios de Evaluación | Ponderación |
    | ----------------------- | ----------- |
    | RABD.3 // CE3a, CE3b // | 5p          |

    Una vez cargada la base de datos de `liga_futbol` (o `SUPERLIGA` según la versión instalada), tras comprobar la estructura de las tablas `Equipo` y `Jugador`, se pide realizar las siguientes consultas:
    
    1. Lista el nombre de todos los equipos que hay en la tabla `Equipo`.
    2. Lista los nombres y los presupuestos de todos los equipos.
    3. Lista todas las columnas de la tabla `Equipo`.
    4. Lista el nombre de los jugadores junto con su altura.
    5. Recupera todas las posibilidades de posiciones que tienen los jugadores (ej: Portero, Defensa...).
    6. Lista el nombre y la altura en centímetros (altura * 100) de todos los jugadores.
    7. Lista el nombre de los equipos, el presupuesto en euros y también en dólares estadounidenses (asumiendo 1€ = 1.1$).
    8. A partir de la consulta anterior, utiliza los siguientes alias para las columnas: nombre de equipo, euros, dólares.

### **AC402**

??? "Ejercicio AC402"

    | Criterios de Evaluación | Ponderación |
    | ----------------------- | ----------- |
    | RABD.3 // CE3a, CE3b // | 5p          |

    Sobre la base de datos `liga_futbol`, y haciendo uso de funciones, realiza las siguientes consultas:
      
    1. Lista los nombres y sus ciudades de todos los equipos de la tabla `Equipo`, convirtiendo los nombres a mayúscula.
    2. Lista los nombres y los apellidos de todos los jugadores, convirtiendo los nombres a minúsculas.
    3. Lista el nombre de todos los jugadores en una columna, y en otra columna recupera en mayúsculas las 3 primeras letras de su posición.
    4. Lista el dorsal del jugador y el código de su equipo, así como un código formado por los datos de estos campos unidos (ej: `RMA-10`).
    5. Lista el nombre completo de los jugadores concatenando nombre y apellidos, y calcula la longitud total de su nombre completo.
    6. Lista los nombres, el presupuesto y el presupuesto incrementado un 10% de todos los equipos, redondeando el resultado.
    7. Lista los nombres de los jugadores y su altura truncada a 1 decimal (ej: 1.8).
    8. Muestra el nombre de los jugadores, su altura, y una categoría de altura: `Bajo` si mide menos de 1.75, `Medio` si mide entre 1.75 y 1.85, y `Alto` si mide más de 1.85.

### **AC403**

??? "Ejercicio AC403"

    | Criterios de Evaluación | Ponderación |
    | ----------------------- | ----------- |
    | RABD.3 // CE3b // | 5p          | 

    Sobre la base de datos `liga_futbol`, realiza las siguientes consultas:
        
    1. Lista, para cada jugador, además de su nombre, en campos separados, el día, el mes y el año de su nacimiento.
    2. Listado de jugadores, con su nombre, fecha de nacimiento y edad actual (calculada con `TIMESTAMPDIFF` o similar).
    3. Para cada equipo, necesitamos su nombre, su año de fundación y cuántos años lleva existiendo hasta la actualidad.
    4. Crea un listado con el nombre de los equipos y genera un código aleatorio para cada uno.
    5. Listado de jugadores ordenado por posición (alfabéticamente) y dentro de esta por altura descendente.
    6. Listado del nombre y presupuesto de los equipos (con formato numérico apropiado) ordenado por presupuesto de mayor a menor.
    7. Lista los tres jugadores más jóvenes de la base de datos.
    8. Recupera el equipo con el presupuesto más alto.

### **AR604**

??? "Ejercicio AR604"

    | Criterios de Evaluación | Ponderación |
    | ----------------------- | ----------- |
    | RABD.3 // CE3b // | 5p          |

    Sobre la base de datos `tienda_informatica`, realiza las siguientes consultas:
    
    1. Lista el nombre de todos los productos que hay en la tabla `producto`.
    2. Lista los nombres y los precios de todos los productos de la tabla `producto`.
    3. Lista todas las columnas de la tabla `producto`.
    4. Lista el nombre de los productos, el precio en euros y el precio en dólares estadounidenses (USD).
    5. Lista el nombre de los productos, el precio en euros y el precio en dólares estadounidenses (USD). Utiliza los siguientes alias para las columnas: `nombre de producto`, `euros`, `dólares`.
    6. Lista los nombres y los precios de todos los productos de la tabla `producto`, convirtiendo los nombres a mayúscula.
    7. Lista los nombres y los precios de todos los productos de la tabla `producto`, convirtiendo los nombres a minúscula.
    8. Lista el nombre de todos los fabricantes en una columna, y en otra columna obtenga en mayúsculas los dos primeros caracteres del nombre del fabricante.
    9. Lista los nombres y los precios de todos los productos de la tabla `producto`, redondeando el valor del precio.
    10. Lista los nombres y los precios de todos los productos de la tabla `producto`, truncando el valor del precio para mostrarlo sin ninguna cifra decimal.
    11. Lista el identificador de los fabricantes que tienen productos en la tabla `producto`.
    12. Lista el identificador de los fabricantes que tienen productos en la tabla `producto`, eliminando los identificadores que aparecen repetidos.
    13. Lista los nombres de los fabricantes ordenados de forma ascendente.
    14. Lista los nombres de los fabricantes ordenados de forma descendente.
    15. Lista los nombres de los productos ordenados en primer lugar por el nombre de forma ascendente y en segundo lugar por el precio de forma descendente.
    16. Devuelve una lista con las 5 primeras filas de la tabla `fabricante`.
    17. Devuelve una lista con 2 filas a partir de la cuarta fila de la tabla `fabricante`. La cuarta fila también se debe incluir en la respuesta.
    18. Lista el nombre y el precio del producto más barato. (Utilice solamente las cláusulas `ORDER BY` y `LIMIT`)
    19. Lista el nombre y el precio del producto más caro. (Utilice solamente las cláusulas `ORDER BY` y `LIMIT`)

### **AR405**

??? "Ejercicio AR405"

    | Criterios de Evaluación | Ponderación |
    | ----------------------- | ----------- |
    | RABD.3 // CE3b // | 5p          |

    Sobre la base de datos `Gestión de empleados`, realiza las siguientes consultas:

    1. Lista el primer apellido de todos los empleados.
    2. Lista el primer apellido de los empleados eliminando los apellidos que estén repetidos.
    3. Lista todas las columnas de la tabla empleado.
    4. Lista el nombre y los apellidos de todos los empleados.
    5. Lista el identificador de los departamentos de los empleados que aparecen en la tabla empleado.
    6. Lista el identificador de los departamentos de los empleados que aparecen en la tabla empleado, eliminando los identificadores que aparecen repetidos.
    7. Lista el nombre y apellidos de los empleados en una única columna.
    8. Lista el nombre y apellidos de los empleados en una única columna, convirtiendo todos los caracteres en mayúscula.
    9. Lista el nombre y apellidos de los empleados en una única columna, convirtiendo todos los caracteres en minúscula.
    10. Lista el identificador de los empleados junto al nif, pero el nif deberá aparecer en dos columnas, una mostrará únicamente los dígitos del nif y la otra la letra.
    11. Lista el nombre de cada departamento y el valor del presupuesto actual del que dispone. Para calcular este dato tendrá que restar al valor del presupuesto inicial (columna presupuesto) los gastos que se han generado (columna gastos). Tenga en cuenta que en algunos casos pueden existir valores negativos. Utilice un alias apropiado para la nueva columna columna que está calculando.
    12. Lista el nombre de los departamentos y el valor del presupuesto actual ordenado de forma ascendente.
    13. Lista el nombre de todos los departamentos ordenados de forma ascendente.
    14. Lista el nombre de todos los departamentos ordenados de forma descendente.
    15. Lista los apellidos y el nombre de todos los empleados, ordenados de forma alfabética tendiendo en cuenta en primer lugar sus apellidos y luego su nombre.
    16. Devuelve una lista con el nombre y el presupuesto, de los 3 departamentos que tienen mayor presupuesto.
    17. Devuelve una lista con el nombre y el presupuesto, de los 3 departamentos que tienen menor presupuesto.
    18. Devuelve una lista con el nombre y el gasto, de los 2 departamentos que tienen mayor gasto.
    19. Devuelve una lista con el nombre y el gasto, de los 2 departamentos que tienen menor gasto.
    20. Devuelve una lista con 5 filas a partir de la tercera fila de la tabla empleado. La tercera fila se debe incluir en la respuesta. La respuesta debe incluir todas las columnas de la tabla empleado.  

### **AC406**

??? "Ejercicio AC406"

    | Criterios de Evaluación | Ponderación |
    | ----------------------- | ----------- |
    | RABD.3 // CE3b // | 5p          |

    Sobre la base de datos `liga_futbol`, realiza las siguientes consultas:
    
    1. Recupera el nombre, apellidos y posición del jugador con dorsal `10` del equipo con código `RMA` (o el código que corresponda al Real Madrid).
    2. Listar sin repeticiones la ciudad de todos los equipos que se fundaron antes del año 1950.
    3. Listar el nombre de los jugadores que no tienen asignado un dorsal (o cuyo dorsal es NULL, si aplica).
    4. Listar el nombre y ciudad de los equipos que no sean de `Madrid` ni de `Barcelona`.
    5. Listar el nombre y altura de los jugadores que midan menos de 1.70 o más de 1.95 metros.
    6. Listar el nombre de los jugadores cuya posición no sea ni `Portero`, ni `Defensa`.
    7. Listar el nombre de los jugadores que tengan en su apellido la secuencia de letras `ez`.
    8. Listar el nombre y presupuesto de los equipos que tienen un presupuesto menor a 50 millones pero se fundaron antes de 1980.
    9. Listar el nombre de los jugadores que son `Delantero` o `Medio` y que:
        
        a) Miden más de 1.85; o  
        b) Tienen menos de 20 años.


### **AC407**

??? "Ejercicio AC407"

    | Criterios de Evaluación | Ponderación |
    | ----------------------- | ----------- |
    | RABD.3 // CE3b // | 5p          |

    Explica qué recuperan las siguientes consultas (en lenguaje natural, no leyendo la consulta):

    ```sql
    SELECT CodEmp, ROUND(SalEmp, 2) FROM empleado WHERE SalEmp > 2500000;
    SELECT SUM(NumHij) FROM hijo;
    SELECT CodHab, DesHab FROM habilidad WHERE LOWER(DesHab) LIKE '%gestión%';
    SELECT AVG(SalEmp) FROM empleado WHERE NumHi >= 1;
    SELECT NomEmp, TIMESTAMPDIFF(YEAR, FecInEmp, CURDATE()) FROM empleado WHERE TIMESTAMPDIFF(YEAR, FecInEmp, CURDATE()) > 25;
    SELECT CodCen, NomCen FROM centro WHERE PobCen = "Elche" ORDER BY NomCen DESC;
    SELECT COUNT(*) FROM departamento WHERE PreAnu > 20000000;
    SELECT CodEmp, NomEmp, COALESCE(ExTelEmp, NumHi, "0000") from empleado;
    SELECT CodHab, DesHab, CHAR_LENGTH(DesHab) FROM habilidad WHERE CodHab LIKE 'A%';
    ```


### **AR408**

??? "Ejercicio AR408"

    | Criterios de Evaluación | Ponderación |
    | ----------------------- | ----------- |
    | RABD.3 // CE3b // | 5p          |

    Sobre la base de datos `tienda_informatica`, realiza las siguientes consultas:
    
    20. Lista el nombre de todos los productos del fabricante cuyo identificador de fabricante es igual a 2.
    21. Lista el nombre de los productos que tienen un precio menor o igual a 120€.
    22. Lista el nombre de los productos que tienen un precio mayor o igual a 400€.
    23. Lista el nombre de los productos que **no tienen** un precio mayor o igual a 400€.
    24. Lista todos los productos que tengan un precio entre 80€ y 300€. Sin utilizar el operador `BETWEEN`. 
    25. Lista todos los productos que tengan un precio entre 60€ y 200€. Utilizando el operador `BETWEEN`.
    26. Lista todos los productos que tengan un precio mayor que 200€ y que el identificador de fabricante sea igual a 6. 
    27. Lista todos los productos donde el identificador de fabricante sea 1, 3 o 5. Sin utilizar el operador `IN`. 
    28. Lista todos los productos donde el identificador de fabricante sea 1, 3 o 5. Utilizando el operador `IN`.
    29. Lista el nombre y el precio de los productos en céntimos (Habrá que multiplicar por 100 el valor del precio). Cree un alias para la columna que contiene el precio que se llame `céntimos`.
    30. Lista los nombres de los fabricantes cuyo nombre empiece por la letra `S`.
    31. Lista los nombres de los fabricantes cuyo nombre termine por la vocal `e`.
    32. Lista los nombres de los fabricantes cuyo nombre contenga el carácter `w`.
    33. Lista los nombres de los fabricantes cuyo nombre sea de 4 caracteres.
    34. Devuelve una lista con el nombre de todos los productos que contienen la cadena `Portátil` en el nombre.
    35. Devuelve una lista con el nombre de todos los productos que contienen la cadena `Monitor` en el nombre y tienen un precio inferior a 215 €.
    36. Lista el nombre y el precio de todos los productos que tengan un precio mayor o igual a 180€. Ordene el resultado en primer lugar por el precio (en orden descendente) y en segundo lugar por el nombre (en orden ascendente).

### **AP409**

??? "Ejercicio AP409"

    | Criterios de Evaluación | Ponderación |
    | ----------------------- | ----------- |
    | RABD.3 // CE3b // | 5p          |

    Sobre la base de datos `Gestion de empleados`, realiza las siguientes consultas:
    
    21. Devuelve una lista con el nombre de los departamentos y el presupuesto, de aquellos que tienen un presupuesto mayor o igual a 150000 euros.
    22. Devuelve una lista con el nombre de los departamentos y el gasto, de aquellos que tienen menos de 5000 euros de gastos.
    23. Devuelve una lista con el nombre de los departamentos y el presupuesto, de aquellos que tienen un presupuesto entre 100000 y 200000 euros. Sin utilizar el operador `BETWEEN`.
    24. Devuelve una lista con el nombre de los departamentos que **no** tienen un presupuesto entre 100000 y 200000 euros. Sin utilizar el operador `BETWEEN`.
    25. Devuelve una lista con el nombre de los departamentos que tienen un presupuesto entre 100000 y 200000 euros. Utilizando el operador `BETWEEN`.
    26. Devuelve una lista con el nombre de los departamentos que **no** tienen un presupuesto entre 100000 y 200000 euros. Utilizando el operador `BETWEEN`.
    27. Devuelve una lista con el nombre de los departamentos, gastos y presupuesto, de aquellos departamentos donde los gastos sean mayores que el presupuesto del que disponen.
    28. Devuelve una lista con el nombre de los departamentos, gastos y presupuesto, de aquellos departamentos donde los gastos sean menores que el presupuesto del que disponen.
    29. Devuelve una lista con el nombre de los departamentos, gastos y presupuesto, de aquellos departamentos donde los gastos sean iguales al presupuesto del que disponen.
    30. Lista todos los datos de los empleados cuyo segundo apellido sea `NULL`.
    31. Lista todos los datos de los empleados cuyo segundo apellido **no sea** `NULL`.
    32. Lista todos los datos de los empleados cuyo segundo apellido sea `López`.
    33. Lista todos los datos de los empleados cuyo segundo apellido sea `Díaz` o `Moreno`. Sin utilizar el operador `IN`.
    34. Lista todos los datos de los empleados cuyo segundo apellido sea `Díaz` o `Moreno`. Utilizando el operador `IN`.
    35. Lista los nombres, apellidos y nif de los empleados que trabajan en el departamento `3`.
    36. Lista los nombres, apellidos y nif de los empleados que trabajan en los departamentos `2`, `4` o `5`.


### **AC410**

??? "Ejercicio AC410"

    | Criterios de Evaluación | Ponderación |
    | ----------------------- | ----------- |
    | RABD.3 // CE3c // | 5p          |

    Sobre la base de datos `liga_futbol`, y utilizando composiciones internas, realiza las siguientes consultas:
    
    1. Muestra para cada jugador, su nombre, apellidos y el nombre del equipo al que pertenece.
    2. Muestra para cada equipo, su nombre y el nombre del estadio donde juega.
    3. Muestra para cada jugador, su nombre, el nombre de su equipo y el nombre de su estadio.
    4. Muestra el nombre del equipo, la ciudad y el nombre de su estadio, del equipo que tenga el presupuesto más alto.
    5. Listar los jugadores del equipo `Real Madrid` (utilizando el nombre del equipo en la condición, no el código).
    6. Listar el nombre del jugador y el nombre de su mentor (tabla `Jugador` con auto-referencia a `mentorID`), para aquellos jugadores que tengan mentor.
    7. Usando operadores de conjuntos :
        
        1. Equipos que tienen jugadores registrados.
        2. Equipos que no tienen jugadores registrados (si hubiese).
    8. Recupera los jugadores que juegan en equipos de la ciudad de `Sevilla`.
        
    9. Recupera los equipos que tienen jugadores que juegan en la posición de `Portero`.
    10. Recupera todos los jugadores que son capitaneados/mentorizados por otro jugador (tienen `mentorID` no nulo).


### **AP411**

??? "Ejercicio AP411"

    | Criterios de Evaluación | Ponderación |
    | ----------------------- | ----------- |
    | RABD.3 // CE3c // | 5p          |

    Sobre la base de datos `liga_futbol`, y utilizando composiciones externas, realiza las siguientes consultas:

    1. Listar el nombre de todos los estadios y, si se ha jugado algún partido en ellos, la fecha y el código del partido. Deben aparecer todos los estadios.
    2. Listar el nombre de todos los árbitros y el código de los partidos que han arbitrado. Incluir a los árbitros que no han dirigido ningún encuentro.
    3. Listar el nombre de todos los patrocinadores y el nombre de los equipos a los que patrocinan. Incluir aquellos patrocinadores que actualmente no tienen contrato con ningún equipo.
    4. Mostrar el nombre de los equipos que **no** tienen ningún patrocinador.
    5. Listar el nombre de todos los jugadores y, si han jugado algún partido, los minutos jugados. Deben aparecer todos los jugadores, tengan o no referencias en las estadísticas.
    6. Mostrar el nombre de los jugadores que **no** han participado en ningún partido (no tienen registros en la tabla de estadísticas).
    7. Listar el nombre de todos los jugadores y el nombre de su mentor. Deben aparecer todos los jugadores, indicando `NULL` (o vacío) si no tienen mentor.
    8. Listar el nombre de todos los jugadores y el nombre de sus "pupilos" (jugadores a los que mentorizan). Deben aparecer todos los jugadores, incluso si no son mentores de nadie.
    9. Listar el nombre de todos los equipos y el nombre de su entrenador. Asegurarse de mostrar todos los equipos, incluso si no tienen entrenador registrado.
    10. Listar todas las jornadas de la base de datos y la cantidad de partidos asociados a ellas. Si alguna jornada no tiene partidos, debe aparecer con 0.
    11. Listar el nombre de todos los equipos y la suma total de los montos de sus contratos de patrocinio. Si un equipo no tiene patrocinadores, debe aparecer con un total de 0.


### **AC412**

??? "Ejercicio AC412"

    | Criterios de Evaluación | Ponderación |
    | ----------------------- | ----------- |
    | RABD.3 // CE3c // | 5p          |

    Sobre la base de datos `liga_futbol`, y utilizando operaciones de conjuntos (`UNION`, `INTERSECT`, `EXCEPT` o sus equivalentes), realiza las siguientes consultas:

    1. Elabora un listado único que contenga los nombres de todas las ciudades donde hay un equipo registrado y las ciudades donde se ubica algún estadio.
    2. Genera una lista con los nombres y apellidos de todas las personas registradas en la base de datos: jugadores, entrenadores y árbitros. Indica en una columna adicional el tipo de persona ('Jugador', 'Entrenador', 'Arbitro').
    3. Obtén la lista de los códigos de los equipos que han jugado algún partido como local y que también han jugado algún partido como visitante.
    4. Obtén la lista de los códigos de los equipos que han jugado como local en algún partido, pero que **no** han jugado como visitante en ningún encuentro.
    5. Muestra los nombres de los estadios en los que se ha jugado algún partido con clima 'Soleado' o donde la asistencia ha superado los 70,000 espectadores (utiliza la unión de conjuntos).
    6. Lista los identificadores de los jugadores que han marcado algún gol y que también han recibido alguna tarjeta amarilla.
    7. Lista los identificadores de los jugadores que han marcado algún gol pero que **no** han recibido ninguna tarjeta roja.
    8. Muestra una lista de todos los apellidos presentes en la tabla `Jugador` y en la tabla `Entrenador`, eliminando los duplicados.
    9. Obtén los identificadores de los árbitros que han pitado algún partido en la jornada 1 y que también han pitado algún partido en la jornada 2.
    10. Lista los nombres de los equipos que tienen un presupuesto superior a 100 millones **unido** a los equipos que se fundaron antes del año 1950.
    11. Devuelve un listado de todos los posibles resultados climáticos registrados en los partidos y todas las posiciones posibles de los jugadores (usando las columnas correspondientes), para ver la variedad de términos usados en la BD.


### **AA413**

??? "Ejercicio AA413: Actividad de Ampliación"

    | Criterios de Evaluación | Ponderación |
    | ----------------------- | ----------- |
    | RABD.3 // CE3c // | 5p          |

    Sobre la base de datos `liga_futbol`:

    1. **Transferencias caras**: Lista el nombre completo del jugador (Nombre + " " + Apellido), el nombre del equipo de origen, el nombre del equipo de destino, y el costo del traspaso, para todos los traspasos que costaron más de 5.000.000 (asume la unidad monetaria de la BD) y ocurrieron antes del año 2024. Ordena los resultados por el costo de mayor a menor.
    2. **Partidos de Apertura**: Lista el código del partido, la fecha (formato día/mes/año), el nombre del estadio, y el nombre del árbitro para todos los partidos de la 'Jornada 1' de cualquier temporada. Utiliza `DATE_FORMAT` para la fecha.
    3. **Expulsiones**: Muestra el nombre y apellido del jugador, el nombre de su equipo y los minutos jugados, para aquellos registros de partido (`EstadisticaPartido`) donde el jugador haya recibido alguna tarjeta roja. Incluye también el nombre del árbitro que dirigió ese encuentro.
    4. **Condiciones Adversas**: Lista los nombres de los dos equipos que se enfrentaron (Local vs Visitante) y el nombre del estadio, para todos los partidos donde el clima registrado contenga la palabra 'Lluvia' (usa `LIKE`) y el estadio tenga césped natural.
    5. **Cadena de Mando**: Lista el nombre del jugador pupilo, su fecha de nacimiento, el nombre de su mentor, y la fecha de nacimiento del mentor. Filtra para mostrar solo aquellos casos donde el mentor es más joven que el pupilo (¡Curioso caso!).
    6. **Patrocinadores Principales**: Lista el nombre del equipo, el nombre de la empresa patrocinadora y el monto total del contrato. Muestra solo los contratos firmados en el año actual (usa `YEAR` y `CURDATE` o un año fijo reciente) y cuya duración sea superior a 12 meses.