//
//  Annie-And-The-Ocean
//
import SpriteKit

class Story2Scene: SKScene {

    private let textImages = ["text", "text1", "text2"]
    private let buttonImages = ["btn1", "btn2"]
    private var currentTextIndex = 0
    private var currentButtonIndex = 0
    private var canShowButton = true

    private var textNode: SKSpriteNode!
    private var tapButton: SKSpriteNode!

    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "StoryScene3")
        let scaleFactor = self.size.width / background.size.width
        background.setScale(scaleFactor)
        background.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        self.addChild(background)

        // Text display
        textNode = SKSpriteNode(imageNamed: textImages[currentTextIndex])
        textNode.size = CGSize(width: self.size.width / 2 + 200, height: 414)
        textNode.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2 + 230)
        self.addChild(textNode)

        // Tap button
        let buttonAnim = SKAction.animate(with: buttonImages.map { SKTexture(imageNamed: $0) }, timePerFrame: 0.5)
        tapButton = SKSpriteNode(imageNamed: buttonImages[currentButtonIndex])
        tapButton.size = CGSize(width: 65, height: 55)
        tapButton.position = CGPoint(x: self.size.width / 3 + 670, y: self.size.height / 2 + 75)
        tapButton.run(SKAction.repeatForever(buttonAnim), withKey: "buttonAnimation")
        self.addChild(tapButton)

        // Trash left
        addFloatingItem("trash1", size: CGSize(width: 315, height: 665),
                        pos: CGPoint(x: self.size.width / 2 - 595, y: self.size.height / 2 + 160),
                        amplitude: 14.0, period: 1.0)

        // Trash right
        addFloatingItem("trash2", size: CGSize(width: 315, height: 665),
                        pos: CGPoint(x: self.size.width / 2 + 595, y: self.size.height / 2 + 160),
                        amplitude: 14.0, period: 1.0)

        // Turtle
        let turtle = SKSpriteNode(imageNamed: "turtleGreen1")
        turtle.size = CGSize(width: self.size.width / 2 - 10, height: self.size.width / 2 - 410)
        turtle.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2 - 260)
        self.addChild(turtle)

        let tiltAngle = CGFloat.pi / 52
        let tiltRight = SKAction.rotate(toAngle: tiltAngle, duration: 1.6)
        tiltRight.timingMode = .easeInEaseOut
        let tiltLeft = SKAction.rotate(toAngle: -tiltAngle, duration: 1.6)
        tiltLeft.timingMode = .easeInEaseOut
        turtle.run(SKAction.repeatForever(SKAction.sequence([tiltRight, tiltLeft])))
    }

    private func addFloatingItem(_ image: String, size: CGSize, pos: CGPoint, amplitude: CGFloat, period: TimeInterval) {
        let item = SKSpriteNode(imageNamed: image)
        item.size = size
        item.position = pos
        self.addChild(item)

        let moveUp = SKAction.moveBy(x: 0, y: amplitude, duration: period)
        moveUp.timingMode = .easeInEaseOut
        item.run(SKAction.repeatForever(SKAction.sequence([moveUp, moveUp.reversed()])))
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard canShowButton else {
            for touch in touches {
                let tappedNode = atPoint(touch.location(in: self))
                if tappedNode.name == "nextButton" {
                    let scene = Story3Scene(size: self.size)
                    scene.scaleMode = self.scaleMode
                    self.view?.presentScene(scene, transition: SKTransition.fade(withDuration: 0.8))
                }
            }
            return
        }

        for touch in touches {
            let tappedNode = atPoint(touch.location(in: self))
            guard tappedNode == tapButton else { continue }

            currentTextIndex += 1
            if currentTextIndex >= textImages.count {
                currentTextIndex = textImages.count - 1
                canShowButton = false
                tapButton.removeFromParent()
                showNextButton()
            } else {
                textNode.texture = SKTexture(imageNamed: textImages[currentTextIndex])
            }

            currentButtonIndex = (currentButtonIndex + 1) % buttonImages.count
            animateButtonTransition()
        }
    }

    private func showNextButton() {
        let nextButton = SKSpriteNode(imageNamed: "btnNext")
        nextButton.position = CGPoint(x: self.size.width / 4 * 3 + 200, y: self.size.height / 4 + 60)
        nextButton.alpha = 0
        nextButton.name = "nextButton"
        self.addChild(nextButton)
        nextButton.run(SKAction.fadeIn(withDuration: 0.5))
    }

    private func animateButtonTransition() {
        tapButton.removeAction(forKey: "buttonAnimation")
        tapButton.run(SKAction.fadeOut(withDuration: 0.25)) { [weak self] in
            guard let self = self else { return }
            self.tapButton.texture = SKTexture(imageNamed: self.buttonImages[self.currentButtonIndex])
            self.tapButton.run(SKAction.fadeIn(withDuration: 0.25)) {
                let anim = SKAction.animate(with: self.buttonImages.map { SKTexture(imageNamed: $0) }, timePerFrame: 0.5)
                self.tapButton.run(SKAction.repeatForever(anim), withKey: "buttonAnimation")
            }
        }
    }
}
