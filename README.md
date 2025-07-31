# 🎓 Sistema Seguro de Inscripción y Chat Universitario

Desarrollado por **Jorge G. Olarte**  
**Universidad Nacional del Altiplano – Ingeniería de Sistemas**

## Descripción General

Plataforma web para la gestión académica que permite el registro de usuarios, inscripción a cursos y chat entre estudiantes. El enfoque principal está en la seguridad de la base de datos, validación de entradas y auditoría de acciones a través de procedimientos almacenados y triggers.

## Funcionalidades Principales

- Registro y Login Seguros  
  - Validación con CAPTCHA
  - Verificación de email y usuario con expresiones regulares  
  - Contraseñas encriptadas con SHA-512
  - Prevención de inyecciones SQL usando `prepare()` y `bind_param()`

- Sistema de Inscripción a Cursos
  - Inscripción permitida solo a cursos del departamento del usuario
  - Visualización de chats disponibles tras la inscripción

- Chat con Funciones CRUD  
  - Chat por curso con opción de **publicar, editar y eliminar** mensajes  
  - Solo se pueden modificar o eliminar mensajes propios

- Auditoría y Seguridad en Base de Datos  
  - Uso de triggers y procedimientos almacenados para registrar cambios  
  - Estructura normalizada y control de integridad referencial  
  - Control de sesiones y logout seguro

## Tecnologías Utilizadas

- **Backend:** PHP (sin frameworks)
- **Base de datos:** MySQL  
- **Frontend:** HTML, CSS, JavaScript, AJAX  
- **Seguridad:** CAPTCHA, SHA-512, consultas preparadas

## Mejoras Futuras

- Agregar soporte para roles de administradores/docentes  
- Implementar chat en tiempo real con WebSockets  
- Mejorar la interfaz con un framework moderno (ej. React)  
- Añadir soporte multilenguaje

