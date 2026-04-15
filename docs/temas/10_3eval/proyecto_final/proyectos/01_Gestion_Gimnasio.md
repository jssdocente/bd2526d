# 💡 Proyecto 1: Gestión de Centro Deportivo (Gimnasio)

## 📝 Notas de la Reunión con el Cliente (Contexto)
"Hola, necesito un sistema para mi gimnasio. Quiero que los **socios** se registren con su DNI y un email; es vital que no haya dos socios con el mismo correo por el tema de la aplicación móvil. Los socios pueden estar 'activos' o 'pausados'. 

Tengo **monitores** que dan **actividades** (como Yoga o Spinning). Cada clase tiene un límite de personas que no se puede superar. Los monitores cobran un sueldo fijo pero ganan más según la gente que apunten. Vendemos varios **planes** (Mensual, Anual). Cuando un socio viene, hace una **reserva**. Si el tipo está en pausa o la clase está llena, el sistema tiene que decirle que no. Si cambiamos un precio, quiero saber quién ha sido."

---

## 1. Diseño de la Base de Datos (Reglas de Negocio)
El alumno deberá traducir estas necesidades a un modelo de al menos 6 entidades con las siguientes reglas:

- **Unicidad**: Garantizar que identificadores personales y correos no se dupliquen.
- **Dominios**: Controlar que los estados del socio y los nombres de las actividades pertenezcan a una lista cerrada.
- **Integridad**: Los precios y los aforos permitidos deben ser siempre valores positivos.
- **Relaciones**: Permitir que cambios en el ID del socio se reflejen en su historial, pero impedir el borrado de planes si ya tienen pagos asociados.

---

## 2. Requisitos de Programación (Especificación Técnica)

### A. Operaciones CRUD
Debes crear procedimientos con nombres descriptivos como `sp_crear_socio`, `sp_modificar_actividad`, `sp_listar_planes`, etc. Cada procedimiento debe realizar validaciones previas y confirmar la operación.

### B. Lógica Modular (Funciones Anidadas)
- **`fn_calcular_iva(importe)`**: Recibe una base y devuelve el valor del impuesto.
- **`fn_precio_total(plan_id)`**: Debe llamar a la función anterior para devolver el importe final del plan seleccionado.

### C. Procesamiento Transaccional ("El Pedido")
- **`sp_tramitar_pago_cuota(socio_id, plan_id, importe)`**:
    - **Lógica**: Iniciar transacción. Validar si el socio es apto para pagar. Registrar el cobro y actualizar el acceso del socio. 
    - **Gestión de Errores**: Si el `importe` no coincide con el calculado por las funciones anteriores, usa `SIGNAL SQLSTATE '45000'` para lanzar el error: "Error: El importe ingresado no coincide con la tarifa vigente". Aplica `ROLLBACK`.

### D. Automatización (Triggers)
1.  **Auditoría**: Trigger `tr_auditoria_tarifas` (AFTER UPDATE en planes). Debe guardar en una tabla histórica: fecha, acción ('CAMBIO PRECIO'), el usuario que lo hizo y los valores antiguo/nuevo.
2.  **Validación de Aforo**: Trigger `tr_validar_aforo` (BEFORE INSERT en reservas). Debe contar las reservas actuales y, si se excede el máximo permitido, lanzar un `SIGNAL` con un mensaje de "Clase completa".

### E. Procesamiento Masivo (Cursores)
- **`sp_liquidar_incentivos_monitores()`**: Cursor que recorra a los monitores para calcular un plus (ej: 2€ por alumno asistido) e insertarlo en la tabla de nóminas.

### F. Borrado y Creatividad
- **Gestión de Baja**: `sp_baja_total_socio` (Borrado físico tras limpiar dependencias).
- **Extra**: Aportar **2 funcionalidades adicionales** (Ej: `sp_sugerir_actividad` según el perfil o `fn_estado_forma_socio`).
