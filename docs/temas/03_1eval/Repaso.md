# **Resumen de Estudio: 1 Evaluación**

## 📚 Diseño Conceptual, Modelo E/R, Modelo Lógico.

## 1. El Proceso de Diseño de Bases de Datos
Antes de escribir código, debemos diseñar. El proceso se divide en tres fases secuenciales:

1.  **Diseño Conceptual:** Analizamos el mundo real (requisitos) y creamos un esquema independiente de la tecnología (Diagrama **Entidad-Relación**).
2.  **Diseño Lógico:** Transformamos el esquema conceptual a un modelo soportado por bases de datos (Modelo **Relacional** / Tablas).
3.  **Diseño Físico:** Implementamos el diseño lógico en un SGBD concreto (MySQL, Oracle) usando SQL y configuraciones físicas.

**Objetivos del diseño:** Coherencia, rendimiento, seguridad, escalabilidad y facilidad de mantenimiento.

---

## 2. Elementos del Modelo Entidad-Relación (ER)
El modelo describe el mundo mediante tres constructores básicos:

### A. Entidades (Rectángulos)
Objetos (reales o abstractos) sobre los que guardamos información (Ej: `ALUMNO`, `COCHE`).
*   **Fuertes:** Tienen existencia propia.
*   **Débiles:** Dependen de otra entidad para existir o identificarse.
    *   *Dependencia de Existencia:* Si se borra la fuerte, desaparece la débil.
    *   *Dependencia de Identificación:* Necesitan la clave de la fuerte para identificarse (llevan marcas "ID" o doble rombo).

### B. Relaciones (Rombos)
Asociaciones entre entidades, descritas generalmente por **verbos** (Ej: `COMPRAR`, `ESTUDIAR`).
*   **Grado:** Binarias (2 entidades), Ternarias (3 entidades), Reflexivas (la misma entidad se relaciona consigo misma).

### C. Atributos (Elipses)
Propiedades que describen a las entidades o relaciones.
*   **Identificador (Clave):** Único, no nulo y estable (subrayado).
*   **Compuesto:** Se divide en sub-partes (Dirección -> calle, número).
*   **Multivaluado:** Puede tener varios valores para la misma entidad (Teléfonos). Se representa con doble óvalo.
*   **Derivado:** Se calcula a partir de otros datos (Edad a partir de Fecha Nacimiento). Se representa con línea punteada.

---

## 3. Cardinalidades
Definen la participación de las entidades en una relación. Se expresan como **(Mínima, Máxima)**.

*   **Cardinalidad Mínima (Participación):**
    *   **0:** Opcional (puede no relacionarse).
    *   **1:** Obligatoria (debe relacionarse al menos una vez).
*   **Cardinalidad Máxima:**
    *   **1:** Solo se relaciona con una ocurrencia.
    *   **N:** Se relaciona con muchas ocurrencias.

### Tipos de Relaciones (según cardinalidad máxima):
1.  **1:1 (Uno a Uno):** Un empleado dirige un departamento (y viceversa).
2.  **1:N (Uno a Muchos):** Un cliente realiza muchos pedidos, pero un pedido es de un solo cliente.
3.  **N:M (Muchos a Muchos):** Un alumno estudia varias asignaturas y una asignatura tiene varios alumnos.

> **💡 Regla de lectura:** Para saber la cardinalidad de una entidad A en una relación con B, pregúntate: *"¿Una ocurrencia de A con cuántas de B se relaciona?"* (El resultado se anota en el lado opuesto o junto a la entidad, según la notación).

---

## 4. El Modelo Extendido (EER)
Se usa para situaciones más complejas que el modelo básico no cubre.

### A. Generalización y Especialización (Relaciones IS-A / Es-Un)
Jerarquías de herencia (Padre/Hijo). Los hijos heredan atributos y relaciones del padre.
*   **Restricción de Disyunción:**
    *   **Disjunta (d):** El padre solo puede ser uno de los hijos (o A o B).
    *   **Solapada (o):** El padre puede ser varios hijos a la vez (A y B).
*   **Restricción de Totalidad:**
    *   **Total (Doble línea):** Todo padre *debe* ser al menos un tipo de hijo.
    *   **Parcial (Línea simple):** Un padre puede no ser ninguno de los hijos definidos.

### B. Agregación (Entidad Asociativa)
Cuando necesitamos tratar una **relación** (y las entidades que la forman) como si fuera una nueva **entidad** para relacionarla con otra cosa.
*   *Ejemplo:* `DOCENTE` imparte clase en `AULA`. Esa relación crea una "Sesión" o "Clase". Ahora queremos registrar `INCIDENCIAS` sobre esa "Sesión". Convertimos la relación en una agregación.

