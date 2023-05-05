//
//  Annie-And-The-Ocean
//
import Foundation
import SpriteKit
import AVFoundation

var backAudioMain = AVAudioPlayer()

class MainMenuScene: SKScene{
    var sound = SKAction.playSoundFileNamed("transition.mp4", waitForCompletion: false)
    
    override func didMove(to view: SKView) {
        
        let filePath = Bundle.main.path(forResource: "main", ofType: "mp4")
        let audioNSURL = NSURL(fileURLWithPath: filePath!)
        do { backAudioMain = try AVAudioPlayer(contentsOf: audioNSURL as URL)}
        catch { return print("Cannot Find The Audio")}
        backAudioMain.numberOfLoops = -1
        backAudioMain.volume = 0.7
        backAudioMain.play()
        
        let background = SKSpriteNode(imageNamed: "backgroundStart")
        let width = self.size.width
        let scaleFactor = width / background.size.width
        background.setScale(scaleFactor)
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        self.addChild(background)
        
        let buttonImage = SKSpriteNode(imageNamed: "btn")
        buttonImage.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        self.addChild(buttonImage)
        buttonImage.name = "startButton"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches{
            self.run(sound)
            let pointOfTOuch = touch.location(in: self)
            let nodeITapped = atPoint(pointOfTOuch)
            
            if nodeITapped.name == "startButton"{
                let sceneToMoveTo = StoryScene(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                let myTransition = SKTransition.fade(withDuration: 0.8)
                self.view!.presentScene(sceneToMoveTo, transition: myTransition)
            }
        }
        
    }
    
}
