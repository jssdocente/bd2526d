# 💡 Proyecto 4: Gestión de Taller Mecánico (Reparaciones y Piezas)

## 📝 Notas de la Reunión con el Cliente (Contexto)
"Hola, necesito organizar mi taller. Registramos los **vehículos** (matrícula única) y su dueño. Cuando abrimos una **orden de trabajo**, asignamos un **mecánico** según su especialidad (chapa, mecánica...). Queremos saber si la avería está en proceso o terminada.

En el almacén tenemos **piezas**. Cada vez que usamos una pieza, el stock debe bajar. Al final, quiero una factura que sume piezas e IVA mas horas de trabajo. Si un cliente pide borrar sus datos por privacidad, debemos poder eliminar su historia por completo, pero si solo deja de venir, lo marcamos como inactivo."

---

## 1. Diseño de la Base de Datos (Reglas de Negocio)
Diseña al menos 6 tablas basándote en lo siguiente:
- **Restricciones**: Matrículas y números de bastidor deben ser únicos. Precios de mano de obra siempre positivos.
- **Dominios**: Especialidades de mecánicos y estados de la orden (pendiente, aviso, cerrada) limitados.
- **Integridad**: No permitir borrar mecánicos de la plantilla si tienen órdenes de trabajo históricas asignadas.

---

## 2. Requisitos de Programación (Especificación Técnica)

### A. Operaciones CRUD (Obligatorias para todas las tablas)
Crear procedimientos del tipo `sp_registrar_vehiculo`, `sp_modificar_pieza`, `sp_baja_mecanico`, etc. Deben controlar que no se dupliquen datos críticos.

### B. Lógica Modular (Funciones Anidadas)
- **`fn_coste_materiales(orden_id)`**: Suma el precio de todas las piezas consumidas en una orden específica.
- **`fn_presupuesto_total(id_orden, horas)`**: Calcula el total de la factura llamando a la función de materiales y sumando la mano de obra aplicada.

### C. Procesamiento Transaccional ("El Pedido")
- **`sp_finalizar_y_facturar_reparacion(id_orden, horas)`**:
    - **Lógica**: Iniciar transacción. Validar que la orden esté 'En Proceso', registrar el total de horas, calcular el importe final y cambiar el estado a 'Terminada'.
    - **Gestión de Errores**: Si la orden no tiene piezas asignadas o el mecánico ya no está en activo, lanza `SIGNAL SQLSTATE '45000'` con: "Error: No se puede facturar una orden sin materiales registrados". Aplica `ROLLBACK`.

### D. Automatización (Triggers)
1.  **Auditoría**: Trigger `tr_audit_precios_piezas` (AFTER UPDATE en piezas). Guardar en histórico quién cambió el precio del repuesto y cuándo.
2.  **Validación**: Trigger `tr_control_stock_piezas` (BEFORE INSERT en detalle_reparacion). Si no hay cantidad suficiente de la pieza solicitada, bloquea la acción con un `SIGNAL`.

### E. Procesamiento Masivo (Cursores)
- **`sp_comisiones_mecanicos_mes()`**: Cursor que recorra a los mecánicos para calcular un bono extra basado en el total de facturación de sus órdenes de trabajo cerradas este mes.

### F. Borrado y Creatividad
- **Gestión de GDPR**: `sp_eliminar_expediente_completo` (Borrado físico de cliente, coche e historial tras aviso legal).
- **Extra**: Aportar **2 funcionalidades adicionales** (Ej: `fn_proxima_itv_estimada` o `sp_gestion_citas_previas`).
