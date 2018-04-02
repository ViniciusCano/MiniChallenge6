//
//  Floor.swift
//  empilhar
//
//  Created by Vinícius Cano Santos on 12/03/2018.
//  Copyright © 2018 Vinícius Cano Santos. All rights reserved.
//

import UIKit
import SceneKit

class FloorNode: SCNNode {
    
    //MARK:- Variables
    var numberOfXBlocks: Int?
    var numberOfZBlocks: Int?
    var blockSize: CGFloat = 0.1
    
    //MARK:- Initializers
    override init() {
        super.init()
    }
    
    init(numberOfXBlocks: Int, numberOfZBlocks: Int) {
        super.init()
        
        self.numberOfXBlocks = numberOfXBlocks
        self.numberOfZBlocks = numberOfZBlocks
        
//        let plane = SCNPlane(width: CGFloat(numberOfXBlocks) * blockSize, height: CGFloat(numberOfZBlocks) * blockSize)
//        plane.firstMaterial?.diffuse.contents = UIColor.red
//        let planeNode = SCNNode(geometry: plane)
//        planeNode.position = SCNVector3.init(((CGFloat(numberOfXBlocks)*blockSize)/2) - blockSize/2, -blockSize/2, (CGFloat(numberOfZBlocks)*blockSize)/2 - blockSize/2)
//        planeNode.eulerAngles = SCNVector3.init(-Float.pi/2, 0, 0)
//        planeNode.physicsBody = SCNPhysicsBody(type: .static, shape: nil)
//        planeNode.physicsBody?.damping = 1
//        planeNode.physicsBody?.restitution = 0
        
//        self.addChildNode(planeNode)
        
        for i in 0...numberOfXBlocks - 1 {
            for j in 0...numberOfZBlocks - 1 {
                let block = SCNBox(width: blockSize, height: blockSize, length: blockSize, chamferRadius: 0)
                block.firstMaterial?.diffuse.contents = UIImage(named: "art.scnassets/textura.jpg")
                let node = SCNNode(geometry: block)
                node.position = SCNVector3.init(blockSize * CGFloat(i), 0.01, blockSize * CGFloat(j))
//                node.physicsBody?.categoryBitMask = 1
//                node.physicsBody?.collisionBitMask = 1
//                node.physicsBody?.contactTestBitMask = 1
                
                
                
                node.physicsBody = SCNPhysicsBody(type: .static, shape: SCNPhysicsShape(geometry: block, options: nil))
                node.physicsBody?.friction = 1
                node.physicsBody?.restitution = 0
                node.physicsBody?.damping = 1
//                node.physicsBody?.mass = 30
//                node.physicsBody?.isAffectedByGravity = false
                super.addChildNode(node)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

