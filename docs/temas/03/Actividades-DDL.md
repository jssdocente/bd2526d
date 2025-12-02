# Actividades

### **AC301**

??? "Ejercicio AC301"

    | Criterios de Evaluación | Ponderación |
    | ----------------------- | ----------- |
    | RABD.2 // CE2a, CE2c // | 5p          |

    Para cada uno de los siguientes requisitos de almacenamiento, elige el tipo de dato de MySQL más adecuado y justifica tu decisión, considerando el uso de memoria y la precisión necesaria:

    a) El número de identificación fiscal de una persona (NIF/DNI en España).<br>
    b) El sueldo mensual de un empleado (puede tener decimales, hasta 6 cifras antes del punto y 2 después).<br>
    c) Un identificador único para transacciones bancarias (cadena alfanumérica de 32 caracteres, como un UUID).<br>
    d) Si un producto está en oferta o no.<br>
    e) La cantidad de stock de un producto, que puede ir de 0 a 65535.<br>
    f) La dirección IP de un usuario.<br>
    g) El contenido de un comentario de blog (varios párrafos, pero limitado a 5000 caracteres).<br>
    h) Coordenadas GPS (latitud y longitud con alta precisión).<br>

### **AC302**

??? "Ejercicio AC302"

    | Criterios de Evaluación             | Ponderación |
    | ----------------------------------- | ----------- |
    | RABD.2 // CE2a, CE2c, CE2e, CE2h // | 5p          |

    Se desea crear una tabla `Usuario` donde el campo `nombreUsuario` debe ser único y las búsquedas deben distinguir entre mayúsculas y minúsculas, así como acentos. La base de datos debe soportar el idioma español y caracteres especiales.

    a) ¿Qué `CHARACTER SET` recomendarías para la base de datos y/o la columna `nombreUsuario`?<br>
    b) ¿Qué `COLLATION` específica dentro de ese juego de caracteres deberías usar para que las comparaciones sean sensibles a mayúsculas/minúsculas y acentos?<br>
    c) Escribe la sentencia SQL para crear una tabla `Usuario` con un campo `nombreUsuario` de 50 caracteres que cumpla con estos requisitos de sensibilidad.<br>

### **AC303**

??? "Ejercicio AC303"

    | Criterios de Evaluación             | Ponderación |
    | ----------------------------------- | ----------- |
    | RABD.2 // CE2a, CE2c, CE2e, CE2h // | 5p          |

    Imagina que estás diseñando una tabla `Evento`. Para cada campo, elige el tipo de dato más apropiado y sus atributos (ej. `NOT NULL`, `DEFAULT`, `UNSIGNED`, `ZEROFILL`, etc.) justificando tu elección:

    a) `id`: Un identificador numérico único para cada evento, que se genera automáticamente.<br>
    b) `nombreEvento`: El nombre del evento (obligatorio).<br>
    c) `fechaHoraInicio`: La fecha y hora exactas en que comienza el evento (obligatorio, por defecto la fecha y hora actual si no se especifica).<br>
    d) `duracionMinutos`: La duración del evento en minutos (siempre un número positivo, hasta 32767 minutos).<br>
    e) `esPrivado`: Un indicador de si el evento es privado o público.<br>
    f) `descripcion`: Una descripción opcional del evento, que puede ser muy larga (hasta 10.000 caracteres).<br>

### **AC304**

??? "Ejercicio AC304"

    | Criterios de Evaluación                   | Ponderación |
    | ----------------------------------------- | ----------- |
    | RABD.2 // CE2b, CE2c, CE2d, CE2e, CE2h // | 3p          |

    Crea una tabla `Cliente` con los siguientes campos:

    - `id`: Entero, clave primaria, auto-incrementable.
    - `nombre`: Cadena de texto de hasta 100 caracteres, no nulo.
    - `apellido`: Cadena de texto de hasta 100 caracteres, no nulo.
    - `email`: Cadena de texto de hasta 255 caracteres, única.
    - `fechaNacimiento`: Fecha.

### **AC305**

