//
//  Annie-And-The-Ocean
//
import SpriteKit
import AVFoundation

class GameScene: SKScene, SKPhysicsContactDelegate {

    // MARK: - Constants

    private let idTurtle: UInt32 = 1
    private let idEnemy: UInt32 = 2
    private let idItem: UInt32 = 3

    private let soundBubble = SKAction.playSoundFileNamed("bubble.mp4", waitForCompletion: false)
    private let soundClose = SKAction.playSoundFileNamed("close.mp4", waitForCompletion: false)

    // MARK: - State

    private var started = false
    private var finished = false
    private var canRestart = false
    private var scores = 0
    private var difficultyMultiplier: CGFloat = 1.0
    private var backAudioGame: AVAudioPlayer?

    // MARK: - UI Nodes

    private let textScores = SKLabelNode(fontNamed: "OpenSans-Light")
    private let btnPlay = SKSpriteNode(imageNamed: "btnPlay")
    private let btnRestart = SKSpriteNode(imageNamed: "btnRestart")
    private let gameOverSprite = SKSpriteNode(imageNamed: "gameOver")
    private let turtle = ObjetoAnimado("turtle")

    // MARK: - Parallax Layers

    private let layerBack1 = SKNode()
    private let layerBack2 = SKNode()
    private let layerBack3 = SKNode()
    private let layerBack4 = SKNode()
    private let layerFront = SKNode()

    // MARK: - Enemies

    private var enemiesA: [ObjetoAnimado] = []
    private var enemiesB: [ObjetoAnimado] = []

    // MARK: - Lifecycle

    override func didMove(to view: SKView) {
        AudioManager.shared.stopAll()
        setupAudio()

        self.backgroundColor = .black
        self.physicsWorld.contactDelegate = self

        setupParallaxLayer(layerBack1, image: "back1", duration: 18, yOffset: -60, height: self.size.height / 2 + 80)
        setupParallaxLayer(layerBack2, image: "back2", duration: 20, yOffset: 60, height: self.size.height / 2 - 200)
        setupParallaxLayer(layerBack3, image: "back3", duration: 12, yOffset: -60, height: self.size.height / 2 + 80, xPadding: -5)
        setupParallaxLayer(layerBack4, image: "back4", duration: 5, yOffset: -65, height: self.size.height / 2 + 200)
        setupFrontLayer()

        setupTurtle()
        setupScoreUI()
        setupButtons()
        startSpawning()
    }

    // MARK: - Setup

    private func setupAudio() {
        guard let filePath = Bundle.main.path(forResource: "game", ofType: "mp4") else { return }
        let audioURL = URL(fileURLWithPath: filePath)
        do {
            backAudioGame = try AVAudioPlayer(contentsOf: audioURL)
        } catch {
            print("Cannot Find The Audio")
            return
        }
        backAudioGame?.numberOfLoops = -1
        backAudioGame?.volume = 1.0
        backAudioGame?.play(atTime: (backAudioGame?.deviceCurrentTime ?? 0) + 0.6)
    }

    private func setupParallaxLayer(_ layer: SKNode, image: String, duration: TimeInterval, yOffset: CGFloat, height: CGFloat, xPadding: CGFloat = 0) {
        let move = SKAction.moveBy(x: -self.size.width, y: 0, duration: duration)
        let reset = SKAction.moveBy(x: self.size.width, y: 0, duration: 0)
        let loop = SKAction.repeatForever(SKAction.sequence([move, reset]))

        for i in 0..<2 {
            let bg = SKSpriteNode(imageNamed: image)
            bg.anchorPoint = CGPoint(x: 0, y: 0)
            bg.size.width = self.size.width
            bg.size.height = height
            bg.position = CGPoint(x: self.size.width * CGFloat(i) + xPadding, y: self.size.height / 4 + yOffset)
            bg.zPosition = -1
            bg.run(loop)
            layer.addChild(bg)
        }
        self.addChild(layer)
        layer.speed = 0
    }

