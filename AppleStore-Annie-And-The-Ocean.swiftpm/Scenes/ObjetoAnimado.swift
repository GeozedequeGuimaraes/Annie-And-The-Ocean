//
//  Annie-And-The-Ocean
//
import SpriteKit

class ObjetoAnimado: SKSpriteNode {
    var nome: String?
    var sinOffSet = CGFloat(Float.random(in:1200..<1360.0))
    var sinOffSet1 = CGFloat(Float.random(in:600..<800.0))
    
    init(_ nome:String) {
        self.nome = nome
    let textura = SKTexture(imageNamed: "\(nome)1")
    super.init(texture: textura, color: .red, size:textura.size ())
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        var imagens: [SKTexture] = []
        for i in 1...3 {
            imagens.append(SKTexture(imageNamed: "\(self.nome!)\(i)"))
        }
        let animacao:SKAction = SKAction.animate (with: imagens, timePerFrame: 0.2,resize: true, restore: true)
        animacao.timingMode = .easeInEaseOut
        self.run(SKAction.repeatForever(animacao))
    }
    
    public func atuliazaSinusoidA(){
        let py = CGFloat((sin(self.position.x*0.01)*100)+50+sinOffSet)
        self.position = CGPoint(x:self.position.x, y:py);
    }
    
    public func atuliazaSinusoidB(){
        let py = CGFloat((sin(self.position.x*0.01)*100)+50+sinOffSet1)
        self.position = CGPoint(x:self.position.x, y:py);
    }
}