!!! tip "Puntos importantes"

    1.  Recuerda que los atributos propios de una relación **N:M** (como "fecha" o "nota") no pertenecen a ninguna de las dos entidades por separado, sino a la relación.
    2.  Diferencia bien entre **Entidad Débil** (doble rectángulo) y **Atributo Multivaluado** (doble óvalo).
    3.  En la notación "Pata de Gallo": El tridente significa "Muchos", el círculo "Cero" y la barra vertical "Uno".
    4.  La **pérdida expresiva** ocurre cuando hay reglas del negocio que no podemos dibujar en el diagrama y debemos escribirlas como notas al pie.


## 📚 Diseño Lógico y Transformación al Modelo Relacional

## 1. El Modelo Relacional: Conceptos Básicos
El modelo relacional, propuesto por **Codd** a finales de los 60, es la base de las bases de datos modernas. Su objetivo es mantener la independencia de los datos (lógica y física) y garantizar la integridad.

### Elementos Estructurales
*   **Relación (Tabla):** Estructura principal compuesta por filas y columnas. El orden de las filas y columnas es **irrelevante**.
*   **Tupla (Fila):** Representa un registro único (ej. un alumno concreto).
*   **Atributo (Columna):** Representa una propiedad (ej. el nombre).
*   **Dominio:** Conjunto de valores válidos y del mismo tipo (ej. enteros, fechas) que puede tomar un atributo.

### Restricciones
*   **Clave Primaria (PK):** Identifica univocamente a una fila.
    *   *Integridad de Entidad:* **Nunca** puede ser NULL y debe ser única.
    *   Puede ser **subrogada** (artificial, ej: ID autonumérico) o natural.
*   **Clave Ajena / Foránea (FK):** Columna que apunta a la PK de otra tabla (o de la misma) para relacionarlas.
    *   *Integridad Referencial:* El valor de la FK debe existir en la tabla padre o ser NULL.
    *   *Borrado:* Si borramos al padre, la FK puede configurarse para **Propagar** (borrar hijos), **Anular** (poner NULL) o **Rechazar** (impedir borrado).
*   **Unicidad (UK):** Evita duplicados en columnas que no son PK (ej. email). Permite nulos (según el SGBD).
*   **Valor NULL:** Representa ausencia de información, desconocido o no aplicable.

## 2. Transformación: Del Dibujo (ER) a las Tablas (Relacional)

Es el paso crucial del diseño conceptual al lógico. Aquí están las reglas de oro:

### A. Entidades y Atributos

*   **Entidad → Tabla.**
*   **Atributo → Columna.**
*   **Atributo Multivaluado →** Se crea una **Tabla Nueva** (con la FK de la entidad original + el valor).
*   **Atributo Compuesto →** Se desglosa en columnas simples en la misma tabla.

### B. Relaciones Binarias

1.  **Relación 1:N (Uno a Muchos):**
    *   **Regla:** La PK del lado "1" viaja como FK a la tabla del lado "N".
    *   *Ejemplo:* Un Cliente (1) tiene muchos Pedidos (N) -> El `id_cliente` se pone en la tabla `Pedidos`.
    *   Si la cardinalidad mínima es 0, la FK admite NULL; si es 1, es NOT NULL.

2.  **Relación N:M (Muchos a Muchos):**
    *   **Regla:** Se crea **SIEMPRE una Tabla Nueva** (Intermedia).
    *   Esta tabla contiene las FK de ambas entidades.
    *   Si la relación tenía atributos (ej. `fecha_compra`), van a esta tabla nueva.

3.  **Relación 1:1 (Uno a Uno):**
    *   **Regla:** Se propaga la PK de un lado al otro como FK + restricción **UNIQUE**.
    *   *Consejo:* Poner la FK en la tabla que "tiene la obligación" (participación total) para evitar Nulos.

### C. Casos Especiales

*   **Reflexiva (Recursiva):**
    *   *Si es 1:N (Jefe-Empleado):* FK en la misma tabla apuntando a sí misma.
    *   *Si es N:M (Pieza-Componente):* Tabla nueva con dos FK apuntando a la tabla original.

*   **Entidad Débil (por identificación):**
    *   Su PK es **Compuesta**: Incluye su identificador propio + la FK de la entidad fuerte.

*   **Jerarquías (Herencia ISA):**
    1.  *Una tabla (Superclase):* Todo junto. Muchos nulos, pero rápido.
    2.  *Tablas por subclase:* Se repiten datos comunes. No hay tabla padre.
    3.  *Tabla por entidad:* Una tabla padre y tablas hijas con PK=FK. Es la más "pura".

