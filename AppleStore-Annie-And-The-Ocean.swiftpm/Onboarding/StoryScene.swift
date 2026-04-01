//
//  Annie-And-The-Ocean
//
import SpriteKit

class StoryScene: SKScene {

    override func didMove(to view: SKView) {
        AudioManager.shared.stopMainAudio()
        AudioManager.shared.playStoryAudio()

        let background = SKSpriteNode(imageNamed: "StoryScene1")
        let scaleFactor = self.size.width / background.size.width
        background.setScale(scaleFactor)
        background.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        self.addChild(background)

        // Bubble
        let bubble = SKSpriteNode(imageNamed: "bolha")
        bubble.size = CGSize(width: 307, height: 270)
        bubble.position = CGPoint(x: self.size.width / 4 - 120, y: self.size.height / 2 + 200)
        self.addChild(bubble)

        let bobble = SKAction.sequence([
            SKAction.moveBy(x: 0, y: 14, duration: 1.3),
            SKAction.moveBy(x: 0, y: -14, duration: 1.3)
        ])
        bobble.timingMode = .easeInEaseOut
        bubble.run(SKAction.repeatForever(bobble))

        // Egg
        let egg1 = SKTexture(imageNamed: "egg1")
        let egg2 = SKTexture(imageNamed: "egg2")
        egg1.filteringMode = .linear
        egg2.filteringMode = .linear

        let eggAnim = SKAction.animate(with: [egg1, egg2], timePerFrame: 0.85)
        eggAnim.timingFunction = { t in
            let t2 = t * t
            return (3 * t2) - (2 * t * t2)
        }

        let egg = SKSpriteNode(texture: egg1)
        egg.size = CGSize(width: 162, height: 206)
        egg.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2 + 150)
        egg.run(SKAction.repeatForever(eggAnim))
        addChild(egg)

        // Leaves
        addLeaf("leaf1", size: CGSize(width: 337, height: 235), pos: CGPoint(x: self.size.width - 100, y: self.size.height / 2 + 280), angle: .pi / 40, duration: 1.5)
        addLeaf("leaf2", size: CGSize(width: 357, height: 345), pos: CGPoint(x: self.size.width, y: self.size.height / 2 + 180), angle: .pi / 60, duration: 2.0)
        addLeaf("leaf3", size: CGSize(width: 230, height: 340), pos: CGPoint(x: self.size.width - 20, y: self.size.height / 2 + 150), angle: .pi / 50, duration: 1.3)

        // Crab
        let crab = SKSpriteNode(imageNamed: "crabs")
        crab.size = CGSize(width: 537, height: 305)
        crab.anchorPoint = CGPoint(x: 1.0, y: 0.0)
        crab.position = CGPoint(x: self.size.width - 120, y: self.size.height / 4 + 100)
        self.addChild(crab)

        let moveRight = SKAction.moveBy(x: -50, y: 0, duration: 2.0)
        moveRight.timingMode = .easeInEaseOut
        let moveLeft = SKAction.moveBy(x: 50, y: 0, duration: 2.0)
        moveLeft.timingMode = .easeInEaseOut
        crab.run(SKAction.repeatForever(SKAction.sequence([moveRight, moveLeft])))

        // Birds
        let bird = SKSpriteNode(imageNamed: "birds")
        bird.size = CGSize(width: 657, height: 155)
        bird.position = CGPoint(x: self.size.width / 4 + 60, y: self.size.height / 4 + 340)
        self.addChild(bird)

        let tiltAngle = CGFloat.pi / 52
        let tiltRight = SKAction.rotate(toAngle: tiltAngle, duration: 1.5)
        tiltRight.timingMode = .easeInEaseOut
        let tiltLeft = SKAction.rotate(toAngle: -tiltAngle, duration: 1.5)
        tiltLeft.timingMode = .easeInEaseOut
        bird.run(SKAction.repeatForever(SKAction.sequence([tiltRight, tiltLeft])))

        // Next button
        let nextButton = SKSpriteNode(imageNamed: "btnNext")
        nextButton.position = CGPoint(x: self.size.width / 4 * 3 + 200, y: self.size.height / 4 + 60)
        nextButton.name = "nextButton"
        self.addChild(nextButton)
    }

    private func addLeaf(_ image: String, size: CGSize, pos: CGPoint, angle: CGFloat, duration: TimeInterval) {
        let leaf = SKSpriteNode(imageNamed: image)
        leaf.size = size
        leaf.anchorPoint = CGPoint(x: 1.0, y: 0.0)
        leaf.position = pos
        self.addChild(leaf)

        let rotateRight = SKAction.rotate(byAngle: angle, duration: duration)
        let rotateLeft = SKAction.rotate(byAngle: -angle, duration: duration)
        leaf.run(SKAction.repeatForever(SKAction.sequence([rotateRight, rotateLeft])))
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let point = touch.location(in: self)
            let tappedNode = atPoint(point)

            if tappedNode.name == "nextButton" {
                let scene = Story1Scene(size: self.size)
                scene.scaleMode = self.scaleMode
                self.view?.presentScene(scene, transition: SKTransition.fade(withDuration: 0.5))
            }
        }
    }
}
