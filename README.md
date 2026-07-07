# Eventify Hosts Mobile App

Aplicación móvil para anfitriones de la plataforma **Eventify**, desarrollada con Flutter. Permite a los anfitriones gestionar eventos, administrar información relevante y ofrecer una experiencia optimizada desde dispositivos móviles.

---

## 📱 Tecnologías

- **Flutter**
- **Dart**

---

## 🏗 Arquitectura

El proyecto está construido utilizando una arquitectura modular basada en buenas prácticas de Flutter, con énfasis en la separación de responsabilidades y la escalabilidad.

### Gestión de estado
- Riverpod
- Flutter Riverpod

### Navegación
- GoRouter

### Networking
- Dio

### Serialización
- json_serializable
- json_annotation

### Modelos inmutables
- Freezed

### Almacenamiento local
- Flutter Secure Storage
- Shared Preferences

### Internacionalización
- intl
- flutter_localizations

### Utilidades
- UUID
- URL Launcher
- Image Picker
- Google Fonts

---

## 🚀 Requisitos

- Flutter SDK >= **3.0.0**
- Dart SDK >= **3.0.0**
- Android Studio o Visual Studio Code
- Xcode (para compilación en iOS)

---

## 📦 Dependencias principales

| Dependencia | Descripción |
|--------------|-------------|
| flutter_riverpod | Gestión de estado |
| riverpod | Inyección de dependencias |
| dio | Cliente HTTP |
| go_router | Navegación declarativa |
| flutter_secure_storage | Almacenamiento seguro |
| shared_preferences | Persistencia de preferencias |
| freezed | Modelos inmutables |
| json_serializable | Serialización JSON |
| google_fonts | Tipografías de Google |
| intl | Internacionalización |
| image_picker | Selección de imágenes |
| url_launcher | Apertura de enlaces externos |
| uuid | Generación de identificadores únicos |

---

## 🔒 Almacenamiento

El proyecto utiliza:

- **Flutter Secure Storage** para información sensible como tokens o credenciales.
- **Shared Preferences** para configuraciones y preferencias del usuario.

---

## 📐 Estándares del proyecto

- Null Safety
- Flutter Lints
- Material Design 3
- Generación automática de código con Build Runner
