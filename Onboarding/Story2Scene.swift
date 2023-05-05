// 
// Annie-And-The-Ocean
//
import Foundation
import SpriteKit
import AVFoundation

class Story2Scene: SKScene {
    let textImages = ["text", "text1", "text2"]
    var currentTurtleIndex = 0
    
    let buttonImages = ["btn1", "btn2"]
    var currentButtonIndex = 0
    
    var text: SKSpriteNode!
    var button: SKSpriteNode!
    var buttonImage: SKSpriteNode!
    
    var canShowButton = true
    
    override func didMove(to view: SKView) {
        
        let background = SKSpriteNode(imageNamed: "StoryScene3")
        let width = self.size.width
        let scaleFactor = width / background.size.width
        background.setScale(scaleFactor)
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        self.addChild(background)
        
        let textImage = textImages[currentTurtleIndex]
        text = SKSpriteNode(imageNamed: textImage)
        text.size = CGSize(width: width / 2 + 200, height: 414)
        text.position = CGPoint(x: self.size.width/2, y: self.size.height/2 + 230)
        self.addChild(text)
        
        let buttonAnimation = SKAction.animate(with: buttonImages.map { SKTexture(imageNamed: $0) }, timePerFrame: 0.5)
        button = SKSpriteNode(imageNamed: buttonImages[currentButtonIndex])
        button.size = CGSize(width: 65, height: 55)
        button.position = CGPoint(x: self.size.width/3 + 670 , y: self.size.height/2+75)
        button.run(SKAction.repeatForever(buttonAnimation), withKey: "buttonAnimation")
        self.addChild(button)
        
        let trashLeft = SKSpriteNode(imageNamed: "trash1")
        trashLeft.size = CGSize(width: 315, height: 665)
        trashLeft.position = CGPoint(x: self.size.width/2 - 595, y: self.size.height/2 + 160)
        self.addChild(trashLeft)
        
        let amplitude: CGFloat = 14.0
        let period: TimeInterval = 1
        let moveTrashLeft = SKAction.moveBy(x: 0, y: amplitude, duration: period)
        moveTrashLeft.timingMode = .easeInEaseOut
        let reverseMoveTrashLeft = moveTrashLeft.reversed()
        let sequenceTrashLeft = SKAction.sequence([moveTrashLeft, reverseMoveTrashLeft])
        
        let repeatForeverTrashLeft = SKAction.repeatForever(sequenceTrashLeft)
        trashLeft.run(repeatForeverTrashLeft)
        
        let trashRight = SKSpriteNode(imageNamed: "trash2")
        trashRight.size = CGSize(width: 315, height: 665)
        trashRight.position = CGPoint(x: self.size.width/2 + 595, y: self.size.height/2 + 160)
        self.addChild(trashRight)
        
        let _: CGFloat = 13.0
        let _: TimeInterval = 1
        let moveTrashRight = SKAction.moveBy(x: 0, y: amplitude, duration: period)
        moveTrashRight.timingMode = .easeInEaseOut
        let reverseMoveTrashRight = moveTrashRight.reversed()
        let sequenceTrashRight = SKAction.sequence([moveTrashRight, reverseMoveTrashRight])
        
        let repeatForeverTrashRight = SKAction.repeatForever(sequenceTrashRight)
        trashRight.run(repeatForeverTrashRight)
        
        let turtle = SKSpriteNode(imageNamed: "turtleGreen1")
        turtle.size = CGSize(width: width / 2 - 10, height: width / 2 - 410)
        turtle.position = CGPoint(x: self.size.width/2, y: self.size.height/2 - 260)
        self.addChild(turtle)
        
        let tiltAngleTurtle = CGFloat.pi/52
        let tiltRightTurtle = SKAction.rotate(toAngle: tiltAngleTurtle, duration: 1.6)
        let tiltLeftTurtle = SKAction.rotate(toAngle: -tiltAngleTurtle, duration: 1.6)
        
        let tiltRightTimingModeTurtle: SKActionTimingMode = .easeInEaseOut
        let tiltLeftTimingModeTurtle: SKActionTimingMode = .easeInEaseOut
        
        tiltRightTurtle.timingMode = tiltRightTimingModeTurtle
        tiltLeftTurtle.timingMode = tiltLeftTimingModeTurtle
        
        let tiltRightSequenceTurtle = SKAction.sequence([tiltRightTurtle])
        let tiltLeftSequenceTurtle = SKAction.sequence([tiltLeftTurtle])
        
        let repeatTurtle = SKAction.repeatForever(SKAction.sequence([tiltRightSequenceTurtle, tiltLeftSequenceTurtle]))
        turtle.run(repeatTurtle)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard canShowButton else {
            for touch in touches {
                let location = touch.location(in: self)
                let touchedNode = self.atPoint(location)
                if touchedNode.name == "nextButton" {
                    let sceneToMoveTo = Story3Scene(size: self.size)
                    sceneToMoveTo.scaleMode = self.scaleMode
                    let myTransition = SKTransition.fade(withDuration: 0.8)
                    self.view!.presentScene(sceneToMoveTo, transition: myTransition)
                }
            }
            return
        }
        
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = self.atPoint(location)
            
            if touchedNode == button {
                currentTurtleIndex += 1
                if currentTurtleIndex >= textImages.count {
                    currentTurtleIndex = textImages.count - 1
                    canShowButton = false
                    button.removeFromParent()
                    let buttonImage = SKSpriteNode(imageNamed: "btnNext")
                    buttonImage.position = CGPoint(x: self.size.width/4 * 3 + 200, y: self.size.height/4 + 60)
                    buttonImage.alpha = 0
                    buttonImage.name = "nextButton"
                    self.addChild(buttonImage)
                    
                    let fadeInAction = SKAction.fadeIn(withDuration: 0.5)
                    buttonImage.run(fadeInAction)
                } else {
                    text.texture = SKTexture(imageNamed: textImages[currentTurtleIndex])
                }
                currentButtonIndex += 1
                
                if currentButtonIndex >= buttonImages.count {
                    currentButtonIndex = 0
                }
                button.removeAction(forKey: "buttonAnimation")
                button.run(SKAction.fadeOut(withDuration: 0.25)) {
                    self.button.texture = SKTexture(imageNamed: self.buttonImages[self.currentButtonIndex])
                    self.button.run(SKAction.fadeIn(withDuration: 0.25)) {
                        let buttonAnimation = SKAction.animate(with: self.buttonImages.map { SKTexture(imageNamed: $0) }, timePerFrame: 0.5)
                        self.button.run(SKAction.repeatForever(buttonAnimation), withKey: "buttonAnimation")
                    }
                }
            }
        }
    }
}
