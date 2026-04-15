# 💡 Proyecto 3: Gestión de Biblioteca (Préstamos y Reservas)

## 📝 Notas de la Reunión con el Cliente (Contexto)
"Queremos modernizar la biblioteca. Necesito guardar los datos de los **libros** (con su ISBN) y saber cuántos ejemplares tenemos. Los **lectores** se registran con su DNI y no puede haber duplicados. Quiero saber si están 'aptos' o 'sancionados' si devuelven libros tarde.

Cuando alguien pide un **préstamo**, anotamos la fecha límite. Si se pasa, el sistema debe multarle. No podemos prestar un libro si no quedan copias libres. Además, si un bibliotecario añade libros al inventario, quiero saber quién ha sido para evitar errores de conteo."

---

## 1. Diseño de la Base de Datos (Reglas de Negocio)

Diseña al menos 6 tablas siguiendo estas directrices:
- **Restricciones**: El ISBN y el DNI deben ser únicos. El stock de libros debe ser siempre de 0 en adelante.
- **Dominios**: Los estados de los libros (disponible, prestado, reparando) y de los lectores deben ser finitos.
- **Integridad**: Si se actualiza el código de un autor, debe reflejarse en sus libros. Si un lector tiene préstamos antiguos, su ficha no puede ser eliminada físicamente.

---

## 2. Requisitos de Programación (Especificación Técnica)

### A. Operaciones CRUD (Obligatorias para todas las tablas)
Implementar procedimientos como `sp_alta_libro`, `sp_baja_lector`, `sp_modificar_autor`, etc. Todos deben validar la existencia previa de los registros.

### B. Lógica Modular (Funciones Anidadas)
- **`fn_dias_retraso(prestamo_id)`**: Calcula la diferencia entre la fecha actual y la fecha límite de devolución.
- **`fn_calcular_multa(id_prestamo)`**: Llama a la función anterior y, basándose en los días, devuelve el importe económico de la sanción.

### C. Procesamiento Transaccional ("El Pedido")
- **`sp_realizar_prestamo(lector_id, isbn)`**:
    - **Lógica**: Iniciar transacción. Validar que el lector no tenga multas y que el libro tenga stock. Restar un ejemplar y crear la ficha de préstamo con fecha a +15 días.
    - **Gestión de Errores**: Si el lector tiene el estado 'Sancionado', usa `SIGNAL SQLSTATE '45000'` con: "Error: El usuario no puede realizar préstamos por sanciones vigentes". Aplica `ROLLBACK`.

### D. Automatización (Triggers)
1.  **Auditoría**: Trigger `tr_log_stock_libros` (AFTER UPDATE en libros). Registrar en una tabla técnica quién movió el stock, cuándo y la cantidad resultante.
2.  **Validación**: Trigger `tr_impedir_prestamo_multa` (BEFORE INSERT en préstamos). Si el lector tiene registros de multas sin pagar, bloquea la operación con un `SIGNAL`.

### E. Procesamiento Masivo (Cursores)
- **`sp_revision_diaria_atrasos()`**: Cursor que recorra todos los préstamos activos. Si la fecha límite es anterior a hoy, debe sancionar al lector automáticamente y calcular su multa inicial.

### F. Borrado y Creatividad
- **Gestión de GDPR**: `sp_eliminar_lector_definitivo` (Borrado físico tras asegurar que no tiene libros pendientes).
- **Extra**: Aportar **2 funcionalidades adicionales** (Ej: `fn_sugerir_libro_por_autor` o `sp_gestion_sala_estudio`).
