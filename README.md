# Inception

### ¿Qué es Docker?
Docker es una potente plataforma de código abierto que utiliza contenedores para simplificar la creación, despliegue y ejecución de aplicacioes. Estos contenedores permiten a los desarrolladores empaquetar una aplicación con todos sus componentes necesarios, como bibliotecas y otras dependencias, y enviarla como un único paquete.

### Conceptos claves
1. _Docker Engine:_ Este es el núcleo de Docker, es responsable de la construcción, ejecución y gestión de contenedores.
2. _Docker Image:_ Una snapshot de un sistema de archivos que incluye todas las cosas que necesitamos para ejecutar una aplicación, imágenes padre, libs...
3. _Docker Container:_ Una instancia de una imagen Docker que se puede ejecutar, iniciar, detener, mover y eliminar. Los contenedores están aislados entre sí y del sistema anfitrión.
4. _Dockerfile:_ Un archivo de texto que contiene un conjunto de instrucciones para construir una imagen Docker. Define la imagen base, añade código de aplicación, establece variables de entorno y configura el comportamiento del contenedor.
5. _Docker Hub:_ Un registro público basado en la nube donde se pueden almacenar, compartir y distribuir imágenes Docker. Docker Hub proporciona un amplio repositorio de imágenes públicas que pueen utilizarse como base para sus contenedores.
6. _Docker Compose:_ Una herramienta para definir y ejecutar aplicaciones multicontenedor utilizando un simple archivo YML. Permite definir los servicios, redes y volúmenes para su pila de aplicaciones.
7. _Docker Daemon:_ escucha las peticiones de la API de DOcker y gestiona objetos Docker como imágene, contenedores, redes y volúmenes.
8. _Docker namespaces:_ Docker utiliza una tecnología llamada namespaces para proporcionar un espacio de trabajo aislado llamado contenedor. Cuando ejecutas un contenedor, Docker crea un conjunto de namespaces para ese contenedor. Estos espacios de nombres proporcionan una capa de aislamiento espacio de nombres y su acceso está limitado a los espacios de nombres.