??? "Ejercicio AC305"

    | Criterios de Evaluación                   | Ponderación |
    | ----------------------------------------- | ----------- |
    | RABD.2 // CE2b, CE2c, CE2d, CE2e, CE2h // | 5p          |

    En una universidad, se lleva un registro de las asignaturas que cursa cada alumno en un periodo académico específico. Crea una tabla `Matricula` con los siguientes campos, utilizando una clave primaria compuesta:

    - `alumnoId`: Entero, no nulo.
    - `asignaturaId`: Entero, no nulo.
    - `periodoAcademico`: Cadena de texto de 10 caracteres (ej: "2023-2024").
    - `fechaMatricula`: Fecha, no nulo.

    La combinación de `alumnoId`, `asignaturaId` y `periodoAcademico` debe ser única.

### **AC306**

??? "Ejercicio AC306"

    | Criterios de Evaluación                   | Ponderación |
    | ----------------------------------------- | ----------- |
    | RABD.2 // CE2b, CE2c, CE2d, CE2e, CE2h // | 5p          |

    Crea dos tablas: `Departamento` y `Empleado`.

    - **`Departamento`**:
      - `id`: Entero, clave primaria, auto-incrementable.
      - `nombreDepartamento`: Cadena de texto de hasta 50 caracteres, único, no nulo.
    - **`Empleado`**:
      - `id`: Entero, clave primaria, auto-incrementable.
      - `nombreEmpleado`: Cadena de texto de hasta 100 caracteres, no nulo.
      - `apellidoEmpleado`: Cadena de texto de hasta 100 caracteres, no nulo.
      - `email`: Cadena de texto de hasta 255 caracteres, única.
      - `departamentoId`: Entero, clave foránea que referencia a `id` de la tabla `Departamento`.

    Define la clave foránea para que, si un departamento es eliminado, los empleados asociados a ese departamento pasen a tener `NULL` en su `departamentoId`.

### **AC307**

??? "Ejercicio AC307"

    | Criterios de Evaluación                   | Ponderación |
    | ----------------------------------------- | ----------- |
    | RABD.2 // CE2b, CE2c, CE2d, CE2e, CE2h // | 7p          |

    Considerando la tabla `Matricula` del Ejercicio AC305. Ahora queremos que `alumnoId` sea una clave foránea que referencia a una tabla `Alumno` y `asignaturaId` sea una clave foránea que referencia a una tabla `Asignatura`.

    - **`Alumno`**:
      - `id`: Entero, clave primaria, auto-incrementable.
      - `nombreAlumno`: Cadena de texto de hasta 100 caracteres, no nulo.
    - **`Asignatura`**:
      - `id`: Entero, clave primaria, auto-incrementable.
      - `nombreAsignatura`: Cadena de texto de hasta 100 caracteres, no nulo.

    Escribe las sentencias SQL para crear las tres tablas (`Alumno`, `Asignatura` y `Matricula`) con sus respectivas claves foráneas. Para `Matricula`, asegúrate de que la clave foránea `alumnoId` referencie a `Alumno` y `asignaturaId` a `Asignatura`, con las acciones por defecto en caso de borrado o actualización.

### **AC308**

??? "Ejercicio AC308"

    | Criterios de Evaluación                   | Ponderación |
    | ----------------------------------------- | ----------- |
    | RABD.2 // CE2b, CE2c, CE2d, CE2e, CE2h // | 5p          |

    Crea una tabla `Producto` con los siguientes campos:

    - `id`: Entero, clave primaria, auto-incrementable.
    - `nombreProducto`: Cadena de texto de hasta 100 caracteres, no nulo.
    - `precioUnitario`: Decimal (10, 2), no nulo. Debe ser siempre mayor que 0.
    - `cantidadStock`: Entero, no nulo, con un valor por defecto de 0. Debe ser siempre mayor o igual a 0.
    - `fechaUltimaActualizacion`: Fecha y hora, con valor por defecto la fecha y hora actual.

    Incluye las restricciones `CHECK` necesarias para `precioUnitario` y `cantidadStock`.

### **AC309**

??? "Ejercicio AC309"

    | Criterios de Evaluación | Ponderación |
    | ----------------------- | ----------- |
    | RABD.2 // CE2h //       | 3p          |

    Después de crear las tablas de los ejercicios AC304, AC306 y AC308, utiliza la línea de comandos de MySQL para:

    a) Mostrar la sentencia `CREATE TABLE` completa de la tabla `Cliente`.<br>
    b) Mostrar la estructura detallada de la tabla `Empleado`.<br>
    c) Mostrar la sentencia `CREATE TABLE` completa de la tabla `Producto`, verificando que las restricciones `CHECK` se hayan aplicado.<br>


