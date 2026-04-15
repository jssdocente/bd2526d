# 📝 Entrega de Proyecto Final: Base de Datos 3ª Evaluación

**Nombre del Alumno:** *[Tu Nombre Completo]*  
**Idea de Proyecto Elegida:** *[Ej: Gestión de Gimnasio]*  
**Fecha de Entrega:** *[Fecha]*

---

## 1. Fase de Análisis de Requisitos

### 1.1. Resumen de Reuniones con el Cliente

*[Incluye aquí una breve narrativa o puntos clave de lo que el "cliente" te ha solicitado en tus reuniones simuladas. Debe quedar claro qué problema estamos resolviendo].*

### 1.2. Funcionalidades Extra Aportadas

*[Explica brevemente las 2 funcionalidades adicionales que has añadido por tu cuenta para mejorar el sistema].*
1. **Funcionalidad 1:** *[Descripción]*
2. **Funcionalidad 2:** *[Descripción]*

### 1.3. Pensamientos de Diseño y Justificación

*[Explica por qué has decidido crear ciertas tablas o qué restricciones has puesto y por qué. Ejemplo: "He separado la tabla X para evitar redundancia de datos..."]*

---

## 2. Diseño del Modelo de Datos

### 2.1. Modelo Conceptual (Diagrama E/R)
*[Inserta aquí la imagen de tu diagrama Entidad/Relación].*

**Descripción de Entidades:**
*   **Tabla/Entidad 1:** *[Explica para qué sirve y qué información almacena].*
*   **Tabla/Entidad 2:** *[Explica para qué sirve y qué información almacena].*
*   *[...añadir tantas como sea necesario...]*

### 2.2. Modelo Lógico (Tablas y Relaciones)
*[Inserta aquí el código DBML y una imagen de tu modelo lógico (diagrama de tablas)].*

**Decisiones de Transformación y Relaciones:**
*[Basado en el Proyecto de Muestra: Explica cómo has pasado tus "dibujos" a tablas reales. Por ejemplo:]*
1.  **Relaciones:** *[Explica cómo las líneas del E/R se han convertido en Claves Foráneas (FK) y en qué tablas las has colocado].*
2.  **Transformación:** *[Explica las decisiones de transformación que has tomado que sean importantes, es decir, no sean conversión directa].*
3.  **Integridad de Datos:** *[Justifica el uso de Claves Primarias y restricciones de Unicidad].*
4. **Otra información**: *[Explica cualquier otra información relevante sobre el modelo lógico].*

---

## 3. Implementación Física (MySQL)

### 3.1. Gestión de Usuarios y Seguridad

*[Copia el código SQL para crear los dos usuarios requeridos (ADMIN y APP_USER) y la asignación de sus permisos].*

```sql
-- Código de creación de usuarios y GRANTs
```

### 3.2. Estructura de Tablas e Índices

*[Indica las tablas creadas, sus restricciones (PK, FK, CHECK) y qué índices has creado para mejorar la velocidad de las consultas].*

---

## 4. Programación Procedimental (MySQL)

### 4.1. Operaciones CRUD (Procedimientos para todas las tablas)

*[Debes incluir el bloque de código para cada tabla principal. Ejemplo:]*

#### Tabla: *[Nombre de la Tabla 1]*
```sql
-- Procedimientos sp_crear, sp_consultar, sp_actualizar, sp_borrar
```

#### Tabla: *[Nombre de la Tabla 2]*

```sql
-- Procedimientos sp_crear, sp_consultar, sp_actualizar, sp_borrar
```

### 4.2. Lógica Modular (Funciones)

*[Incluye aquí tus funciones, destacando aquellas que son "anidadas" (una función que llama a otra)].*

### 4.3. Operación Compleja: "El Pedido" (Transacción)
*[Pega aquí el código de tu procedimiento transaccional principal. Explica cómo controlas los errores con ROLLBACK y SIGNAL].*

### 4.4. Automatización (Triggers)
*[Divide esta sección en:]*
1. **Auditoría:** *[Trigger que guarda cambios en una tabla histórica].*
2. **Validación:** *[Trigger que impide insertar datos incorrectos].*
3. **Automatización:** *[Trigger que realiza una acción automática tras un cambio].*

### 4.5. Procesamiento Masivo (Cursores)
*[Explica el propósito de tu cursor y pega el código aquí (Recuerda usar el estilo WHILE)].*

---

## 5. Conclusiones y Defensa
*[Explica brevemente qué ha sido lo más difícil y cómo has verificado que todo funciona (pruebas realizadas)].*

---

## ANEXO: Script Completo de la Base de Datos
*[Copia aquí el SCRIPT COMPLETO que permita crear la base de datos desde cero: creación de la BD, tablas, triggers, funciones y procedimientos. Debe estar perfectamente comentado para que el profesor pueda ejecutarlo directamente].*

```sql
/* 
#######################################################
# SCRIPT DE CREACIÓN COMPLETA - [NOMBRE DEL PROYECTO]
# ALUMNO: [TU NOMBRE]
#######################################################
*/

-- 1. CREACIÓN DE LA BASE DE DATOS Y TABLAS
-- ...

-- 2. CARGA DE DATOS MÍNIMA (PARA PRUEBAS)
-- ...

-- 3. FUNCIONES Y PROCEDIMIENTOS
-- ...

-- 4. TRIGGERS
-- ...
```
