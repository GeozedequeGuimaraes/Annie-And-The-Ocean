//
//  Annie-And-The-Ocean
//
import Foundation
import SpriteKit
import AVFoundation

var started: Bool = false
var finished: Bool = false
var canRestart: Bool = false

var scores = 0;
var idTurtle:UInt32 = 1
var idEnemy:UInt32 = 2
var idItem: UInt32 = 3

var soundBubble = SKAction.playSoundFileNamed("bubble.mp4", waitForCompletion: false)
var soundClose = SKAction.playSoundFileNamed ("close.mp4", waitForCompletion: false)
var backAudioGame = AVAudioPlayer()
class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let textScores = SKLabelNode(fontNamed: "OpenSans-Light")
    
    let btnPlay = SKSpriteNode(imageNamed: "btnPlay")
    let btnRestart = SKSpriteNode(imageNamed: "btnRestart")
    let gameOver = SKSpriteNode(imageNamed: "gameOver")
    
    let turtle: ObjetoAnimado = ObjetoAnimado ("turtle")
    
    var intervaloItens:TimeInterval = 1.0
    var sorteialtens = SKAction ()
    
    let objetoDummy = SKNode()
    let objetoDummy1 = SKNode()
    let objetoDummy2 = SKNode()
    let objetoDummy3 = SKNode()
    let objetoDummy4 = SKNode()
    
    var enemies: [ObjetoAnimado] = []
    var enemies1: [ObjetoAnimado] = []
    
    override func didMove(to view: SKView) {
        backAudioStory.stop()
        
        let filePath = Bundle.main.path(forResource: "game", ofType: "mp4")
        let audioNSURL = NSURL(fileURLWithPath: filePath!)
        do {
            backAudioGame = try AVAudioPlayer(contentsOf: audioNSURL as URL)
        } catch {
            print("Cannot Find The Audio")
        }
        backAudioGame.numberOfLoops = -1
        backAudioGame.volume = 1.0
        let delay: TimeInterval = 0.6
        backAudioGame.play(atTime: backAudioGame.deviceCurrentTime + delay)
        
        self.backgroundColor = .black
        self.physicsWorld.contactDelegate = self
        
        var back1: SKSpriteNode = SKSpriteNode()
        let moveBack1 = SKAction.moveBy(x: -self.size.width, y: 0, duration: 18)
        let reposicionaBack1 = SKAction.moveBy(x: self.size.width, y: 0, duration: 0)
        let repeteBack1 = SKAction.repeatForever(SKAction.sequence([moveBack1, reposicionaBack1]))
        
        for i in 0..<2 {
            back1 = SKSpriteNode(imageNamed: "back1")
            back1.anchorPoint = CGPoint(x: 0, y: 0)
            back1.size.width = self.size.width
            back1.position = CGPoint(x: self.size.width * CGFloat(i), y: self.size.height / 4 - 60)
            back1.run(repeteBack1)
            back1.size.height = self.size.height/2 + 80
            back1.zPosition = -1
            objetoDummy.addChild(back1)
        }
        self.addChild(objetoDummy)
        objetoDummy.speed = 0
        
        
        var back2: SKSpriteNode = SKSpriteNode()
        let moveBack2 = SKAction.moveBy(x: -self.size.width, y: 0, duration: 20)
        let reposicionaBack2 = SKAction.moveBy(x: self.size.width, y: 0, duration: 0)
        let repeteBack2 = SKAction.repeatForever(SKAction.sequence([moveBack2, reposicionaBack2]))
        
        for i in 0..<2 {
            back2 = SKSpriteNode(imageNamed: "back2")
            back2.anchorPoint = CGPoint(x: 0, y: 0)
            back2.size.width = self.size.width
            back2.position = CGPoint(x: self.size.width * CGFloat(i), y: self.size.height / 4 + 60)
            back2.run(repeteBack2)
            back2.size.height = self.size.height/2  - 200
            back2.zPosition = -1
            objetoDummy1.addChild(back2)
        }
        self.addChild(objetoDummy1)
        objetoDummy1.speed = 0
        
        
        var back3: SKSpriteNode = SKSpriteNode()
        let moveBack3 = SKAction.moveBy(x: -self.size.width, y: 0, duration: 12)
        let reposicionaBack3 = SKAction.moveBy(x: self.size.width, y: 0, duration: 0)
        let repeteBack3 = SKAction.repeatForever(SKAction.sequence([moveBack3, reposicionaBack3]))
        
        for i in 0..<2 {
            back3 = SKSpriteNode(imageNamed: "back3")
            back3.anchorPoint = CGPoint(x: 0, y: 0)
            back3.size.width = self.size.width
            back3.position = CGPoint(x: self.size.width * CGFloat(i), y: self.size.height / 4 - 60)
            back3.position.x -= 5
            back3.run(repeteBack3)
            back3.size.height = self.size.height/2 + 80
            back3.zPosition = -1
            objetoDummy2.addChild(back3)
        }
        self.addChild(objetoDummy2)
        objetoDummy2.speed = 0
        
        
        var back4: SKSpriteNode = SKSpriteNode()
        let moveBack4 = SKAction.moveBy(x: -self.size.width, y: 0, duration: 5)
        let reposicionaBack4 = SKAction.moveBy(x: self.size.width, y: 0, duration: 0)
        let repeteBack4 = SKAction.repeatForever(SKAction.sequence([moveBack4, reposicionaBack4]))
        
        for i in 0..<2 {
            back4 = SKSpriteNode(imageNamed: "back4")
            back4.anchorPoint = CGPoint(x: 0, y: 0)
            back4.size.width = self.size.width
            back4.position = CGPoint(x: self.size.width * CGFloat(i), y: self.size.height / 4 - 65)
            back4.run(repeteBack4)
            back4.size.height = self.size.height/2 + 200
            back4.zPosition = -1
            objetoDummy3.addChild(back4)
        }
        self.addChild(objetoDummy3)
        objetoDummy3.speed = 0
        
        
        var back5: SKSpriteNode = SKSpriteNode()
        let moveBack5 = SKAction.moveBy(x: -self.size.width, y: 0, duration: 2.5)
        let reposicionaBack5 = SKAction.moveBy(x: self.size.width, y: 0, duration: 0)
        let repeteBack5 = SKAction.repeatForever(SKAction.sequence([moveBack5, reposicionaBack5]))
        
        for i in 0..<2 {
            back5 = SKSpriteNode(imageNamed: "back6")
            back5.anchorPoint = CGPoint(x: 0, y: 0)
            back5.size.width = self.size.width + 65
            back5.position = CGPoint(x: self.size.width * CGFloat(i) - 30, y:350)
            back5.run(repeteBack5)
            back5.size.height = self.size.height/2 + 200
            back5.zPosition = -1
            objetoDummy4.addChild(back5)
        }
        self.addChild(objetoDummy4)
        objetoDummy4.speed = 1.5
        
        turtle.position = CGPoint(x: self.size.width/4 - 100, y: self.size.height/2 - 230)
        turtle.name = "Personagem"
        self.addChild(turtle)
        
        let score = SKSpriteNode(imageNamed: "score")
        score.size = CGSize(width: 300, height: 123)
        score.anchorPoint = CGPoint(x: 1.0, y: 0.0)
        score.position = CGPoint(x: self.size.width/2 + 150, y: self.size.height/2+410)
        score.name = "score"
        self.addChild(score)
        
        textScores.text = "\(scores)"
        textScores.fontColor = .white
        textScores.fontSize = 55
        textScores.position = CGPoint(x: self.size.width/2 , y: self.size.height/2+430)
        self.addChild(textScores)
        
        btnPlay.anchorPoint = CGPoint(x: 1.0, y: 0.0)
        btnPlay.zPosition = 1
        btnPlay.position = CGPoint(x: self.size.width/2 + 250, y: self.size.height/2-200)
        self.addChild(btnPlay)
        
        btnRestart.anchorPoint = CGPoint(x: 1.0, y: 0.0)
        btnRestart.position = CGPoint(x: self.size.width/2 + 250, y: self.size.height/2-196)
        btnRestart.zPosition = 1
        btnRestart.isHidden = true
        self.addChild(btnRestart)
        
        gameOver.anchorPoint = CGPoint(x: 1.0, y: 0.0)
        gameOver.position = CGPoint(x: self.size.width/2 + 430, y: self.size.height/2-196)
        gameOver.zPosition = 1
        gameOver.isHidden = true
        self.addChild(gameOver)
        
        let acaoSorteiaItem = SKAction.run {
            if(!finished && started){
                let sorteio = Int.random(in: 0..<20)
                self.intervaloItens = TimeInterval(Float.random(in:0..<3.0))
                if(sorteio < 5 ){
                    self.createEnemyA()
                } else if((sorteio >= 5) && (sorteio < 13)){
                    self.createEnemyB()
                    
                } else if (sorteio >= 15){
                    self.createSeaweed()
                }
            }
        }
        self.run(SKAction.repeatForever(SKAction.sequence([acaoSorteiaItem,SKAction.wait(forDuration: intervaloItens)])))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        
        if(!started) {
            started = true
            turtle.physicsBody = SKPhysicsBody(circleOfRadius: turtle.size.height/2.5, center: CGPoint(x: 10, y: 0))
            turtle.physicsBody?.isDynamic = true
            turtle.physicsBody?.allowsRotation = false
            
            self.turtle.physicsBody?.categoryBitMask = idTurtle
            self.turtle.physicsBody?.collisionBitMask = 0
            self.turtle.physicsBody?.contactTestBitMask = idEnemy | idItem
            
            btnPlay.isHidden = true
            btnRestart.isHidden = true
            gameOver.isHidden = true
            
            objetoDummy.speed = 1
            objetoDummy1.speed = 1
            objetoDummy2.speed = 1.1
            objetoDummy3.speed = 1.1
            objetoDummy4.speed = 1.5
            
            self.run (SKAction.repeatForever (SKAction.sequence( [sorteialtens, SKAction.wait(forDuration: 1.0)])))
            self.turtle.physicsBody?.applyImpulse(CGVector(dx:0,dy:200))
            
        }else if(started && !finished) {
            self.turtle.physicsBody?.velocity = CGVector.zero
            self.turtle.physicsBody?.applyImpulse(CGVector(dx:0,dy:200))
        }
        
        else if (canRestart) {
            turtle.position = CGPoint(x: self.size.width/4 - 100, y: self.size.height/2 - 230)
            self.turtle.physicsBody?.velocity = CGVector.zero
            self.turtle.physicsBody?.isDynamic = false
            self.turtle.zRotation = 0
            
            started = false
            finished = false
            canRestart = false
            
            btnRestart.isHidden = true
            gameOver.isHidden = true

            self.btnPlay.alpha = 0
            self.btnPlay.isHidden = false
            UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseInOut], animations: {
                self.btnPlay.alpha = 1.0
            }, completion: nil)
            
            scores = 0
            textScores.text = "\(scores)"
            
            objetoDummy.speed = 0
            objetoDummy1.speed = 0
            objetoDummy2.speed = 0
            objetoDummy3.speed = 0
            objetoDummy4.speed = 1.5
        }
    }
    
    override func didSimulatePhysics () {
        if(started){
            self.turtle.zRotation =
            (self.turtle.physicsBody?.velocity.dy)!*0.0005
        }
    }
    
    func createEnemyA(){
        let px = self.frame.size.width+CGFloat(Float.random(in:30..<240))
        let py = Float.random(in:50..<480)
        let tempo = TimeInterval(Float.random(in:12..<17.0))
        
        let shark:ObjetoAnimado = ObjetoAnimado ("shark")
        shark.setScale (1.2)
        shark.position = CGPoint (x: px, y: self.size.height/2+CGFloat(py))
        shark.name = "Inimigo"
        
        shark.physicsBody?.categoryBitMask = idEnemy
        self.addChild(shark)
        enemies.append(shark)
        
        shark.physicsBody = SKPhysicsBody (rectangleOf: CGSize(width: shark.size.width-10, height: 30), center:
                                            CGPoint (x:0,y:-shark.size.height/2+25))
        shark.physicsBody?.isDynamic = false
        shark.physicsBody?.allowsRotation = false
        shark.run(SKAction.sequence([SKAction.moveTo(x: -self.frame.size.width-700, duration: tempo), SKAction.removeFromParent(),SKAction.run {
            self.enemies.remove(at: 0)
        }]))
    }
    
    func createEnemyB(){
        let px = self.frame.size.width+CGFloat(Float.random(in:70..<200.0))
        let py = CGFloat(Float.random(in:-50..<10)+10)
        let tempo = TimeInterval(Float.random(in:12..<17.0))
        let trash:ObjetoAnimado = ObjetoAnimado ("trash0")
        
        trash.setScale (1.3)
        trash.position = CGPoint(x: px, y: self.size.height/2+CGFloat(py))
        trash.name = "Inimigo"
        trash.physicsBody?.categoryBitMask = idEnemy
        self.addChild(trash)
        enemies1.append(trash)
        
        trash.physicsBody = SKPhysicsBody (rectangleOf: CGSize(width: trash.size.width-10, height: 30), center: CGPoint (x:0,y:-trash.size.height/2+25))
        trash.physicsBody?.isDynamic = false
        trash.physicsBody?.allowsRotation = false
        trash.run(SKAction.sequence([SKAction.moveTo(x:-self.frame.size.width-700, duration: tempo), SKAction.removeFromParent()]))
    }
    
    func createSeaweed(){
        let px = self.frame.size.width+CGFloat(Float.random(in:0..<200.0))
        let py = CGFloat(Float.random(in:-320..<440.0)+50)
        
        let tempo = TimeInterval(9.3)
        let seaweed:ObjetoAnimado = ObjetoAnimado ("seaweed")
        
        seaweed.size = CGSize(width: 210, height: 200)
        seaweed.position = CGPoint(x: self.size.width+px, y: self.size.height/2+CGFloat(py))
        seaweed.name = "Item"
        self.addChild(seaweed)
        
        seaweed.physicsBody = SKPhysicsBody (rectangleOf: CGSize(width: seaweed.size.width-5, height: 30), center:CGPoint (x:0,y:-seaweed.size.height/2+25))
        seaweed.physicsBody?.isDynamic = false
        seaweed.physicsBody?.allowsRotation = false
        seaweed.physicsBody?.categoryBitMask = idItem
        seaweed.run(SKAction.sequence([SKAction.moveTo(x: -self.frame.size.width-200, duration: tempo), SKAction.removeFromParent()]))
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        for a in enemies {
            a.atuliazaSinusoidA()
        }
        
        for b in enemies1 {
            b.atuliazaSinusoidB()
        }
        
        if(!finished && started){
            if(turtle.position.y < (self.size.height/4 - 70)) || (turtle.position.y > (self.size.height/2+600)) {
                fimDeJogo ()
            }
        }
    }
    
    func fimDeJogo() {
        self.run(soundClose)
        finished = true
        
        self.turtle.physicsBody?.applyImpulse(CGVector(dx:-180, dy: 150))
        objetoDummy.speed = 0
        objetoDummy1.speed = 0
        objetoDummy2.speed = 0
        objetoDummy3.speed = 0
        
        self.gameOver.isHidden = false
        self.gameOver.alpha = 0.0
        self.btnRestart.alpha = 0.0
        
        UIView.animate(withDuration: 0.5, delay: 0.5, options: [.curveEaseInOut], animations: {
            self.gameOver.alpha = 1.0
            self.btnRestart.alpha = 1.0
        }, completion: nil)
        
        self.run(SKAction.sequence([SKAction.wait(forDuration: 1.7), SKAction.run({
            canRestart = true;
            self.btnPlay.isHidden = true
            self.gameOver.isHidden = true
            
            self.btnRestart.alpha = 0
            
            self.btnRestart.isHidden = false
            
            UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseInOut], animations: {
                self.btnRestart.alpha = 1.0
            }, completion: nil)
            
            let children = self.children
            for child in children {
                if let node = child as? SKNode, (node.name == "Item" || node.name == "Inimigo") {
                    
                    let fadeOutAction = SKAction.fadeOut(withDuration: 0.5)
                    let removeAction = SKAction.removeFromParent()
                    let sequenceAction = SKAction.sequence([fadeOutAction, removeAction])
                    node.run(sequenceAction)
                }
            }
        })]))
    }
    
    func createBubble (_ pos:CGPoint){
        let bubble: ObjetoAnimado = ObjetoAnimado ("bubble")
        bubble.position = pos
        self.addChild(bubble)
        bubble.run(SKAction.move(by: CGVector (dx: -10, dy: 5), duration: 1.0))
        bubble.run (SKAction.sequence ( [SKAction.wait(forDuration: 0.5),SKAction.removeFromParent ()]))
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if(contact.bodyA.node?.name == "Inimigo" ){
            contact.bodyA.node?.removeFromParent ()
            fimDeJogo()
        }
        
        if(contact.bodyA.node?.name == "Item" ){
            let px = CGFloat(contact.bodyA.node?.position.x ?? 0)
            let py = CGFloat(contact.bodyA.node?.position.y ?? 0)
            contact.bodyA.node?.removeFromParent()
            createBubble(CGPoint(x: px, y: py))
            
            contact.bodyA.node?.removeFromParent()
            self.run(soundBubble)
            scores += 1
            textScores.text = "\(scores)"
        }
    }
}