### **AC310**

??? "Ejercicio AC31"

    | Criterios de Evaluación       | Ponderación |
    | ----------------------------- | ----------- |
    | RABD.2 // CE2b, CE2c, CE2h // | 3p          |

    - A la tabla `Cliente` (del Ejercicio AC304), añade una nueva columna llamada `telefono` de tipo cadena de texto de hasta 15 caracteres, que puede ser nula.
    - Modifica la columna `descripcion` de la tabla `Evento` (del Ejercicio AC303.C) para que ahora tenga un límite de 20.000 caracteres y sea de tipo `TEXT` en lugar del `VARCHAR` implícito.
    - De la tabla `Producto` (del Ejercicio AC308.C), elimina la columna `fechaUltimaActualizacion`.
    - A la tabla `Empleado` (del Ejercicio AC306.C), añade una restricción `UNIQUE` a la combinación de `nombreEmpleado` y `apellidoEmpleado`. Esto significa que no puede haber dos empleados con el mismo nombre y apellido.


### **AC311**

??? "Ejercicio AC311"

    | Criterios de Evaluación | Ponderación |
    | ----------------------- | ----------- |
    | RABD.2 // CE2b, CE2h // | 3p          |

    a) Renombra la columna `nombreProducto` de la tabla `Producto` (del Ejercicio AC308.C) a `nombre`.<br>
    b) Renombra la tabla `Producto` a `Articulo`.<br>
    c) Elimina la clave foránea que relaciona la tabla `Empleado` con la tabla `Departamento`.<br>
    d) Elimina la tabla `Evento` (del Ejercicio AC303.C).<br>

---

> Exercicios tipo examen


### **AC312**

??? "Ejercicio AC312.A"

    |  Criterios de Evaluación  | Ponderación |
    | --- | --- |
    | RABD.2 // CE2b, CE2c, CE2d, CE2e, CE2h // | 5p          |


    A partir del siguiente modelo lógico:

    <div class="grid cards" markdown>

    - Módelo lógico
    
        ```sql
        Table Estudiante {
            nia texto [pk, note:"10 longitud fija"]
            nombre texto [not null, note:"max 50 caracteres"]
            apellidos texto [not null, note:"max 80 caracteres"]
            fnac fecha [not null]
            grupoID numero [not null]
        }

        Table Grupo {
            codigo numero [pk]
            descripcion texto [not null, note:"max 500 longitud"]
            delegadoID texto [null, note:"FK de estudiante"]
        }

        Table Asignatura {
            codigo numero [pk]
            nombre texto [not null, note:"max 100 longitud"]
            docenteID texto [not null]
        }

        Table Docente {
            dni texto [pk, note:"9 longitud fija"]
            nombre texto [not null]
            email texto [not null, unique]
        }

        Table Matricula {
            estudianteID texto [pk]
            asignaturaID numero [pk]
        }

        Ref: "Grupo"."codigo" < "Estudiante"."grupoID"
        Ref: "Estudiante"."nia" - "Grupo"."delegadoID"
        Ref: "Estudiante"."nia" < "Matricula"."estudianteID"
        Ref: "Asignatura"."codigo" < "Matricula"."asignaturaID"
        Ref: "Docente"."dni" < "Asignatura"."docenteID"
        ```

    - Diagrama módelo lógico
        
        ![](img/AC312.png"")    

    </div>

    Realiza el modelo físico, creando un script único incluyendo los siguientes elementos:

    - La creación de la BD, de nombre "AC312A"
    - Cada tabla indicada en el modelo lógico con su nombre y atributos.
    - Crea las restricciones de Foreign Key dando nombre a la restricción.
    ```sql
    CONSTRAINT {nombre-restriccion} FOREIGN KEY ({columna}) REFERENCES {tabla}({columna})
    ```

### **AC313**

