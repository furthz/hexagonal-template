## ℹ️ Acerca

Plantilla para los microservicios de NexUx, está desarrollado en `Typescript` y `Node.js` . La arquitectura muestra el código base de una arquitectura Hexagonal; se están incluyendo varias herramientas para mejorar las buenas prácticas en el desarrollo de software.

### Quick Start

- Instalar dependencias
  ```bash
    npm install
  ```
- Iniciar el contenedor
  ```bash
    docker-compose up
  ```
- Detener el contenedor
  ```bash
  docker-compose down
  ```

### Configurar Debug

Para configurar el debug es necesario iniciar el docker-compose y agregar la siguiente configuración en el IDE de Visual Code

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "type": "node",
      "request": "attach",
      "name": "Attach to docker",
      "restart": true,
      "port": 9229,
      "remoteRoot": "/project"
    }
  ]
}
```

## Features

- Construido usando Typescript
- Logger hecho con nexuxlog
- Pruebas unitarias con Jest
- Lint con ESLint
- Formatear con Prettier
- Contenerizado con Docker
- Git hooks con Husky
- Mensajes de Commit con Conventional Commits

### Scripts

| comando                     | descripción                                                    |
| --------------------------- | -------------------------------------------------------------- |
| `npm run build`             | Construir el proyecto y generar los archivos finales           |
| `npm run build:compile`     | Compilar los objetos                                           |
| `npm run build:clean`       | Eliminar la compilación anterior                               |
| `npm run check:format`      | Verificar si el proyecto está formateado correctamente         |
| `npm run check:lint`        | Verificar si el proyecto está con lint correctamente           |
| `npm run check:packagejson` | Verificar si el package.json del proyecto es correcto          |
| `npm run check:markdown`    | Verificar si los archivos markdown son correctos               |
| `npm run commit`            | Ayuda a generar los commits siguiendo commits convencionales   |
| `npm run fix:format`        | Corrige problemas de formato                                   |
| `npm run fix:lint`          | Corrige problemas del lint                                     |
| `npm run check:staged`      | Verifica y corrige archivos staged                             |
| `npm run test`              | Ejecuta todos los test                                         |
| `npm run test:unit`         | Ejecuta las pruebas unitarias                                  |
| `npm run test:watch`        | Ejecuta test en modo watch                                     |
| `npm run version`           | Genera una nueva versión del proyecto                          |
| `npm run reset-hard`        | Resetear el repositorio git para limpiar el estado             |
| `npm run prepare-release`   | Prepara el proyecto para un release y generar un nuevo release |
| `npm run update-deps`       | Actualiza las dependencias del proyecto                        |
