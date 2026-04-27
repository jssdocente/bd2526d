# Rúbrica de Evaluación — Proyecto Final BD (3ª Evaluación)

> **Instrucciones de uso:** Valora cada criterio de forma independiente según la descripción del rango correspondiente. Multiplica la nota de cada criterio por su peso y suma los parciales para obtener la nota final.
>
> **Defensa oral:** evaluada de forma independiente como **Apto / No Apto**. No computa en la nota.

---

## Pesos por criterio

| Criterio | Peso |
|---|---|
| 1. Diseño Conceptual y Lógico | 10% |
| 2. Implementación Física (BD) | 10% |
| 3. Programación PL/SQL | 80% |

---

## Tabla de rúbrica

| Rango | **1. Diseño Conceptual y Lógico** | **2. Implementación Física (BD)** | **3. Programación PL/SQL** |
|:---:|---|---|---|
| | *Peso: 10%* | *Peso: 10%* | *Peso: 80%* |
| **9 – 10** <br>Sobresaliente | · E/R correcto y completo (≥8 tablas, cardinalidades, atributos bien definidos)<br>· Modelo lógico (DBML o equivalente) fiel al E/R, FK bien colocadas<br>· Decisiones de diseño justificadas con claridad (normalización, separación de entidades)<br>· 2 funcionalidades extra bien integradas y razonadas | · Usuarios ADMIN y APP_USER creados con permisos exactos y verificados<br>· Todas las tablas con PK, FK, CHECK y NOT NULL adecuados<br>· Índices en campos de consulta frecuente con justificación<br>· Script ejecutable desde cero sin errores, con carga de datos de prueba incluida | **CRUD:**<br>· Completo en ≥3 tablas (alta, baja, modificación, consulta)<br>· Funciones modulares y anidadas (`fn_` reutilizadas dentro de `sp_`)<br>· Procedimiento transaccional con `START TRANSACTION`, `ROLLBACK` y `SIGNAL`<br>· Cursor con bucle `WHILE` y `FETCH` correcto<br>· Borrado seguro en cascada (eliminación completa de datos personales)<br><br>**TRIGGERS *(elemento clave)*:**<br>· Trigger de validación que bloquea datos incoherentes con `SIGNAL`<br>· Trigger de auditoría completo: tabla de auditoría con campos fecha, usuario, tabla, acción y valores anterior/nuevo<br>· La tabla de auditoría tiene registros verificables y cubre ≥2 eventos distintos<br><br>**FUNCIONALIDADES EXTRA *(elemento clave)*:**<br>· Las 2 funcionalidades adicionales están completamente implementadas<br>· Son funcionales y se integran de forma coherente con el sistema |
| **7 – 8** <br>Notable | · E/R correcto con alguna cardinalidad imprecisa o atributo menor omitido<br>· Modelo lógico coherente con el E/R<br>· Decisiones de diseño justificadas de forma básica<br>· 2 funcionalidades extra presentes, aunque una poco desarrollada | · Usuarios creados con algún permiso sobrante o faltante menor<br>· Tablas principales con PK y FK correctas; algún CHECK o NOT NULL omitido en tablas secundarias<br>· Índices presentes pero sin justificación explícita<br>· Script ejecutable con ajustes menores | **CRUD:**<br>· Funcional en ≥3 tablas<br>· Funciones modulares pero sin anidamiento entre ellas<br>· Transacción con `ROLLBACK`, pero `SIGNAL` incompleto o ausente<br>· Cursor presente y funcional<br>· Borrado seguro implementado de forma básica<br><br>**TRIGGERS *(elemento clave)*:**<br>· Ambos triggers presentes y funcionales<br>· Tabla de auditoría con los campos mínimos (fecha, usuario, tabla, acción), sin almacenar valores anterior/nuevo<br><br>**FUNCIONALIDADES EXTRA *(elemento clave)*:**<br>· Las 2 funcionalidades extra están implementadas<br>· Una de ellas puede tener errores menores o estar poco desarrollada |
| **5 – 6** <br>Aprobado | · E/R incompleto (alguna entidad o relación faltante) pero refleja el núcleo del sistema<br>· Modelo lógico con errores menores (FK mal colocada, tipo de dato incorrecto)<br>· Pocas o ninguna justificación de diseño<br>· Solo 1 funcionalidad extra implementada | · Solo uno de los dos usuarios correctamente configurado, o permisos con errores significativos<br>· Tablas con PK pero sin FK en relaciones importantes<br>· Apenas hay índices<br>· Script necesita correcciones para ejecutarse | **CRUD:**<br>· Presente en ≥3 tablas pero con operaciones incompletas (falta alguna baja o consulta)<br>· Funciones sin modularidad apreciable<br>· Transacción sin control de errores (`ROLLBACK` ausente)<br>· Cursor con errores menores de sintaxis o lógica<br>· Sin borrado seguro<br><br>**TRIGGERS *(elemento clave)*:**<br>· Al menos 1 trigger funciona correctamente (auditoría o validación)<br>· Tabla de auditoría existe pero incompleta (faltan campos obligatorios o no registra eventos reales)<br><br>**FUNCIONALIDADES EXTRA *(elemento clave)*:**<br>· Solo 1 de las 2 funcionalidades extra está implementada<br>· O ambas entregadas de forma muy rudimentaria |
| **3 – 4** <br>Insuficiente | · E/R muy incompleto o con errores graves (entidades duplicadas, relaciones incorrectas)<br>· Modelo lógico no se corresponde con el E/R<br>· Sin justificaciones<br>· No se han añadido funcionalidades extra | · Usuarios no creados o con permisos incorrectos<br>· Tablas con errores estructurales graves (sin PK, FK a campos inexistentes)<br>· Sin índices<br>· Script no ejecutable | **CRUD:**<br>· Incompleto en menos de 3 tablas<br>· Sin funciones modulares<br>· Sin transacción real<br>· Sin cursor o con errores graves<br><br>**TRIGGERS *(elemento clave)*:**<br>· Código de trigger presente pero no funciona o no hace lo requerido<br>· Tabla de auditoría inexistente o vacía<br><br>**FUNCIONALIDADES EXTRA *(elemento clave)*:**<br>· Ninguna funcionalidad extra entregada<br>· O son copias sin adaptar del proyecto guía |
| **0 – 2** <br>Muy deficiente | · Sin diagrama E/R o irreconocible<br>· Sin modelo lógico<br>· Menos de 8 tablas o estructura sin sentido para el dominio | · Sin script o con errores que impiden crear la base de datos<br>· Sin gestión de usuarios ni restricciones de integridad | **CRUD:**<br>· Sin procedimientos almacenados o ninguno funciona<br><br>**TRIGGERS *(elemento clave)*:**<br>· Sin triggers<br>· Sin tabla de auditoría<br><br>**FUNCIONALIDADES EXTRA *(elemento clave)*:**<br>· No entregadas |