??? "Ejercicio AC313"

    |  Criterios de Evaluación  | Ponderación |
    | --- | --- |
    | RABD.2 // CE2b, CE2c, CE2d, CE2e, CE2h // | 5p          |

    A partir del siguiente modelo lógico:

    <div class="grid cards" markdown>

    - Módelo lógico
    
        ```sql
        Table Estudiante {
        nia texto [pk, note:"10 longitud fija"]
        nombre texto [not null, note:"max 50 caracteres"]
        apellidos texto [not null, note:"max 80 caracteres"]
        fnac fecha [not null]
        grupoID numero [not null]
        }

        Table Grupo {
        codigo numero [pk]
        descripcion texto [not null, note:"max 500 longitud"]
        delegadoID texto [null, note:"FK de estudiante"]
        }

        Table Asignatura {
        codigo numero [pk]
        nombre texto [not null, note:"max 100 longitud"]
        cicloID texto [not null]
        docenteID texto [not null]
        }

        Table Ciclo {
        codigo texto [pk, note:"codigo de 3 digitos"]
        nombre texto [not null]
        tipo texto [note: "Valores posibles A,B,C,D,E"]
        }

        Table Docente {
        dni texto [pk, note:"9 longitud fija"]
        nombre texto [not null]
        email texto [not null, unique]
        }

        Table Matricula {
        estudianteID texto [pk]
        asignaturaID numero [pk]
        }

        Ref: "Grupo"."codigo" < "Estudiante"."grupoID"
        Ref: "Estudiante"."nia" - "Grupo"."delegadoID"
        Ref: "Estudiante"."nia" < "Matricula"."estudianteID"
        Ref: "Asignatura"."codigo" < "Matricula"."asignaturaID"
        Ref: "Docente"."dni" < "Asignatura"."docenteID"
        Ref: "Ciclo"."codigo" < "Asignatura"."cicloID"
        ```

    - Diagrama módelo lógico
        
        ![](img/AC313.png"")    

    </div>


    Realiza el modelo físico, creando un script único incluyendo los siguientes elementos:

    - La creación de la BD, de nombre "AC313"
    - Cada tabla indicada en el modelo lógico con su nombre y atributos.
    - Cada restricción se agrega utilizando la forma dando nombre a la restricción.
    - Para las restricciones de Foreign Key, aplica la siguiente propagación:
    - Al borrar un docente, el campo `docenteID` debe ser null.
    - Al borrar un grupo, el campo `grupoID` debe ser null.
    - Al eliminar un `estudiante` el campo `delegadoID` sea null.
    - No se permita borrar 
        - un ciclo si tiene asignaturas vinculadas.
        - un estudiante si tiene matriculas
        - una asignatura si tiene matriculas


### **AC314**

