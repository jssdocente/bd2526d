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



