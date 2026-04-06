# 📥 **UT8. Programación de SQL: Funciones y procedimientos**

!!! info "Información de la unidad"

    === "Contenidos"

        Programación de bases de datos:

          - Introducción. Lenguaje de programación.
          - Variables del sistema y variables de usuario.
          - Funciones.
          - Estructuras de control de flujo.
          - Procedimientos almacenados. Funciones de usuario.

    === "Propuesta didáctica"

          En esta unidad vamos a trabajar el RA5 "**Desarrolla procedimientos almacenados evaluando y utilizando las sentencias del lenguaje incorporado en el sistema gestor de bases de datos.**"

          Criterios de evaluación

        - **CE5a**: Se han identificado las diversas formas de automatizar tareas.
        - **CE5b**: Se han reconocido los métodos de ejecución de guiones.
        - **CE5c**: Se han identificado las herramientas disponibles para editar guiones.
        - **CE5d**: Se han definido y utilizado guiones para automatizar tareas.
        - **CE5e**: Se ha hecho uso de las funciones proporcionadas por el sistema gestor.
        - **CE5f**: Se han definido procedimientos y funciones de usuario.
        - **CE5g**: Se han utilizado estructuras de control de flujo.

!!! info "Bases de datos recursos"

    Aquí tienes los enlaces a las bases de datos de recursos para esta unidad:

    - [TechStore](../06/bd/bd_tech_store.sql)


## **8.1 Automatización de tareas**

Imagina que cada mañana, al llegar a tu puesto de trabajo, tuvieras que revisar manualmente miles de registros para encontrar cuáles han caducado y borrarlos uno por uno. Sería una pérdida de tiempo enorme y muy propensa a errores. Para evitar esto, las bases de datos permiten la **automatización**.

Automatizar procesos consiste en programar el sistema para que realice tareas por sí solo. Esto nos ayuda a:
- **Optimizar el tiempo**: El sistema trabaja mientras nosotros hacemos otras cosas.
- **Reducir errores**: Una vez programado, el sistema no se equivoca de fila ni se olvida de un paso.
- **Mejorar el rendimiento**: Las tareas pesadas se pueden programar para horas de poco tráfico (como la madrugada).

### Estrategias de automatización

Dentro de un SGBD como **MariaDB**, tenemos varias herramientas para lograr esto:

1.  **Triggers (Disparadores)**: Se ejecutan solos cuando ocurre algo (ej. "cuando alguien borre un cliente, guarda una copia en la tabla de papelera").
2.  **Procedimientos almacenados**: Son bloques de código que guardamos con un nombre para ejecutarlos cuando queramos (como una "receta" que guardas en tu recetario).
3.  **Eventos (Jobs)**: Tareas que se ejecutan cada cierto tiempo (ej. "todos los domingos a las 3:00 AM haz una copia de seguridad").
4.  **Scripts externos**: Programas en lenguajes como Python o Java que se conectan a la base de datos y le mandan órdenes.

!!! note "Bases de datos y Programación"
    Aunque en el módulo de _Programación_ aprenderéis a usar Java para hablar con la base de datos, es muy útil que la propia base de datos sea "inteligente" y se sepa gestionar a sí misma mediante procedimientos.

### El concepto de "Guion" (Script)

Un **guion** o **_script_** es simplemente un archivo de texto que contiene una lista de órdenes SQL. En lugar de escribir las órdenes una a una en la consola, las ponemos todas en un archivo `.sql` y le decimos al gestor: "ejecuta todo esto en orden".

Podemos ejecutar un archivo SQL:
- **Desde la terminal (fuera de MariaDB)**:
    `mariadb -u usuario -p nombre_db < mi_script.sql`
- **Desde la consola de MariaDB (dentro)**:
    `source mi_script.sql`

A continuación, veremos cómo ir más allá de simples listas de órdenes y crear auténtica **lógica de programación** dentro de MariaDB.

## **8.2 Lenguajes de programación en BD**

