# **Resumen de Estudio: 1 Evaluación**

## **📚 Diseño Físico: Lenguaje DDL (SQL)**

### **1. Contexto: Del Diseño Lógico al Físico**

Hemos pasado por el **Diseño Conceptual** (Entidades/Relaciones) y el **Diseño Lógico** (Tablas genéricas). Ahora entramos en el **Diseño Físico**: la implementación real en un SGBD concreto (en nuestro caso, **MySQL**).

*   **Objetivo:** Traducir el esquema lógico a código SQL ejecutable.
*   **Herramienta:** El lenguaje **SQL** (Structured Query Language).

#### **Sublenguajes de SQL**

Aunque SQL es uno solo, se divide en categorías según su función. Para este tema, nos centramos en el primero:

1.  **DDL (Data Definition Language):** Definir estructura (`CREATE`, `ALTER`, `DROP`).
2.  **DML:** Manipular datos (`INSERT`, `UPDATE`, `DELETE`).
3.  **DQL:** Consultar datos (`SELECT`).
4.  **DCL:** Control de acceso (`GRANT`, `REVOKE`).

---

### **2. Tipos de Datos (Data Types)**

Elegir el tipo correcto es vital para la optimización y la integridad.

#### 🔤 Texto

*   **`CHAR(n)`:** Longitud **fija**. Si guardas "Hola" en un `CHAR(10)`, rellena con espacios. *Úsalo para códigos fijos (ej: DNI, CP)*.
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

### **3. Sintaxis DDL: Creación de Estructuras**

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

!!! tip "Motores (engine) en MySQL"

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

### 5. Tabla Resumen DDL

**Intrucción CREATE (Creación)**

Se utiliza para definir nuevos objetos. Lo más importante es saber definir los tipos de datos y, sobre todo, las restricciones con nombre personalizado.

| Acción | Sintaxis / Descripción | Ejemplo Práctico |
| :--- | :--- | :--- |
| **Crear Base de Datos** | `CREATE DATABASE [IF NOT EXISTS] nombre;` | `CREATE DATABASE TIENDA_DB;` |
| **Crear Tabla Básica** | `CREATE TABLE nombre_tabla (columnas...);` | `CREATE TABLE PRODUCTO (id INT, nombre VARCHAR(50));` |
| **PK (Simple)** | Definir clave primaria al crear la columna o al final. | `id INT AUTO_INCREMENT PRIMARY KEY` |
| **PK (Compuesta)** | Obligatorio definirla al final de la tabla. | `PRIMARY KEY (pedido_id, producto_id)` |
| **Restricciones de Columna** | Reglas directas: `NOT NULL`, `DEFAULT`, `UNIQUE`. | `precio DECIMAL(10,2) NOT NULL DEFAULT 0` |
| **Constraint: UNIQUE** | Crear restricción de unicidad con **nombre**. | `CONSTRAINT uk_usuario_email UNIQUE (email)` |
| **Constraint: CHECK** | Validar condiciones lógicas (MySQL 8.0+). | `CONSTRAINT chk_edad_minima CHECK (edad >= 18)` |
| **Constraint: FK (Básica)** | Clave Foránea apuntando a otra tabla. | `CONSTRAINT fk_prod_cat FOREIGN KEY (cat_id) REFERENCES CATEGORIA(id)` |
| **Constraint: FK (Avanzada)** | FK con reglas de borrado/actualización (`CASCADE`, `SET NULL`, `RESTRICT`). | `CONSTRAINT fk_hijo_padre FOREIGN KEY (padre_id) REFERENCES PADRE(id) ON DELETE CASCADE ON UPDATE CASCADE` |

**Ejemplo completo `CREATE`:**
```sql
CREATE TABLE USUARIO (
    id INT AUTO_INCREMENT,
    nick VARCHAR(20) NOT NULL,
    edad INT,
    grupo_id INT,
    PRIMARY KEY (id),
    CONSTRAINT uk_usuario_nick UNIQUE (nick),
    CONSTRAINT chk_mayor_edad CHECK (edad >= 18),
    CONSTRAINT fk_usuario_grupo FOREIGN KEY (grupo_id) 
        REFERENCES GRUPO(id) ON DELETE SET NULL
);
```

