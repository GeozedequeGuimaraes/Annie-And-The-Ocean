//
//  Annie-And-The-Ocean
//
import Foundation
import SpriteKit

class Story1Scene: SKScene{
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "StoryScene2")
        let width = self.size.width
        let scaleFactor = width / background.size.width
        background.setScale(scaleFactor)
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        self.addChild(background)
        
        let turtle = SKSpriteNode(imageNamed: "turtle")
        turtle.position = CGPoint(x: self.size.width/2 - 310, y: self.size.height/2 + 390)
        self.addChild(turtle)
        
        let rippleTurtle = SKAction.sequence([
            SKAction.scale(to: 1.05, duration: 2.0),
            SKAction.scale(to: 0.95, duration: 2.0)
        ])
        turtle.run(SKAction.repeatForever(rippleTurtle))
        
        let moveTurtle = SKAction.sequence([
            SKAction.moveBy(x: 50, y: 20, duration: 2.0),
            SKAction.moveBy(x: 50, y: -20, duration: 2.0)
        ])
        let rotateTurtle = SKAction.rotate(byAngle: 0.2, duration: 0.3)
        let sequence = SKAction.sequence([moveTurtle, rotateTurtle, moveTurtle.reversed(), rotateTurtle.reversed()])
        turtle.run(SKAction.repeatForever(sequence))
        
        let straw = SKSpriteNode(imageNamed: "straw")
        straw.size = CGSize(width: 110, height: 140)
        straw.position = CGPoint(x: self.size.width/2 - 620, y: self.size.height/3 + 350)
        
        self.addChild(straw)
        
        let scaleUpStraw = SKAction.scale(to: 0.9, duration: 0.8)
        let scaleDownStraw = SKAction.scale(to: 1.0, duration: 0.8)
        let scaleStraw = SKAction.sequence([scaleUpStraw, scaleDownStraw])
        
        let fadeOutStraw = SKAction.fadeAlpha(to: 0.6, duration: 0.5)
        let fadeInStraw = SKAction.fadeAlpha(to: 1.3, duration: 0.5)
        let blinkStraw = SKAction.sequence([fadeOutStraw, fadeInStraw])
        
        let repeatScaleStraw = SKAction.repeatForever(scaleStraw)
        let repeatBlinkStraw = SKAction.repeatForever(blinkStraw)
        
        straw.run(repeatScaleStraw)
        straw.run(repeatBlinkStraw)
        
        let plastic = SKSpriteNode(imageNamed: "plastic")
        plastic.size = CGSize(width: 130, height: 120)
        plastic.position = CGPoint(x: self.size.width/2 - 600, y: self.size.height/3 + 130)
        
        let scaleUpPlastic = SKAction.scale(to: 0.9, duration: 0.8)
        let scaleDownPlastic = SKAction.scale(to: 1.0, duration: 0.8)
        let scalePlastic = SKAction.sequence([scaleUpPlastic, scaleDownPlastic])
        
        let fadeOutPlastic = SKAction.fadeAlpha(to: 0.6, duration: 0.6)
        let fadeInPlastic = SKAction.fadeAlpha(to: 1.3, duration: 0.6)
        let blinkPlastic = SKAction.sequence([fadeOutPlastic, fadeInPlastic])
        
        let repeatScalePlastic = SKAction.repeatForever(scalePlastic)
        let repeatBlinkPlastic = SKAction.repeatForever(blinkPlastic)
        
        plastic.run(repeatScalePlastic)
        plastic.run(repeatBlinkPlastic)
        
        self.addChild(plastic)
        
        let turtleGreen = SKSpriteNode(imageNamed: "turtleGreen")
        turtleGreen.size = CGSize(width: 270, height: 220)
        turtleGreen.position = CGPoint(x: self.size.width/3 - 90, y: self.size.height/3 + 140)
        
        let rotateTurtleGreen = SKAction.sequence([
            SKAction.rotate(toAngle: degToRad1(-5.0), duration: 1.3),
            SKAction.rotate(toAngle: degToRad1(5.0), duration: 1.3)
        ])
        turtleGreen.run(SKAction.repeatForever(rotateTurtleGreen))
        
        func degToRad1(_ degree: Double) -> CGFloat {
            return CGFloat(degree / 210.0 * Double.pi)
        }
        
        self.addChild(turtleGreen)
        
        let shark = SKSpriteNode(imageNamed: "shark")
        shark.size = CGSize(width: 470, height: 430)
        shark.position = CGPoint(x: self.size.width/2 * 2 - 320, y: self.size.height/2 + 60)
        self.addChild(shark)
        
        let rotateShark = SKAction.sequence([
            SKAction.rotate(toAngle: degToRad(-5.0), duration: 1.3),
            SKAction.rotate(toAngle: degToRad(5.0), duration: 1.3)
        ])
        shark.run(SKAction.repeatForever(rotateShark))
        
        func degToRad(_ degree: Double) -> CGFloat {
            return CGFloat(degree / 210.0 * Double.pi)
        }
        
        let buttonImage = SKSpriteNode(imageNamed: "btnNext")
        buttonImage.position = CGPoint(x: self.size.width/4 * 3 + 200, y: self.size.height/4 + 60)
        self.addChild(buttonImage)
        buttonImage.name = "nextButton"
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches{
            let pointOfTOuch = touch.location(in: self)
            let nodeITapped = atPoint(pointOfTOuch)
            
            if nodeITapped.name == "nextButton"{
                let sceneToMoveTo = Story2Scene(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                let myTransition = SKTransition.fade(withDuration: 0.5)
                self.view!.presentScene(sceneToMoveTo, transition: myTransition)
            }
        }
        
    }
}