### 4. Diccionario de Datos

No olvides que el esquema relacional no son solo las tablas. El **Diccionario de Datos** es el documento (metadatos) que describe:
*   Nombres de tablas y columnas.
*   Tipos de datos.
*   Definición de claves (PK, FK) y restricciones.
*   Descripción lógica del contenido.

Aquí tienes un **Resumen de Estudio** detallado y estructurado, diseñado específicamente para alumnos. Se ha puesto especial énfasis en la sintaxis DDL y los tipos de datos, ya que son los puntos más críticos y complejos de cara a un examen o práctica.

---

## 📚 Diseño Físico: Lenguaje DDL (SQL)

### 1. Contexto: Del Diseño Lógico al Físico

Hemos pasado por el **Diseño Conceptual** (Entidades/Relaciones) y el **Diseño Lógico** (Tablas genéricas). Ahora entramos en el **Diseño Físico**: la implementación real en un SGBD concreto (en nuestro caso, **MySQL**).

*   **Objetivo:** Traducir el esquema lógico a código SQL ejecutable.
*   **Herramienta:** El lenguaje **SQL** (Structured Query Language).

#### Sublenguajes de SQL

Aunque SQL es uno solo, se divide en categorías según su función. Para este tema, nos centramos en el primero:
1.  **DDL (Data Definition Language):** Definir estructura (`CREATE`, `ALTER`, `DROP`).
2.  **DML:** Manipular datos (`INSERT`, `UPDATE`, `DELETE`).
3.  **DQL:** Consultar datos (`SELECT`).
4.  **DCL:** Control de acceso (`GRANT`, `REVOKE`).

---

### 2. Tipos de Datos (Data Types)

Elegir el tipo correcto es vital para la optimización y la integridad.

#### 🔤 Texto
*   **`CHAR(n)`:** Longitud **fija**. Si guardas "Hola" en un `CHAR(10)`, rellena con espacios. *Úsalo para códigos fijos (ej: DNI, CP).*
*   **`VARCHAR(n)`:** Longitud **variable**. Solo ocupa lo que escribas + un extra para la longitud. *El estándar para nombres, emails, direcciones.*
*   **`TEXT`:** Para textos largos sin límite predefinido corto. *Tiene limitaciones de rendimiento al ordenar/indexar.*

#### 🔢 Números
*   **Enteros:** `TINYINT`, `SMALLINT`, `INT`, `BIGINT`.
    *   *Modificador `UNSIGNED`:* Solo permite positivos, duplicando el rango máximo.
*   **Decimales Exactos:**
    *   **`DECIMAL(M, D)`:** Exactitud total. `DECIMAL(10,2)` significa 10 dígitos totales, 2 de ellos decimales. *Obligatorio para dinero.*
*   **Decimales Aproximados:**
    *   **`FLOAT` / `DOUBLE`:** Para cálculos científicos. *No usar para dinero por errores de redondeo.*

#### 📅 Fecha y Hora
*   **`DATE`:** Solo fecha (YYYY-MM-DD).
*   **`TIME`:** Solo hora (HH:MM:SS).
*   **`DATETIME`:** Fecha y hora. Rango amplio.
*   **`TIMESTAMP`:** Fecha y hora. Rango limitado (hasta 2038). **Ventaja:** Se guarda en UTC y se adapta a la zona horaria; puede actualizarse solo al modificar la fila.

#### 🛠 Otros
*   **`ENUM`:** Lista cerrada de valores (ej: 'S', 'M', 'L', 'XL'). Internamente son números (1, 2...).
*   **`BLOB`:** Binarios grandes (imágenes, archivos).
*   **`BOOLEAN`:** En MySQL es un alias de `TINYINT(1)`.

---

### 3. Sintaxis DDL: Creación de Estructuras

> **⚠️ Nota sobre Mayúsculas/Minúsculas:**
> En Windows, los nombres de tablas suelen ser insensibles a mayúsculas. En **Linux**, son **sensibles**. *Recomendación: Usar siempre minúsculas para tablas y columnas.*

#### 🏛️ Bases de Datos
```sql
-- Crear si no existe
CREATE DATABASE IF NOT EXISTS tienda CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

-- Seleccionar para usar
USE tienda;

-- Borrar
DROP DATABASE IF EXISTS tienda;
```
*   **Motores:** `InnoDB` (Soporta transacciones y FK, el estándar moderno) vs `MyISAM` (Antiguo, rápido en lectura, sin integridad referencial).
*   **Charset:** Usar `utf8mb4` para soporte completo Unicode (emojis incluidos).

