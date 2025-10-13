{% set tooltip_ssl = "Secure Sockets Layer: Un protocolo de seguridad estándar para establecer un enlace cifrado entre un servidor y un cliente." %}
{% set tooltip_api = "Application Programming Interface: Un conjunto de definiciones y protocolos para construir e integrar software de aplicaciones." %}
{% set tooltip_erp = "Enterprise Resource Planning: Software de gestión de procesos de negocio." %}

{% set CE6a = "Se han utilizado herramientas gráficas para representar el diseño lógico." %}
{% set CE6b = "Se han identificado las tablas del diseño lógico." %}
{% set CE6c = "Se han identificado los campos que forman parte de las tablas del diseño lógico." %}
{% set CE6d = "Se han analizado las relaciones entre las tablas del diseño lógico." %}
{% set CE6e = "Se han identificado los campos clave." %}
{% set CE6f = "Se han aplicado reglas de integridad." %}
{% set CE6g = "Se han aplicado reglas de normalización." %}

# UT2-B **Diseño Lógico: Modelor Relacional**

!!! info "Información de la unidad"

    === "Contenidos"

        Bases de datos relacionales:

        *   Modelo de datos.
        *   Terminología del modelo relacional.
        *   Tipos de datos.
        *   Claves primarias.
        *   Restricciones de validación.
        *   El valor NULL.
        *   Claves ajenas.

        Interpretación de Diagramas Entidad/Relación:

        *   Elementos del modelo relacional.
        *   Restricciones semánticas del modelo relacional.
        *   Normalización de modelos relacionales.

    === "Propuesta didáctica"

          En esta unidad vamos a comenzar a trabajar el RA6: **Diseña modelos relacionales normalizados interpretando diagramas entidad/relación**.

          Criterios de evaluación

          *   **CE6a**: Se han utilizado herramientas gráficas para representar el diseño lógico.
          *   **CE6b**: Se han identificado las tablas del diseño lógico.
          *   **CE6c**: Se han identificado los campos que forman parte de las tablas del diseño lógico.
          *   **CE6d**: Se han analizado las relaciones entre las tablas del diseño lógico.
          *   **CE6e**: Se han identificado los campos clave.
          *   **CE6f**: Se han aplicado reglas de integridad.
          *   **CE6g**: Se han aplicado reglas de normalización.



## **Contenido de la unidad**

El contenido de la unidad está repartido en los siguientes bloques.

Índice:

- [2.4 Modelo relacional](./2.4-ModeloRelacional.md)
- [2.B Actividades](./2.B-Actividades.md)


### Programación de Aula (9h)

  Esta unidad es la segunda, con lo que se imparte en la primera evaluación, con una duración estimada de 12 sesiones lectivas:

  | Sesión | Contenidos | Actividades | Criterios trabajados |
  | --- | --- | --- | --- |
  | 1 | Modelo Relacional | [AC201.b](./2.B-Actividades.md#ac201b) | <abbr title="{{ CE6b }}">CE6b</abbr>, <abbr title="{{ CE6c }}">CE6c</abbr>, <abbr title="{{ CE6d }}">CE6d</abbr> |
  | 2 | [Elementos](./2.4-ModeloRelacional.md#elementos) |  |  |
  | 3 | [Restricciones](./2.4-ModeloRelacional.md#restricciones-semánticas) | [AC203.b](./2.B-Actividades.md#ac203b) | <abbr title="{{ CE6b }}">CE6b</abbr> |
  | 4 | [Notacion](./2.4-ModeloRelacional.md#notacion) | [AC205.b](./2.B-Actividades.md#ac205b) | <abbr title="{{ CE6b }}">CE6b</abbr> |
  | 5 | Interpretando modelos | [AC209.b](./2.B-Actividades.md#ac209b) | <abbr title="{{ CE6b }}">CE6b</abbr>, <abbr title="{{ CE6c }}">CE6c</abbr>, <abbr title="{{ CE6e }}">CE6e</abbr> |
  | 6 | Diccionario de datos | [AC208.b](./2.B-Actividades.md#ac208b) | <abbr title="{{ CE6b }}">CE6b</abbr>, <abbr title="{{ CE6c }}">CE6c</abbr>, <abbr title="{{ CE6e }}">CE6e</abbr> |
  | 7 | [Dependencias funcionales](./2.4-ModeloRelacional.md#dependencias-funcionales) |  |  |
  | 8 | [Formas normales](./2.4-ModeloRelacional.md#formas-normales) | [AC209.b](./2.B-Actividades.md#ac209b) | <abbr title="{{ CE6b }}">CE6b</abbr>, <abbr title="{{ CE6c }}">CE6c</abbr>, <abbr title="{{ CE6e }}">CE6e</abbr> |
  | 9 | Desnormalización | [AC210.b](./2.B-Actividades.md#ac210b) | <abbr title="{{ CE6b }}">CE6b</abbr>, <abbr title="{{ CE6c }}">CE6c</abbr>, <abbr title="{{ CE6e }}">CE6e</abbr> |
