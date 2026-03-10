# 📥 **UT6. SQL (DML). Manipulación de datos**

!!! info "Información de la unidad"

    === "Contenidos"

        Manipulación de datos:

        - Inserción de registros.
        - Modificación de registros.
        - Borrado de registros.
        - Borrado y modificación con combinaciones.
        - Transacciones.

    === "Propuesta didáctica"

          En esta unidad vamos a trabajar el RA4 "**Modifica la información almacenada en una base de datos empleando asistentes, herramientas gráficas y el lenguaje de manipulación de datos.**"

          Criterios de evaluación

        - **CE4a**: Se han identificado las sentencias para editar el contenido de la base de datos.
        - **CE4b**: Se han insertado registros en las tablas.
        - **CE4c**: Se han modificado registros de las tablas.
        - **CE4d**: Se han borrado registros de las tablas.
        - **CE4e**: Se han realizado borrados y modificaciones sobre una tabla basados en el contenido de otras tablas.
        - **CE4f**: Se han utilizado transacciones para asegurar la integridad de los datos.

!!! info "Bases de datos recursos"

    Aquí tienes los enlaces a las bases de datos de recursos para esta unidad:

    - [Sakila](../05/bd/sakila/sakila.md)
    - [Universidad](../04/res/UniversidadA.md)
    - [LigaFutbol](../04/res/liga_futbol.md)


En este tema abordaremos cómo guardar y gestionar los datos de nuestras tablas. A esto se le llama tratamiento de datos DML (Data Manipulation Language).

Sobre una tabla, podemos aplicar las operaciones CRUD (Create, Read, Update, Delete). Ya conocemos el "Read" (SELECT), ahora nos centraremos en el resto:

1. Inserción de datos (`INSERT`)
2. Modificación de datos (`UPDATE`)
3. Borrado de datos (`DELETE`)
4. Transacciones

---

Supongamos que tenemos la siguiente definición de la tabla `alumnos` que usaremos para ilustrar los ejemplos:

```sql
CREATE DATABASE IF NOT EXISTS centro_estudios;
USE centro_estudios;

CREATE TABLE alumnos (
    id INT AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL DEFAULT 'N/A',
    edad INT,
    email VARCHAR(100) UNIQUE,

    CONSTRAINT alumnos_pk PRIMARY KEY (id)
);
```

## 📥 **1.1 Insertar datos (INSERT INTO)**

La sentencia `INSERT INTO` se utiliza para insertar nuevos registros en una tabla.

### Sintaxis básica

```sql
INSERT INTO nombre_tabla (columna1, columna2, ...) VALUES (valor1, valor2, ...);
```

**Ejemplo:** insertar un alumno con todos sus datos:

```sql
INSERT INTO alumnos (id, nombre, apellido, edad) VALUES (1, 'Juan', 'Perez', 20);
```

Podemos **omitir el nombre de las columnas**, pero esto obliga a indicar todos los valores en el mismo orden en el que se definieron en el `CREATE TABLE`:

```sql
INSERT INTO alumnos VALUES (2, 'Maria', 'Gomez', 21, 'maria@email.com');
```

### Inserción parcial y valores por defecto

Si queremos insertar valores solo en algunas columnas (dejando el resto como `NULL` o con su valor por defecto):

```sql
INSERT INTO alumnos (nombre, edad) VALUES ('Pedro', 22);
```

!!! warning "Importante"
    Si intentamos omitir una columna definida como `NOT NULL` que no tiene valor por defecto, SQL devolverá un error.

### Inserción múltiple

Para insertar varios registros en una única sentencia (mucho más eficiente que varias sentencias individuales):

```sql
INSERT INTO alumnos (nombre, apellido, edad) 
VALUES ('Lucia', 'López', 19),
       ('Andrés', 'García', 23),
       ('Marta', 'Sanz', 20);
```

### Gestión de Auto-incrementos

En columnas `AUTO_INCREMENT`, el método más limpio es omitir la columna en el `INSERT`. No obstante, existen varias formas:

| Método | Ejemplo | Calificación | Razón |
| --- | --- | --- | --- |
| **Omitir Columna** | `(nombre, edad)` | ⭐⭐⭐⭐⭐ | Limpio y estándar. |
| **Pasar NULL** | `(id, nombre, ...)` | ⭐⭐⭐ | El motor genera el ID, pero ensucia la consulta. |
| **Pasar 0** | `(0, 'Juan', ...)` | ⭐⭐ | Funciona en MySQL/MariaDB pero es confuso. |

