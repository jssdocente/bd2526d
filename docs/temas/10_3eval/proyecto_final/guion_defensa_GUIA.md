# 🗣️ Guía de Exposición para la Defensa del Proyecto

Este documento tiene como objetivo servir de apoyo a los alumnos para la preparación de la defensa oral del proyecto ante el profesor. 

## Introducción al Guion de Defensa

Para que la defensa sea efectiva, no basta con mostrar el código; es necesario demostrar que el sistema funciona correctamente y que se comprende la lógica de negocio aplicada. Este fichero contiene un **script de ejecución secuencial** que simula un ciclo operativo real en el sistema (en este caso, basado en el Hotel Gran Horizonte).

Los alumnos deben seguir este orden lógico durante su exposición:

1.  **Seguridad**: Validar que los permisos de usuario están correctamente configurados.
2.  **Integridad**: Demostrar que los procedimientos CRUD impiden la entrada de datos erróneos.
3.  **Reglas de Negocio**: Verificar que los Triggers protegen el estado de la base de datos (evitar duplicidad de reservas, aforos, etc.).
4.  **Transaccionalidad**: Ejecutar el proceso crítico (Check-out) y explicar cómo se gestionan los cálculos y errores.
5.  **Automatización**: Mostrar el uso de cursores para tareas masivas.
6.  **Trazabilidad**: Enseñar el rastro dejado por los disparadores de auditoría.

---

## 📜 Script de Defensa (SQL)

A continuación se presenta el código que debe ejecutarse paso a paso. Se recomienda copiarlo en una pestaña limpia de vuestro cliente SQL (MySQL Workbench, DBeaver, etc.) e ir comentando cada bloque mientras se ejecuta.

```sql
/* 
###########################################################################
# GUION DE EXPOSICIÓN: DEFENSA PROYECTO "HOTEL GRAN HORIZONTE"
# Objetivo: Demostrer la funcionalidad técnica y lógica del sistema.
###########################################################################
*/

-- ========================================================================
-- BLOQUE 1: SEGURIDAD Y PERMISOS
-- ========================================================================
-- "Empezamos demostrando que el sistema es seguro. Solo el ADMIN puede 
-- alterar la estructura, mientras que la aplicación usa un usuario limitado."

-- 1. Intentamos borrar una tabla con el usuario de la APP (Debe fallar)
-- [Explicación: El usuario APP_USER solo tiene permisos DML y EXECUTE]
-- DROP TABLE Clientes; 

-- 2. Conectamos como ADMIN para preparar los datos de la defensa.
-- SELECT USER();


-- ========================================================================
-- BLOQUE 2: GESTIÓN DE MAESTROS Y VALIDACIÓN (CRUD)
-- ========================================================================
-- "Vamos a registrar un nuevo cliente. Mi procedimiento sp_cliente_crear 
-- no solo inserta, sino que valida que el DNI no exista previamente."

-- 1. Registro correcto
CALL sp_cliente_crear('12345678A', 'Juan Perez', 'juan@email.com');

-- 2. Demostración de robustez: Intentar duplicar DNI (Debe lanzar SIGNAL SQLSTATE)
-- "Si intento registrar el mismo DNI, el procedimiento detiene la ejecución 
-- con un mensaje personalizado para informar al usuario."
-- CALL sp_cliente_crear('12345678A', 'Otro Juan', 'otro@email.com');


-- ========================================================================
-- BLOQUE 3: OPERATIVA - RESERVAS Y CONSUMOS (TRIGGERS DE VALIDACIÓN)
-- ========================================================================
-- "Simularemos la llegada del cliente. El sistema debe impedir reservar si 
-- la habitación no está 'Libre' gracias al trigger tr_validar_habitacion_disponible."

-- 1. Ocupamos la habitación 101 (Suite)
-- [El alumno muestra que el estado inicial en la tabla Habitaciones es 'Libre']
INSERT INTO Estancias (cliente_dni, habitacion_numero, fecha_entrada, fecha_salida, estado_pago) 
VALUES ('12345678A', 101, CURDATE(), DATE_ADD(CURDATE(), INTERVAL 2 DAY), FALSE);

-- 2. Prueba de fuego del Trigger: Intentar meter a otro cliente en la 101 hoy
-- "El trigger BEFORE INSERT detecta que la 101 ya no está libre y bloquea la estancia."
-- INSERT INTO Estancias (cliente_dni, habitacion_numero, fecha_entrada, ...) VALUES ('88888888Z', 101, ...);

-- 3. Cargamos servicios (Consumos)
-- "El cliente usa el Spa y el Minibar. Usaremos procedimientos para registrar consumos."
-- CALL sp_registrar_consumo(p_estancia_id, p_servicio_id, p_cantidad);


-- ========================================================================
-- BLOQUE 4: PROCESO MAESTRO - CHECK-OUT (TRANSACCIONES Y FUNCIONES)
-- ========================================================================
-- "Este es el corazón del proyecto. El Check-out es una transacción que 
-- garantiza que o se cobra todo correctamente o no se hace nada."

-- "Dentro de este procedimiento se llaman a funciones anidadas:
--  1. fn_sumar_consumos: Recorre los servicios y suma importes.
--  2. fn_aplicar_iva: Aplica el 21% al total general."

-- 1. Ejecutamos el Check-out
CALL sp_realizar_checkout(1); -- Suponiendo que el ID de estancia es 1

-- 2. Verificación de resultados
-- "Podemos ver que: 
--  - El estado_pago ha pasado a TRUE.
--  - La habitacion_numero 101 ha pasado automáticamente a estado 'Limpieza'."
SELECT * FROM Estancias WHERE id = 1;
SELECT * FROM Habitaciones WHERE numero = 101;


-- ========================================================================
-- BLOQUE 5: AUTOMATIZACIÓN Y CURSORES (FUNCIONALIDAD EXTRA)
-- ========================================================================
-- "Como funcionalidad extra, he implementado un sistema para el equipo de limpieza.
--  En lugar de buscar habitación por habitación, un cursor genera las tareas."

-- 1. Generar tareas masivas
CALL sp_extra_generar_tareas_limpieza();

-- 2. Verificamos la tabla de tareas
-- "El cursor ha detectado todas las habitaciones en estado 'Limpieza' e 
-- insertado una fila en Tareas_Personal para cada una."
SELECT * FROM Tareas_Personal WHERE fecha = CURDATE();


-- ========================================================================
-- BLOQUE 6: CONTROL DE CAMBIOS (AUDITORÍA)
-- ========================================================================
-- "Finalmente, demostramos la trazabilidad. Si la dirección del hotel 
-- decide cambiar el precio de una Suite, el trigger tr_audit_precios_habitacion 
-- guardará el rastro de quién lo hizo y cuándo."

-- 1. Cambiamos el precio base de la categoría Suite (ID 1) de 150€ a 180€
UPDATE Categorias SET precio_base = 180.00 WHERE id = 1;

-- 2. Consultamos la tabla de auditoría
-- "Aquí vemos el valor antiguo, el nuevo, el usuario del sistema y la fecha exacta."
SELECT * FROM Auditoria_Precios;

-- ========================================================================
-- FIN DE LA DEFENSA
-- ========================================================================
```
