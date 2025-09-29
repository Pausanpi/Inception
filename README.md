# Inception - Docker Infrastructure Project

## 🎯 Descripción General

Este proyecto implementa una infraestructura completa usando Docker Compose con tres servicios principales:
- **NGINX**: Servidor web con SSL/TLS
- **WordPress**: CMS con PHP-FPM
- **MariaDB**: Base de datos

Todo el stack funciona de manera containerizada y se accede via HTTPS a través del dominio `pausanch.42.fr`.

## 🏗️ Arquitectura del Proyecto

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│     NGINX       │    │   WORDPRESS     │    │    MARIADB      │
│   (Port 443)    │◄──►│   (Port 9000)   │◄──►│   (Port 3306)   │
│   SSL Reverse   │    │   PHP-FPM       │    │   Database      │
│   Proxy         │    │   CMS           │    │   Server        │
└─────────────────┘    └─────────────────┘    └─────────────────┘
         │                       │                       │
         └───────────────────────┼───────────────────────┘
                                 │
                    ┌─────────────────┐
                    │   Docker Host   │
                    │  pausanch.42.fr │
                    └─────────────────┘
```

## 📁 Estructura del Proyecto

```
refactorizado/
├── Makefile                    # Comandos de gestión del proyecto
├── README.md                   # Este archivo
└── srcs/
    ├── docker-compose.yml      # Orchestación de contenedores
    ├── .env                    # Variables de entorno
    └── requirements/
        ├── nginx/
        │   ├── Dockerfile      # Imagen de NGINX
        │   ├── conf/
        │   │   └── nginx.conf  # Configuración del servidor
        │   └── tools/
        │       └── nginx_start.sh  # Script de inicialización
        ├── wordpress/
        │   ├── Dockerfile      # Imagen de WordPress
        │   ├── conf/
        │   │   └── www.conf    # Configuración PHP-FPM
        │   └── tools/
        │       └── wp.sh       # Script de setup de WordPress
        └── mariadb/
            ├── Dockerfile      # Imagen de MariaDB
            ├── conf/
            │   └── my.cnf      # Configuración de la base de datos
            └── tools/
                └── db.sh       # Script de inicialización de DB
```

## 🚀 Guía de Uso

### Prerequisitos
- Docker y Docker Compose instalados
- Permisos de sudo (para modificar /etc/hosts)

### Instalación y Ejecución

1. **Clonar y posicionarse en el directorio:**
   ```bash
   cd refactorizado/
   ```

2. **Levantar toda la infraestructura:**
   ```bash
   make
   # o alternativamente:
   make up
   ```

3. **Acceder al sitio:**
   - Abrir navegador y ir a: `https://pausanch.42.fr`
   - El certificado SSL es auto-firmado (aceptar la advertencia del navegador)

### Comandos Disponibles

```bash
make up      # Inicia todos los servicios
make down    # Para todos los contenedores
make clean   # Limpia contenedores, imágenes y volúmenes
make re      # Reconstruye todo desde cero
```

## 🔧 Componentes Detallados

### 🌐 NGINX (Servidor Web)
**Ubicación:** `requirements/nginx/`

**Funcionalidades:**
- Servidor HTTPS con certificado SSL auto-generado
- Proxy reverso hacia WordPress (PHP-FPM)
- Redirección automática HTTP → HTTPS
- Configuración optimizada para WordPress

**Características técnicas:**
- Puerto 443 (HTTPS) y 80 (HTTP redirect)
- Certificado SSL generado con OpenSSL
- Configuración con FastCGI para PHP
- Validaciones de conectividad con WordPress

**Script de inicialización:** `nginx_start.sh`
- Genera certificados SSL si no existen
- Espera a que WordPress esté disponible
- Valida configuración antes de iniciar
- Logs detallados para debugging

### 💻 WordPress (CMS)
**Ubicación:** `requirements/wordpress/`

**Funcionalidades:**
- CMS completo con PHP-FPM 7.4
- Instalación automática via WP-CLI
- Configuración de usuarios admin y regular
- Tema Bedrock pre-instalado