??? "Ejercicio AC314: La Superliga de Datos"

    |  Criterios de Evaluación  | Ponderación |
    | --- | --- |
    | RABD.2 // CE2b, CE2c, CE2d, CE2e, CE2h // | 15p          |

    Te han contratado como Administrador de Base de Datos (DBA) para la nueva liga de fútbol. El equipo de análisis te ha entregado el modelo lógico inicial, pero como suele pasar en los proyectos reales, los requisitos van a cambiar sobre la marcha y tendrás que adaptar la base de datos sin perder información.

    **Parte 1: El Modelo Lógico Inicial**

    Analiza el siguiente código DBML. Presta atención a las notas sobre longitudes y tipos de datos.

    <div class="grid cards" markdown>

    - Módelo lógico
    
        ```sql
        // Nombre de la Base de Datos: LIGA_FUTBOL

        Table EQUIPO {
        cod_equipo char(3) [pk, note: "Código de 3 letras, ej: RMA, BAR"]
        nombre_oficial varchar(100) [not null, unique, note: "Nombre único del club"]
        ciudad varchar(30) [not null]
        anio_fundacion int [null]
        web_oficial varchar(200) [null]
        }

        Table JUGADOR {
        dni char(9) [pk, note: "DNI con letra"]
        nombre varchar(50) [not null]
        apellidos varchar(50) [not null]
        dorsal int [not null]
        posicion enum [note: "Valores: 'PORTERO','DEFENSA','MEDIO','DELANTERO'"]
        cod_equipo char(3) [not null, note: "FK hacia EQUIPO"]
        }

        Table ESTADIO {
        id_estadio int [pk, increment]
        nombre varchar(100) [not null]
        capacidad int [not null, default: 5000]
        cod_equipo char(3) [not null, unique, note: "FK hacia EQUIPO. Relación 1:1"]
        }

        // Relaciones
        Ref: EQUIPO.cod_equipo < JUGADOR.cod_equipo
        Ref: EQUIPO.cod_equipo - ESTADIO.cod_equipo // Relación 1:1
        ```

    - Diagrama módelo lógico
        
        ![](img/AC314.png"")    

    </div>

    **Parte 2: Tareas de Implementación (DDL)**

    Realiza un **único script SQL** (.sql) que resuelva secuencialmente los siguientes apartados. Comenta cada paso en el código.

    *A. Creación de la Estructura Base*

    1.  Crea la base de datos `SUPERLIGA` y selecciónala.
    2.  Crea la tabla **`ESTADIO`** con su clave primaria.
    3.  Crea la tabla **`EQUIPO`**.
        *   Define la `PK` y la restricción `UNIQUE` de nombre (`uk_equipo_nombre`).
        *   **IMPORTANTE:** Define la Clave Ajena `EstadioID` (`fk_equipo_estadio`) **dentro** de la sentencia `CREATE TABLE`.
    4.  Crea la tabla **`JUGADOR`**, pero **NO definas la Clave Ajena** `EquipoID` todavía (la añadiremos después).
        *   Define la `PK`.
        *   Define una restricción `CHECK` llamada `chk_jugador_dorsal` para asegurar que el dorsal está entre *1 y 99*.

    *B. Modificación de la Estructura (ALTER)*

    El cliente te llama con nuevos requisitos. Usa sentencias `ALTER TABLE` para aplicar los cambios:

    5.  **Agregar Restricción Olvidada:** Añade la Clave Ajena `EquipoID` a la tabla `JUGADOR` que referencia a la tabla `EQUIPO`. Dale el nombre `fk_jugador_equipo`.
    6.  **Agregar Columna:** Añade una columna `email` a la tabla `JUGADOR` (Varchar 100, único). Asegúrate de crear la restricción `UNIQUE` con nombre `uk_jugador_email`.
    7.  **Modificar Columna:** Se han dado cuenta de que algunos nombres de estadios son muy largos. Modifica la columna `nombre` de la tabla `ESTADIO` para que admita hasta 150 caracteres.
    8.  **Añadir Validación:** Añade una restricción `CHECK` a la tabla `EQUIPO` llamada `chk_presupuesto_positivo` para asegurar que el `presupuesto` sea mayor o igual a 0.
    9.  **Eliminar Columna:** La columna `web` de la tabla `EQUIPO` ya no es necesaria. Elimínala.
    10. **Eliminar Restricción:** Elimina la restricción `CHECK` del dorsal de la tabla `JUGADOR` (`chk_jugador_dorsal`) porque han fichado a un jugador que quiere llevar el 0.

    *C. Operaciones Destructivas*

    11. Crea una tabla ficticia llamada `PATROCINADOR` con un campo `id` y `nombre`.
    12. Elimina la tabla `PATROCINADOR`.


### **AC315**

