# Documento de Arquitectura

## 1. Introducción

### 1.1 Propósito
El propósito del documento es presentar un caso de estudio detallado sobre el desarrollo de un software a medida para "Muebles La Sabana". Este software busca mejorar la gestión operativa de la empresa, asegurando un crecimiento sostenible y el cumplimiento de obligaciones normativas.

### 1.2 Alcance
El documento cubre diversos aspectos del sistema, como el desarrollo de una aplicación frontend que tendrá los diferentes módulos identificados para el sistema, el desarrollo de una API Rest, el desarrollo de los microservicios, bases de datos y dando énfasis al requerimiento no funcional de seguridad.

### 1.3 Referencias
Los estándares y documentos relevantes para consultar incluyen normativas contables y de seguridad aplicables a la operación de "Muebles La Sabana", así como mejores prácticas en desarrollo de software y gestión de proyectos. (Considerar incluir normativas y estándares como ISO/IEC 27001 para seguridad de la información).

### 1.4 A quién va dirigido?
El Diagrama C1 (Contexto): Va dirigido a la gerencia y diferentes departamentos de Muebles La Sabana (negocio).
El Diagrama C2 (Contenedores):  Va dirigido a los arquitectos de software, líderes técnicos, al área de TI y al equpo de seguridad de la empresa.
El diagrama C3 (Componentes):  Va dirigido princpalmente a desarrolladores frontend y backend, a QAs.

## 2. Descripción General

### 2.1 Visión General del Sistema
El sistema es un software personalizado diseñado para gestionar las operaciones de "Muebles La Sabana", incluyendo pedidos, ventas, y finanzas. Facilita el crecimiento orgánico de la empresa y asegura el cumplimiento normativo.

El sistema opera en un contexto de alta complejidad operativa, donde "Muebles La Sabana" actúa como intermediario entre carpinteros locales y clientes, y debe gestionar transacciones y datos financieros de manera eficiente y segura.

**Características Funcionales**

Gestión de pedidos y ventas:

- Procesamiento de pedidos de clientes.
- Seguimiento de ventas realizadas y pedidos en curso.
- Gestión de la logística y la entrega de productos.

Gestión de Proveedores:

- Registro y gestión de carpinteros y otros proveedores.
- Asignación de pedidos a proveedores según disponibilidad y capacidad.

Gestión de inventario:

- Catálogo de productos que incluye información detallada sobre cada mueble.
- Gestión de inventarios para mantener un control de stock.

Gestión de Clientes:

- Registro de información de clientes, tanto Personas Jurídicas como Personas Naturales.
- Historial de compras y preferencias de clientes.

Módulo de Contabilidad:

- Registro de transacciones financieras.
- Gestión de facturación y cuentas por cobrar.
- Cumplimiento de obligaciones contables y fiscales.

Módulo de Tesorería:

- Gestión de pagos a proveedores.
- Control de flujo de caja.

Módulo de Reportes y análisis

- Genera módulos personalizados de los diferentes módulos mencionados anteriormente: Clientes, de Ventas, de Contabilidad, etc.


### 2.2 Requisitos Principales
Dentro de los requisitos funcionales del sistema para Muebles La Sabana se encuentran los que tienen que ver con el negocio y que abordan las diferentes características mencionadas en el apartado anterior, como por ejemplo el procesamiento de pedidos y ventas, control de inventarios, administración de clientes y proveedores, funcionalidades financieras (contabilidad y tesorería), creación de reportes.

En cuanto a requerimientos no funcionales, se priorizará el atributo de seguridad. Para ello el sistema deberá contar con las siguientes características.

- **Protección de datos sensibles**: se deberá identificar en las funcionalidades del negocio información sensible de los clientes y de los usuarios e implementar un estándar de cifrado robusto como aes256 , se deberán implementar unos controles rigurosos de acceso a las fuentes e datos de información crítica, cifrado de llaves simétricas y asimétricas, garantizar donde se cifra y se desencripta la información de manera segura.

- **Implementar un modelo  de autenticación y autorización basado en roles**: Se requiere un mecanismo que asegure que solo los usuarios autorizados pueden acceder a información y funcionalidades específicas.  Se puede adquirir un servicio en la nube que nos garantice una actualización continua respecto a las buenas prácticas de autorización y autenticación disminuyendo así los costos en infraestructura propios y el mantenimiento de las mismas.  Estos servicios ya nos ofrecen los mecanismos de autenticación reforzada como por ejemplo una autenticación multi factor MFA y por otro lado nos ofrece un modelo operativo de control de acceso basado en roles de acuerdo a la definición de matriz de roles.  Servicios en nube como Azure B2C, Identity Server, Oautho 2.0, JWT, mecanismos de cifrados de autenticación.  

