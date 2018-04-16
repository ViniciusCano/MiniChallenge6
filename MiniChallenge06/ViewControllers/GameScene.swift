import SceneKit

class GameScene: SCNScene {
    
    var level: Int32 = 0
    var building = Building()
    var bombs: Int32 = 0
    
    init(level: Int32, bombs: Int32) {
        super.init()
        self.level = level
        self.bombs = bombs
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
