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
{% set CE6h = "Se han analizado y documentado las restricciones que no pueden plasmarse en el diseño lógico." %}

# UT2-A **Diseño Conceptual: Modelo Entidad Relación**

!!! info "Información de la unidad"

    === "Contenidos"

        Bases de datos relacionales:

        - Modelo de datos

        Interpretación de Diagramas Entidad/Relación:

        - El modelo E/R. Entidades y relaciones. Cardinalidades. Debilidad.
        - El modelo E/R ampliado. Generalización y especialización. Agregación.

    === "Propuesta didáctica"

          En esta unidad vamos a comenzar a trabajar el RA6: **Diseña modelos relacionales normalizados interpretando diagramas entidad/relación**.

          Criterios de evaluación

          - **CE6b**: Se han identificado las tablas del diseño lógico.
          - **CE6c**: Se han identificado los campos que forman parte de las tablas del diseño lógico.
          - **CE6d**: Se han analizado las relaciones entre las tablas del diseño lógico.
          - **CE6e**: Se han identificado los campos clave.



## **Contenido de la unidad**

El contenido de la unidad está repartido en los siguientes bloques.

Índice:

- [2.1 Modelo Entidad-Relación](./2.1-ModeloER.md)
- [2.2 Restricciones](./2.2-Restricciones.md)
- [2.3 Modelo Extendido](./2.3-Modelo-extendido.md)
- [2.A Actividades](./2.A-Actividades.md)


### Programación de Aula (12h)

  Esta unidad es la segunda, con lo que se imparte en la primera evaluación, con una duración estimada de 12 sesiones lectivas:

  | Sesión | Contenidos | Actividades | Criterios trabajados |
  | --- | --- | --- | --- |
  | 1 | [Modelo Entidad Relación](2.1-ModeloER.md#2-el-modelo-entidad-relación). | [AC201](./2.A-Actividades.md#ac201-rabd6--ce6b-ce6c) | <abbr title="{{ CE6b }}">CE6b</abbr>, <abbr title="{{ CE6c }}">CE6c</abbr>, <abbr title="{{ CE6d }}">CE6d</abbr> |
  | 2 | [Entidades](2.1-ModeloER.md#️entidades). Relaciones - Cardinalidad |  |  |
  | 3 | [Relaciones](2.1-ModeloER.md#relaciones) [1:1](2.1-ModeloER.md#relacion-11), [1:N](2.1-ModeloER.md#relacion-1n), [N:M](2.1-ModeloER.md#relacion-nm) | [AC203](./2.A-Actividades.md#ac203-rabd6--ce6d) | <abbr title="{{ CE6b }}">CE6b</abbr> |
  | 4 | [Atributos](2.1-ModeloER.md#atributos). Trabajando las cardinalidades | [AC204](./2.A-Actividades.md#ac204-rabd6--ce6d) | <abbr title="{{ CE6b }}">CE6b</abbr> |
  | 5 | [Atributos identificadores](2.1-ModeloER.md#identificadores). Modelados sencillos | [AC205](./2.A-Actividades.md#ac205-rabd6--ce6b-ce6c-ce6e) | <abbr title="{{ CE6b }}">CE6b</abbr>, <abbr title="{{ CE6c }}">CE6c</abbr>, <abbr title="{{ CE6e }}">CE6e</abbr> |
  | 6 | Completando modelos | [AC208](./2.A-Actividades.md#ac208-rabd6--ce6b-ce6c-ce6e) | <abbr title="{{ CE6b }}">CE6b</abbr>, <abbr title="{{ CE6c }}">CE6c</abbr>, <abbr title="{{ CE6e }}">CE6e</abbr> |
  | 7 | [Restricciones](./2.2-Restricciones.md#22-restricciones) |  |  |
  | 8 | [Modelado EER](./2.3-Modelo-extendido.md#23-el-modelo-entidad-relación-extendido). Generalización. [Tipos](./2.3-Modelo-extendido.md#tipos) | [AC209](./2.A-Actividades.md#ac209-rabd6--ce6b-ce6c-ce6e) | <abbr title="{{ CE6b }}">CE6b</abbr>, <abbr title="{{ CE6c }}">CE6c</abbr>, <abbr title="{{ CE6e }}">CE6e</abbr> |
  | 9 | Modelados con generalizaciones | [AC210](./2.A-Actividades.md#ac210-rabd6--ce6b-ce6c-ce6e) | <abbr title="{{ CE6b }}">CE6b</abbr>, <abbr title="{{ CE6c }}">CE6c</abbr>, <abbr title="{{ CE6e }}">CE6e</abbr> |
  | 10 | [Agregaciones](./2.3-Modelo-extendido.md#agregacion) | [AC212](./2.A-Actividades.md#ac212-rabd6--ce6b-ce6c-ce6e) | <abbr title="{{ CE6b }}">CE6b</abbr>, <abbr title="{{ CE6c }}">CE6c</abbr>, <abbr title="{{ CE6e }}">CE6e</abbr> |
  | 11 | Interpretando modelos | [AC215](./2.A-Actividades.md#ac215-rabd6--ce6b-ce6c-ce6d-ce6e) | <abbr title="{{ CE6b }}">CE6b</abbr>, <abbr title="{{ CE6c }}">CE6c</abbr>, <abbr title="{{ CE6d }}">CE6d</abbr>, <abbr title="{{ CE6e }}">CE6e</abbr> |
  | 12 | [Reto - Diseñando una BD](./2.A-Actividades.md#reto-i---diseñamos) | [PY216](./2.A-Actividades.md#py216-rabd6--ce6b-ce6c-ce6d-ce6e) | <abbr title="{{ CE6b }}">CE6b</abbr>, <abbr title="{{ CE6c }}">CE6c</abbr>, <abbr title="{{ CE6d }}">CE6d</abbr>, <abbr title="{{ CE6e }}">CE6e</abbr> |

