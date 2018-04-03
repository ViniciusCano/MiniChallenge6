//
//  Column.swift
//  empilhar
//
//  Created by Vinícius Cano Santos on 13/03/2018.
//  Copyright © 2018 Vinícius Cano Santos. All rights reserved.
//

import UIKit
import SceneKit

class ColumnFloorNode: FloorNode{
    
    //MARK:- Initializer
    init(coordinates: [(Int, Int)]) {
        super.init()
        
        for (x, z) in coordinates{
            let column = SCNBox(width: blockSize, height: blockSize, length: blockSize, chamferRadius: 0)
            column.firstMaterial?.diffuse.contents = UIColor.red
            let node = SCNNode(geometry: column)
            node.physicsBody?.damping = 1
            node.physicsBody?.friction = 1
            node.physicsBody?.restitution = 0
            node.physicsBody?.mass = 1
            node.physicsBody = SCNPhysicsBody(type: .dynamic, shape: SCNPhysicsShape(geometry: column, options: nil))
            
            node.position = SCNVector3.init(CGFloat(x)*blockSize, 0, CGFloat(z)*blockSize)
            super.addChildNode(node)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
