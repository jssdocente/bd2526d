# Actividades de la unidad 8

En estas actividades pondremos en práctica la programación procedural en MariaDB utilizando la base de datos **TechStore**.

### 🛠️ 1. Procedimientos Almacenados Básicos

!!! example "Actividad Resuelta: Contador de Proveedores Activos"
    
    **Enunciado**: Crea un procedimiento llamado `pa_contar_proveedores_activos` que muestre por pantalla el número de proveedores que están actualmente marcados como activos.

    **Solución**:
    ```sql
    DELIMITER //
    CREATE PROCEDURE pa_contar_proveedores_activos()
    COMMENT "Muestra el total de proveedores con estado activo"
    BEGIN
        SELECT COUNT(*) AS "Total Activos" 
        FROM proveedores 
        WHERE activo = TRUE;
    END //
    DELIMITER ;

    -- Para probarlo:
    CALL pa_contar_proveedores_activos();
    ```


#### **AC801: Buscador de Stock Crítico**

??? "Actividad AC801"

    | Criterios de Evaluación | Ponderación |
    | ----------------------- | ----------- |
    | CE5f, CE5d              | 1p          |

    Crea un procedimiento llamado `pa_verificar_stock` que reciba un número entero como parámetro de entrada (`limite`).
    
    1. El procedimiento debe mostrar el `id`, `nombre` y `stock` de todos los productos cuyo stock sea **menor o igual** al límite proporcionado.
    2. Añade un comentario al procedimiento explicando su utilidad.
    3. Ejecuta el procedimiento para buscar productos con 5 o menos unidades.
    4. Comprueba qué sucede si pasas un valor negativo.

---

#### **AC802: Resumen de Cliente (IN/OUT)**

??? "Actividad AC802"

    | Criterios de Evaluación | Ponderación |
    | ----------------------- | ----------- |
    | CE5f                    | 1.5p        |

    Crea un procedimiento llamado `pa_resumen_cliente` que reciba el ID de un cliente y devuelva, mediante parámetros de salida, la cantidad total de pedidos realizados por ese cliente y la suma total de dinero gastado.
    
    * **Entrada**: `cliente_id INT`.
    * **Salida**: `total_pedidos INT`, `suma_gastada DECIMAL(10,2)`.

    **Pasos:**
    
    1. Define el procedimiento con los parámetros correctos.
    2. Utiliza `SELECT ... INTO` para asignar los valores a los parámetros de salida.
    3. Realiza la llamada al procedimiento utilizando variables de usuario (`@pedidos`, `@gasto`) para recoger los resultados.
    4. Muestra los resultados finales con un `SELECT`.

---

### 🧠 2. Lógica y Control de Flujo

!!! example "Actividad Resuelta: Simulación de Ahorro con Intereses (Bucles y Variables)"

    **Enunciado**: Crea un procedimiento `pa_simular_ahorro` que reciba un saldo inicial y un porcentaje de interés (en decimal, ej: 0.05 para 5%). El procedimiento debe usar variables locales y un bucle `WHILE` para calcular y mostrar el saldo proyectado cada año durante un periodo de 5 años.

    **Solución**:
    ```sql
    DELIMITER //
    CREATE PROCEDURE pa_simular_ahorro(IN saldo_inicial DECIMAL(10,2), IN interes FLOAT)
    BEGIN
        DECLARE contador INT DEFAULT 1;
        DECLARE saldo_actual DECIMAL(10,2);
        
        SET saldo_actual = saldo_inicial;

        WHILE contador <= 5 DO
            SET saldo_actual = saldo_actual + (saldo_actual * interes);
            SELECT CONCAT("Año ", contador, ": ", saldo_actual, "€") AS Proyección;
            SET contador = contador + 1;
        END WHILE;
    END //
    DELIMITER ;

    -- Para probarlo (Saldo de 1000€ al 5% de interés):
    CALL pa_simular_ahorro(1000.00, 0.05);
    ```


#### **AC803: Clasificador Dinámico de Productos**

