# **Resumen de Estudio: 1 Evaluación**

## **📚 Diseño Conceptual, Modelo E/R, Modelo Lógico.**

### 1. El Proceso de Diseño de Bases de Datos
Antes de escribir código, debemos diseñar. El proceso se divide en tres fases secuenciales:

1.  **Diseño Conceptual:** Analizamos el mundo real (requisitos) y creamos un esquema independiente de la tecnología (Diagrama **Entidad-Relación**).
2.  **Diseño Lógico:** Transformamos el esquema conceptual a un modelo soportado por bases de datos (Modelo **Relacional** / Tablas).
3.  **Diseño Físico:** Implementamos el diseño lógico en un SGBD concreto (MySQL, Oracle) usando SQL y configuraciones físicas.

**Objetivos del diseño:** Coherencia, rendimiento, seguridad, escalabilidad y facilidad de mantenimiento.

---

### 2. Elementos del Modelo Entidad-Relación (ER)

El modelo describe el mundo mediante tres constructores básicos:

#### A. Entidades (Rectángulos)

Objetos (reales o abstractos) sobre los que guardamos información (Ej: `ALUMNO`, `COCHE`).

*   **Fuertes:** Tienen existencia propia.
*   **Débiles:** Dependen de otra entidad para existir o identificarse.
    *   *Dependencia de Existencia:* Si se borra la fuerte, desaparece la débil.
    *   *Dependencia de Identificación:* Necesitan la clave de la fuerte para identificarse (llevan marcas "ID" o doble rombo).

#### B. Relaciones (Rombos)

Asociaciones entre entidades, descritas generalmente por **verbos** (Ej: `COMPRAR`, `ESTUDIAR`).

*   **Grado:** Binarias (2 entidades), Ternarias (3 entidades), Reflexivas (la misma entidad se relaciona consigo misma).

#### C. Atributos (Elipses)

Propiedades que describen a las entidades o relaciones.

*   **Identificador (Clave):** Único, no nulo y estable (subrayado).
*   **Compuesto:** Se divide en sub-partes (Dirección -> calle, número).
*   **Multivaluado:** Puede tener varios valores para la misma entidad (Teléfonos). Se representa con doble óvalo.
*   **Derivado:** Se calcula a partir de otros datos (Edad a partir de Fecha Nacimiento). Se representa con línea punteada.

---

### 3. Cardinalidades

Definen la participación de las entidades en una relación. Se expresan como **(Mínima, Máxima)**.

*   **Cardinalidad Mínima (Participación):**
    *   **0:** Opcional (puede no relacionarse).
    *   **1:** Obligatoria (debe relacionarse al menos una vez).
*   **Cardinalidad Máxima:**
    *   **1:** Solo se relaciona con una ocurrencia.
    *   **N:** Se relaciona con muchas ocurrencias.

#### Tipos de Relaciones (según cardinalidad máxima):

1.  **1:1 (Uno a Uno):** Un empleado dirige un departamento (y viceversa).
2.  **1:N (Uno a Muchos):** Un cliente realiza muchos pedidos, pero un pedido es de un solo cliente.
3.  **N:M (Muchos a Muchos):** Un alumno estudia varias asignaturas y una asignatura tiene varios alumnos.

> **💡 Regla de lectura:** Para saber la cardinalidad de una entidad A en una relación con B, pregúntate: *"¿Una ocurrencia de A con cuántas de B se relaciona?"* (El resultado se anota en el lado opuesto o junto a la entidad, según la notación).

---

### 4. El Modelo Extendido (EER)

Se usa para situaciones más complejas que el modelo básico no cubre.

#### A. Generalización y Especialización (Relaciones IS-A / Es-Un)

Jerarquías de herencia (Padre/Hijo). Los hijos heredan atributos y relaciones del padre.

*   **Restricción de Disyunción:**
    *   **Disjunta (d):** El padre solo puede ser uno de los hijos (o A o B).
    *   **Solapada (o):** El padre puede ser varios hijos a la vez (A y B).
*   **Restricción de Totalidad:**
    *   **Total (Doble línea):** Todo padre *debe* ser al menos un tipo de hijo.
    *   **Parcial (Línea simple):** Un padre puede no ser ninguno de los hijos definidos.

