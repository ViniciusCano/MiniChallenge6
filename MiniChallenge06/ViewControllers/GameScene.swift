import SceneKit

class GameScene: SCNScene {
    
    var building = Building()
    var bombs: Int = 0
    
    init(bombs: Int) {
        super.init()
        self.bombs = bombs
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