!!! tip "Obtener el ID recién insertado"
    A menudo, tras insertar un registro con un campo `AUTO_INCREMENT`, necesitamos saber qué ID se ha generado (por ejemplo, para usarlo inmediatamente en un `INSERT` en otra tabla relacionada).
    
    En MySQL/MariaDB podemos obtener este valor con la función:
    ```sql
    SELECT LAST_INSERT_ID();
    ```
    Este valor es único para la conexión actual, por lo que no hay riesgo de obtener el ID generado por otro usuario simultáneamente.

---

### 🧱 **Opciones avanzadas de inserción**

#### **A. Carga masiva desde consulta (INSERT ... SELECT)**
Permite insertar datos que provienen de otra tabla. Muy útil para históricos o copias de seguridad.

```sql
-- Creamos una tabla para alumnos becados
CREATE TABLE alumnos_becados (id INT, nombre VARCHAR(50));

-- Insertamos solo los alumnos menores de 20 años
INSERT INTO alumnos_becados (id, nombre)
SELECT id, nombre 
FROM alumnos 
WHERE edad < 20;
```

#### **B. Evitar errores con INSERT IGNORE**
Si intentamos insertar un registro que ya existe (duplicado de clave primaria o única), el script se detendría. Con `IGNORE`, SQL descarta los errores de duplicidad y continúa insertando el resto de filas.

```sql
INSERT IGNORE INTO alumnos (id, nombre, email) 
VALUES (1, 'Juan', 'juan@email.com'); -- Si el ID 1 ya existe, no hace nada y no da error.
```

#### **C. Reemplazo total (REPLACE INTO)**
Es una variante de MySQL. Si el registro existe (por PK o UNIQUE), **lo borra y lo inserta de nuevo** con los nuevos valores. Si no existe, actúa como un `INSERT`.

```sql
REPLACE INTO alumnos (id, nombre, edad) VALUES (1, 'Juan Antonio', 21);
```

#### **D. Actualizar al insertar (ON DUPLICATE KEY UPDATE)**
Es la opción "Upsert" (Update + Insert). Si el registro no existe, lo inserta. Si ya existe, ejecuta un `UPDATE` parcial.

```sql
INSERT INTO alumnos (id, nombre, email) 
VALUES (1, 'Juan', 'contacto@juan.com')
ON DUPLICATE KEY UPDATE email = 'nuevo_contacto@juan.com';
```

#### **E. Sintaxis SET**
MySQL permite otra forma de insertar, similar a un `UPDATE`, que a veces es más legible:

```sql
INSERT INTO alumnos 
SET nombre = 'Clara',
    apellido = 'Mota',
    edad = 24;
```

---

## 🆙 **1.2 Modificar datos (UPDATE)**

La sentencia `UPDATE` se utiliza para modificar datos ya existentes en una tabla.

```sql
UPDATE nombre_tabla
SET columna1 = valor1, columna2 = valor2, ... 
WHERE condicion;
```

**Ejemplo:** cambiar la edad de un alumno concreto:

```sql
UPDATE alumnos 
SET edad = 25 
WHERE id = 1;
```

!!! failure "¡Cuidado con el WHERE!"
    Si olvidas la cláusula `WHERE`, el `UPDATE` se aplicará a **todos** los registros de la tabla.

### Operaciones aritméticas

Podemos actualizar una columna basándonos en su valor actual:

```sql
UPDATE alumnos 
SET edad = edad + 1; -- Todos los alumnos cumplen años
```

## 🗑️ **1.3 Borrar datos (DELETE FROM)**

Elimina registros de una tabla de forma permanente.

```sql
DELETE FROM nombre_tabla WHERE condicion;
```

**Ejemplo:** borrar al alumno con ID 3:

```sql
DELETE FROM alumnos WHERE id = 3;
```

### **TRUNCATE vs DELETE**

| Característica | TRUNCATE | DELETE |
| --- | --- | --- |
| **Velocidad** | Instantáneo (recrea la tabla) ⚡ | Lento (borra fila a fila) 🐢 |
| **Reset Auto-inc** | Sí (Vuelve a 1) | No (sigue la cuenta) |
| **Filtro WHERE** | No permitido | Sí |
| **Transacciones** | No se puede deshacer | Se puede revertir (ROLLBACK) |
| **¿Admite WHERE?** | No (Borra todo) | Sí |

### 👻 **Borrado Lógico (Eliminación Virtual)**

En aplicaciones reales, a menudo **no se borran los datos físicamente** de la base de datos. En su lugar, se realiza lo que se conoce como **Borrado Lógico** o **Eliminación Virtual**.