#### B. Agregación (Entidad Asociativa)

Cuando necesitamos tratar una **relación** (y las entidades que la forman) como si fuera una nueva **entidad** para relacionarla con otra cosa.

*   *Ejemplo:* `DOCENTE` imparte clase en `AULA`. Esa relación crea una "Sesión" o "Clase". Ahora queremos registrar `INCIDENCIAS` sobre esa "Sesión". Convertimos la relación en una agregación.

!!! tip "Puntos importantes"

    1.  Recuerda que los atributos propios de una relación **N:M** (como "fecha" o "nota") no pertenecen a ninguna de las dos entidades por separado, sino a la relación.
    2.  Diferencia bien entre **Entidad Débil** (doble rectángulo) y **Atributo Multivaluado** (doble óvalo).
    3.  En la notación "Pata de Gallo": El tridente significa "Muchos", el círculo "Cero" y la barra vertical "Uno".
    4.  La **pérdida expresiva** ocurre cuando hay reglas del negocio que no podemos dibujar en el diagrama y debemos escribirlas como notas al pie.


## **📚 Diseño Lógico y Transformación al Modelo Relacional**

### **1. El Modelo Relacional: Conceptos Básicos**

El modelo relacional, propuesto por **Codd** a finales de los 60, es la base de las bases de datos modernas. Su objetivo es mantener la independencia de los datos (lógica y física) y garantizar la integridad.

#### Elementos Estructurales

*   **Relación (Tabla):** Estructura principal compuesta por filas y columnas. El orden de las filas y columnas es **irrelevante**.
*   **Tupla (Fila):** Representa un registro único (ej. un alumno concreto).
*   **Atributo (Columna):** Representa una propiedad (ej. el nombre).
*   **Dominio:** Conjunto de valores válidos y del mismo tipo (ej. enteros, fechas) que puede tomar un atributo.

#### Restricciones

*   **Clave Primaria (PK):** Identifica univocamente a una fila.
    *   *Integridad de Entidad:* **Nunca** puede ser NULL y debe ser única.
    *   Puede ser **subrogada** (artificial, ej: ID autonumérico) o natural.
*   **Clave Ajena / Foránea (FK):** Columna que apunta a la PK de otra tabla (o de la misma) para relacionarlas.
    *   *Integridad Referencial:* El valor de la FK debe existir en la tabla padre o ser NULL.
    *   *Borrado:* Si borramos al padre, la FK puede configurarse para **Propagar** (borrar hijos), **Anular** (poner NULL) o **Rechazar** (impedir borrado).
*   **Unicidad (UK):** Evita duplicados en columnas que no son PK (ej. email). Permite nulos (según el SGBD).
*   **Valor NULL:** Representa ausencia de información, desconocido o no aplicable.

### **2. Transformación: Del Dibujo (ER) a las Tablas (Relacional)**

 > **Transformación General**