El lenguaje SQL que hemos estudiado hasta ahora es un lenguaje **declarativo**: le decimos a la base de datos *qué* queremos, pero no *cómo* hacerlo paso a paso (por ejemplo, no podíamos usar bucles `for` o condiciones `if`).

Para solucionar esto, los SGBD incluyen extensiones que permiten la **programación estructurada**. La variante de MariaDB (y MySQL) se conoce a menudo como **lenguaje de rutinas almacenadas**, aunque es muy similar conceptualmente a:
- **PL/SQL**: Utilizado por Oracle.
- **PL/pgSQL**: Utilizado por PostgreSQL.
- **T-SQL**: Utilizado por SQL Server.

### ¿Para qué sirve programar en la BD?

Al programar dentro del servidor de base de datos, conseguimos:
- **Modularidad**: Escribimos el código una vez y lo llamamos mil veces.
- **Seguridad**: Podemos dar permiso a un usuario para ejecutar un procedimiento, pero no para borrar tablas directamente.
- **Velocidad**: El código se ejecuta directamente donde están los datos, ahorrando viajes de información por la red.
- **Control de errores**: Podemos capturar fallos y decidir qué hacer si algo sale mal.

### Estructura de un bloque de código

Todo bloque de programación lógica se organiza de la siguiente manera:

```sql
[ DECLARE -- Aquí definimos las variables que usaremos ] 
BEGIN 
    -- Aquí escribimos las instrucciones (el "paso a paso") 
    [ EXCEPTION -- Aquí decimos qué hacer si hay un error ] 
END;
```

A lo largo de esta unidad aprenderemos a utilizar PL/SQL para crear procedimientos almacenados, funciones de usuario, así como a utilizar estructuras de control de flujo para dotar de lógica a nuestros procedimientos y funciones. En la siguiente unidad, veremos el uso de excepciones para gestionar los errores que puedan surgir durante la ejecución de nuestros procedimientos y funciones.

## **8.3 Procedimientos**

Un **procedimiento almacenado** (_Stored Procedure_) es como una función de Java pero que vive dentro de la base de datos. Es un bloque de código SQL al que le ponemos un nombre para poder "llamarlo" siempre que lo necesitemos.

### Creación del procedimiento

Para crear uno, usamos la sentencia `CREATE PROCEDURE`. Su estructura básica es:

```sql
CREATE [OR REPLACE] PROCEDURE nombre_p (parametros) 
BEGIN     
    -- Instrucciones SQL 
END;
```

### ¡Cuidado con el delimitador!

Normalmente, MariaDB ejecuta una orden en cuanto ve un punto y coma (`;`). Como un procedimiento tiene muchas instrucciones internas, cada una con su propio `;`, MariaDB se detendría antes de tiempo.

Usamos `DELIMITER` para cambiar el separador temporalmente:

```sql
DELIMITER // 

CREATE PROCEDURE stock_total_productos()
COMMENT "Muestra la suma total de stock de todos los productos"
BEGIN     
    SELECT SUM(stock) FROM productos; 
END //  

DELIMITER ;
```

### Invocando un procedimiento

Una vez creado, lo llamamos con la palabra clave `CALL`:

```sql
CALL stock_total_productos();
-- +------------+
-- | SUM(stock) |
-- +------------+
-- |        150 |
-- +------------+
```

### Tipos de parámetros

Para que nuestros procedimientos sean flexibles, usamos **parámetros**. En MariaDB existen tres tipos:

1.  **IN (Entrada)**: El dato que recibe el procedimiento.
2.  **OUT (Salida)**: Un valor que el procedimiento nos devuelve. 
3.  **INOUT (Entrada/Salida)**: Recibe un valor y lo devuelve modificado.

#### 1. Parámetros de Entrada (`IN`)

