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