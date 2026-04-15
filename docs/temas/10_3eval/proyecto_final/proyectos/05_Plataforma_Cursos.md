# 💡 Proyecto 5: Plataforma de Cursos Online (Venta y Certificación)

## 📝 Notas de la Reunión con el Cliente (Contexto)
"Tenemos una escuela online y queremos organizar nuestros **cursos**. Cada curso tiene un nombre único y un precio. Los **alumnos** se registran con su email. Cuando un alumno compra un curso (se **matricula**), puede usar cupones de descuento.

Queremos que el sistema controle el progreso: cada curso tiene varias **lecciones** y, cuando el alumno termina todas, se debe generar un certificado automáticamente. Si el precio de un curso cambia, queremos saber quién lo ha hecho por si hay errores."

---

## 1. Diseño de la Base de Datos (Reglas de Negocio)
Diseña al menos 6 tablas basándote en lo siguiente:
- **Restricciones**: El nombre del curso y el email del alumno deben ser únicos. El precio siempre debe ser superior a cero.
- **Dominios**: El descuento de los cupones debe estar entre un rango real (ej: 0-100%).
- **Integridad**: Si se cambia el código de una categoría, debe actualizarse en los cursos. Si un alumno tiene cursos comprados, su registro no se puede borrar sin antes procesar sus pagos.

---

## 2. Requisitos de Programación (Especificación Técnica)

### A. Operaciones CRUD (Obligatorias para todas las tablas)
Crear procedimientos como `sp_alta_curso`, `sp_modificar_alumno`, `sp_baja_leccion`, `sp_consulta_certificados`, etc. Validar siempre que los registros existan antes de modificar o consultar.

### B. Lógica Modular (Funciones Anidadas)
- **`fn_valor_descuento(precio, cupon_id)`**: Calcula cuánto dinero se resta al precio según el tipo de cupón.
- **`fn_precio_final_curso(id_curso, id_cupon)`**: Calcula el importe final llamando a la función anterior para aplicar el descuento sobre el precio base.

### C. Procesamiento Transaccional ("El Pedido")
- **`sp_comprar_curso_online(alumno_id, curso_id, cupon_id)`**:
    - **Lógica**: Iniciar transacción. Validar que el alumno no tiene ya el curso activo. Aplicar el descuento, registrar el pago y activar la matrícula.
    - **Gestión de Errores**: Si el alumno está 'Suspendido' o el curso ya ha sido finalizado previamente, usa `SIGNAL SQLSTATE '45000'` con: "Error: El alumno no cumple los requisitos para esta inscripción". Aplica `ROLLBACK`.

### D. Automatización (Triggers)
1.  **Auditoría**: Trigger `tr_audit_tarifas_elearning` (AFTER UPDATE en cursos). Registrar quién cambió el precio, cuándo y la variación.
2.  **Validación**: Trigger `tr_control_certificado_auto` (AFTER UPDATE en progreso_lecciones). Cuando se detecte que el alumno ha terminado la última lección del curso, debe insertar automáticamente la fila en la tabla de certificados.

### E. Procesamiento Masivo (Cursores)
- **`sp_promocion_alumnos_vips()`**: Cursor que recorra a los alumnos que han terminado 3 o más cursos y les asigne automáticamente un cupón de 'Beca 50%' en su perfil para su próxima compra.

### F. Borrado y Creatividad
- **Gestión de GDPR**: `sp_eliminacion_historico_alumno` (Borrado físico tras asegurar que se han exportado sus certificados).
- **Extra**: Aportar **2 funcionalidades adicionales** (Ej: `sp_ranking_alumnos_por_nota` o `fn_tiempo_estimado_curso`).