!!! example "Buscar por nombre"

    ```sql
    DELIMITER // 
    CREATE PROCEDURE buscar_producto(IN p_nombre VARCHAR(100)) 
    BEGIN     
        SELECT * FROM productos WHERE nombre LIKE CONCAT('%', p_nombre, '%'); 
    END // 
    DELIMITER ; 

    CALL buscar_producto('Laptop');
    ```

!!! example "Listar productos de un proveedor"

    ```sql
    DELIMITER //
    CREATE PROCEDURE listar_por_proveedor(IN prov_id INT)
    BEGIN
        SELECT p.nombre, p.precio, pr.nombre AS proveedor
        FROM productos p
        JOIN proveedores pr ON p.proveedor_id = pr.id
        WHERE pr.id = prov_id;
    END //
    DELIMITER ;

    CALL listar_por_proveedor(1);
    ```

#### 2. Parámetros de Salida (`OUT`)

!!! example "Obtener el precio más caro"

    ```sql
    DELIMITER // 
    CREATE PROCEDURE precio_mas_caro(OUT max_p DECIMAL(10,2)) 
    BEGIN     
        SELECT MAX(precio) INTO max_p FROM productos; 
    END // 
    DELIMITER ; 

    CALL precio_mas_caro(@p_max);
    SELECT @p_max AS "El producto más caro vale";
    ```

!!! example "Contar pedidos según su estado"

    ```sql
    DELIMITER //
    CREATE PROCEDURE contar_pedidos_estado(IN p_estado VARCHAR(20), OUT v_total INT)
    BEGIN
        SELECT COUNT(*) INTO v_total FROM pedidos WHERE estado = p_estado;
    END //
    DELIMITER ;

    CALL contar_pedidos_estado('PENDIENTE', @pendientes);
    SELECT @pendientes;
    ```

#### 3. Parámetros de Entrada/Salida (`INOUT`)

!!! example "Actualizar saldo de cliente con un bono"

    ```sql
    DELIMITER // 
    CREATE PROCEDURE aplicar_bono_fidelidad(INOUT v_saldo DECIMAL(10,2), IN p_bono INT) 
    BEGIN     
        SET v_saldo = v_saldo + p_bono; 
    END // 
    DELIMITER ; 

    SET @saldo_cli = 100.50;
    CALL aplicar_bono_fidelidad(@saldo_cli, 50);
    SELECT @saldo_cli; -- Resultado: 150.50
    ```

## **8.4 Variables en MariaDB**

### 1. Variables Locales (`DECLARE`)
Viven solo dentro del procedimiento. Muy útiles para pasos intermedios.

```sql
DELIMITER //
CREATE PROCEDURE calcular_compra_minima(IN p_id INT)
BEGIN
    DECLARE v_precio DECIMAL(10,2);
    -- Guardamos el precio en la variable local
    SELECT precio INTO v_precio FROM productos WHERE id = p_id;
    -- Mostramos cuánto costarían 10 unidades
    SELECT (v_precio * 10) AS "Coste de 10 unidades";
END //
DELIMITER ;
```

### 2. Variables de Usuario (`@`)
Existen durante toda tu conexión a la base de datos (sesión). Se usan principalmente para recibir datos de un parámetro `OUT` o para guardar valores que usarás más tarde.

```sql
-- Ejemplo A: Guardar un valor manualmente
SET @mi_descuento = 0.15;
SELECT nombre, precio * @mi_descuento FROM productos;

-- Ejemplo B: Recibir un valor de un procedimiento (PARÁMETRO OUT)
CALL precio_mas_caro(@p_max);
SELECT @p_max;
```

## **8.5 Estructuras de control**

### Condicionales (`IF`)

!!! example "Clasificar stock"

    ```sql
    DELIMITER //
    CREATE PROCEDURE aviso_stock(IN p_id INT)
    BEGIN
        DECLARE v_cantidad INT;
        SELECT stock INTO v_cantidad FROM productos WHERE id = p_id;

        IF v_cantidad < 5 THEN
            SELECT "Stock CRÍTICO" AS Mensaje;
        ELSEIF v_cantidad < 15 THEN
            SELECT "Stock Bajo" AS Mensaje;
        ELSE
            SELECT "Stock Saludable" AS Mensaje;
        END IF;
    END //
    DELIMITER ;
    ```

