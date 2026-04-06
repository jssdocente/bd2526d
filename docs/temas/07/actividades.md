# Actividades de la unidad 7

### 🔑 1. Seguridad y DCL

#### **AC700: Seguridad y Hashing de contraseñas**

??? "Actividad AC700"

    | Criterios de Evaluación | Ponderación |
    | ----------------------- | ----------- |
    | CE4h                    | 1p          |

    Para reforzar el concepto de seguridad en el almacenamiento de credenciales, realiza las siguientes tareas:

    1. **Tabla de Seguridad**: Crea una tabla llamada `usuarios_gestion` con las columnas `id`, `username`, `password_hash` y `salt`.
    2. **Generación de Credenciales**: Inserta un usuario llamado `alumno01` cuya contraseña sea `estudiante123`. Para ello:
        * Genera un `salt` aleatorio de 16 caracteres usando `MD5(RAND())`.
        * Almacena el hash de la contraseña concatenada con el salt usando `SHA2(..., 256)`.
    3. **Verificación**: Realiza una consulta `SELECT` que simule un inicio de sesión, comprobando que el hash generado a partir de una contraseña introducida coincide con el almacenado.

---

#### **AC701: Gestión de usuarios en MariaDB**

??? "Actividad AC701"

    | Criterios de Evaluación | Ponderación |
    | ----------------------- | ----------- |
    | CE2g, CE2h              | 2p          |

    Sobre la instalación de MariaDB que utilizas normalmente, realiza las siguientes operaciones, indicando los comandos necesarios y adjuntando capturas de pantalla de los resultados obtenidos:

    1. Comprueba los usuarios existentes en nuestro SGBD.
    2. Crea un usuario `ac701local` con contraseña `123456` que sólo pueda conectarse desde `localhost`. Comprueba que puedes acceder con el nuevo usuario.
    3. Crea un usuario `ac701remoto` con contraseña `123456` que pueda conectarse desde cualquier lugar. Comprueba que puedes acceder con el nuevo usuario.
    4. Modifica la contraseña del usuario `ac701remoto` para que sea `severo`. Comprueba que puedes acceder con la nueva contraseña.
    5. Vuelve a comprobar los usuarios existentes en nuestro SGBD.
    6. Elimina el usuario `ac701remoto`.

---

#### **AC702: Gestión de privilegios y permisos**

??? "Actividad AC702"

    | Criterios de Evaluación | Ponderación |
    | ----------------------- | ----------- |
    | CE2g, CE2h              | 2p          |

    Sobre la instalación de MariaDB que utilizas normalmente, realiza las siguientes operaciones, indicando los comandos necesarios y adjuntando capturas de pantalla de los resultados obtenidos:

    1. Comprueba los permisos del usuario `user01` (creado si has seguido los apuntes de la unidad 7).
    2. Sobre el usuario `ac701local`:
        * Comprueba sus permisos.
        * Asigna los permisos necesarios para que sólo pueda acceder a la tabla `productos` de la base de datos `techstore`, pudiendo hacer consultas, inserciones y borrados, pero no modificaciones sobre los datos.
        * Comprueba de nuevo los permisos.
    3. Entra al sistema como el usuario `ac701local`, y realiza las siguientes operaciones sobre la tabla `productos`:
        * Insertar un nuevo producto técnico.
        * Intenta modificar el precio del producto (debería fallar).
        * Elimina el producto insertado.
    4. Crea un nuevo usuario `ac702lectura` con contraseña `123456` que únicamente pueda consultar todas las tablas de la base de datos `techstore`.
    5. Crea un nuevo usuario `ac703todo` con contraseña `123456` pueda hacer de todo en el sistema, a modo de administrador del sistema.
    6. Entra al sistema como el usuario `ac703todo`, y elimina los usuarios `ac701local` y `ac702lectura`.
    7. Recupera los usuarios existentes en el sistema.

---

### 🗳️ 2. Transacciones y TCL

#### **AC704: Lógica transaccional**

??? "Actividad AC704"

    | Criterios de Evaluación | Ponderación |
    | ----------------------- | ----------- |
    | CE4e, CE4f              | 3p          |

    A partir del siguiente fragmento de código que realiza transacciones, se pide contestar a las preguntas que aparecen como comentarios dentro del código:

    ```sql
    CREATE TABLE cuentas (
        id INTEGER UNSIGNED PRIMARY KEY,
        saldo DECIMAL(11,2) CHECK (saldo >= 0)
    );

    INSERT INTO cuentas VALUES (1, 1000);
    INSERT INTO cuentas VALUES (2, 2000);
    INSERT INTO cuentas VALUES (3, 0);

    START TRANSACTION;
    UPDATE cuentas SET saldo = saldo - 100 WHERE id = 1;
    UPDATE cuentas SET saldo = saldo + 100 WHERE id = 2;
    COMMIT;
    -- ¿Qué contiene cuentas en este momento?

    START TRANSACTION;
    UPDATE cuentas SET saldo = saldo - 100 WHERE id = 9999;
    UPDATE cuentas SET saldo = saldo + 100 WHERE id = 2;
    COMMIT;
    -- ¿Qué sucede cuando una cuenta no existe? ¿Se ha modificado el saldo de la cuenta 2?

    START TRANSACTION;
    UPDATE cuentas SET saldo = saldo + 100 WHERE id = 2;
    UPDATE cuentas SET saldo = saldo - 100 WHERE id = 3;
    COMMIT;
    -- ¿Y si una cuenta no tiene saldo? ¿Se han modificado ambos saldos?
    ```

    A continuación, indica las sentencias SQL necesarias para realizar las siguientes tareas dentro de una única operación:
    * Inserta una nueva cuenta, la 4, con un saldo de 400€.
    * Inserta la cuenta 5 con un saldo de 500€.
    * Modifica la cuenta 3 para que su saldo sea 300€.

    Y en otra operación:
    * Inserta la cuenta 6 con un saldo de 600€.
    * Modifica las cuentas 4 y 5 y quítales 200€ (en una única operación).
    * Deshaz las dos últimas operaciones.