- **Sistema de observabilidad**: Va a permitir recopilar métricas, logs, trazas del sistema y capturar todas las peticiones que se realizan desde el sistema de información incluyendo las diferentes autenticaciones que se realizan.  (Open telemetry, grafana, prometheus, elastic).  

- **Sistema de auditoría**: es el encargado de registrar, monitorear y analizar todas las actividades dentro del sistema. Este módulo captura y almacena cada acción realizada por los usuarios, incluyendo inicios de sesión, modificaciones de datos, transacciones financieras y accesos a información sensible. También permite la generaicón de informes para revisar las actividades, anomalías.  

- Establecer pruebas continuas de seguridad en el ciclo de vida del desarrollo, pruebas SAST, pruebas de hacking ético, pruebas DAST.  Estas pruebas se pueden implementar de forma continua e integral en el modelo CI/CD.

- Disminuir vulnerabilidades en el código y dinámico.  Para ello realizar análisis de código estático en SONAR.

## 3. Diagramas de Arquitectura modelo C4

### 3.1 Context Diagram (C1):

Este diagrama muestra el Sistema de Gestión de Muebles la Sabana como elementro central.  Este sistema interactua con usuarios (empleados, clientes, proveedores) y con dos sistemas externos que son el sistema de auditoría (registra y monitorea actividades críticas) y el sistema de observabilidad (recopila métricas, trazas, logs en tiempo real).

### 3.2 Container Diagram (C2):

El diagrama C2 (Contenedores) muestra los contenedores que componen el Sistema de Gestión Muebles La Sabana. En el diagrama se observa la Aplicación Web frontend, la API REST que sirve como backend, y varios microservicios o módulos que manejan funcionalidades específicas como Gestión de Inventario, Ventas, Clientes, Proveedores, Contabilidad, Tesorería, y Reportes. También incluye las bases de datos: una transaccional para operaciones del negocio, otra para auditoría, y una tercera para gestión de usuarios. El diagrama C2 ilustra cómo estos contenedores se comunican entre sí y con los sistemas externos identificados en el C1.

- **Frontend Web Application:** La interfaz de usuario utilizada por clientes, proveedores y administradores para interactuar con el sistema.

- **API Rest Backend Application**  : Contiene la lógica de negocio principal, procesando las solicitudes del frontend y coordinando la comunicación con otros servicios.

- **Authentication & Authorization Service:** Un servicio dedicado a manejar la seguridad, autenticando usuarios y autorizando acciones según sus roles y permisos.

- **Microservicios**: Cada uno de los requerimientos funcionales están representados como microservicios (Gestión de inventario, ventas, clientes, proveedores, contabilidad, tesorería, reportes. )

**Databases:**:
Transaccional: Almacena toda la información del sistema, incluyendo credenciales, datos de clientes, pedidos.
Auditoría: Almacena registros de eventos y accesos
Usuarios: Gestiona credenciales y perfiles de usuario  

**Atributo de Seguridad:**
- Authentication & Authorization Service: Garantiza que solo usuarios autorizados puedan acceder a funcionalidades del sistema. 
- Servicio de Auditoria: Registra eventos de seguridad y accesos.

**Sistema de Observabilidad**: Aunque es un sistema externo, se muestra su interacción con todos los contenedores para la recopilación de métricas, logs y trazas.

### 3.3 Diagrama de componetes(C3):
En este diagrama se muestra los componentes de la aplicación web frontend. En este ejemplo se muestran los componentes como el Framework SPA (React/Angular/Vue), el Módulo de Enrutamiento, los módulos  de funcionalidad (Inventario, Ventas, etc.), el Módulo de Autenticación Frontend, y el Cliente API REST. También se muestra la interacción de estos componentes entre sí en el contenedor y con otros contendedores externos.

## 4. Detalles Técnicos

- **Tecnologías utilizadas:** El sistema se implementará utilizando tecnologías adecuadas para la gestión de datos sensibles y la seguridad, como cifrado de datos, autenticación de usuarios, y servidores seguros.
- **Componentes clave:** Descripción detallada de cada componente, incluyendo su funcionalidad y cómo interactúa con otros componentes.

## 5. Conclusión

Este documento de arquitectura proporciona una visión clara y detallada del sistema que se desarrollará para "Muebles La Sabana". A través de esta arquitectura, se garantizará que el sistema cumpla principalmente con el requisito de seguridad, aunque también se abordan otros requisitos como rendimiento, usabilidad, disponibilidad, y mantenibilidad. Los próximos pasos incluyen la validación de esta arquitectura con los equipos de desarrollo y la planificación de la implementación.

---
