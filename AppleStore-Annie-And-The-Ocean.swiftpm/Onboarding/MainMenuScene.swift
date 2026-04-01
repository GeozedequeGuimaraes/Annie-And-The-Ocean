//
//  Annie-And-The-Ocean
//
import SpriteKit

class MainMenuScene: SKScene {

    private let transitionSound = SKAction.playSoundFileNamed("transition.mp4", waitForCompletion: false)

    override func didMove(to view: SKView) {
        AudioManager.shared.playMainAudio()

        let background = SKSpriteNode(imageNamed: "backgroundStart")
        let scaleFactor = self.size.width / background.size.width
        background.setScale(scaleFactor)
        background.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        self.addChild(background)

        let startButton = SKSpriteNode(imageNamed: "btn")
        startButton.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        startButton.name = "startButton"
        self.addChild(startButton)

        // Subtle pulse on start button
        let pulse = SKAction.sequence([
            SKAction.scale(to: 1.05, duration: 0.8),
            SKAction.scale(to: 1.0, duration: 0.8)
        ])
        startButton.run(SKAction.repeatForever(pulse))
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            self.run(transitionSound)
            let point = touch.location(in: self)
            let tappedNode = atPoint(point)

            if tappedNode.name == "startButton" {
                let scene = StoryScene(size: self.size)
                scene.scaleMode = self.scaleMode
                self.view?.presentScene(scene, transition: SKTransition.fade(withDuration: 0.8))
            }
        }
    }
}