---

#### **AC705: El Procesamiento Atómico de un Pedido**

??? "Actividad AC705"

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

---

### 🔒 3. Concurrencia y Bloqueos

#### **AC707: Bloqueos y concurrencia**

??? "Actividad AC707"

    | Criterios de Evaluación | Ponderación |
    | ----------------------- | ----------- |
    | CE4e, CE4f, CE4g, CE4h  | 3p          |

    Abre dos sesiones contra el SGBD con dos usuarios distintos (por ejemplo, `user01` y `root`) en dos terminales. Con uno de ellos, ejecuta las siguientes sentencias:

    ```sql
    CREATE OR REPLACE TABLE departamento (
        id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
        nombre VARCHAR(100) NOT NULL,
        jefe VARCHAR(100)
    );
    INSERT INTO departamento (id, nombre, jefe) VALUES (1, 'Contabilidad', "J1");
    INSERT INTO departamento (id, nombre, jefe) VALUES (2, 'Marketing', "J1");
    INSERT INTO departamento (id, nombre, jefe) VALUES (3, 'I+D', "J2");
    ```

    Inserta el departamento `4` con tu nombre y `J3` como tu jefe. A continuación, anota las sentencias necesarias para cada caso y adjunta capturas de pantalla de cada uno de los terminales de los usuarios:

    1. Con el usuario indicado, realiza las siguientes tareas y contesta a las preguntas que se plantean:

        | Usuario 1 | Usuario 2 | Pregunta |
        | --- | --- | --- |
        | Comienza una transacción. Consulta la tabla `departamento`. |  | ¿Qué datos aparecen y por qué? |
        | Modifica el jefe de _Marketing_ para que sea `J2`. |  |  |
        |  | Consulta la tabla `departamento`. | ¿Qué datos aparecen y por qué? |
        |  | Elimina el departamento de _Marketing_. | ¿Qué sucede? |

    2. ¿Qué cambiaría si hubiéramos bloqueado la tabla con accesos de lectura?
        
        | Usuario 1 | Usuario 2 | Pregunta |
        | --- | --- | --- |
        | Comienza una transacción. Bloquea la tabla `departamento` para permitir sólo accesos de lectura. Consulta la tabla utilizando el bloqueo. |  | ¿Qué datos aparecen y por qué? |
        | Modifica el jefe de _Marketing_ para que sea `J2` (utilizando el bloqueo). |  | ¿Qué sucede? |
        |  | Consulta la tabla `departamento`. | ¿Qué sucede? |
        | Desbloquea la tabla `departamento`. |  |  |

    3. ¿Y si la bloqueamos para accesos de escritura?
        
        | Usuario 1 | Usuario 2 | Pregunta |
        | --- | --- | --- |
        | Comienza una transacción. Bloquea la tabla `departamento` para permitir sólo accesos de escritura. Consulta la tabla utilizando el bloqueo. |  | ¿Qué datos aparecen y por qué? |
        | Modifica el jefe de _Marketing_ para que sea `J2` (utilizando el bloqueo). |  | ¿Qué sucede? |
        |  | Consulta la tabla `departamento`. | ¿Qué sucede? |
        | Desbloquea la tabla `departamento`. |  |  |

---

#### **AC708: Problemas de concurrencia**

??? "Actividad AC708"

    | Criterios de Evaluación | Ponderación |
    | ----------------------- | ----------- |
    | CE4e, CE4f, CE4g, CE4h  | 3p          |

    Abre dos sesiones contra el SGBD en dos terminales. Con uno de ellos, ejecuta las siguientes sentencias:

    ```sql
    CREATE TABLE persona (
        id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
        nombre VARCHAR(100) NOT NULL
    );
    INSERT INTO persona (id, nombre) VALUES (1, 'Andreu');
    INSERT INTO persona (id, nombre) VALUES (2, 'Marina');
    ```

    Inserta la persona con el id `3` y tu nombre. Realiza las siguientes tareas y contesta a las preguntas:

    | Usuario 1 | Usuario 2 | Pregunta |
    | --- | --- | --- |
    | Comienza una transacción |  |  |
    | Modifica el nombre de `Andreu` por `Andreu 4K`. Consulta la tabla `persona`. | Consulta la tabla `persona`. | ¿Qué datos aparecen y por qué? |
    |  | Cambia el nivel de aislamiento a _Lectura no confirmada_ (solo para la siguiente transacción). | |
    |  | Comienza una transacción. Consulta la tabla `persona`. | ¿Qué datos aparecen y por qué? |
    | Anula la sentencia realizada. |  | |
    | Consulta la tabla `persona`. | Consulta la tabla `persona`. | ¿Qué datos aparecen y por qué? |

    1. ¿Qué tipo de problema de acceso concurrente a los datos se ha producido con el _Usuario 2_ al realizar la primera consulta?
    2. ¿Cómo se podría solucionar? Ejecuta otra vez las sentencias anteriores solucionando el problema.