---
**Intrucción ALTER (Modificación)**

Se usa cuando la tabla ya existe y necesitamos cambiar su estructura. Es vital distinguir entre columnas y constraints.

| Acción | Sintaxis / Descripción | Ejemplo Práctico |
| :--- | :--- | :--- |
| **Añadir Columna** | `ADD COLUMN nombre tipo [atributos];` | `ALTER TABLE USUARIO ADD COLUMN email VARCHAR(100) UNIQUE;` |
| **Modificar Columna** | `MODIFY COLUMN nombre nuevo_tipo [atributos];` <br>*(Cambia tipo, longitud o nulidad)* | `ALTER TABLE USUARIO MODIFY COLUMN nick VARCHAR(50) NOT NULL;` |
| **Renombrar Columna** | `CHANGE COLUMN viejo nuevo nuevo_tipo;` | `ALTER TABLE USUARIO CHANGE COLUMN nick apodo VARCHAR(50);` |
| **Renombrar/Cambiar**| `CHANGE email nuevo_email VARCHAR(50)` | Renombra Y cambia el tipo a la vez. | |
| **Renombrar Tabla** | `RENAME TO nueva_tabla` | Cambia el nombre de la tabla entera. |
| **Modificar tipo columna** | `MODIFY COLUMN email TEXT` | Cambia el tipo o propiedades. | |
| **Eliminar Columna** | `DROP COLUMN nombre;` | `ALTER TABLE USUARIO DROP COLUMN edad;` | |
| **Añadir PK** | Si la tabla no tenía PK. | `ALTER TABLE TABLA ADD PRIMARY KEY (id);` |
| **Añadir FK** | Agregar relación a tabla existente. | `ALTER TABLE USUARIO ADD CONSTRAINT fk_user_pais FOREIGN KEY (pais_id) REFERENCES PAIS(id);` |
| **Añadir Constraint**| `ADD CONSTRAINT uk_email UNIQUE(email)` | Añade reglas (PK, FK, Check...). | |
| **Borrar Constraint**| `DROP CONSTRAINT nombre_constraint` | Elimina la regla. | | 
| **Añadir UNIQUE** | Agregar restricción de unicidad. | `ALTER TABLE USUARIO ADD CONSTRAINT uk_email UNIQUE (email);` |
| **Eliminar FK** | Se usa `DROP FOREIGN KEY` + nombre del constraint. | `ALTER TABLE USUARIO DROP FOREIGN KEY fk_user_pais;` |
| **Eliminar UNIQUE/Index** | Se usa `DROP INDEX` + nombre del constraint. | `ALTER TABLE USUARIO DROP INDEX uk_email;` |
| **Eliminar CHECK** | Se usa `DROP CHECK` (MySQL 8.0+). | `ALTER TABLE USUARIO DROP CHECK chk_mayor_edad;` |

---

**Intrucción DROP (Eliminación)**

Cuidado: estas acciones son destructivas y borran tanto la estructura como los datos.

| Acción | Sintaxis / Descripción | Ejemplo Práctico |
| :--- | :--- | :--- |
| **Eliminar Base de Datos** | Borra la BD completa. | `DROP DATABASE IF EXISTS TIENDA_DB;` |
| **Eliminar Tabla** | Borra la tabla y sus datos. | `DROP TABLE IF EXISTS USUARIO;` |
| **Eliminar varias Tablas** | Borra múltiples tablas a la vez (útil por dependencias). | `DROP TABLE TABLA_HIJA, TABLA_PADRE;` |
| **Truncar Tabla** | **NO** es DROP, pero vacía datos manteniendo estructura. | `TRUNCATE TABLE USUARIO;` |

---

### 6. Otros conceptos importantes

#### 👁️ Vistas (`CREATE VIEW`)
*   Tablas virtuales basadas en una consulta `SELECT`.
*   No almacenan datos físicos, solo la definición.
*   Útiles para simplificar consultas complejas o por seguridad (ocultar columnas).

#### 📜 Diccionario de Datos
*   Es donde el SGBD guarda la información sobre la estructura (metadatos).
*   Comando útil: `SHOW CREATE TABLE nombre_tabla;` (te da el código exacto para recrear la tabla).