
## 1. Title and Description
- **WalkieTalkie**
- Digital walkie-talkie app for iOS.
- Allows users to register and log in, join communication channels, view the list of connected users in real-time, and talk through push-to-talk functionality.

## 2. Technologies and Architecture
- Programming Language: Swift
- Architecture: VIPER
- Principles: SOLID, Repository, Delegate Pattern
- UI Framework: UIKit
- Uses `.xib`

## 3. Main Features
- Register and Login with API
- Real-time audio communication with WebSocket
- Management of connected users count
- Disconnection handling and UI states

## 4. Project Structure
```plaintext
WalkieTalkie/
│
├── Register/       # Register Module (VIPER)
├── Login/          # Login Module (VIPER)
├── Channel/        # Channel Module (VIPER)
├── Channels/       # Channels Module (VIPER)
│
├── Services/       # Reusable services (AudioService, WebSocketService)
├── Repositories/   # Networking and persistence logic
├── Networking/     # API configuration, Endpoints, URLSession
├── Components/     # Reusable UI components (Keyboard handling, TextField)
│
├── Tests/          # Unit Tests and Integration Tests
├── UITests/        # UI and E2E Tests
│
```

## 5. Installation and Setup
- iOS 18.5
- Swift 5

## 6. Usage
- How to run the app in the simulator: **Cmd+R**
- How to run the tests: **Cmd+U** in Xcode or `xcodebuild test`
- Example flow: **Login → Join a channel → Connect with users**

## 7. Testing
- Framework used: **XCTest**
- Strategy: Unit Tests, Integration Tests, UI Tests, E2E Tests
