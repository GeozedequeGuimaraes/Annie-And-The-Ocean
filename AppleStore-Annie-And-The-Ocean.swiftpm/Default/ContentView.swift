import SwiftUI
import SpriteKit

struct ContentView: View {
    var scene: SKScene {
        let scene = MainMenuScene(size: CGSize(width: 1536, height: 2048))
            scene.scaleMode = .aspectFill
            return scene
        }
    var body: some View {
        VStack {
            SpriteView(scene: scene)
            .ignoresSafeArea()
        }
    }
}
