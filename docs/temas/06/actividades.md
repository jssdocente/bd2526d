# Actividades de la unidad 6

??? info "Base de datos para las actividades: TechStore"

    Para las actividades de este bloque vamos a crear desde cero una base de datos simulando el motor de una tienda de tecnología. 

    Ejecuta el siguiente script para crear el entorno de estructuración y la base de datos vacía antes de empezar:

    ```sql
    DROP DATABASE IF EXISTS techstore;
    CREATE DATABASE techstore;
    USE techstore;

    CREATE TABLE proveedores (
        id INT AUTO_INCREMENT PRIMARY KEY,
        nombre VARCHAR(50) NOT NULL,
        ciudad VARCHAR(50),
        activo BOOLEAN DEFAULT TRUE
    );

    CREATE TABLE clientes (
        id INT AUTO_INCREMENT PRIMARY KEY,
        nombre VARCHAR(50) NOT NULL,
        email VARCHAR(100) UNIQUE NOT NULL,
        saldo DECIMAL(10,2) DEFAULT 0.00
    );

    CREATE TABLE productos (
        id INT AUTO_INCREMENT PRIMARY KEY,
        nombre VARCHAR(100) NOT NULL,
        precio DECIMAL(10,2) NOT NULL,
        stock INT DEFAULT 0,
        proveedor_id INT,
        activo BOOLEAN DEFAULT TRUE,
        FOREIGN KEY (proveedor_id) REFERENCES proveedores(id) ON DELETE SET NULL
    );

    CREATE TABLE pedidos (
        id INT AUTO_INCREMENT PRIMARY KEY,
        fecha DATETIME DEFAULT CURRENT_TIMESTAMP,
        cliente_id INT,
        total DECIMAL(10,2) DEFAULT 0.00,
        estado VARCHAR(20) DEFAULT 'PENDIENTE',
        FOREIGN KEY (cliente_id) REFERENCES clientes(id)
    );

    CREATE TABLE detalle_pedido (
        pedido_id INT,
        producto_id INT,
        cantidad INT NOT NULL,
        precio_unitario DECIMAL(10,2) NOT NULL,
        PRIMARY KEY (pedido_id, producto_id),
        FOREIGN KEY (pedido_id) REFERENCES pedidos(id) ON DELETE CASCADE,
        FOREIGN KEY (producto_id) REFERENCES productos(id)
    );
    ```

    **📋 Datos a introducir**

    A continuación, se proporcionan los datos de referencia que debes insertar en la base de datos utilizando comandos DML a lo largo de las siguientes actividades.

    **Tabla Proveedores**

    | id | nombre | ciudad | activo |
    | :--- | :--- | :--- | :--- |
    | 1 | ElectroComponentes | Madrid | TRUE |
    | 2 | InforGlobal | Barcelona | TRUE |
    | 3 | TechAsia | Valencia | FALSE |

    **Tabla Clientes**

    | id | nombre | email | saldo |
    | :--- | :--- | :--- | :--- |
    | 1 | Ana García | ana@email.com | 150.00 |
    | 2 | Luis Perez | luis@email.com | 0.00 |
    | 3 | Marta Lopez | marta@email.com | 20.50 |
    | 4 | Carlos Ruiz | carlos@email.com | 300.00 |

    **Tabla Productos**

    | id | nombre | precio | stock | proveedor_id | activo |
    | :--- | :--- | :--- | :--- | :--- | :--- |
    | 1 | Ratón Óptico X1 | 15.50 | 50 | 1 | TRUE |
    | 2 | Teclado Mecánico RGB | 45.00 | 20 | 1 | TRUE |
    | 3 | Monitor 24" IPS | 120.00 | 5 | 2 | TRUE |
    | 4 | Webcam HD | 35.00 | 0 | 2 | TRUE |
    | 5 | Pendrive 64GB | 12.00 | 100 | 3 | TRUE |

---

### 📥 1. Inserción de Datos (INSERT)

#### **AC601: Población inicial (INSERT básico y múltiple)**

??? "Actividad AC601"

    | Criterios de Evaluación | Ponderación |
    | ----------------------- | ----------- |
    | CE4b                    | 2p          |

    Vamos a insertar los datos iniciales propuestos en las tablas basándonos en los cuadros superiores.

    1. **Inserción de proveedores (Básica)**: Inserta primero el proveedor 1, indicando todos los campos explícitamente. A continuación, inserta el proveedor 2 omitiendo las columnas, asegurando el orden correcto. Finalmente, inserta al proveedor 3.
    2. **Inserción de clientes (Múltiple)**: Inserta a todos los clientes propuestos (del 1 al 4) en una **única sentencia `INSERT`**, aprovechando la inserción masiva.
    3. **Inserción de productos**: Inserta los 5 productos referenciados cuidando de que la clave foránea (`proveedor_id`) apunte a la ID correcta. Si en algún momento tienes dudas, omite la columna `id` para aprovechar el `AUTO_INCREMENT`.

