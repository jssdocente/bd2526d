# 💡 Proyecto 2: Gestión de Restaurante (Comandas y Mesas)

## 📝 Notas de la Reunión con el Cliente (Contexto)

"Necesito controlar el día a día de mi restaurante. Quiero saber qué **mesas** tengo libres o cuáles están ocupadas. En la **carta**, los platos tienen un nombre y un precio; no quiero que se repitan platos con el mismo nombre. A veces nos quedamos sin un ingrediente y hay que marcar el plato como 'agotado'.

Los **camareros** trabajan en diferentes turnos. Cuando se abre una **comanda**, quiero que se sepa quién la atiende. Al final, el sistema debe calcular el ticket con el IVA y liberar la mesa. Si borro un plato de la carta porque ya no lo hacemos, no quiero que desaparezca de las facturas que ya cobré hace meses."

---

## 1. Diseño de la Base de Datos (Reglas de Negocio)
Diseña al menos 6 tablas basándote en lo siguiente:
- **Restricciones**: El número de mesa y el nombre del plato deben ser únicos.
- **Dominios**: Los turnos de camareros y estados de mesa deben limitarse a opciones específicas.
- **Valores**: Los precios y las capacidades de las mesas deben ser siempre mayores que cero.
- **Integridad**: Impedir la eliminación física de platos si estos aparecen en algún historial de ventas.

---

## 2. Requisitos de Programación (Especificación Técnica)

### A. Operaciones CRUD (Obligatorias para todas las tablas)

Crear procedimientos como `sp_alta_producto`, `sp_modificar_mesa`, `sp_consulta_camarero`, etc. Deben incluir validaciones de existencia antes de operar.

### B. Lógica Modular (Funciones Anidadas)
- **`fn_calcular_iva(precio)`**: Devuelve el valor del impuesto aplicado.
- **`fn_total_comanda(comanda_id)`**: Debe sumar el importe de todos los productos de la comanda y llamar a la función del IVA para devolver el total facturable.

### C. Procesamiento Transaccional ("El Pedido")
- **`sp_finalizar_y_cobrar(comanda_id, metodo_pago)`**:
    - **Lógica**: Iniciar transacción. Sumar consumos, marcar la comanda como pagada y poner la mesa como 'Libre'. 
    - **Gestión de Errores**: Si la mesa no tiene productos asignados o ya estaba libre, usa `SIGNAL SQLSTATE '45000'` con el mensaje: "Error: No se puede cobrar una mesa sin consumiciones activas". Aplica `ROLLBACK`.

### D. Automatización (Triggers)
1.  **Auditoría**: Trigger `tr_auditoria_cierres` (AFTER UPDATE en comandas). Debe registrar en una tabla histórica el importe total cobrado, el usuario que cerró la cuenta y la fecha/hora exacta.
2.  **Validación**: Trigger `tr_verificar_stock` (BEFORE INSERT en detalle_comanda). Debe verificar si el producto está marcado como 'Disponible'. Si no, lanza un `SIGNAL` de "Producto agotado en cocina".

### E. Procesamiento Masivo (Cursores)
- **`sp_informe_ventas_camareros()`**: Cursor que recorra a la plantilla para calcular el total de euros vendidos por cada uno y lo inserte en una tabla de 'Rendimiento Mensual'.

### F. Borrado y Creatividad
- **Gestión de GDPR**: `sp_anonimizar_cliente` (Sustituir datos personales de reservas antiguas por valores genéricos).
- **Extra**: Aportar **2 funcionalidades adicionales** (Ej: `fn_sugerencia_vino_maridaje` o `sp_gestion_alergenos`).
