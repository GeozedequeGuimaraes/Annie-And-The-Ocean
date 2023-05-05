import Foundation
import SpriteKit
import AVFAudio

class Story3Scene: SKScene{
    let textImages = ["text3", "text4", "text5"]
    var currentTurtleIndex = 0
    
    let buttonImages = ["btn1", "btn2"]
    var currentButtonIndex = 0
    
    var text: SKSpriteNode!
    var button: SKSpriteNode!
    var buttonImage: SKSpriteNode!
    
    var canShowButton = true
    
    var soundStory = SKAction.playSoundFileNamed("transition.mp4", waitForCompletion: false)
    override func didMove(to view: SKView) {
              
        let background = SKSpriteNode(imageNamed: "StoryScene4")
        let width = self.size.width
        let scaleFactor = width / background.size.width
        background.setScale(scaleFactor)
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        self.addChild(background)
        
        let wave = SKSpriteNode(imageNamed: "wave")
        wave.size = CGSize(width: self.size.width, height: self.size.height/2)
        wave.position = CGPoint(x: self.size.width/2, y: self.size.height/2 + 100)
        self.addChild(wave)
        
        let amplitude: CGFloat = 90.0
        let period: TimeInterval = 5
        let moveUp = SKAction.moveBy(x: 0, y: amplitude, duration: period/2)
        let moveDown = SKAction.moveBy(x: 0, y: -amplitude, duration: period/2)
        let waveSequence = SKAction.sequence([moveUp, moveDown])
        let repeatForever = SKAction.repeatForever(waveSequence)
        wave.run(repeatForever)
        
        let foliage = SKSpriteNode(imageNamed: "foliage")
        foliage.size = CGSize(width: self.size.width, height: self.size.height/2 + 40)
        foliage.position = CGPoint(x: self.size.width/2, y: self.size.height/2 - 20)
        self.addChild(foliage)
        
        let textImage = textImages[currentTurtleIndex]
        text = SKSpriteNode(imageNamed: textImage)
        text.size = CGSize(width: width / 2 + 130, height: 300)
        text.position = CGPoint(x: self.size.width/2, y: self.size.height/2 + 300)
        self.addChild(text)
        
        let buttonAnimation = SKAction.animate(with: buttonImages.map { SKTexture(imageNamed: $0) }, timePerFrame: 0.5)
        button = SKSpriteNode(imageNamed: buttonImages[currentButtonIndex])
        button.size = CGSize(width: 60, height: 50)
        button.position = CGPoint(x: self.size.width/3 + 650 , y: self.size.height/2+200)
        button.run(SKAction.repeatForever(buttonAnimation), withKey: "buttonAnimation")
        self.addChild(button)
        
        let seagull1: ObjetoAnimado = ObjetoAnimado ("seagull")
        seagull1.setScale(1.2)
        seagull1.position = CGPoint(x: self.size.width/2 + 620 , y: self.size.height/2 + 200)
        self.addChild(seagull1)
        
        let seagull2: ObjetoAnimado = ObjetoAnimado ("seagull2")
        seagull2.setScale(1.1)
        seagull2.position = CGPoint(x: self.size.width/2 - 600 , y: self.size.height/2 + 350)
        self.addChild(seagull2)
        
        let turtle = SKSpriteNode(imageNamed: "turtleBlack")
        turtle.size = CGSize(width: 104, height: 105)
        turtle.position = CGPoint(x: self.size.width/2 - 450 , y: self.size.height/2 - 150)
        self.addChild(turtle)
  
        let fadeOutTurtle = SKAction.fadeAlpha(to: 0.8, duration: 0.5)
        let fadeInTurtle = SKAction.fadeAlpha(to: 1.3, duration: 0.5)
        let blinkTurtle = SKAction.sequence([fadeOutTurtle, fadeInTurtle])
        
        let repeatBlinkTurtle = SKAction.repeatForever(blinkTurtle)
        
        turtle.run(repeatBlinkTurtle)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard canShowButton else {
            for touch in touches {
                let location = touch.location(in: self)
                let touchedNode = self.atPoint(location)
                
                if touchedNode.name == "nextButton" {
                    self.run(soundStory)
                    let sceneToMoveTo = GameScene(size: self.size)
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
