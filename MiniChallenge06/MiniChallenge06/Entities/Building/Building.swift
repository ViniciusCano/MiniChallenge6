//
//  Building.swift
//  empilhar
//
//  Created by Vinícius Cano Santos on 12/03/2018.
//  Copyright © 2018 Vinícius Cano Santos. All rights reserved.
//

import UIKit
import SceneKit

class Building: SCNNode {
    
    //MARK:- Functions
    func addFloor(floor: FloorNode) {
        floor.position.y = (Float(self.childNodes.count) * Float(floor.blockSize))
        self.addChildNode(floor)
    }
    
    func activate(){
        for item in self.childNodes {
            for node in item.childNodes {
                node.physicsBody = nil
                guard let nodeGeometry = node.geometry else { return }
                node.physicsBody = SCNPhysicsBody(type: .dynamic, shape: SCNPhysicsShape(geometry: nodeGeometry, options: nil))
            }
        }
    }
    
}


