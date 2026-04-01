<div align="center">

# 🐢 Annie And The Ocean

### Swift Playground — WWDC23 Swift Student Challenge Winner

[![Swift](https://img.shields.io/badge/Swift-FA7343?style=for-the-badge&logo=swift&logoColor=white)](https://swift.org)
[![SwiftUI](https://img.shields.io/badge/SwiftUI-0D96F6?style=for-the-badge&logo=swift&logoColor=white)](https://developer.apple.com/xcode/swiftui/)
[![SpriteKit](https://img.shields.io/badge/SpriteKit-000000?style=for-the-badge&logo=apple&logoColor=white)](https://developer.apple.com/spritekit/)
[![WWDC23](https://img.shields.io/badge/WWDC23-Winner-gold?style=for-the-badge&logo=apple&logoColor=white)](https://developer.apple.com/wwdc23/swift-student-challenge/)

<img src="https://github.com/GeozedequeGuimaraes/Demeter/assets/74778769/2d9e8475-6ca1-4b54-a89f-571dd00e5a8d" width="700" alt="Annie And The Ocean - Main Screen"/>

</div>

---

## About

**Annie And The Ocean** is an interactive game built as a Swift Playground, submitted to the [WWDC 2023 Swift Student Challenge](https://developer.apple.com/wwdc23/swift-student-challenge/) and selected as a **winner**.

You play as **Annie**, a brave green sea turtle navigating through dangerous ocean depths — dodging sharks and trash — while searching for food and a safe haven. The game raises awareness about **ocean pollution** and its impact on marine life through an immersive storytelling experience.

### Highlights

- **Narrative onboarding** — a multi-scene illustrated story introduces Annie's world before gameplay
- **Progressive difficulty** — the ocean gets more dangerous the longer you survive
- **Parallax scrolling** — five layered backgrounds create depth and immersion
- **Physics-based gameplay** — tap to swim, dodge enemies, and collect seaweed

---

## Tech Stack

| Technology | Role |
|---|---|
| **Swift** | Core language |
| **SwiftUI** | App shell and lifecycle |
| **SpriteKit** | Rendering, physics, collisions, and animation |
| **AVFoundation** | Background music and sound effects |

---

## How to Run

1. Clone this repository
2. Open `AppleStore-Annie-And-The-Ocean.swiftpm` in **Xcode** or **Swift Playgrounds** (iPad/Mac)
3. Press **Cmd + R** to build and run

> **Requirements:** Xcode 14+ or Swift Playgrounds 4+ · iOS 15.2+

---

## Architecture

```
AppleStore-Annie-And-The-Ocean.swiftpm/
├── Default/
│   ├── MyApp.swift              # App entry point
│   ├── ContentView.swift        # SwiftUI → SpriteKit bridge
│   └── AudioManager.swift       # Centralized audio management
├── Onboarding/
│   ├── MainMenuScene.swift      # Title screen
│   ├── StoryScene.swift         # Story part 1 — the beach
│   ├── Story1Scene.swift        # Story part 2 — the dangers
│   ├── Story2Scene.swift        # Story part 3 — ocean pollution
│   └── Story3Scene.swift        # Story part 4 — transition to game
├── Scenes/
│   ├── GameScene.swift          # Main gameplay loop
│   └── ObjetoAnimado.swift      # Animated sprite base class
├── Assets.xcassets/             # All visual assets
└── Resources/                   # Audio files
```

---

## Demo

<div align="center">

https://github.com/GeozedequeGuimaraes/Annie-And-The-Ocean/raw/main/Screenshots/demo.mp4

</div>

---

## Screenshots

<div align="center">
  <img src="https://github.com/GeozedequeGuimaraes/Demeter/assets/74778769/a1ebe480-dece-4ba0-9c9e-5429865ebc54" width="340" alt="Annie And The Ocean - Gameplay"/>
  &nbsp;&nbsp;
  <img src="https://github.com/GeozedequeGuimaraes/Demeter/assets/74778769/e1672bb3-fd68-4eb9-a931-55dac3848753" width="340" alt="Annie And The Ocean - Ocean Scene"/>
</div>

---

## Author

<div align="center">

**Geozedeque Guimarães**
Computer Science — CIn-UFPE

[![GitHub](https://img.shields.io/badge/GitHub-181717?style=flat-square&logo=github&logoColor=white)](https://github.com/GeozedequeGuimaraes)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-0A66C2?style=flat-square&logo=linkedin&logoColor=white)](https://linkedin.com/in/geozedeque-guimaraes)

</div>
