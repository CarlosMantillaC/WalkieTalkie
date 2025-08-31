# 1. Título y Descripción
* WalkieTalkie
* Aplicación de walkie-talkie digital para iOS. 
* Permite a los usuarios registrarse e iniciar sesión, unirse a canales de comunicación, ver la lista de usuarios conectados en tiempo real y hablar mediante la funcionalidad push-to-talk.

# 2. Tecnologías y Arquitectura
* Lenguaje de programación: Swift
* Arquitectura: VIPER
* Principios: SOLID, Repository, Delegate Pattern
* Framework de UI: UIKit
* Uso de .XiB

# 3. Características principales
* Register y Login con API
* Comunicación de audio en tiempo real con WebSocket
* Gestión de cantidad de usuarios conectados
* Desconexión y estados de UI

# 4. Estructura del proyecto

WalkieTalkie/
│
├── Register/       # Módulo Register (VIPER)
├── Login/          # Módulo Login (VIPER)
├── Channel/        # Módulo Channel (VIPER)
├── Channels/       # Módulo Channels (VIPER)
│
├── Services/       # Servicios reutilizables (AudioService, WebSocketService)
├── Repositories/   # Lógica de red y persistencia
├── Networking/     # Configuración de API, Endpoints, URLSession
├── Components/     # Componentes de UI reutilizables (Configuración del teclado, TextField)
│
├── Tests/     # Unit Tests e Integration Tests
├── UITests/   # UI e E2E Tests
│

# 5. Instalación y Configuración
* iOS 18.5
* Swift 5

# 6. Uso
* Cómo correr la app en el simulador (Cmd+R)
* Cómo correr los tests (Cmd+U en Xcode o xcodebuild test)
* Ejemplo de flujo básico (Login → Entrar a un canal → Conectarse con usuarios)

# 7. Pruebas
* Framework usado (XCTest)
* Estrategia: Unit Tests, Integration Tests, UI Tests, E2E Tests
