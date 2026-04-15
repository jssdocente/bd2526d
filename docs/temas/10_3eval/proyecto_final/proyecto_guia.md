# 🏨 Proyecto de Muestra: Sistema de Gestión "Hotel Gran Horizonte"

Este documento es una guía completa de cómo debe estructurarse y presentarse el proyecto final de la 3ª Evaluación. Sigue cada fase para entender no solo el *qué*, sino el *porqué* de cada decisión.

---

## **FASE 1: Análisis de Requisitos (Reuniones con el Cliente)**

### <u>Sesión 1: Conceptos Básicos y "El Caos"</u>
**Notas de la reunión:** El dueño del hotel nos explica que actualmente gestiona las reservas en un Excel. A veces, dos recepcionistas reservan la misma habitación para la misma fecha (overbooking). Necesita que cada **Habitación** tenga un número único y un **Tipo** (Suite, Doble, Individual) con un precio base.

**Pensamiento de Diseño:** 
- *Decisión*: No podemos poner el precio directamente en la habitación, porque si cambia el precio de todas las "Suites", tendríamos que editar una por una. Crearemos una tabla de "Categorías" para que, al cambiar el precio ahí, todas las habitaciones de ese tipo se actualicen automáticamente.
- *Restricción*: El número de habitación debe ser la "Llave Primaria" para que sea imposible que se repita.

### <u>Sesión 2: Clientes y Estancias</u>
**Notas de la reunión:** Los **Clientes** nos dan su DNI y email. Queremos saber si un cliente es VIP o habitual. Cuando un cliente llega, se crea una **Estancia**. Una estancia tiene una fecha de entrada y una de salida. Un cliente puede venir muchas veces al año.

**Pensamiento de Diseño:** 
- *Organización*: Si pusiéramos el nombre del cliente dentro de la tabla de Estancias, y el cliente vuelve 10 veces, tendríamos su nombre escrito 10 veces (ocupando espacio y arriesgándonos a errores al escribir). Separamos "Clientes" de "Estancias" y los unimos mediante el DNI. Así, si el cliente cambia de móvil, solo lo editamos en un sitio.

### <u>Sesión 3: Servicios y Facturación</u>
**Notas de la reunión:** En el hotel hay **Servicios** (Spa, Parking, Minibar). El cliente quiere que se vayan cargando consumos a su habitación y que al final se pague todo junto.

### <u>Sesión 4: Fidelización y Operativa (Aportación Extra del Alumno)</u>
*(Esta sesión ha sido simulada por el alumno para cubrir el requisito de funcionalidades extra)*

**Notas de la reunión:** "Me gustaría que el sistema fuera inteligente. Si un cliente viene mucho, que el sistema lo marque como VIP automáticamente. También tengo un problema con la limpieza: cuando alguien deja la habitación, a veces el personal de limpieza no se entera. Quiero que el sistema genere una lista de tareas de limpieza en el momento del Check-out."

**Pensamiento de Diseño:** 

- *Fidelización*: Crearemos un proceso automático que analice el historial. No es algo que el recepcionista deba hacer a mano, sino que la base de datos se encargará.
- *Gestión de Limpieza*: Necesitaremos una tabla de **Tareas** y un cursor que las genere para que el equipo de mantenimiento tenga su hoja de ruta diaria.

---

## **FASE 2: Diseño Conceptual (Diagrama E/R)**
*(En esta fase, el alumno dibujaría las entidades incluyendo la nueva tabla de Tareas y la relación de fidelidad)*

!!! warning "Diagrama E/R: ¿Qué debemos incluir?"

    En esta fase, el alumno debe representar los conceptos discutidos en las reuniones. Puntos a destacar en este ejemplo:

    - **Entidad Categoría**: Separada de Habitaciones para que el precio no dependa de cada cuarto individual, sino del tipo de servicio.
    - **Relación Estancia-Consumo**: Una estancia puede acumular muchos cargos (1:N).
    - **Entidad Tareas de Personal (Extra)**: Vinculada a Habitaciones para coordinar el trabajo tras el check-out solicitado por el cliente.
    - **Atributos Clave**: Identificar claramente qué campos no se pueden repetir (DNI, Número de Habitación, Email).


---

## **FASE 3: Diseño Lógico (Modelo de Tablas)**

