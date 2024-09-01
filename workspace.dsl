workspace {
    model {
        properties {
            "structurizr.groupSeparator" "/"
        }

        usuario = person "Usuario"
        ss_sistemaAuditoria = softwareSystem "Sistema de Auditoría"
        
        ss_mueblesSabana = softwareSystem "Sistema de Gestión Muebles La Sabana" {
            ctn_webapp = container "Frontend - Aplicacion Web" {
                cmp_spaFramework = component "Framework SPA (React/Angular/Vue)"
                cmp_routingModule = component "Módulo de Enrutamiento"
                cmp_authModule = component "Módulo de Autenticación Frontend"
                cmp_inventarioModule = component "Módulo de Inventario"
                cmp_ventasModule = component "Módulo de Ventas"
                cmp_clientesModule = component "Módulo de Clientes"
                cmp_proveedoresModule = component "Módulo de Proveedores"
                cmp_contabilidadModule = component "Módulo de Contabilidad"
                cmp_tesoreriaModule = component "Módulo de Tesorería"
                cmp_reportesModule = component "Módulo de Reportes"
                cmp_apiClientModule = component "Cliente API REST"
            }
            ctn_api = container "API REST"
            
            ctn_autenticacion = container "Módulo de Autenticación y Autorización" {
                tags "Microservices"
            }
            
            ctn_inventario = container "Gestión de Inventario" {
                tags "Microservices"
            }
            
            ctn_ventas = container "Gestión de Pedidos y Ventas" {
                tags "Microservices"
            }
            
            ctn_clientes = container "Gestión de Clientes" {
                tags "Microservices"
            }
            
            ctn_proveedores = container "Gestión de Proveedores" {
                tags "Microservices"
            }
            
            ctn_contabilidad = container "Contabilidad y Finanzas" {
                tags "Microservices"
            }
            
            ctn_tesoreria = container "Tesorería" {
                tags "Microservices"
            }
            
            ctn_reportes = container "Reportes y Análisis" {
                tags "Microservices"
            }
            
            ctn_baseDatosTransaccional = container "Base de Datos Transaccional" {
                tags "Database"
            }
            
            ctn_baseDatosAuditoria = container "Base de Datos de Auditoría" {
                tags "Database"
            }
            
            ctn_baseDatosUsuarios = container "Base de Datos de Usuarios" {
                tags "Database"
            }
        }
        
        usuario -> ctn_webapp "Utiliza"
        ss_sistemaAuditoria -> ss_mueblesSabana "Audita"
        
        ctn_webapp -> ctn_api "Usa"
        ctn_api -> ctn_autenticacion "Valida accesos"
        ctn_api -> ctn_inventario "Gestiona"
        ctn_api -> ctn_ventas "Procesa"
        ctn_api -> ctn_clientes "Administra"
        ctn_api -> ctn_proveedores "Gestiona"
        ctn_api -> ctn_contabilidad "Registra"
        ctn_api -> ctn_tesoreria "Controla"
        ctn_api -> ctn_reportes "Genera"
        
        ctn_autenticacion -> ctn_baseDatosUsuarios "Lee/Escribe"
        ctn_inventario -> ctn_baseDatosTransaccional "Lee/Escribe"
        ctn_ventas -> ctn_baseDatosTransaccional "Lee/Escribe"
        ctn_clientes -> ctn_baseDatosTransaccional "Lee/Escribe"
        ctn_proveedores -> ctn_baseDatosTransaccional "Lee/Escribe"
        ctn_contabilidad -> ctn_baseDatosTransaccional "Lee/Escribe"
        ctn_tesoreria -> ctn_baseDatosTransaccional "Lee/Escribe"
        ctn_reportes -> ctn_baseDatosTransaccional "Lee"
        
        ss_sistemaAuditoria -> ctn_baseDatosAuditoria "Registra auditorías"
        ctn_api -> ctn_baseDatosAuditoria "Registra eventos de auditoría"

        // Relaciones para el frontend
        cmp_spaFramework -> cmp_routingModule "Utiliza para navegación"
        cmp_routingModule -> cmp_authModule "Redirige para autenticación"
        cmp_authModule -> cmp_apiClientModule "Realiza peticiones de autenticación"
        cmp_inventarioModule -> cmp_apiClientModule "Realiza peticiones de inventario"
        cmp_ventasModule -> cmp_apiClientModule "Realiza peticiones de ventas"
        cmp_clientesModule -> cmp_apiClientModule "Realiza peticiones de clientes"
        cmp_proveedoresModule -> cmp_apiClientModule "Realiza peticiones de proveedores"
        cmp_contabilidadModule -> cmp_apiClientModule "Realiza peticiones de contabilidad"
        cmp_tesoreriaModule -> cmp_apiClientModule "Realiza peticiones de tesorería"
        cmp_reportesModule -> cmp_apiClientModule "Realiza peticiones de reportes"
        
        cmp_apiClientModule -> ctn_api "Realiza peticiones HTTP"
    }
    
    views {
        systemContext ss_mueblesSabana "Contexto" {
            include *
            autoLayout
        }
        
        container ss_mueblesSabana "Contenedores" {
            include *
            include usuario
            include ss_sistemaAuditoria
            autoLayout
        }
        
        component ctn_webapp "ComponentesFrontend" {
            include *
            include ctn_api
            autoLayout
        }
        
        styles {
            element "Database" {
                shape Cylinder
            }
            element "Microservices" {
                shape Hexagon
            }
        }
        
        theme default
    }
}