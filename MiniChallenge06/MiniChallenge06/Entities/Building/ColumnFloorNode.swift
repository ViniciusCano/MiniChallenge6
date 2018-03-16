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
            let plane = SCNPlane(width: 0.5, height: 0.5)
            let planeNode = SCNNode(geometry: plane)
//            planeNode.eulerAngles = SCNVector3.init(-Float.pi/2, 0, 0)
//            planeNode.position = SCNVector3.init(0, blockSize/2, 0)
//            planeNode.physicsBody?.categoryBitMask = 1
//            planeNode.physicsBody?.collisionBitMask = 1
//            planeNode.physicsBody?.contactTestBitMask = 1
//            planeNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
            node.physicsBody = SCNPhysicsBody(type: .kinematic, shape: nil)
//            node.addChildNode(planeNode)
            
            node.position = SCNVector3.init(CGFloat(x)*blockSize, 0, CGFloat(z)*blockSize)
            super.addChildNode(node)
        }
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
