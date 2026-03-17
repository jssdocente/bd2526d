# 📝 Resumen SQL - 2ª Evaluación

## 1. Álgebra Relacional (Operaciones Básicas)
| Operación | Notación | Descripción |
| :--- | :--- | :--- |
| **Selección** | **σ**<sub>condición</sub>(R) | Filtra filas (tuplas) que cumplen la condición. |
| **Proyección** | **π**<sub>atributos</sub>(R) | Selecciona columnas específicas. |
| **Unión** | R **∪** S | Combina tuplas de dos relaciones (esquema idéntico). |
| **Intersección** | R **∩** S | Tuplas presentes en ambas relaciones. |
| **Diferencia** | R **−** S | Tuplas en R pero no en S. |
| **Producto Cartesiano** | R **×** S | Combina cada fila de R con cada fila de S. |
| **Join Natural** | R **⨝** S | Une por atributos comunes implícitamente. |
| **Join Equi** | R **⨝**<sub>C</sub> S | Une según una condición de igualdad explícita. |

---

## 2. Consultas DQL (`SELECT`)

### Estructura y Orden de Ejecución
Aunque se escribe en un orden, el motor SQL lo ejecuta en otro:

| Orden Escrito | Cláusula | Orden Ejecución | Propósito |
| :--- | :--- | :---: | :--- |
| 1 | `SELECT` | **5** | Qué columnas mostrar (proyección). |
| 2 | `FROM` / `JOIN` | **1** | De qué tablas sacar los datos y cómo unirlas. |
| 3 | `WHERE` | **2** | Filtrar filas antes de agrupar. |
| 4 | `GROUP BY` | **3** | Agrupar filas para cálculos agregados. |
| 5 | `HAVING` | **4** | Filtrar grupos después de calcular agregados. |
| 6 | `ORDER BY` | **6** | Ordenar el resultado final (`ASC`\|`DESC`). |
| 7 | `LIMIT` | **7** | Restringir el número de filas devueltas. |

### Operadores de Comparación y Lógicos
*   **Relacionales:** `=`, `!=` o `<>`, `<`, `<=`, `>`, `>=`
*   **Rangos:** `BETWEEN inicio AND fin`, `IN (valor1, valor2, ...)`
*   **Nulos:** `IS NULL`, `IS NOT NULL`
*   **Patrones:** `LIKE` (`%` varios caracteres, `_` un carácter)
*   **Lógicos:** `AND`, `OR`, `NOT`

---

## 3. Funciones SQL (Resumen)

### Funciones de Agregación
| Función | Descripción | Detalle |
| :--- | :--- | :--- |
| `COUNT(*)` | Cuenta todas las filas. | Incluye filas con valores `NULL`. |
| `COUNT(col)` | Cuenta valores no nulos. | Ignora los `NULL` en esa columna. |
| `COUNT(DISTINCT col)` | Cuenta valores únicos. | No cuenta duplicados ni nulos. |
| `SUM(col)` | Suma los valores. | Solo para columnas numéricas. |
| `AVG(col)` | Promedio de los valores. | Ignora valores `NULL` en el cálculo. |
| `MAX(col)` / `MIN(col)` | Valor máximo / mínimo. | Funciona con números, fechas y texto. |

### Funciones de Cadena (String)
| Función | Descripción |
| :--- | :--- |
| `CONCAT(s1, s2...)` | Une varias cadenas. |
| `UPPER(s)` / `LOWER(s)` | Convierte a MAYÚSCULAS o minúsculas. |
| `LENGTH(s)` / `CHAR_LENGTH(s)` | Longitud de la cadena (bytes vs caracteres). |
| `LEFT(s, n)` / `RIGHT(s, n)` | Extrae `n` caracteres por la izquierda/derecha. |
| `TRIM(s)` / `LTRIM` / `RTRIM` | Elimina espacios en blanco. |
| `SUBSTRING(s, pos, len)` | Extrae una parte de la cadena. |
| `REPLACE(s, busq, reempl)`| Sustituye texto. |

### Funciones de Fecha y Hora
| Función | Descripción |
| :--- | :--- |
| `NOW()` | Fecha y hora actual del sistema. |
| `CURDATE()` | Fecha actual (`YYYY-MM-DD`). |
| `DATEDIFF(d1, d2)` | Diferencia en días entre dos fechas. |
| `TIMESTAMPDIFF(unit, d1, d2)` | Diferencia en `YEAR`, `MONTH`, `DAY`, `HOUR`... |
| `DATE_FORMAT(d, format)` | Formatea fecha (ej: `%d/%m/%Y`). |
| `YEAR(d)`, `MONTH(d)`, `DAY(d)` | Extrae parte de la fecha. |

### Funciones Matemáticas y de Control
| Función | Descripción |
| :--- | :--- |
| `ROUND(n, d)` | Redondea a `d` decimales. |
| `TRUNCATE(n, d)` | Trunca a `d` decimales. |
| `IFNULL(val, default)` | Si `val` es nulo, devuelve `default`. |
| `COALESCE(v1, v2...)` | Devuelve el primer valor no nulo de la lista. |
| `IF(cond, V, F)` | Condicional simple: si `cond` es cierto devuelve `V`, si no `F`. |
| `CASE` | Estructura `WHEN ... THEN ... ELSE ... END`. |