Esto consiste en añadir una columna a la tabla (normalmente llamada `activo`, `borrado` o `deleted_at`) que indica si el registro debe considerarse "vivo" o "eliminado".

**Ventajas:**
- Permite recuperar datos borrados accidentalmente fácilmente.
- Mantiene la integridad referencial (no rompes históricos de otras tablas).
- Sirve como auditoría para saber qué se borró y cuándo.

**Ejemplo en LigaFutbol:**
Supongamos que añadimos una columna `activo` a la tabla `Jugador`.

```sql
-- En lugar de DELETE, usamos UPDATE
UPDATE Jugador 
SET activo = FALSE 
WHERE id = 10;
```

!!! important "Impacto en las consultas"
    Si usamos borrado lógico, **todas nuestras consultas `SELECT` deberán filtrar por esa columna** para no mostrar datos "borrados":
    ```sql
    SELECT * FROM Jugador WHERE activo = TRUE;
    ```

---

---

### 🚀 **Modificaciones y borrados avanzados**

En muchas ocasiones, la condición para modificar o borrar un registro no está en la propia tabla, sino en otra relacionada.

#### **A. UPDATE con JOIN**
Permite actualizar filas de una tabla basándose en valores de otra tabla combinada o mediante una condición externa.

**Ejemplo:** Supongamos que queremos subir el presupuesto un 20% a todos los equipos que juegan en la ciudad de 'Valencia'.

```sql
UPDATE Equipo e
JOIN Estadio es ON e.estadioID = es.id
SET e.presupuesto = e.presupuesto * 1.20
WHERE es.ciudad = 'Valencia';
```

**Ejemplo:** Subir el salario un 5% a los entrenadores de equipos que tienen un presupuesto inferior a 1.000.000.

```sql
UPDATE Entrenador en
JOIN Equipo eq ON en.equipoID = eq.id
SET en.salario = en.salario * 1.05
WHERE eq.presupuesto < 1000000;
```

#### **B. DELETE con JOIN**
De igual forma, podemos borrar registros filtrando por tablas relacionadas.

**Ejemplo:** Borrar a todos los jugadores que pertenecen al equipo con código 'RMA'.

```sql
DELETE j
FROM Jugador j
JOIN Equipo e ON j.equipoID = e.id
WHERE e.codigo = 'RMA';
```

> **Nota:** En la sintaxis de `DELETE` con `JOIN`, indicamos después del `DELETE` de qué tabla(s) queremos borrar los datos (en este caso, solo de `j`).

#### **C. Borrado multitabla**
Podemos borrar registros de varias tablas a la vez si están relacionadas.

**Ejemplo:** Imaginemos que un equipo desaparece y queremos borrar tanto el equipo como sus contratos de patrocinio en una sola sentencia.

```sql
DELETE eq, cp
FROM Equipo eq
JOIN ContratoPatrocinio cp ON eq.id = cp.equipoID
WHERE eq.codigo = 'DEP_AUX';
```

---

## 🛡️ **1.4 Transacciones**

Una transacción es una unidad lógica de trabajo que comprende una o más sentencias SQL. Para que una base de datos sea fiable, las transacciones deben garantizar cuatro propiedades fundamentales, conocidas por el acrónimo **ACID**.

### 💎 **Propiedades ACID**

| Propiedad | Descripción |
| :--- | :--- |
| **A**tomicidad | La transacción es una unidad única de "todo o nada". Si una parte falla, toda la transacción falla y la base de datos vuelve a su estado original (ROLLBACK). |
| **C**onsistencia | Una transacción lleva a la base de datos de un estado válido a otro estado válido, respetando todas las reglas, restricciones de integridad y triggers. |
| **I**slamiento | Las transacciones que se ejecutan simultáneamente no deben interferir entre sí. Los cambios de una transacción no son visibles para otras hasta que se confirman. |
| **D**urabilidad | Una vez que una transacción ha sido confirmada (COMMIT), los cambios son permanentes y persistirán incluso en caso de fallo del sistema o corte eléctrico. |

---

### 🎮 **Comandos de Control**

En SQL, gestionamos las transacciones mediante los siguientes comandos:

1.  **`START TRANSACTION`** (o `BEGIN`): Marca el punto de inicio de una unidad de trabajo. A partir de aquí, el _Autocommit_ se desactiva.
2.  **`COMMIT`**: Guarda permanentemente todos los cambios realizados durante la transacción actual.
3.  **`ROLLBACK`**: Deshace todos los cambios realizados desde el inicio de la transacción, devolviendo los datos a su estado original.
4.  **`SAVEPOINT nombre`**: Crea un "punto de control" dentro de una transacción larga. Permite deshacer solo una parte de la transacción sin abortarla entera.
5.  **`ROLLBACK TO SAVEPOINT nombre`**: Vuelve al punto de control indicado.

