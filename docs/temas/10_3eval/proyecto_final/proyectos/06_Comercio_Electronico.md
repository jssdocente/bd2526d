# 💡 Idea 6: Comercio Electrónico (E-Commerce y Almacén)

## 📝 Notas de la Reunión con el Cliente (Contexto)
"Queremos una tienda online robusta. Los **productos** tienen una referencia única y el stock que nos queda. Si el stock llega a cero, el sistema no debería dejar vender más. Los **clientes** guardan su dirección para los envíos.

Un **pedido** puede estar 'pendiente', 'enviado' o 'entregado'. Trabajamos con muchos **proveedores**. Si el stock baja de un mínimo, queremos que el sistema anote que hay que pedir reposición. Si un cliente se da de baja, queremos 'anonimizar' sus datos: borrar su nombre por privacidad pero dejar sus pedidos registrados para que la estadística de ventas no se pierda."

---

## 1. Diseño de la Base de Datos (Reglas de Negocio)
Diseña al menos 6 tablas basándote en lo siguiente:
- **Restricciones**: La referencia de producto y el email de cliente deben ser únicos. El stock nunca puede ser inferior a cero.
- **Dominios**: El estado del pedido y el tipo de envío deben estar bien definidos.
- **Integridad**: Si se actualiza el NIF de un proveedor, debe reflejarse en sus productos. Si un producto ha sido vendido alguna vez, no puede eliminarse físicamente de la base de datos.

---

## 2. Requisitos de Programación (Especificación Técnica)

### A. Operaciones CRUD (Obligatorias para todas las tablas)
Implementar procedimientos como `sp_registrar_producto`, `sp_modificar_stock`, `sp_baja_proveedor`, `sp_consulta_pedidos_cliente`, etc. Todos deben incluir control de errores ante registros inexistentes.

### B. Lógica Modular (Funciones Anidadas)
- **`fn_coste_envio(peso, region)`**: Calcula el porte según los kilogramos y la distancia.
- **`fn_total_pedido(pedido_id)`**: Calcula el importe final (productos + IVA) y le suma los gastos de envío llamando a la función anterior.

### C. Procesamiento Transaccional ("El Pedido")
- **`sp_confirmar_pedido_carrito(cliente_id, carrito_id)`**:
    - **Lógica**: Iniciar transacción. Validar stock de todos los artículos seleccionados. Restar stock de la tabla de productos, crear el pedido y generar la factura.
    - **Gestión de Errores**: Si uno de los artículos no tiene stock suficiente, usa `SIGNAL SQLSTATE '45000'` con: "Error: No hay existencias suficientes de uno o más artículos". Aplica `ROLLBACK`.

### D. Automatización (Triggers)
1.  **Auditoría**: Trigger `tr_audit_cambio_precios` (AFTER UPDATE en productos). Registrar quién tocó el precio, cuándo y el cambio porcentual.
2.  **Validación**: Trigger `tr_reposicion_automatica` (AFTER UPDATE en productos). Si tras una venta el stock queda por debajo de 5 unidades, debe insertar una fila en la tabla 'Pedidos_a_Proveedores' automáticamente.

### E. Procesamiento Masivo (Cursores)
- **`sp_resumen_mensual_inventario()`**: Cursor que recorra todos los productos activos de la tienda para calcular el valor total del almacén actual (precio * stock) y guarde un informe por fecha.

### F. Borrado y Creatividad
- **Gestión de GDPR**: `sp_anonimizar_perfil_cliente` (Borrado de nombre, apellidos y email, sustituyéndolos por 'USUARIO ANÓNIMO' pero manteniendo sus IDs vinculados a ventas).
- **Extra**: Aportar **2 funcionalidades adicionales** (Ej: `sp_lista_deseos_con_alertas` o `fn_estimacion_entrega_dias`).
