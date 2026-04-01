//
//  Annie-And-The-Ocean
//
import SpriteKit

class Story1Scene: SKScene {

    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "StoryScene2")
        let scaleFactor = self.size.width / background.size.width
        background.setScale(scaleFactor)
        background.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        self.addChild(background)

        // Main turtle
        let turtle = SKSpriteNode(imageNamed: "turtle")
        turtle.position = CGPoint(x: self.size.width / 2 - 310, y: self.size.height / 2 + 390)
        self.addChild(turtle)

        let ripple = SKAction.sequence([
            SKAction.scale(to: 1.05, duration: 2.0),
            SKAction.scale(to: 0.95, duration: 2.0)
        ])
        turtle.run(SKAction.repeatForever(ripple))

        let swim = SKAction.sequence([
            SKAction.moveBy(x: 50, y: 20, duration: 2.0),
            SKAction.moveBy(x: 50, y: -20, duration: 2.0)
        ])
        let rotate = SKAction.rotate(byAngle: 0.2, duration: 0.3)
        turtle.run(SKAction.repeatForever(SKAction.sequence([swim, rotate, swim.reversed(), rotate.reversed()])))

        // Pollution items with pulsing animation
        addPulsingItem("straw", size: CGSize(width: 110, height: 140),
                       pos: CGPoint(x: self.size.width / 2 - 620, y: self.size.height / 3 + 350))
        addPulsingItem("plastic", size: CGSize(width: 130, height: 120),
                       pos: CGPoint(x: self.size.width / 2 - 600, y: self.size.height / 3 + 130))

        // Green turtle
        let turtleGreen = SKSpriteNode(imageNamed: "turtleGreen")
        turtleGreen.size = CGSize(width: 270, height: 220)
        turtleGreen.position = CGPoint(x: self.size.width / 3 - 90, y: self.size.height / 3 + 140)
        self.addChild(turtleGreen)

        let tiltAngle = CGFloat(5.0 / 210.0 * .pi)
        let tiltAnim = SKAction.sequence([
            SKAction.rotate(toAngle: -tiltAngle, duration: 1.3),
            SKAction.rotate(toAngle: tiltAngle, duration: 1.3)
        ])
        turtleGreen.run(SKAction.repeatForever(tiltAnim))

        // Shark
        let shark = SKSpriteNode(imageNamed: "shark")
        shark.size = CGSize(width: 470, height: 430)
        shark.position = CGPoint(x: self.size.width - 320, y: self.size.height / 2 + 60)
        self.addChild(shark)
        shark.run(SKAction.repeatForever(tiltAnim))

        // Next button
        let nextButton = SKSpriteNode(imageNamed: "btnNext")
        nextButton.position = CGPoint(x: self.size.width / 4 * 3 + 200, y: self.size.height / 4 + 60)
        nextButton.name = "nextButton"
        self.addChild(nextButton)
    }

    private func addPulsingItem(_ image: String, size: CGSize, pos: CGPoint) {
        let item = SKSpriteNode(imageNamed: image)
        item.size = size
        item.position = pos
        self.addChild(item)

        let scale = SKAction.sequence([
            SKAction.scale(to: 0.9, duration: 0.8),
            SKAction.scale(to: 1.0, duration: 0.8)
        ])
        let blink = SKAction.sequence([
            SKAction.fadeAlpha(to: 0.6, duration: 0.5),
            SKAction.fadeAlpha(to: 1.0, duration: 0.5)
        ])
        item.run(SKAction.repeatForever(scale))
        item.run(SKAction.repeatForever(blink))
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let point = touch.location(in: self)
            let tappedNode = atPoint(point)

            if tappedNode.name == "nextButton" {
                let scene = Story2Scene(size: self.size)
                scene.scaleMode = self.scaleMode
                self.view?.presentScene(scene, transition: SKTransition.fade(withDuration: 0.5))
            }
        }
    }
}
