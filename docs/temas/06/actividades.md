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

---

### 🆙 2. Modificación de Datos (UPDATE)

#### **AC602: Modificaciones simples y con subconsultas**

??? "Actividad AC602"

    | Criterios de Evaluación | Ponderación |
    | ----------------------- | ----------- |
    | CE4c                    | 2p          |

    1. **Rebaja directa**: El 'Ratón Óptico X1' tiene poca rotación. Reduce su precio exacto a `12.50`.
    2. **Cálculos porcentuales**: La inflación nos obliga a ajustar nuestro catálogo. Aumenta un `5%` todos los precios de los productos cuyo precio actual sea inferior a 50€.
    3. **Modificación de múltiples columnas**: El proveedor 'InforGlobal' se traslada de ciudad y cambia de razón social. Cambia en una misma sentencia su nombre a 'GlobalTech SA' y su ciudad a 'Tarragona'.
    4. **Incentivo de saldos**: Adelántate a la campaña de verano otorgando un bono adicional sumando el `10%` de saldo a los clientes que tengan actualmente **más de 100€** en el monedero de la tienda.
    5. **Actualización con Subconsulta**: Sube un `15%` el precio de todos los productos suministrados por el proveedor de nombre 'ElectroComponentes'. ¡Ojo! No sabes su `id` y está prohibido usar JOIN. Utiliza una **subconsulta** en la cláusula `WHERE` para obtener dinámicamente el `id` a partir de su nombre.

#### **AC603: Borrados Lógicos y Prevención**

??? "Actividad AC603"

    | Criterios de Evaluación | Ponderación |
    | ----------------------- | ----------- |
    | CE4c                    | 1p          |

    Recordemos que los borrados directos pueden causar inconsistencias futuras. Practiquemos el borrado lógico.

    1. **Descatalogar producto por email de proveedor**: La 'Webcam HD' está dando fallos. Realiza un "borrado lógico" marcando el producto como inactivo (`activo = FALSE`) sirviéndote de una subconsulta que busque aquellos productos cuyo proveedor esté en la ciudad de 'Tarragona' (recuerda que actualizamos a InforGlobal en la actividad anterior).
    2. **Sanción directa**: El proveedor 'ElectroComponentes' está retrasando sus pedidos. Cambia su estado a `activo = FALSE` temporalmente (búscalo por su ID).

---

### 🗑️ 3. Borrado Físico (DELETE)

#### **AC604: Eliminación física**

??? "Actividad AC604"

    | Criterios de Evaluación | Ponderación |
    | ----------------------- | ----------- |
    | CE4d                    | 1.5p        |

    A veces, la Ley de Protección de Datos (GDPR) nos obliga a purgar registros completamente u ocurren errores de captura de datos falsos.

    1. **Purgado definitivo**: El cliente 'Marta Lopez' jamás ha comprado nada y quiere darse de baja definita de nuestra BD. Realiza un borrado físico y definitivo de su registro usando la instrucción adecuada. *(Comprueba luego con `SELECT` que ha desaparecido).*
    2. **Eliminación masiva condicional**: Borra permanentemente de una sola vez a todos los clientes cuyo `email` termine en la cadena `'@test.com'` (usando el operador `LIKE`).
    3. **Borrado Físico usando Subconsultas**: Elimina físicamente todos los productos cuyo proveedor original sea de la ciudad de 'Valencia' (TechAsia).  Debes utilizar una *subconsulta* referenciando a la tabla proveedores (`WHERE proveedor_id IN (SELECT ...)`).

#### **AC605: Integridad Referencial en Borrados (CASCADE, SET NULL y RESTRICT)**

??? "Actividad AC605"

    | Criterios de Evaluación | Ponderación |
    | ----------------------- | ----------- |
    | CE4d                    | 1.5p        |

    La integridad referencial define cómo se comporta la base de datos cuando intentamos borrar registros que tienen dependencias.

    1. **Bloqueo por Restricción (RESTRICT/NO ACTION)**: Intenta borrar físicamente al cliente 'Ana García' (ID 1). *Nota: Solo fallará si Ana ya tiene pedidos asociados. Si no tienes pedidos, inserta uno de prueba primero para observar el error de restricción.*
    2. **Efecto Cascada (CASCADE)**: Inserta un pedido de prueba y una línea en `detalle_pedido`. A continuación, borra el pedido. Verifica si las líneas de detalle asociadas desaparecen automáticamente. ¿Qué ventaja tiene esto frente al borrado manual de cada línea?
    3. **Anulación por Referencia (SET NULL)**: Crea un proveedor temporal llamado 'Proveedor Test' y un producto asociado a él. Borra el proveedor y observa el `proveedor_id` del producto. ¿En qué situaciones es mejor `SET NULL` que `CASCADE`?

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