---

### 🏟️ **Ejemplo de integridad: Fichaje de un jugador**

Imagina que el **Equipo A** ficha a un jugador del **Equipo B** por 500.000€. Esta operación requiere tres pasos atómicos:
1.  Restar 500.000€ al presupuesto del Equipo A.
2.  Sumar 500.000€ al presupuesto del Equipo B.
3.  Cambiar el `equipoID` del jugador.

Si el sistema falla tras el paso 1, el dinero "desaparecería". Usamos transacciones para evitarlo:

```sql
START TRANSACTION;

-- Paso 1: Pago del equipo destino
UPDATE Equipo SET presupuesto = presupuesto - 500000 WHERE codigo = 'EQ_A';

-- Paso 2: Cobro del equipo origen
UPDATE Equipo SET presupuesto = presupuesto + 500000 WHERE codigo = 'EQ_B';

-- Creamos un punto de seguridad por si el cambio de jugador falla
SAVEPOINT antes_de_jugador;

-- Paso 3: Cambio de club del jugador
UPDATE Jugador SET equipoID = (SELECT id FROM Equipo WHERE codigo = 'EQ_A')
WHERE nombre = 'Leo' AND apellido = 'Messi';

-- Verificamos si todo ha ido bien
-- Si el jugador no existiera o hubiera un error de integridad:
-- ROLLBACK TO SAVEPOINT antes_de_jugador; -- Podríamos intentar corregirlo

-- Si todo es correcto, guardamos:
COMMIT;
```

!!! danger "Transacciones e Integridad Referencial"
    Las transacciones son nuestra última línea de defensa. Aunque las claves ajenas (`FOREIGN KEY`) evitan datos huérfanos, solo las transacciones aseguran que operaciones complejas que afectan a varias filas (como la transferencia de fondos anterior) sean consistentes.

### 🔌 **Autocommit: El comportamiento por defecto**

Por defecto, MySQL y MariaDB operan en modo **Autocommit = 1**. Esto significa que cada sentencia individual (`INSERT`, `UPDATE`, `DELETE`) es tratada como una transacción completa que se confirma automáticamente al terminar.

Para realizar transacciones de varias líneas, tenemos dos opciones:
*   Usar explícitamente `START TRANSACTION` (desactiva el autocommit solo para ese bloque).
*   Desactivar el autocommit globalmente con `SET autocommit = 0;` (peligroso en entornos de producción si se olvida hacer `COMMIT`).

---

## ❌ **Errores comunes y buenas prácticas**

Al manipular datos, el riesgo de cometer errores críticos es alto. Sigue estos consejos:

1. **¡El WHERE es sagrado!**: Antes de ejecutar un `UPDATE` o `DELETE`, ejecuta un `SELECT` con el mismo `WHERE` para verificar qué filas se verán afectadas.
   
   ```sql
   -- Primero verificamos:
   SELECT * FROM alumnos WHERE edad > 30;
   
   -- Si los resultados son correctos, cambiamos a DELETE:
   DELETE FROM alumnos WHERE edad > 30;
   ```

2. **Usa transacciones para pruebas**: Si no estás seguro de un cambio masivo, usa `START TRANSACTION`. Verifica el resultado con un `SELECT` y, si no es lo que esperabas, haz `ROLLBACK`.

3. **Copias de seguridad rápidas**: Antes de una operación peligrosa, puedes duplicar una tabla en segundos:
   
   ```sql
   CREATE TABLE alumnos_backup AS SELECT * FROM alumnos;
   ```

4. **Cuidado con las Claves Ajenas**: Si una tabla tiene restricciones de integridad (`FOREIGN KEY`), es posible que no puedas borrar un registro si tiene datos relacionados en otra tabla (error de restricción). En ese caso, deberás borrar primero los "hijos" o configurar el borrado en cascada (`ON DELETE CASCADE`).

5. **Asignación de NULL**: Recuerda que para poner un valor a `NULL` se usa el operador `=`, pero para buscarlo se usa `IS NULL`.
   
   ```sql
   -- Correcto para modificar:
   UPDATE alumnos SET email = NULL WHERE id = 5;
   
   -- Correcto para buscar:
   SELECT * FROM alumnos WHERE email IS NULL;
   ```