#### **AC602: Inserciones avanzadas e IDs Auto-incrementales**

??? "Actividad AC602"

    | Criterios de Evaluación | Ponderación |
    | ----------------------- | ----------- |
    | CE4b                    | 1.5p        |

    1. **Inserte Ignorando Errores**: Intenta insertar de nuevo a la cliente 'Ana García' con el mismo email (`ana@email.com`). Utiliza la cláusula `IGNORE` para que la base de datos salte el error de unicidad (`UNIQUE`) silenciando el fallo sin interrumpir ningún script.
    2. **Actualizar al insertar (Upsert)**: El cliente 'Luis Perez' se vuelve a registrar con el correo `luis@email.com`. Realiza una inserción que incluya `ON DUPLICATE KEY UPDATE` de forma que, al detectar que el email ya existe, sencillamente le sume `5.00` a su `saldo` como regalo de retorno.
    3. **Inserción con sintaxis SET**: MySQL permite insertar mediante asignaciones precisas. Añade un nuevo producto utilizando la sintaxis `INSERT INTO productos SET ...`, poniéndolo como 'Auriculares Inalámbricos', precio 29.99, stock 15 y asociado al proveedor número 2.
    4. **Obtención de ID Autoincremental**: Un nuevo proveedor entra al sistema. Inserta al proveedor de nombre 'Componentes Sur' de la ciudad de 'Sevilla'. Inmediatamente después, diseña un `INSERT` para dar de alta el producto 'Cable HDMI 2M' (8.50€, 30 de stock) aprovechándote de la función `LAST_INSERT_ID()` para no tener que buscar manualmente la Primary Key del proveedor anterior.

---

### 🆙 2. Modificación de Datos (UPDATE)

#### **AC603: Modificaciones simples y con subconsultas**

??? "Actividad AC603"

    | Criterios de Evaluación | Ponderación |
    | ----------------------- | ----------- |
    | CE4c                    | 2p          |

    1. **Rebaja directa**: El 'Ratón Óptico X1' tiene poca rotación. Reduce su precio exacto a `12.50`.
    2. **Cálculos porcentuales**: La inflación nos obliga a ajustar nuestro catálogo. Aumenta un `5%` todos los precios de los productos cuyo precio actual sea inferior a 50€.
    3. **Modificación de múltiples columnas**: El proveedor 'InforGlobal' se traslada de ciudad y cambia de razón social. Cambia en una misma sentencia su nombre a 'GlobalTech SA' y su ciudad a 'Tarragona'.
    4. **Incentivo de saldos**: Adelántate a la campaña de verano otorgando un bono adicional sumando el `10%` de saldo a los clientes que tengan actualmente **más de 100€** en el monedero de la tienda.
    5. **Actualización con Subconsulta**: Sube un `15%` el precio de todos los productos suministrados por el proveedor de nombre 'ElectroComponentes'. ¡Ojo! No sabes su `id` y está prohibido usar JOIN. Utiliza una **subconsulta** en la cláusula `WHERE` para obtener dinámicamente el `id` a partir de su nombre.

#### **AC604: Borrados Lógicos y Prevención**

??? "Actividad AC604"

    | Criterios de Evaluación | Ponderación |
    | ----------------------- | ----------- |
    | CE4c                    | 1p          |

    Recordemos que los borrados directos pueden causar inconsistencias futuras. Practiquemos el borrado lógico.

    1. **Descatalogar producto por email de proveedor**: La 'Webcam HD' está dando fallos. Realiza un "borrado lógico" marcando el producto como inactivo (`activo = FALSE`) sirviéndote de una subconsulta que busque aquellos productos cuyo proveedor esté en la ciudad de 'Tarragona' (recuerda que actualizamos a InforGlobal en la actividad anterior).
    2. **Sanción directa**: El proveedor 'ElectroComponentes' está retrasando sus pedidos. Cambia su estado a `activo = FALSE` temporalmente (búscalo por su ID).

---

### 🗑️ 3. Borrado Físico (DELETE)

#### **AC605: Eliminación física**