!!! example "Nivel de cliente por saldo"

    ```sql
    DELIMITER //
    CREATE PROCEDURE nivel_cliente(IN c_id INT)
    BEGIN
        DECLARE v_saldo DECIMAL(10,2);
        SELECT saldo INTO v_saldo FROM clientes WHERE id = c_id;

        IF v_saldo > 1000 THEN
            SELECT "VIP" AS Categoria;
        ELSE
            SELECT "ESTANDAR" AS Categoria;
        END IF;
    END //
    DELIMITER ;
    ```

!!! example "Clasificar precios (CASE)"

    Al igual que el `IF`, podemos usar `CASE` para evaluar diferentes condiciones de forma más limpia:

    ```sql
    DELIMITER //
    CREATE PROCEDURE categoria_precio(IN p_id INT)
    BEGIN
        DECLARE v_precio DECIMAL(10,2);
        SELECT precio INTO v_precio FROM productos WHERE id = p_id;

        CASE 
            WHEN v_precio < 50 THEN SELECT "Económico" AS Categoria;
            WHEN v_precio < 500 THEN SELECT "Medio" AS Categoria;
            ELSE SELECT "Lujo" AS Categoria;
        END CASE;
    END //
    DELIMITER ;
    ```

### Bucles (`WHILE`)

Los bucles permiten repetir una acción varias veces.

!!! example "Simular un listado de números para un reporte de ventas"

    ```sql
    DELIMITER //
    CREATE PROCEDURE contador_ventas(IN p_tope INT)
    BEGIN
        DECLARE v_count INT DEFAULT 1;
        WHILE v_count <= p_tope DO
            SELECT CONCAT("Venta número: ", v_count);
            SET v_count = v_count + 1;
        END WHILE;

    END //
    DELIMITER ;
    ```

!!! example "Bucle infinito controlado (LOOP/LEAVE)"

    ```sql
    DELIMITER //
    CREATE PROCEDURE rellenar_stock_emergencia(IN p_id INT, IN p_objetivo INT)
    BEGIN
        DECLARE v_actual INT;
        bucle_stock: LOOP
            SELECT stock INTO v_actual FROM productos WHERE id = p_id;
            
            IF v_actual >= p_objetivo THEN
                LEAVE bucle_stock; -- Salimos cuando alcanzamos el objetivo
            END IF;
            
            UPDATE productos SET stock = stock + 1 WHERE id = p_id;
        END LOOP bucle_stock;
    END //
    DELIMITER ;
    ```

## **8.6 Funciones**

Las funciones siempre **devuelven un valor** y se pueden usar en un `SELECT`.

!!! example "Ejemplo A: Calcular descuento"

    ```sql
    DELIMITER //
    CREATE FUNCTION aplicar_dto(precio DECIMAL(10,2), pct INT) 
    RETURNS DECIMAL(10,2)
    DETERMINISTIC
    BEGIN
        RETURN precio - (precio * pct / 100);
    END //
    DELIMITER ;

    -- Uso
    SELECT nombre, precio, aplicar_dto(precio, 10) AS "Precio rebajado" 
    FROM productos;
    ```

!!! example "Ejemplo B: Estado de stock (Booleano)"

    ```sql
    DELIMITER //
    CREATE FUNCTION hay_stock(p_id INT) 
    RETURNS BOOLEAN
    DETERMINISTIC
    BEGIN
        DECLARE v_stock INT;
        SELECT stock INTO v_stock FROM productos WHERE id = p_id;
        RETURN (v_stock > 0);
    END //
    DELIMITER ;

    -- Uso: Ver qué productos podemos vender hoy
    SELECT nombre FROM productos WHERE hay_stock(id) = TRUE;
    ```