---

## Cálculo de la nota final

```
Nota final = (Nota_C1 × 0,10) + (Nota_C2 × 0,10) + (Nota_C3 × 0,80)
```

**Ejemplo:**

| Criterio | Nota | Peso | Parcial |
|---|---|---|---|
| 1. Diseño | 8 | 10% | 0,80 |
| 2. Implementación | 7 | 10% | 0,70 |
| 3. PL/SQL | 6 | 80% | 4,80 |
| **TOTAL** | | | **6,30** |

---

## Notas de aplicación

- **Condición bloqueante — Script no ejecutable:** Si el script completo no se ejecuta sin errores desde cero, la **nota máxima es un 2**, independientemente del resto de criterios. El script debe incluir obligatoriamente la carga de datos de prueba suficientes para verificar el funcionamiento de procedimientos, triggers y cursores.
- **Condición mínima:** Un proyecto sin ningún trigger funcional **no puede superar el 4**, independientemente del resto de criterios.
- **Penalización por copia:** Evidencia de plagio entre alumnos → nota 0 en el criterio afectado.
- **Redondeo:** Se aplica redondeo estándar (≥ 0,5 sube al entero superior).
- **Defensa oral:** evaluada aparte como **Apto / No Apto**. No superar la defensa puede implicar revisión de la nota final a criterio del profesor.