---

## 4. Agrupamientos (`GROUP BY` & `HAVING`)
*   **Regla de Oro:** Todas las columnas del `SELECT` que **no** tengan función de agregado **DEBEN** estar en el `GROUP BY`.
*   **HAVING vs WHERE:** `WHERE` filtra antes de agrupar; `HAVING` filtra después de agrupar usando funciones agregadas (ej: `HAVING COUNT(*) > 5`).
*   **ROLLUP:** Añade `WITH ROLLUP` al final del `GROUP BY` para obtener totales y subtotales automáticos.

---

## 5. Subconsultas y CTEs

### Subconsultas (Consultas anidadas)
*   **Escalar:** Devuelve un único valor. Se usa con `=`, `>`, `<`, etc.
    *   `WHERE precio > (SELECT AVG(precio) FROM productos)`
*   **De Tabla/Conjunto:** Devuelve una lista. Se usa con `IN`, `ANY`, `ALL`.
    *   `WHERE id IN (SELECT id_autor FROM libros WHERE ...)`
*   **Correlacionada:** La subconsulta depende de la consulta externa (se ejecuta vez por fila).
    *   `SELECT ... FROM film f WHERE f.length > (SELECT AVG(length) FROM film f2 WHERE f2.rating = f.rating)`
*   **Existencia:** `EXISTS` / `NOT EXISTS`. Comprueba si la subconsulta devuelve algo o no.
    *   `WHERE EXISTS (SELECT 1 FROM tabla WHERE ...)`

### CTEs (Common Table Expressions - `WITH`)
Permiten definir "vistas temporales" para hacer la consulta principal más legible y modular.
```sql
WITH ventas_mes AS (
    SELECT id_vendedor, SUM(importe) as total
    FROM ventas
    GROUP BY id_vendedor
)
SELECT * FROM ventas_mes WHERE total > 1000;
```

---

## 6. Operadores de Conjunto
Combinan el resultado de dos consultas (deben tener el mismo nº de columnas y tipos).

| Operador | Descripción |
| :--- | :--- |
| `UNION` | Combina resultados y elimina duplicados. |
| `UNION ALL` | Combina resultados manteniendo duplicados (más rápido). |
| `INTERSECT` | Solo filas que aparecen en ambos resultados. |
| `EXCEPT` | Filas que están en la 1ª consulta pero NO en la 2ª. |

---

## 7. Vistas
*   **Crear:** `CREATE VIEW nombre AS SELECT ...;`
*   **Borrar:** `DROP VIEW nombre;`
*   **Nota:** Son tablas virtuales. Los cambios en las tablas base se reflejan en la vista. Solo son actualizables si son simples (sin `GROUP BY`, `DISTINCT` o `UNION`).

---

---

## 8. Manipulación de Datos (DML)

### Inserción (`INSERT`)
*   **Básico:** `INSERT INTO tabla (col1, col2) VALUES (val1, val2);`
*   **Múltiple:** `INSERT INTO tabla (...) VALUES (...), (...), (...);`
*   **Desde Select:** `INSERT INTO tabla SELECT ... FROM otra_tabla;`
*   **Ignorar errores:** `INSERT IGNORE INTO ...` (salta duplicados).
*   **Reemplazar:** `REPLACE INTO ...` (borra si existe y reinserta).

### Actualización (`UPDATE`)
*   **Básico:** `UPDATE tabla SET col1 = val1 WHERE condicion;`
*   **Con Join:** `UPDATE T1 JOIN T2 ON ... SET T1.col = val WHERE ...;`
*   **⚠️ Cuidado:** El `WHERE` es vital; sin él, actualizas toda la tabla.

### Borrado (`DELETE`)
*   **Básico:** `DELETE FROM tabla WHERE condicion;`
*   **Con Join:** `DELETE t1 FROM tabla1 t1 JOIN tabla2 t2 ON ... WHERE ...;`
*   **TRUNCATE:** `TRUNCATE TABLE tabla;` (Vacia la tabla, resetea auto-incrementos, es más rápido pero no se puede deshacer con Rollback).

---

## 9. Transacciones y ACID
Unidad lógica de trabajo que debe cumplir las propiedades **ACID**:
*   **A**tomicity: Todo o nada.
*   **C**onsistency: De estado válido a estado válido.
*   **I**solation: No interferencia entre transacciones simultáneas.
*   **D**urability: Los cambios tras un `COMMIT` son permanentes.

### Comandos de Control:
1.  `START TRANSACTION;` o `BEGIN;`: Inicia la transacción.
2.  `COMMIT;`: Guarda los cambios permanentemente.
3.  `ROLLBACK;`: Deshace los cambios realizados.
4.  `SAVEPOINT nombre;`: Crea un punto intermedio.
5.  `ROLLBACK TO SAVEPOINT nombre;`: Vuelve al punto indicado sin cancelar todo.