??? "Ejercicio AC315: El marcador en tiempo real"

    |  Criterios de Evaluación  | Ponderación |
    | --- | --- |
    | RABD.2 // CE2b, CE2c, CE2d, CE2e, CE2h // | 15p          |

    La "Liga de Fútbol Digital" te ha contratado como Ingeniero de Datos para construir el núcleo de su nuevo sistema de estadísticas. Necesitan una base de datos robusta capaz de registrar no solo los resultados finales, sino también quién pitó el partido, qué relación jerárquica tienen los árbitros entre sí y las incidencias minuto a minuto (goles, tarjetas, lesiones) asociadas a cada jugador.

    **Parte 1: El Modelo Lógico Inicial**

    Analiza el siguiente código DBML. Presta atención a las notas sobre longitudes y tipos de datos.

    <div class="grid cards" markdown>

    - Módelo lógico
    
        ```sql
        // Nombre de la Base de Datos: LIGA_FUTBOL
        Table EQUIPO {
            id texto [pk, note: "Tipo CHAR(3). Ej: RMA, BAR"]
            nombreLargo texto [not null, note: "Tipo VARCHAR(100)"]
        }

        Table JUGADOR {
            id numero [pk, increment, note: "Entero autoincremental"]
            nombre texto [not null, note: "Tipo VARCHAR(100)"]
            
            // FK
            equipoId texto [not null, note: "FK hacia EQUIPO. Tipo CHAR(3)"]
        }

        Table ARBITRO {
            id numero [pk, increment, note: "Entero autoincremental"]
            nombre texto [not null, note: "Tipo VARCHAR(50)"]
            nivel texto [note: "Tipo ENUM. Valores: 'FIFA', 'NACIONAL', 'REGIONAL'"]
            
            // Relación Reflexiva
            arbitroMentorId numero [null, note: "FK reflexiva hacia ARBITRO. Entero."]
        }

        Table PARTIDO {
            id numero [pk, increment, note: "Entero autoincremental"]
            fecha fecha [not null, note: "Tipo DATETIME"]
            jornada numero [not null, note: "Entero"]
            
            // Roles
            equipoLocalId texto [not null, note: "FK hacia EQUIPO. Tipo CHAR(3)"]
            equipoVisitanteId texto [not null, note: "FK hacia EQUIPO. Tipo CHAR(3)"]
            arbitroId numero [not null, note: "FK hacia ARBITRO. Entero"]
        }

        Table INCIDENCIA {
            // Tabla intermedia
            partidoId numero [pk, note: "Parte de PK. Entero"]
            jugadorId numero [pk, note: "Parte de PK. Entero"]
            minuto numero [pk, note: "Parte de PK. Entero"]
            tipo texto [not null, note: "Tipo VARCHAR(20). Ej: 'GOL'"]
        }

        // Relaciones
        Ref: EQUIPO.id < JUGADOR.equipoId
        Ref: ARBITRO.id - ARBITRO.arbitroMentorId
        Ref: EQUIPO.id < PARTIDO.equipoLocalId
        Ref: EQUIPO.id < PARTIDO.equipoVisitanteId
        Ref: ARBITRO.id < PARTIDO.arbitroId

        Ref: PARTIDO.id < INCIDENCIA.partidoId
        Ref: JUGADOR.id < INCIDENCIA.jugadorId
        ```

    - Diagrama módelo lógico
        
        ![](img/AC315.png"")    

    </div>

    **Parte 2: Tareas de Implementación (DDL)**

    Crea un **único script SQL** para MySQL que realice secuencialmente los siguientes pasos.

    *A. Creación de Tablas (CREATE)*

    1.  Crea la BD `RESULTADOS_FUTBOL`.
    2.  Crea las tablas **`EQUIPO`** y **`JUGADOR`** respetando los tipos indicados en las notas. En `JUGADOR`, define la FK `fk_jugador_equipo` dentro del `CREATE`.
    3.  Crea la tabla **`ARBITRO`**.
        *   Define la columna `arbitroMentorId` (nullable).
        *   Define la **FK Reflexiva** llamada `fk_arbitro_mentor`.
    4.  Crea la tabla **`PARTIDO`**.
        *   Presta atención a las columnas `equipoLocalId` y `equipoVisitanteId` (ambas son `CHAR(3)`).
        *   Define las restricciones `fk_partido_local`, `fk_partido_visitante` y `fk_partido_arbitro`.

    *B. Modificaciones (ALTER)*

    5.  **Tabla Intermedia:** Crea la tabla **`INCIDENCIA`** con su PK compuesta (`partidoId`, `jugadorId`, `minuto`). **NO añadas las FKs todavía**.
    6.  **Añadir FKs:** Usa `ALTER TABLE` para añadir las FKs a `INCIDENCIA` con los nombres:
        *   `fk_incidencia_partido`
        *   `fk_incidencia_jugador`
    7.  **Añadir Columna:** Se ha decidido registrar el tiempo añadido. Añade la columna `tiempoExtra` (`INT`, por defecto `0`) a la tabla `PARTIDO`.
    8.  **Modificar Columna:** El campo `tipo` de la tabla `INCIDENCIA` se definió como `VARCHAR`. Modifícalo para que sea un `ENUM` con los valores: `'GOL'`, `'AMARILLA'`, `'ROJA'`, `'LESION'`.
    9.  **Añadir Validación:** Añade una restricción CHECK llamada `chk_jornada_valida` en `PARTIDO` para asegurar que la jornada está entre 1 y 38.
    10. **Eliminar Restricción:** La federación elimina el sistema de mentores. Borra la restricción FK `fk_arbitro_mentor` de la tabla `ARBITRO`.


