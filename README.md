<div align="center">

# Annie and the ocean

Swift Playground — WWDC23 Swift Student Challenge Winner

[![Swift](https://img.shields.io/badge/Swift-FA7343?style=for-the-badge&logo=swift&logoColor=white)](https://swift.org)
[![SwiftUI](https://img.shields.io/badge/SwiftUI-0D96F6?style=for-the-badge&logo=swift&logoColor=white)](https://developer.apple.com/xcode/swiftui/)
[![SpriteKit](https://img.shields.io/badge/SpriteKit-000000?style=for-the-badge&logo=apple&logoColor=white)](https://developer.apple.com/spritekit/)
[![WWDC23](https://img.shields.io/badge/WWDC23-Winner-gold?style=for-the-badge&logo=apple&logoColor=white)](https://developer.apple.com/wwdc23/swift-student-challenge/)

<img src="https://github.com/GeozedequeGuimaraes/Demeter/assets/74778769/2d9e8475-6ca1-4b54-a89f-571dd00e5a8d" width="700" alt="Annie And The Ocean - Main Screen"/>

</div>

---

## Sobre o projeto

Annie and the Ocean é um jogo interativo feito como Swift Playground, submetido ao [WWDC 2023 Swift Student Challenge](https://developer.apple.com/wwdc23/swift-student-challenge/) e selecionado como vencedor.

O jogador controla Annie, uma tartaruga marinha verde que navega pelas profundezas do oceano desviando de tubarões e lixo enquanto busca comida e um lugar seguro. O jogo aborda a poluição dos oceanos e seu impacto na vida marinha através de uma narrativa imersiva.

O projeto tem onboarding narrativo com uma história ilustrada em múltiplas cenas antes do gameplay, dificuldade progressiva conforme o tempo de sobrevivência, parallax scrolling com cinco camadas de fundo e física de colisão nativa do SpriteKit.

---

## Tecnologias

- Swift — linguagem principal
- - SwiftUI — shell do app e ciclo de vida
  - - SpriteKit — renderização, física, colisões e animações
    - - AVFoundation — música e efeitos sonoros
     
      - ---

      ## Como executar

      1. Clone este repositório
      2. 2. Abra `AppleStore-Annie-And-The-Ocean.swiftpm` no Xcode ou no Swift Playgrounds (iPad/Mac)
         3. 3. Pressione `Cmd + R` para rodar
           
            4. Requisitos: Xcode 14+ ou Swift Playgrounds 4+ · iOS 15.2+
           
            5. ---
           
            6. ## Arquitetura
           
            7. ```
               AppleStore-Annie-And-The-Ocean.swiftpm/
               ├── Default/
               │   ├── MyApp.swift
               │   ├── ContentView.swift
               │   └── AudioManager.swift
               ├── Onboarding/
               │   ├── MainMenuScene.swift
               │   ├── StoryScene.swift
               │   ├── Story1Scene.swift
               │   ├── Story2Scene.swift
               │   └── Story3Scene.swift
               ├── Scenes/
               │   ├── GameScene.swift
               │   └── ObjetoAnimado.swift
               ├── Assets.xcassets/
               └── Resources/
               ```

               ---

               ## Demo

               <div align="center">
               https://github.com/GeozedequeGuimaraes/Annie-And-The-Ocean/raw/main/Screenshots/demo.mp4
               </div>div>

               ---

               ## Screenshots

               <div align="center">
               <img src="https://github.com/GeozedequeGuimaraes/Demeter/assets/74778769/a1ebe480-dece-4ba0-9c9e-5429865ebc54" width="340" alt="Annie And The Ocean - Gameplay"/>
               &nbsp;&nbsp;
               <img src="https://github.com/GeozedequeGuimaraes/Demeter/assets/74778769/e1672bb3-fd68-4eb9-a931-55dac3848753" width="340" alt="Annie And The Ocean - Ocean Scene"/>
               </div>div>

               ---

               ## Autor

               <div align="center">

               Geozedeque Guimarães — Estudante de Ciência da Computação, CIn-UFPE

               [![GitHub](https://img.shields.io/badge/GitHub-181717?style=flat-square&logo=github&logoColor=white)](https://github.com/GeozedequeGuimaraes)
               [![LinkedIn](https://img.shields.io/badge/LinkedIn-0A66C2?style=flat-square&logo=linkedin&logoColor=white)](https://linkedin.com/in/geozedeque-guimaraes)

               </div>