**Características técnicas:**
- Puerto 9000 (PHP-FPM)
- Conexión a MariaDB
- Instalación automática en primer arranque
- Gestión de permisos de archivos

**Script de inicialización:** `wp.sh`
- Descarga WordPress con WP-CLI
- Crea configuración de base de datos
- Instala WordPress con datos del .env
- Crea usuarios admin y regular
- Configura permisos de archivos

### 🗄️ MariaDB (Base de Datos)
**Ubicación:** `requirements/mariadb/`

**Funcionalidades:**
- Servidor de base de datos MariaDB
- Configuración automática de usuarios y permisos
- Optimizada para WordPress
- Configuración de seguridad básica

**Características técnicas:**
- Puerto 3306
- Charset UTF8MB4 para soporte completo Unicode
- Usuario root y usuario específico para WordPress
- Configuración de socket Unix para mejor rendimiento

**Script de inicialización:** `db.sh`
- Inicializa directorio de datos si es necesario
- Configura contraseñas y usuarios
- Crea base de datos para WordPress
- Aplica configuraciones de seguridad

## 🔐 Configuración de Seguridad

### SSL/TLS
- Certificado auto-firmado (válido para desarrollo)
- Protocolos TLSv1.2 y TLSv1.3
- Redirección forzada HTTPS

### Base de Datos
- Usuario root restringido a localhost
- Usuario específico para WordPress con permisos limitados
- Eliminación de usuarios anónimos
- Contraseñas definidas en variables de entorno

### Sistema de Archivos
- Permisos apropiados para directorios web
- Archivos de configuración protegidos
- Volúmenes persistentes en el host

## 📝 Variables de Entorno

El archivo `.env` contiene todas las configuraciones:

```bash
# Dominio
DOMAIN_NAME=pausanch.42.fr

# Base de Datos
MYSQL_HOSTNAME=mariadb
MYSQL_DATABASE=pausanchdb
MYSQL_USER=pausanch
MYSQL_PASSWORD=inception
MYSQL_ROOT_PASSWORD=inception

# WordPress
WORDPRESS_TITLE=pausanchPage
WORDPRESS_ADMIN=pausanch_wordpress
WORDPRESS_ADMIN_PASS=inception
WORDPRESS_ADMIN_EMAIL=pausanch@42.fr
WORDPRESS_USER=pausanch
WORDPRESS_EMAIL=pausanchuser@42.fr
WORDPRESS_USER_PASS=inception
```

## 💾 Persistencia de Datos

Los datos se almacenan en el host en:
- `/home/pausanch/data/wordpress/` - Archivos de WordPress
- `/home/pausanch/data/mariadb/` - Datos de la base de datos

Esto garantiza que los datos persistan entre reinicios de contenedores.

## 🐛 Troubleshooting

### Problema: No se puede acceder a pausanch.42.fr
**Solución:** El Makefile automáticamente añade la entrada al /etc/hosts

### Problema: Certificado SSL no válido
**Solución:** Es normal, es auto-firmado. Aceptar la advertencia del navegador.

### Problema: WordPress no carga
**Solución:** 
1. Verificar que todos los contenedores están running: `docker ps`
2. Revisar logs: `docker logs wordpress` / `docker logs nginx`

### Problema: Error de conexión a base de datos
**Solución:**
1. Verificar contenedor MariaDB: `docker logs mariadb`
2. Comprobar variables de entorno en `.env`

## 🔄 Flujo de Inicialización

1. **MariaDB** se inicia primero y configura la base de datos
2. **WordPress** espera a MariaDB, se instala y configura
3. **NGINX** espera a WordPress, genera SSL y configura proxy
4. Sistema listo para usar en `https://pausanch.42.fr`

## 📊 Logs y Monitoreo

Para ver logs en tiempo real:
```bash
docker logs -f nginx      # Logs de NGINX
docker logs -f wordpress  # Logs de WordPress
docker logs -f mariadb    # Logs de MariaDB
```