Modelo lógico realizado en lenguaje [DBML](https://dbdiagram.io/).

??? info "Modelo de Tablas"
    ```dbml
    // Código para dbdiagram.io (Versión Completa)

    Table Clientes {
    dni varchar [pk]
    nombre varchar
    email varchar [unique]
    tipo_cliente enum // 'Estandar', 'VIP', 'Suspendido'
    }

    Table Categorias {
    id int [pk, increment]
    nombre varchar
    precio_base decimal
    }

    Table Habitaciones {
    numero int [pk]
    categoria_id int
    estado enum // 'Libre', 'Ocupada', 'Mantenimiento', 'Limpieza'
    }

    Table Estancias {
    id int [pk, increment]
    cliente_dni varchar
    habitacion_numero int
    fecha_entrada date
    fecha_salida date
    estado_pago boolean
    }

    Table Servicios {
    id int [pk, increment]
    descripcion varchar
    precio_fijo decimal
    }

    Table Consumos {
    id int [pk, increment]
    estancia_id int
    servicio_id int
    cantidad int
    fecha datetime
    }

    Table Tareas_Personal {
    id int [pk, increment]
    habitacion_numero int
    tarea varchar
    fecha date
    estado enum // 'Pendiente', 'Terminada'
    }

    Table Auditoria_Precios {
    id int [pk, increment]
    categoria_id int
    precio_viejo decimal
    precio_nuevo decimal
    usuario varchar
    fecha_cambio datetime
    accion varchar
    }
    ```
!!! warning "Transformación al Modelo Lógico"
    Aquí explicamos cómo convertimos los dibujos (E/R) en tablas reales:

    1.  **De Entidad a Tabla**: Cada "caja" del diagrama se convierte en una tabla con sus columnas.
    2.  **Gestión de Relaciones**: Las líneas que unían entidades se transforman en **Claves Foráneas (FK)**. Por ejemplo, en `Estancias` guardamos el `cliente_dni` para saber de quién es la reserva.
    3.  **Eliminado de Repeticiones**: En lugar de escribir "Suite" y "200€" en cada habitación, usamos el `categoria_id`. Así, si el hotel sube precios, solo editamos la tabla `Categorias`.
    4.  **Tipos de Datos**: En esta fase definimos si un campo es un número, una fecha o un texto (`varchar`).


    
---

## **FASE 4: Implementación (Lógica Procedimental MySQL)**

### A. Funciones Auxiliares (Modularidad y Reutilización)
Estas funciones realizan cálculos base sin modificar datos, permitiendo que otros procesos las reutilicen cómodamente.

```sql
DELIMITER //

-- Función: Suma el importe total de servicios consumidos en una estancia
CREATE FUNCTION fn_sumar_consumos(p_estancia_id INT) 
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE v_suma DECIMAL(10,2);
    SELECT SUM(c.cantidad * s.precio_fijo) INTO v_suma
    FROM Consumos c
    JOIN Servicios s ON s.id = c.servicio_id
    WHERE c.estancia_id = p_estancia_id;
    RETURN IFNULL(v_suma, 0); -- Si no hay consumos, devolvemos 0
END //

-- Función: Cálculo de IVA (Modularidad)
CREATE FUNCTION fn_aplicar_iva(p_base DECIMAL(10,2)) 
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    RETURN p_base * 1.21; -- Aplicamos el 21% de IVA
END //

DELIMITER ;
```

### B. Gestión CRUD Completa (Ejemplo: Clientes)
Se deben implementar procedimientos para gestionar todas las tablas del sistema.

```sql
DELIMITER //

-- ALTA: Con validación de existencia previa
CREATE PROCEDURE sp_cliente_crear(IN p_dni VARCHAR(9), IN p_nom VARCHAR(50), IN p_mail VARCHAR(50))
BEGIN
    IF EXISTS (SELECT 1 FROM Clientes WHERE dni = p_dni) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: El DNI ya está registrado';
    END IF;
    INSERT INTO Clientes (dni, nombre, email, tipo_cliente) VALUES (p_dni, p_nom, p_mail, 'Estandar');
END //

-- ACTUALIZACIÓN: Modificar datos de contacto
CREATE PROCEDURE sp_cliente_actualizar(IN p_dni VARCHAR(9), IN p_nuevo_nom VARCHAR(50), IN p_nuevo_mail VARCHAR(50))
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Clientes WHERE dni = p_dni) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Cliente no encontrado';
    END IF;
    UPDATE Clientes SET nombre = p_nuevo_nom, email = p_nuevo_mail WHERE dni = p_dni;
END //

-- CONSULTA: Obtener datos de un cliente
CREATE PROCEDURE sp_cliente_consultar(IN p_dni VARCHAR(9))
BEGIN
    SELECT * FROM Clientes WHERE dni = p_dni;
END //

-- BAJA FÍSICA (GDPR: Derecho al olvido)
CREATE PROCEDURE sp_cliente_eliminar_permanente(IN p_dni VARCHAR(9))
BEGIN
    START TRANSACTION;
        -- Borrado de rastro en cascada manual para asegurar integridad
        DELETE FROM Consumos WHERE estancia_id IN (SELECT id FROM Estancias WHERE cliente_dni = p_dni);
        DELETE FROM Estancias WHERE cliente_dni = p_dni;
        DELETE FROM Clientes WHERE dni = p_dni;
    COMMIT;
END //

DELIMITER ;
```

### C. Automatización y Auditoría (Disparadores)

#### 1. Auditoría de Precios (Tablas de Histórico)
```sql
CREATE TRIGGER tr_audit_precios_habitacion
AFTER UPDATE ON Categorias
FOR EACH ROW
BEGIN
    IF OLD.precio_base <> NEW.precio_base THEN
        INSERT INTO Auditoria_Precios (categoria_id, p_viejo, p_nuevo, usuario, fecha, accion)
        VALUES (OLD.id, OLD.precio_base, NEW.precio_base, USER(), NOW(), 'ACTUALIZACIÓN');
    END IF;
END;
```

#### 2. Validación de Estado (Reglas de Negocio)
```sql
CREATE TRIGGER tr_validar_habitacion_disponible
BEFORE INSERT ON Estancias
FOR EACH ROW
BEGIN
    IF (SELECT estado FROM Habitaciones WHERE numero = NEW.habitacion_numero) NOT IN ('Libre') THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La habitación no está disponible para reserva.';
    END IF;
END;
```

### D. Operaciones Complejas y Flujo de Negocio

#### 1. La Transacción Maestra: Check-out (Integración Natural)
```sql
DELIMITER //
CREATE PROCEDURE sp_realizar_checkout(IN p_estancia_id INT)
BEGIN
    DECLARE v_total_servicios, v_precio_noche, v_total_neto DECIMAL(10,2);
    DECLARE v_noches, v_hab_num INT;
    DECLARE v_log_id BIGINT DEFAULT NULL; -- Variable para depuración

    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
        GET DIAGNOSTICS CONDITION 1 @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
        CALL write_log(v_log_id, CONCAT('ERROR CRÍTICO: ', @p2));
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Fallo crítico en facturación.';
    END;

    START TRANSACTION;
        CALL write_log(v_log_id, CONCAT('Iniciando Check-out para Estancia: ', p_estancia_id));

        SELECT habitacion_numero, DATEDIFF(fecha_salida, fecha_entrada) 
        INTO v_hab_num, v_noches FROM Estancias WHERE id = p_estancia_id;

        CALL write_log(v_log_id, CONCAT('Habitación detectada: ', v_hab_num));

        SET v_total_servicios = fn_sumar_consumos(p_estancia_id);
        CALL write_log(v_log_id, CONCAT('Total servicios calculados: ', v_total_servicios));
        
        SELECT c.precio_base INTO v_precio_noche FROM Categorias c 
        JOIN Habitaciones h ON h.categoria_id = c.id WHERE h.numero = v_hab_num;

        SET v_total_neto = fn_aplicar_iva(v_total_servicios + (v_noches * v_precio_noche));

        -- Cierre y cambio a estado 'Limpieza' (Requisito Extra)
        UPDATE Estancias SET estado_pago = TRUE WHERE id = p_estancia_id;
        UPDATE Habitaciones SET estado = 'Limpieza' WHERE numero = v_hab_num;
        
        CALL write_log(v_log_id, 'Check-out finalizado con éxito. Habitación en limpieza.');
    COMMIT;
END //
DELIMITER ;
```

#### 2. Funcionalidad Extra A: Sistema de Fidelización
**¿En qué consiste?** Para premiar a los clientes habituales, este proceso analiza el historial de estancias. Si un cliente ha completado 3 o más estancias pagadas, el sistema lo promociona a **VIP** automáticamente para aplicarle ventajas en el futuro.

```sql
DELIMITER //
CREATE PROCEDURE sp_extra_fidelizar_clientes()
BEGIN
    UPDATE Clientes SET tipo_cliente = 'VIP'
    WHERE dni IN (
        SELECT cliente_dni FROM Estancias WHERE estado_pago = TRUE 
        GROUP BY cliente_dni HAVING COUNT(*) >= 3
    );
END //
DELIMITER ;
```

#### 3. Funcionalidad Extra B: Gestión de Limpieza (Cursores)
**¿En qué consiste?** Tras un Check-out, la habitación queda en estado 'Limpieza'. Este procedimiento usa un **cursor** para recorrer todas esas habitaciones y generar automáticamente una orden de trabajo para el personal de mantenimiento.

```sql
DELIMITER //
CREATE PROCEDURE sp_extra_generar_tareas_limpieza()
BEGIN
    DECLARE v_done INT DEFAULT FALSE;
    DECLARE v_num_hab INT;
    DECLARE cur_l CURSOR FOR SELECT numero FROM Habitaciones WHERE estado = 'Limpieza';
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_done = TRUE;

    OPEN cur_l;
    
    -- Primer FETCH antes de entrar al bucle
    FETCH cur_l INTO v_num_hab;
    
    WHILE NOT v_done DO
        -- Insertamos la tarea de limpieza
        INSERT INTO Tareas_Personal (habitacion_numero, tarea, fecha, estado) 
        VALUES (v_num_hab, 'LIMPIEZA TRAS CHECKOUT', CURDATE(), 'Pendiente');
        
        -- FETCH al final del cuerpo para avanzar a la siguiente fila
        FETCH cur_l INTO v_num_hab;
    END WHILE;
    
    CLOSE cur_l;
END //
DELIMITER ;
```

---

## 🛠️ BONUS: Sistema de Depuración Profesional (Trazabilidad)

Dado que MySQL no permite depuración paso a paso en tiempo real, utilizaremos un **Sistema de Logging** para rastrear la lógica de nuestros procedimientos.

### 1. Infraestructura de Logs
Crea esta tabla y este procedimiento auxiliar **una sola vez** en tu base de datos:

```sql
-- Tabla para almacenar los mensajes de rastro
CREATE TABLE debug_log (
    id INT AUTO_INCREMENT PRIMARY KEY,
    log_id BIGINT,              -- Identificador único de la ejecución
    mensaje VARCHAR(255),
    instante TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER //
-- Procedimiento para escribir en el log fácilmente
CREATE PROCEDURE write_log(INOUT p_log_id BIGINT, IN p_mensaje VARCHAR(255))
BEGIN
    -- Si es el primer mensaje, generamos un log_id único basado en el tiempo
    IF p_log_id IS NULL OR p_log_id = 0 THEN
        SET p_log_id = UNIX_TIMESTAMP();
    END IF;
    
    INSERT INTO debug_log (log_id, mensaje) VALUES (p_log_id, p_mensaje);
END //
DELIMITER ;
```

### 2. Cómo usarlo en tus proyectos (Ejemplo)
Para depurar un proceso, el alumno debe seguir estos 3 pasos:

```sql
CREATE PROCEDURE sp_ejemplo_con_debug()
BEGIN
    -- PASO 1: Declarar la variable para el ID de ejecución
    DECLARE v_log_id BIGINT DEFAULT NULL;

    -- PASO 2: Escribir mensajes de rastro en puntos clave
    CALL write_log(v_log_id, 'Iniciando el proceso...');
    
    -- ... Tu lógica (IF, Loops, etc.) ...
    IF (1 < 2) THEN
        CALL write_log(v_log_id, 'Entrando por la rama verdadera del IF');
    END IF;

    -- PASO 3: Al final, mostrar la traza completa de ESTA ejecución
    SELECT instante, mensaje FROM debug_log 
    WHERE log_id = v_log_id 
    ORDER BY instante ASC;
END;
```

Esto permite al alumno ver exactamente qué camino tomó su código y qué valores tenían las variables en cada momento, sin mezclar mensajes con otras ejecuciones anteriores.