#### 🏗️ Tablas (`CREATE TABLE`)
Es la instrucción más compleja. Estructura general:

```sql
CREATE TABLE nombre_tabla (
    nombre_columna tipo_dato [restricciones_columna],
    nombre_columna2 tipo_dato [restricciones_columna],
    ...
    [restricciones_tabla]
) ENGINE=InnoDB;
```

*Modificadores de Columna*
*   **`NOT NULL`**: Obliga a tener un valor.
*   **`DEFAULT valor`**: Si no insertas nada, usa este valor.
*   **`AUTO_INCREMENT`**: Genera una secuencia (1, 2, 3...) automática. *Solo para claves primarias enteras.*

---

### 4. Restricciones (Constraints)
Las reglas que protegen la integridad de los datos. Se recomienda ponerles nombre (`CONSTRAINT nombre ...`).

#### 🔑 Primary Key (PK)
Identificador único de la fila.
*   Implica `UNIQUE` + `NOT NULL`.
*   Puede ser compuesta (varias columnas).

```sql
-- En la misma línea (simple)
id INT PRIMARY KEY AUTO_INCREMENT

-- Al final (recomendado o para compuestas)
CONSTRAINT pk_empleado PRIMARY KEY (id_empleado)
CONSTRAINT pk_detalle PRIMARY KEY (id_pedido, id_producto)
```

#### 🔗 Foreign Key (FK) - Integridad Referencial
Vincula una columna con la PK de otra tabla.
*   Garantiza que no apuntes a algo que no existe.

```sql
CONSTRAINT fk_pedido_cliente FOREIGN KEY (id_cliente)
    REFERENCES clientes(id)
    ON DELETE [ACCIÓN] ON UPDATE [ACCIÓN]
```

**Acciones ante borrado del padre (`ON DELETE`):**
1.  **`CASCADE`:** Borra también a los hijos (útil en detalles de pedido).
2.  **`SET NULL`:** Los hijos se quedan con valor NULL (útil si se va el empleado, pero el pedido queda).
3.  **`RESTRICT` / `NO ACTION`:** Impide borrar al padre si tiene hijos (seguridad por defecto).

#### 🛡️ Otras Restricciones
*   **`UNIQUE`:** Valores no repetidos. *Diferencia con PK: Permite valores NULL.*
*   **`CHECK`:** Validaciones lógicas.
    *   `CHECK (edad BETWEEN 18 AND 65)`
    *   `CHECK (genero IN ('M', 'F'))`
    *   *Ojo:* Si añades un CHECK a una tabla con datos, MySQL no valida los antiguos, solo los nuevos.

---

### 5. Modificación de Tablas (`ALTER TABLE`)
Usamos `ALTER` cuando la tabla ya existe y queremos cambiar su estructura.

| Acción | Sintaxis | Descripción |
| :--- | :--- | :--- |
| **Añadir columna** | `ADD COLUMN email VARCHAR(50)` | Agrega un campo nuevo. |
| **Borrar columna** | `DROP COLUMN email` | Elimina campo y sus datos (¡Peligro!). |
| **Modificar tipo** | `MODIFY COLUMN email TEXT` | Cambia el tipo o propiedades. |
| **Renombrar/Cambiar**| `CHANGE email nuevo_email VARCHAR(50)` | Renombra Y cambia el tipo a la vez. |
| **Añadir Constraint**| `ADD CONSTRAINT uk_email UNIQUE(email)` | Añade reglas (PK, FK, Check...). |
| **Borrar Constraint**| `DROP CONSTRAINT nombre_constraint` | Elimina la regla. |
| **Renombrar Tabla** | `RENAME TO nueva_tabla` | Cambia el nombre de la tabla entera. |

---

### 6. Otros conceptos importantes

### 🗑️ Borrado (`DROP`)
*   `DROP TABLE empleados;` -> Elimina estructura y datos. Irreversible.
*   Orden de borrado: Primero las tablas hijas (las que tienen la FK), luego las padres.

### 👁️ Vistas (`CREATE VIEW`)
*   Tablas virtuales basadas en una consulta `SELECT`.
*   No almacenan datos físicos, solo la definición.
*   Útiles para simplificar consultas complejas o por seguridad (ocultar columnas).

### 📜 Diccionario de Datos
*   Es donde el SGBD guarda la información sobre la estructura (metadatos).
*   Comando útil: `SHOW CREATE TABLE nombre_tabla;` (te da el código exacto para recrear la tabla).