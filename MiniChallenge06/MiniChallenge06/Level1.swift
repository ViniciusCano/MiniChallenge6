import SceneKit

class Level1: GameScene {
    
    init() {
        super.init(level: 1, bombs: 3)
        
        self.building.addFloor(floor: ColumnFloorNode(coordinates: [(0, 0), (0, 4), (4, 0), (4, 4)]))
        self.building.addFloor(floor: FloorNode(numberOfXBlocks: 5, numberOfZBlocks: 5))
        self.building.addFloor(floor: ColumnFloorNode(coordinates: [(0, 0), (0, 4), (4, 0), (4, 4)]))
        self.building.addFloor(floor: FloorNode(numberOfXBlocks: 5, numberOfZBlocks: 5))
        self.building.addFloor(floor: ColumnFloorNode(coordinates: [(0, 0), (0, 4), (4, 0), (4, 4)]))
        self.building.addFloor(floor: FloorNode(numberOfXBlocks: 5, numberOfZBlocks: 5))
        self.building.addFloor(floor: ColumnFloorNode(coordinates: [(0, 0), (0, 4), (4, 0), (4, 4)]))
        self.building.addFloor(floor: FloorNode(numberOfXBlocks: 5, numberOfZBlocks: 5))
        self.building.addFloor(floor: ColumnFloorNode(coordinates: [(0, 0), (0, 4), (4, 0), (4, 4)]))
        self.building.addFloor(floor: FloorNode(numberOfXBlocks: 5, numberOfZBlocks: 5))
        self.building.addFloor(floor: ColumnFloorNode(coordinates: [(0, 0), (0, 4), (4, 0), (4, 4)]))
        self.building.addFloor(floor: FloorNode(numberOfXBlocks: 5, numberOfZBlocks: 5))
        self.building.addFloor(floor: ColumnFloorNode(coordinates: [(0, 0), (0, 4), (4, 0), (4, 4)]))
        self.building.addFloor(floor: FloorNode(numberOfXBlocks: 5, numberOfZBlocks: 5))
        self.building.addFloor(floor: ColumnFloorNode(coordinates: [(0, 0), (0, 4), (4, 0), (4, 4)]))
        self.building.addFloor(floor: FloorNode(numberOfXBlocks: 5, numberOfZBlocks: 5))
        self.building.addFloor(floor: ColumnFloorNode(coordinates: [(0, 0), (0, 4), (4, 0), (4, 4)]))
        self.building.addFloor(floor: FloorNode(numberOfXBlocks: 5, numberOfZBlocks: 5))
        self.building.addFloor(floor: ColumnFloorNode(coordinates: [(0, 0), (0, 4), (4, 0), (4, 4)]))
        self.building.addFloor(floor: FloorNode(numberOfXBlocks: 5, numberOfZBlocks: 5))
        self.building.addFloor(floor: ColumnFloorNode(coordinates: [(0, 0), (0, 4), (4, 0), (4, 4)]))
        self.building.addFloor(floor: FloorNode(numberOfXBlocks: 5, numberOfZBlocks: 5))
        self.building.addFloor(floor: ColumnFloorNode(coordinates: [(0, 0), (0, 4), (4, 0), (4, 4)]))
        self.building.addFloor(floor: FloorNode(numberOfXBlocks: 5, numberOfZBlocks: 5))
        self.building.addFloor(floor: ColumnFloorNode(coordinates: [(0, 0), (0, 4), (4, 0), (4, 4)]))
        self.building.addFloor(floor: FloorNode(numberOfXBlocks: 5, numberOfZBlocks: 5))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