| Elemento Modelo ER | Transformación a Modelo Relacional (Tablas) | Tratamiento de Claves y Cardinalidad (Reglas) |
| :--- | :--- | :--- |
| **Entidad Fuerte** | Cada entidad se convierte en una tabla. | La clave primaria (PK) de la tabla es el identificador de la entidad. Los demás atributos son columnas. |
| **Entidad Débil** | Cada entidad débil se convierte en una tabla. | La PK de la tabla es compuesta: la PK de la entidad fuerte propietaria (como FK) + el discriminante de la entidad débil. |
| **Relación 1 a 1 (1:1)** | Se añade una clave foránea (FK) en una de las dos tablas. | • La columna FK debe tener **siempre** una restricción **UNIQUE**.<br>• **Regla de Ubicación (para evitar NULLs):** Si la cardinalidad es `(1,1)` en un lado y `(0,1)` en el otro, la FK **siempre se coloca en la tabla del lado `(0,1)`**. De este modo, la FK puede ser declarada como **NOT NULL**.<br>• Si la cardinalidad es `(0,1)` en ambos lados, la FK puede ir en cualquiera de las dos tablas y **debe admitir NULL**.|
| **Relación 1 a Muchos (1:N)** | No se crea una tabla nueva para la relación. | La PK de la entidad del lado "1" migra a la tabla de la entidad del lado "N" como una FK. Si la participación mínima del lado "1" es 0, la FK admite **NULL**. Si es 1, es **NOT NULL**. |
| **Relación Muchos a Muchos (M:N)** | **Siempre** se crea una nueva tabla intermedia para la relación. | • La tabla intermedia contiene como FK las PK de las dos entidades que relaciona.<br>• **Si la relación tiene atributos propios, estos se convierten en columnas adicionales** en esta misma tabla intermedia.<br>• La PK de la nueva tabla es, por lo general, la **combinación de ambas FK** (y a veces, también de algún atributo de la relación si es necesario para garantizar la unicidad). |
| **Relación Reflexiva 1:1** | Se añade una columna en la propia tabla. | La columna es una FK que referencia a la PK de la misma tabla. Debe tener la restricción **UNIQUE** y ser **NULLABLE**. |
| **Relación Reflexiva 1:N** | Se añade una columna en la propia tabla. | La columna es una FK que referencia a la PK de la misma tabla (Ej: `id_jefe` en la tabla `EMPLEADO`). Es **NULLABLE**. |
| **Relación Reflexiva M:N** | Se crea una nueva tabla intermedia. | La tabla intermedia tiene **dos columnas FK**, ambas referenciando a la PK de la tabla original. Sus atributos (si los tiene) también van en esta tabla. |

> **Transformación de Jerarquías (Generalización / Especialización - ISA)**

| Estrategia de Transformación | Descripción de las Tablas Resultantes | Cuándo Usarla (Ventajas / Desventajas) |
| :--- | :--- | :--- |
| **1. Una Sola Tabla (Todo en la Superclase)** | Se crea **una única tabla** para la superclase que contiene todos los atributos (comunes y específicos de todas las subclases). Se añade una columna "tipo" para discriminar. | **Ventaja:** Consultas rápidas (no se necesitan JOINs).<br>**Desventaja:** Mucho espacio desperdiciado por valores **NULL** en atributos no aplicables. |
| **2. Tabla por cada Subclase (Herencia Concreta)** | Se crea **una tabla por cada subclase concreta** (hija). No hay tabla para la superclase (padre). Cada tabla hija repite los atributos comunes además de los suyos específicos. | **Ventaja:** No hay valores NULL. Consultas a una subclase son directas.<br>**Desventaja:** Los atributos comunes están duplicados. Consultar sobre *todos* los tipos requiere uniones (`UNION`). |
| **3. Tabla por cada Clase (Herencia de Tablas)** | Se crea **una tabla para la superclase** con los atributos comunes y **una tabla por cada subclase** con solo sus atributos específicos. La PK de la superclase migra como PK y FK a las tablas hijas. | **Ventaja:** Modelo más normalizado y fiel al ER. Sin redundancia ni NULLs excesivos.<br>**Desventaja:** Las consultas a menudo requieren **JOINs** entre la tabla padre y la hija, lo que puede ser más lento. |

> **Transformación de Agregaciones**

| Elemento ER | Concepto Clave | Transformación a Modelo Relacional |
| :--- | :--- | :--- |
| **Agregación** | Una agregación trata una **relación existente como si fuera una entidad abstracta** para poder participar en otra relación de nivel superior. | **Paso 1:** Se transforma la relación interna (la que es agregada) siguiendo las reglas normales (ej. si es M:N, se crea una tabla intermedia `T_Interna`).<br><br>**Paso 2:** Se transforma la relación externa (la que conecta con la agregación). Para ello, la clave primaria de la tabla `T_Interna` migra como FK a la tabla de la entidad externa (si es 1:N) o a una nueva tabla intermedia (si es M:N). |

#### 4. Diccionario de Datos

No olvides que el esquema relacional no son solo las tablas. El **Diccionario de Datos** es el documento (metadatos) que describe:

*   Nombres de tablas y columnas.
*   Tipos de datos.
*   Definición de claves (PK, FK) y restricciones.
*   Descripción lógica del contenido.

