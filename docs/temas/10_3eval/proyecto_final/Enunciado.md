# Proyecto final Base de Datos (3ª Evaluación)

**Objectivos**

Desarrollar una base de datos relacional para una aplicación Java, donde la lógica de negocio se ejecute principalmente mediante objetos programables (procedimientos, funciones y disparadores), garantizando la integridad, seguridad y eficiencia mediante el uso de transacciones y automatización.

**Proyecto Guía**

Para facilitar su realización se ha creado un proyecto guía que se puede consultar en [proyecto_guia.md](proyecto_guia.md).

## **Fases del proyecto**

### <u>1. Análisis de requisitos</u>

Cada proyecto se basa en un tipo de proyecto específico que viene dado por el profesor. Además de las entidades ya prefijadas, el alumno deberá simular reuniones con el "cliente" para obtener información adicional sobre el proyecto.
A dada proyecto, el alumno le añadirá al menos 2 funcionalidades extra a las ya previamente definidas en el proyecto.
El proyecto debe tener al menos 8 tablas.

- **Entidades principales**: (predefinidas y a definir por el alumno)
- **Relaciones** entre entidades.
- **Operaciones CRUD básicas** (altas, bajas, modificaciones, consultas). *AL MENOS 3 TABLAS COMPLETAS, y TABLAS IMPORTANTES*
    

### <u>2. Diseño del modelo de datos</u>

Crear el diagrama de E/R que refleje: entidades, atributos y relaciones, cardinalidades, ...


### <u>3. Diseño lógico</u>

- Transformas el modelo de ER en un modelo relacional.
- Definir tablas, claves primarias y foráneas


### <u>4. Diseño físico</u>

El diseño físico se realizará en MySQL/MariaDB. 


#### <u>A. Usuarios y permisos</u>

Crear 2 usuarios: 

- ADMIN: con permisos de administrador, todos los permisos.
- APP_USER: solo con los permisos DML (SELECT, UPDATE, DELETE) y ejecución de procedimientos.


#### <u>B. Estructura de la BD</u>

Script para crear:

- Tablas con restricciones (PK, FK, CHECK, NOT NULL, etc..)
- Indices para campos frecuentemente consultados


#### <u>C. Programación PL/SQL</u>

Debe incluir los siguientes puntos:

- Procedimientos/funciones para CRUD.
- Procedimientos/funciones para operaciones complejas.
- Funciones para validación de datos (ej: comprobar stock, calcular totales, ...)
- Uso de transacciones para operaciones complejas.
- Uso de triggers para validación de datos.
- Uso de triggers para auditoría.

Triggers:

- Validación de datos: usar un disparador para controlar/avisar sobre algún evento.
- Auditoría: usar un disparador para registrar cambios en la base de datos con al menos los campos de fecha, usuario, tabla y acción realizada (Insert, update, delete). 
    

