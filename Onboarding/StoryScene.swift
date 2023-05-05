//
//  Annie-And-The-Ocean
//
import Foundation
import SpriteKit
import AVFAudio

var backAudioStory = AVAudioPlayer()
class StoryScene: SKScene{
    
    override func didMove(to view: SKView) {
  
        backAudioMain.stop()
        let filePath = Bundle.main.path(forResource: "Story", ofType: "mp4")
        let audioNSURL = NSURL(fileURLWithPath: filePath!)

        do {
            backAudioStory = try AVAudioPlayer(contentsOf: audioNSURL as URL)
        } catch {
            print("Cannot Find The Audio")
        }
        backAudioStory.numberOfLoops = -1
        backAudioStory.volume = 0.7
        let delay: TimeInterval = 0.7
        backAudioStory.play(atTime: backAudioStory.deviceCurrentTime + delay)

        let background = SKSpriteNode(imageNamed: "StoryScene1")
        let width = self.size.width
        let scaleFactor = width / background.size.width
        background.setScale(scaleFactor)
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        
        self.addChild(background)
        
        let bubble = SKSpriteNode(imageNamed: "bolha")
        bubble.size = CGSize(width: 307, height: 270)
        bubble.position = CGPoint(x: self.size.width/4 - 120, y: self.size.height/2+200)
        
        self.addChild(bubble)
        
        let amplitudeBubble: CGFloat = 14.0
        let periodBubble: TimeInterval = 1.3
        let moveBubble = SKAction.moveBy(x: 0, y: amplitudeBubble, duration: periodBubble)
        moveBubble.timingMode = .easeInEaseOut
        let reverseMoveBubble = moveBubble.reversed()
        let sequence = SKAction.sequence([moveBubble, reverseMoveBubble])
        
        let repeatForeverBubble = SKAction.repeatForever(sequence)
        bubble.run(repeatForeverBubble)
        
        let egg1 = SKTexture(imageNamed: "egg1")
        let egg2 = SKTexture(imageNamed: "egg2")
        
        egg1.filteringMode = .linear
        egg2.filteringMode = .linear
        
        let eggArray = [egg1, egg2]
        
        let animation = SKAction.animate(with: eggArray, timePerFrame: 0.85)
        
        animation.timingFunction = { t in
            let t2 = t * t
            return (3 * t2) - (2 * t * t2)
        }
        
        let egg = SKSpriteNode(texture: egg1)
        
        egg.size = CGSize(width: 162, height: 206)
        egg.position = CGPoint(x: self.size.width/2, y: self.size.height/2 + 150)
        
        egg.run(SKAction.repeatForever(animation))
        
        addChild(egg)
        
        
        let leafTop = SKSpriteNode(imageNamed: "leaf1")
        leafTop.size = CGSize(width: 337, height: 235)
        leafTop.anchorPoint = CGPoint(x: 1.0, y: 0.0)
        leafTop.position = CGPoint(x: self.size.width-100, y: self.size.height/2+280)
        
        self.addChild(leafTop)
        
        let rotateAngleLeafTop = CGFloat.pi / 40
        let rotateRightLeafTop = SKAction.rotate(byAngle: rotateAngleLeafTop, duration: 1.5)
        let rotateLeftLeafTop = SKAction.rotate(byAngle: -rotateAngleLeafTop, duration: 1.5)
        
        let repeatLeafTop = SKAction.repeatForever(SKAction.sequence([rotateRightLeafTop, rotateLeftLeafTop]))
        leafTop.run(repeatLeafTop)
        
        let leafMiddle = SKSpriteNode(imageNamed: "leaf2")
        leafMiddle.size = CGSize(width: 357, height: 345)
        leafMiddle.anchorPoint = CGPoint(x: 1.0, y: 0.0)
        leafMiddle.position = CGPoint(x: self.size.width, y: self.size.height/2+180)
        
        self.addChild(leafMiddle)
        
        let rotateAngleLeafMiddle = CGFloat.pi / 60
        let rotateRightLeafMiddle = SKAction.rotate(byAngle: rotateAngleLeafMiddle, duration: 2.0)
        let rotateLeftLeafMiddle = SKAction.rotate(byAngle: -rotateAngleLeafMiddle, duration: 2.0)
        
        let repeatLeafMiddle = SKAction.repeatForever(SKAction.sequence([rotateRightLeafMiddle, rotateLeftLeafMiddle]))
        leafMiddle.run(repeatLeafMiddle)
        
        let leafBottom = SKSpriteNode(imageNamed: "leaf3")
        leafBottom.size = CGSize(width: 230, height: 340)
        leafBottom.anchorPoint = CGPoint(x: 1.0, y: 0.0)
        leafBottom.position = CGPoint(x: self.size.width-20, y: self.size.height/2+150)
        
        self.addChild(leafBottom)
        
        let rotateAngleLeafBottom = CGFloat.pi / 50
        let rotateRightLeafBottom = SKAction.rotate(byAngle: rotateAngleLeafBottom, duration: 1.3)
        let rotateLeftLeafBottom = SKAction.rotate(byAngle: -rotateAngleLeafBottom, duration: 1.3)
        
        let repeatLeafBottom = SKAction.repeatForever(SKAction.sequence([rotateRightLeafBottom, rotateLeftLeafBottom]))
        leafBottom.run(repeatLeafBottom)
        
        let crab = SKSpriteNode(imageNamed: "crabs")
        crab.size = CGSize(width: 537, height: 305)
        crab.anchorPoint = CGPoint(x: 1.0, y: 0.0)
        crab.position = CGPoint(x: self.size.width - 120, y: self.size.height/4 + 100)
        
        self.addChild(crab)
        
        let moveDistanceCrab: CGFloat = 50.0
        let moveDurationCrab: TimeInterval = 2.0
        let moveRightCrab = SKAction.moveBy(x: -moveDistanceCrab, y: 0, duration: moveDurationCrab)
        let moveLeftCrab = SKAction.moveBy(x: moveDistanceCrab, y: 0, duration: moveDurationCrab)
        let moveRightTimingModeCrab: SKActionTimingMode = .easeInEaseOut
        let moveLeftTimingModeCrab: SKActionTimingMode = .easeInEaseOut
        
        moveRightCrab.timingMode = moveRightTimingModeCrab
        moveLeftCrab.timingMode = moveLeftTimingModeCrab
        
        let moveRightSequenceCrab = SKAction.sequence([moveRightCrab])
        let moveLeftSequenceCrab = SKAction.sequence([moveLeftCrab])
        
        let repeatForeverCrab = SKAction.repeatForever(SKAction.sequence([moveRightSequenceCrab, moveLeftSequenceCrab]))
        crab.run(repeatForeverCrab)
        
        let bird = SKSpriteNode(imageNamed: "birds")
        bird.size = CGSize(width: 657, height: 155)
        bird.position = CGPoint(x: self.size.width / 4 + 60, y: self.size.height/4 + 340)
        self.addChild(bird)
        
        let tiltAngleBird = CGFloat.pi/52
        let tiltRightBird = SKAction.rotate(toAngle: tiltAngleBird, duration: 1.5)
        let tiltLeftBird = SKAction.rotate(toAngle: -tiltAngleBird, duration: 1.5)
        
        let tiltRightTimingModeBird: SKActionTimingMode = .easeInEaseOut
        let tiltLeftTimingModeBird: SKActionTimingMode = .easeInEaseOut
        
        tiltRightBird.timingMode = tiltRightTimingModeBird
        tiltLeftBird.timingMode = tiltLeftTimingModeBird
        
        let tiltRightSequenceBird = SKAction.sequence([tiltRightBird])
        let tiltLeftSequenceBird = SKAction.sequence([tiltLeftBird])
        
        let repeatBird = SKAction.repeatForever(SKAction.sequence([tiltRightSequenceBird, tiltLeftSequenceBird]))
        bird.run(repeatBird)
        
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
                let sceneToMoveTo = Story1Scene(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                let myTransition = SKTransition.fade(withDuration: 0.5)
                self.view!.presentScene(sceneToMoveTo, transition: myTransition)
                
            }
        }
    }
}