---

#### **AP710: Niveles de aislamiento**

??? "Actividad AP710"

    | Criterios de Evaluación | Ponderación |
    | ----------------------- | ----------- |
    | CE4e, CE4f, CE4g, CE4h  | 3p          |

    Abre dos sesiones en dos terminales. Con uno de ellos, ejecuta las siguientes sentencias:

    ```sql
    CREATE OR REPLACE TABLE departamento (
        id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
        nombre VARCHAR(100) NOT NULL,
        jefe VARCHAR(100)
    );
    INSERT INTO departamento (id, nombre, jefe) VALUES (1, 'Contabilidad', "J1");
    INSERT INTO departamento (id, nombre, jefe) VALUES (2, 'Marketing', "J1");
    INSERT INTO departamento (id, nombre, jefe) VALUES (3, 'I+D', "J2");
    ```

    Realiza las siguientes tareas y contesta:

    | Usuario 1 | Usuario 2 | Pregunta |
    | --- | --- | --- |
    | Comprueba el nivel de aislamiento. | Comprueba el nivel de aislamiento. |  |
    | Si no es _Lectura repetible_, cambiarlo. | Si no es _Lectura repetible_, cambiarlo. |  |
    | Comienza una transacción. |  |  |
    | Modifica el jefe de `Contabilidad` a `J3`. No confirma los datos. Consulta la tabla. |  |  |
    |  | Comienza una transacción. Consulta la tabla. | ¿Ve el cambio realizado por el usuario 1? ¿Por qué? |
    |  | Modifica el jefe de `Marketing` a `J4`. No confirma los datos. | ¿Ha podido realizar el cambio? ¿Por qué? |
    |  | Modifica el jefe de `Contabilidad` a `J5`. No confirma los datos. | ¿Ha podido realizar el cambio? ¿Por qué? |
    |  | Cierra la sesión y vuelve a entrar. Consulta la tabla. | ¿Qué ocurre con los cambios realizados por el usuario 2? ¿Por qué? |

---

#### **PR711: Proyecto Final de Unidad**

??? "Actividad PR711"

    | Criterios de Evaluación                   | Ponderación |
    | ----------------------------------------- | ----------- |
    | CE2g, CE2h, CE4e, CE4f, CE4g, CE4h        | 6p          |

    Dado el siguiente DDL sobre un sistema bancario:

    ```sql
    CREATE DATABASE banco;
    USE banco;
    CREATE TABLE clientes (
        id INT PRIMARY KEY AUTO_INCREMENT,
        nombre VARCHAR(100),
        dni VARCHAR(9) UNIQUE
    );
    CREATE TABLE cuentas (
        id INT PRIMARY KEY AUTO_INCREMENT,
        cliente_id INT,
        iban VARCHAR(24) UNIQUE,
        saldo DECIMAL(12,2) CHECK (saldo >= 0),
        tipo ENUM('corriente','ahorro'),
        FOREIGN KEY (cliente_id) REFERENCES clientes(id)
    );
    CREATE TABLE movimientos (
        id INT PRIMARY KEY AUTO_INCREMENT,
        cuenta_origen INT,
        cuenta_destino INT,
        importe DECIMAL(12,2),
        fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        estado ENUM('pendiente','completado','anulado') DEFAULT 'pendiente'
    );
    ```

    Realiza las siguientes tareas:

    1. **Gestión de roles**: Crea los usuarios `cajero`, `gestor` y `auditor` con sus correspondientes permisos. Crea un rol `empleado_basico` y asígnalo a `cajero`.
    2. **Prueba de seguridad**: Conéctate como `cajero` e intenta borrar un cliente. Justifica el resultado.
    3. **Transferencia Avanzada**: Implementa una transferencia de 500€ usando transacciones y `SAVEPOINT` (`sp_movimiento`, `sp_resta`).
    4. **Simulación de Errores**: Provoca un fallo por saldo insuficiente y demuestra que el `SAVEPOINT` funciona correctamente.
    5. **Concurrencia**: Abre dos sesiones. El Usuario 1 inicia una transferencia (sin COMMIT). El Usuario 2 intenta otra sobre la misma cuenta. Documenta el error de *timeout*.
    6. **Bloqueo Explícito**: Repite el apartado anterior usando `SELECT ... FOR UPDATE`. ¿Qué diferencia observas?