??? "Actividad AC803"

    | Criterios de Evaluación | Ponderación |
    | ----------------------- | ----------- |
    | CE5g                    | 2p          |

    **Nivel: Medio-Avanzado**

    Crea un procedimiento llamado `pa_categorizar_producto` que reciba el ID de un producto (`producto_id`) y devuelva un mensaje de texto indicando su gama de precio y su disponibilidad.

    **Lógica interna:**
    
    1. Recupera el precio y el stock del producto en variables locales.
    2. Utiliza un bloque `IF` o `CASE` para determinar la **Gama**:
        * Menos de 100€: "Gama Blanca/Entrada".
        * Entre 100€ y 500€: "Gama Media".
        * Más de 500€: "Gama Premium".
    3. Utiliza otro bloque `IF` para determinar el **Aviso de Stock**:
        * Stock = 0: "AGOTADO".
        * Stock > 0: "DISPONIBLE".
    4. El procedimiento debe devolver un único `SELECT` con una frase del tipo: *"El producto [Nombre] es de Gama Media y está DISPONIBLE"*.

---

#### **AC804: Procesador de Pedido Masivo (Bucles)**

??? "Actividad AC804"

    | Criterios de Evaluación | Ponderación |
    | ----------------------- | ----------- |
    | CE5g, CE5d              | 2.5p        |

    Imagina que la tienda quiere "limpiar" stock regalando unidades de un producto específico a los clientes con saldo más bajo hasta que se agote un presupuesto.

    Crea un procedimiento `pa_simular_reparto` que reciba un `id_producto` y un `presupuesto_max`.
    
    1. Usa un bucle (`WHILE` o `LOOP`) para simular la entrega del producto a clientes (puedes simplemente ir restando el precio del producto al presupuesto).
    2. En cada iteración:
        * Comprueba si el presupuesto restante es suficiente para el precio del producto.
        * Si es suficiente, resta el precio al presupuesto e incrementa un contador de "entregas simulas".
        * Si no es suficiente, rompe el bucle con `LEAVE`.
    3. Al finalizar, muestra un mensaje indicando el total de productos que se podrían haber repartido y el presupuesto sobrante.

---

### ⚡ 3. Funciones de Usuario

!!! example "Actividad Resuelta: Obtener Nombre de Cliente"

    **Enunciado**: Crea una función `fn_nombre_cliente` que reciba el ID de un cliente (`id_cliente`) y devuelva su nombre completo.

    **Solución**:
    ```sql
    DELIMITER //
    CREATE FUNCTION fn_nombre_cliente(id_cliente INT)
    RETURNS VARCHAR(50)
    DETERMINISTIC
    BEGIN
        DECLARE v_nombre VARCHAR(50);
        SELECT nombre INTO v_nombre 
        FROM clientes 
        WHERE id = id_cliente;
        RETURN v_nombre;
    END //
    DELIMITER ;

    -- Para probarlo:
    SELECT id, email, fn_nombre_cliente(id) FROM clientes;
    ```


#### **AC805: Formateador de Moneda y Alertas**

??? "Actividad AC805"

    | Criterios de Evaluación | Ponderación |
    | ----------------------- | ----------- |
    | CE5e, CE5f              | 3p          |

    Realiza las siguientes tareas de creación de funciones:

    1. **Función `fn_formato_precio`**: Recibe un `importe` (DECIMAL) y devuelve un `VARCHAR` con el símbolo del euro al final y dos decimales (ej: `120.50€`).
    2. **Función `fn_estado_pedido`**: Recibe el `id_pedido` y devuelve una cadena descriptiva:
        * Si el total > 1000€: "Pedido Prioritario".
        * Si el total <= 1000€ y el estado es 'PENDIENTE': "Revisión necesaria".
        * En cualquier otro caso: "Pedido Estándar".
    3. **Consulta Maestra**: Realiza un `SELECT` sobre la tabla `pedidos` que utilice ambas funciones para mostrar el ID del pedido, el total formateado y su estado calculado.

---

### 🚀 4. Reto Final (Opcional)

#### **AC806: El Optimizador de Inventario**

??? "Actividad AC806"

    Crea un procedimiento `pa_autocompletar_stock` que recorra (mediante lógica de programación) la tabla de productos. Si un producto tiene stock menor a 10 y su proveedor está **ACTIVO**, debe realizar un `UPDATE` sumando 20 unidades al stock. 
    
    *Pista: Para esta actividad deberías investigar el uso de **CURSORES**, que permiten recorrer los resultados de una consulta fila por fila dentro de un procedimiento.*