    private func setupFrontLayer() {
        let move = SKAction.moveBy(x: -self.size.width, y: 0, duration: 2.5)
        let reset = SKAction.moveBy(x: self.size.width, y: 0, duration: 0)
        let loop = SKAction.repeatForever(SKAction.sequence([move, reset]))

        for i in 0..<2 {
            let bg = SKSpriteNode(imageNamed: "back6")
            bg.anchorPoint = CGPoint(x: 0, y: 0)
            bg.size.width = self.size.width + 65
            bg.size.height = self.size.height / 2 + 200
            bg.position = CGPoint(x: self.size.width * CGFloat(i) - 30, y: 350)
            bg.zPosition = -1
            bg.run(loop)
            layerFront.addChild(bg)
        }
        self.addChild(layerFront)
        layerFront.speed = 1.5
    }

    private func setupTurtle() {
        turtle.position = CGPoint(x: self.size.width / 4 - 100, y: self.size.height / 2 - 230)
        turtle.name = "Personagem"
        self.addChild(turtle)
    }

    private func setupScoreUI() {
        let score = SKSpriteNode(imageNamed: "score")
        score.size = CGSize(width: 300, height: 123)
        score.anchorPoint = CGPoint(x: 1.0, y: 0.0)
        score.position = CGPoint(x: self.size.width / 2 + 150, y: self.size.height / 2 + 410)
        score.name = "score"
        self.addChild(score)

        textScores.text = "0"
        textScores.fontColor = .white
        textScores.fontSize = 55
        textScores.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2 + 430)
        self.addChild(textScores)
    }

    private func setupButtons() {
        btnPlay.anchorPoint = CGPoint(x: 1.0, y: 0.0)
        btnPlay.zPosition = 1
        btnPlay.position = CGPoint(x: self.size.width / 2 + 250, y: self.size.height / 2 - 200)
        self.addChild(btnPlay)

        btnRestart.anchorPoint = CGPoint(x: 1.0, y: 0.0)
        btnRestart.position = CGPoint(x: self.size.width / 2 + 250, y: self.size.height / 2 - 196)
        btnRestart.zPosition = 1
        btnRestart.isHidden = true
        self.addChild(btnRestart)

        gameOverSprite.anchorPoint = CGPoint(x: 1.0, y: 0.0)
        gameOverSprite.position = CGPoint(x: self.size.width / 2 + 430, y: self.size.height / 2 - 196)
        gameOverSprite.zPosition = 1
        gameOverSprite.isHidden = true
        self.addChild(gameOverSprite)
    }

    private func startSpawning() {
        let spawnAction = SKAction.run { [weak self] in
            guard let self = self, !self.finished, self.started else { return }
            let roll = Int.random(in: 0..<20)
            if roll < 5 {
                self.createEnemyA()
            } else if roll < 13 {
                self.createEnemyB()
            } else if roll >= 15 {
                self.createSeaweed()
            }
        }
        let waitAction = SKAction.wait(forDuration: 1.0, withRange: 2.0)
        self.run(SKAction.repeatForever(SKAction.sequence([spawnAction, waitAction])))
    }

    // MARK: - Touch

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !started {
            startGame()
        } else if started && !finished {
            turtle.physicsBody?.velocity = CGVector.zero
            turtle.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 200))
        } else if canRestart {
            restartGame()
        }
    }

    private func startGame() {
        started = true
        difficultyMultiplier = 1.0

        turtle.physicsBody = SKPhysicsBody(circleOfRadius: turtle.size.height / 2.5, center: CGPoint(x: 10, y: 0))
        turtle.physicsBody?.isDynamic = true
        turtle.physicsBody?.allowsRotation = false
        turtle.physicsBody?.categoryBitMask = idTurtle
        turtle.physicsBody?.collisionBitMask = 0
        turtle.physicsBody?.contactTestBitMask = idEnemy | idItem

        btnPlay.isHidden = true
        btnRestart.isHidden = true
        gameOverSprite.isHidden = true

        layerBack1.speed = 1
        layerBack2.speed = 1
        layerBack3.speed = 1.1
        layerBack4.speed = 1.1
        layerFront.speed = 1.5

        turtle.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 200))

        // Progressive difficulty
        let increaseDifficulty = SKAction.run { [weak self] in
            guard let self = self else { return }
            if self.difficultyMultiplier < 1.8 {
                self.difficultyMultiplier += 0.05
                self.layerBack1.speed = self.difficultyMultiplier
                self.layerBack2.speed = self.difficultyMultiplier
                self.layerBack3.speed = self.difficultyMultiplier * 1.1
                self.layerBack4.speed = self.difficultyMultiplier * 1.1
                self.layerFront.speed = self.difficultyMultiplier * 1.5
            }
        }
        self.run(SKAction.repeatForever(SKAction.sequence([
            SKAction.wait(forDuration: 8.0),
            increaseDifficulty
        ])), withKey: "difficulty")
    }

    private func restartGame() {
        turtle.position = CGPoint(x: self.size.width / 4 - 100, y: self.size.height / 2 - 230)
        turtle.physicsBody?.velocity = CGVector.zero
        turtle.physicsBody?.isDynamic = false
        turtle.zRotation = 0

        started = false
        finished = false
        canRestart = false

        btnRestart.isHidden = true
        gameOverSprite.isHidden = true

        btnPlay.alpha = 0
        btnPlay.isHidden = false
        btnPlay.run(SKAction.fadeIn(withDuration: 0.5))

        scores = 0
        textScores.text = "0"

        layerBack1.speed = 0
        layerBack2.speed = 0
        layerBack3.speed = 0
        layerBack4.speed = 0
        layerFront.speed = 1.5

        self.removeAction(forKey: "difficulty")
    }

    // MARK: - Physics

    override func didSimulatePhysics() {
        if started {
            turtle.zRotation = (turtle.physicsBody?.velocity.dy ?? 0) * 0.0005
        }
    }

    // MARK: - Enemy/Item Creation

    private func createEnemyA() {
        let px = self.frame.size.width + CGFloat(Float.random(in: 30..<240))
        let py = Float.random(in: 50..<480)
        let baseTempo = Float.random(in: 12..<17.0)
        let tempo = TimeInterval(baseTempo / Float(difficultyMultiplier))

        let shark = ObjetoAnimado("shark")
        shark.setScale(1.2)
        shark.position = CGPoint(x: px, y: self.size.height / 2 + CGFloat(py))
        shark.name = "Inimigo"

        shark.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: shark.size.width - 10, height: 30),
                                          center: CGPoint(x: 0, y: -shark.size.height / 2 + 25))
        shark.physicsBody?.isDynamic = false
        shark.physicsBody?.allowsRotation = false
        shark.physicsBody?.categoryBitMask = idEnemy

        self.addChild(shark)
        enemiesA.append(shark)

        shark.run(SKAction.sequence([
            SKAction.moveTo(x: -self.frame.size.width - 700, duration: tempo),
            SKAction.removeFromParent(),
            SKAction.run { [weak self] in
                self?.enemiesA.removeAll { $0 === shark }
            }
        ]))
    }

    private func createEnemyB() {
        let px = self.frame.size.width + CGFloat(Float.random(in: 70..<200.0))
        let py = CGFloat(Float.random(in: -50..<10) + 10)
        let baseTempo = Float.random(in: 12..<17.0)
        let tempo = TimeInterval(baseTempo / Float(difficultyMultiplier))

        let trash = ObjetoAnimado("trash0")
        trash.setScale(1.3)
        trash.position = CGPoint(x: px, y: self.size.height / 2 + py)
        trash.name = "Inimigo"

        trash.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: trash.size.width - 10, height: 30),
                                          center: CGPoint(x: 0, y: -trash.size.height / 2 + 25))
        trash.physicsBody?.isDynamic = false
        trash.physicsBody?.allowsRotation = false
        trash.physicsBody?.categoryBitMask = idEnemy

        self.addChild(trash)
        enemiesB.append(trash)

        trash.run(SKAction.sequence([
            SKAction.moveTo(x: -self.frame.size.width - 700, duration: tempo),
            SKAction.removeFromParent(),
            SKAction.run { [weak self] in
                self?.enemiesB.removeAll { $0 === trash }
            }
        ]))
    }

    private func createSeaweed() {
        let px = self.frame.size.width + CGFloat(Float.random(in: 0..<200.0))
        let py = CGFloat(Float.random(in: -320..<440.0) + 50)
        let tempo = TimeInterval(9.3 / Double(difficultyMultiplier))

        let seaweed = ObjetoAnimado("seaweed")
        seaweed.size = CGSize(width: 210, height: 200)
        seaweed.position = CGPoint(x: self.size.width + px, y: self.size.height / 2 + py)
        seaweed.name = "Item"

        seaweed.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: seaweed.size.width - 5, height: 30),
                                            center: CGPoint(x: 0, y: -seaweed.size.height / 2 + 25))
        seaweed.physicsBody?.isDynamic = false
        seaweed.physicsBody?.allowsRotation = false
        seaweed.physicsBody?.categoryBitMask = idItem

        self.addChild(seaweed)

        seaweed.run(SKAction.sequence([
            SKAction.moveTo(x: -self.frame.size.width - 200, duration: tempo),
            SKAction.removeFromParent()
        ]))
    }

    // MARK: - Update

    override func update(_ currentTime: TimeInterval) {
        for a in enemiesA {
            a.atualizaSinusoidA()
        }
        for b in enemiesB {
            b.atualizaSinusoidB()
        }

        guard !finished, started else { return }

        if turtle.position.y < (self.size.height / 4 - 70) ||
           turtle.position.y > (self.size.height / 2 + 600) {
            fimDeJogo()
        }
    }

    // MARK: - Game Over

    private func fimDeJogo() {
        self.run(soundClose)
        finished = true

        turtle.physicsBody?.applyImpulse(CGVector(dx: -180, dy: 150))
        layerBack1.speed = 0
        layerBack2.speed = 0
        layerBack3.speed = 0
        layerBack4.speed = 0
        self.removeAction(forKey: "difficulty")

        // Screen shake
        let shake = SKAction.sequence([
            SKAction.moveBy(x: 8, y: 0, duration: 0.05),
            SKAction.moveBy(x: -16, y: 0, duration: 0.05),
            SKAction.moveBy(x: 8, y: 0, duration: 0.05)
        ])
        self.run(SKAction.repeat(shake, count: 3))

        gameOverSprite.isHidden = false
        gameOverSprite.alpha = 0
        gameOverSprite.setScale(0.8)
        gameOverSprite.run(SKAction.group([
            SKAction.fadeIn(withDuration: 0.5),
            SKAction.scale(to: 1.0, duration: 0.3)
        ]))

        self.run(SKAction.sequence([
            SKAction.wait(forDuration: 1.7),
            SKAction.run { [weak self] in
                guard let self = self else { return }
                self.canRestart = true
                self.btnPlay.isHidden = true
                self.gameOverSprite.isHidden = true

                self.btnRestart.alpha = 0
                self.btnRestart.isHidden = false
                self.btnRestart.run(SKAction.fadeIn(withDuration: 0.5))

                for child in self.children {
                    if child.name == "Item" || child.name == "Inimigo" {
                        child.run(SKAction.sequence([
                            SKAction.fadeOut(withDuration: 0.5),
                            SKAction.removeFromParent()
                        ]))
                    }
                }
                self.enemiesA.removeAll()
                self.enemiesB.removeAll()
            }
        ]))
    }

    // MARK: - Collect Effect

    private func createBubble(_ pos: CGPoint) {
        let bubble = ObjetoAnimado("bubble")
        bubble.position = pos
        self.addChild(bubble)
        bubble.run(SKAction.group([
            SKAction.move(by: CGVector(dx: -10, dy: 30), duration: 0.8),
            SKAction.fadeOut(withDuration: 0.8),
            SKAction.scale(to: 1.5, duration: 0.8)
        ]))
        bubble.run(SKAction.sequence([
            SKAction.wait(forDuration: 0.8),
            SKAction.removeFromParent()
        ]))
    }

    private func pulseScore() {
        let pulse = SKAction.sequence([
            SKAction.scale(to: 1.4, duration: 0.1),
            SKAction.scale(to: 1.0, duration: 0.15)
        ])
        textScores.run(pulse)
    }

    // MARK: - Collision

    func didBegin(_ contact: SKPhysicsContact) {
        let nodeA = contact.bodyA.node
        let nodeB = contact.bodyB.node

        let enemy = [nodeA, nodeB].first { $0?.name == "Inimigo" }
        let item = [nodeA, nodeB].first { $0?.name == "Item" }

        if let enemy = enemy {
            enemy?.removeFromParent()
            fimDeJogo()
            return
        }

        if let item = item, let itemNode = item {
            let pos = itemNode.position
            itemNode.removeFromParent()
            createBubble(pos)
            self.run(soundBubble)
            scores += 1
            textScores.text = "\(scores)"
            pulseScore()
        }
    }
}
