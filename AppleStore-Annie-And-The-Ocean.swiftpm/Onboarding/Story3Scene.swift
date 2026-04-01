//
//  Annie-And-The-Ocean
//
import SpriteKit

class Story3Scene: SKScene {

    private let textImages = ["text3", "text4", "text5"]
    private let buttonImages = ["btn1", "btn2"]
    private var currentTextIndex = 0
    private var currentButtonIndex = 0
    private var canShowButton = true

    private var textNode: SKSpriteNode!
    private var tapButton: SKSpriteNode!

    private let transitionSound = SKAction.playSoundFileNamed("transition.mp4", waitForCompletion: false)

    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "StoryScene4")
        let scaleFactor = self.size.width / background.size.width
        background.setScale(scaleFactor)
        background.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        self.addChild(background)

        // Wave
        let wave = SKSpriteNode(imageNamed: "wave")
        wave.size = CGSize(width: self.size.width, height: self.size.height / 2)
        wave.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2 + 100)
        self.addChild(wave)

        let moveUp = SKAction.moveBy(x: 0, y: 90, duration: 2.5)
        let moveDown = SKAction.moveBy(x: 0, y: -90, duration: 2.5)
        wave.run(SKAction.repeatForever(SKAction.sequence([moveUp, moveDown])))

        // Foliage
        let foliage = SKSpriteNode(imageNamed: "foliage")
        foliage.size = CGSize(width: self.size.width, height: self.size.height / 2 + 40)
        foliage.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2 - 20)
        self.addChild(foliage)

        // Text display
        textNode = SKSpriteNode(imageNamed: textImages[currentTextIndex])
        textNode.size = CGSize(width: self.size.width / 2 + 130, height: 300)
        textNode.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2 + 300)
        self.addChild(textNode)

        // Tap button
        let buttonAnim = SKAction.animate(with: buttonImages.map { SKTexture(imageNamed: $0) }, timePerFrame: 0.5)
        tapButton = SKSpriteNode(imageNamed: buttonImages[currentButtonIndex])
        tapButton.size = CGSize(width: 60, height: 50)
        tapButton.position = CGPoint(x: self.size.width / 3 + 650, y: self.size.height / 2 + 200)
        tapButton.run(SKAction.repeatForever(buttonAnim), withKey: "buttonAnimation")
        self.addChild(tapButton)

        // Seagulls
        let seagull1 = ObjetoAnimado("seagull")
        seagull1.setScale(1.2)
        seagull1.position = CGPoint(x: self.size.width / 2 + 620, y: self.size.height / 2 + 200)
        self.addChild(seagull1)

        let seagull2 = ObjetoAnimado("seagull2")
        seagull2.setScale(1.1)
        seagull2.position = CGPoint(x: self.size.width / 2 - 600, y: self.size.height / 2 + 350)
        self.addChild(seagull2)

        // Turtle
        let turtle = SKSpriteNode(imageNamed: "turtleBlack")
        turtle.size = CGSize(width: 104, height: 105)
        turtle.position = CGPoint(x: self.size.width / 2 - 450, y: self.size.height / 2 - 150)
        self.addChild(turtle)

        let blink = SKAction.sequence([
            SKAction.fadeAlpha(to: 0.8, duration: 0.5),
            SKAction.fadeAlpha(to: 1.0, duration: 0.5)
        ])
        turtle.run(SKAction.repeatForever(blink))
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard canShowButton else {
            for touch in touches {
                let tappedNode = atPoint(touch.location(in: self))
                if tappedNode.name == "nextButton" {
                    self.run(transitionSound)
                    let scene = GameScene(size: self.size)
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