??? "Actividad AC605"

    | Criterios de Evaluación | Ponderación |
    | ----------------------- | ----------- |
    | CE4d                    | 1.5p        |

    A veces, la Ley de Protección de Datos (GDPR) nos obliga a purgar registros completamente u ocurren errores de captura de datos falsos.

    1. **Purgado definitivo**: El cliente 'Marta Lopez' jamás ha comprado nada y quiere darse de baja definita de nuestra BD. Realiza un borrado físico y definitivo de su registro usando la instrucción adecuada. *(Comprueba luego con `SELECT` que ha desaparecido).*
    2. **Eliminación masiva condicional**: Borra permanentemente de una sola vez a todos los clientes cuyo `email` termine en la cadena `'@test.com'` (usando el operador `LIKE`).
    3. **Borrado Físico usando Subconsultas**: Elimina físicamente todos los productos cuyo proveedor original sea de la ciudad de 'Valencia' (TechAsia).  Debes utilizar una *subconsulta* referenciando a la tabla proveedores (`WHERE proveedor_id IN (SELECT ...)`).

---

### 🚀 4. Operaciones Multi-tabla (JOIN)

#### **AC606: Modificaciones Relacionales**

??? "Actividad AC606"

    | Criterios de Evaluación | Ponderación |
    | ----------------------- | ----------- |
    | CE4e                    | 2.5p        |

    1. **Actualización Relacional (UPDATE JOIN)**: Aprovechando un subsidio de exportación para la capital, rebaja un **10%** el precio de todos los productos suministrados por proveedores ubicados en la ciudad de 'Madrid'.
    2. **Repercusión en la cadena (UPDATE JOIN)**: Como nuestro proveedor número 3 ('TechAsia') cesó su actividad, marcamos su registro como inactivo. Ahora debemos reflejar esto en su catálogo. Actualiza el campo `activo` a falso únicamente en los `productos` que pertenezcan a proveedores inactivos (`activo = FALSE`), realizando un `UPDATE` que combine las dos tablas (JOIN).
    3. **Eliminación Relacional (DELETE JOIN)**: Haz una limpieza exhaustiva del almacén local. Realiza un **borrado físico y absoluto** (DELETE) combinando las tablas correspondientes (JOIN) para eliminar los `productos` de aquellos proveedores situados en 'Barcelona' que tengan, además, exactamente 0 de stock.

---

### 🛡️ 5. Transacciones e Integridad

#### **AC607: El Procesamiento Atómico de un Pedido**

??? "Actividad AC607"

    | Criterios de Evaluación | Ponderación |
    | ----------------------- | ----------- |
    | CE4f                    | 2p          |

    Es vital que el dinero se reste del monedero, el stock se descuente y quede registrado el ticket de manera atómica.

    Vamos a simular que el cliente **1 (Ana García)** quiere realizar un pedido de 2 unidades del producto **2 (Teclado Mecánico RGB)** (asumimos precio 45.00€). Sigue rigurosamente estos pasos construidos por ti mismo:

    1. **Comienzo**: Inicia una transacción explícita.
    2. **Paso 1 (Creación de Cabecera)**: Inserta un registro en `pedidos` para el cliente ID 1 con `estado = 'CONFIRMADO'` y sumándole el total (`90.00`).
    3. **Paso 2 (Línea de Pedido Dinámica)**: Usando la función `LAST_INSERT_ID()` para referenciar a la ID del pedido que acabas de generar, inserta una línea en `detalle_pedido` relacionándolo al producto 2, con `cantidad=2` y `precio_unitario=45.00`.
    4. **Paso 3 (Descuento Monetario)**: Realiza un `UPDATE` en clientes descontando `90.00` al saldo del cliente 1.
    5. **Paso 4 (Reducción Inventario)**: Realiza un `UPDATE` restando 2 al `stock` del producto 2.
    6. **Punto de Control de Respaldo**: Crea temporalmente un punto de guardado mediante `SAVEPOINT punto_verificacion;`.
    7. **Simulador de sabotaje**: Falla la integridad en una hipotética segunda línea del carrito: intenta insertar una nueva línea dentro de detalle con un `#producto=99` (uno que no existe). Esto generará un error de clave foránea.
    8. **Recuperación y Confirmación**: Emite el comando de `ROLLBACK TO SAVEPOINT punto_verificacion;` para volver al momento exacto previo al fallo y, finalmente, ejecuta `COMMIT;` para consolidar toda la compra maestra sin estropear el resto de los datos de Ana. 
