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
    
    func activate(bomb: Bomb) {
        print(bomb.worldPosition)
        let bombRoundedPositionX = round(1000 * bomb.worldPosition.x) / 1000 + 0.1
        let bombRoundedPositionY = round(1000 * bomb.worldPosition.y) / 1000 + 0.1
        let bombRoundedPositionZ = round(1000 * bomb.worldPosition.z) / 1000 + 0.1
        
        for item in self.childNodes {
            for node in item.childNodes {
                let blockSize = Float((node.parent as! FloorNode).blockSize)
                print(node.worldPosition.x, node.worldPosition.y, node.worldPosition.z)
                //1 - Tudo Positivo
                //2 - Tudo Negativo
                //3 - X negativo Y positivo Z positivo
                //4 - X e Y negativo Z positivo
                //5 - X e Z positivo Y negativo
                //6 - X positivo Y e Z negativo
                //7 - X e Y positivo e Z negativo
                //8 - X e Z negativo e Y positivo
                if (((round(1000 * node.worldPosition.x) / 1000) <= bombRoundedPositionX + blockSize) && ((round(1000 * node.worldPosition.y) / 1000) <= bombRoundedPositionY + blockSize) && ((round(1000 * node.worldPosition.z) / 1000) <= bombRoundedPositionZ + blockSize)) ||
                    (((round(1000 * node.worldPosition.x) / 1000) >= bombRoundedPositionX + blockSize + 0.1) && ((round(1000 * node.worldPosition.y) / 1000) >= bombRoundedPositionY + blockSize + 0.1) && ((round(1000 * node.worldPosition.z) / 1000) >= bombRoundedPositionZ + blockSize + 0.1)) ||
                    (((round(1000 * node.worldPosition.x) / 1000) >= bombRoundedPositionX + blockSize + 0.1) && ((round(1000 * node.worldPosition.y) / 1000) <= bombRoundedPositionY + blockSize) && ((round(1000 * node.worldPosition.z) / 1000) <= bombRoundedPositionZ + blockSize)) ||
                    (((round(1000 * node.worldPosition.x) / 1000) >= bombRoundedPositionX + blockSize + 0.1) && ((round(1000 * node.worldPosition.y) / 1000) >= bombRoundedPositionY + blockSize + 0.1) && ((round(1000 * node.worldPosition.z) / 1000) <= bombRoundedPositionZ + blockSize)) ||
                    (((round(1000 * node.worldPosition.x) / 1000) <= bombRoundedPositionX + blockSize) && ((round(1000 * node.worldPosition.y) / 1000) <= bombRoundedPositionY + blockSize) && ((round(1000 * node.worldPosition.z) / 1000) >= bombRoundedPositionZ + blockSize + 0.1)) ||
                    (((round(1000 * node.worldPosition.x) / 1000) >= bombRoundedPositionX + blockSize + 0.1) && ((round(1000 * node.worldPosition.y) / 1000) <= bombRoundedPositionY + blockSize) && ((round(1000 * node.worldPosition.z) / 1000) >= bombRoundedPositionZ + blockSize + 0.1))
                    {
                    
                    node.physicsBody = nil
                    guard let nodeGeometry = node.geometry else { return }
                    node.physicsBody = SCNPhysicsBody(type: .dynamic, shape: SCNPhysicsShape(geometry: nodeGeometry, options: nil))
                }
            }
        }
    }
}


extension SCNVector3 {
    func length() -> Float {
        return sqrtf(x*x + y*y + z*z)
    }
    
    static func - (left: SCNVector3, right: SCNVector3) -> SCNVector3 {
        return SCNVector3Make(left.x - right.x, left.y - right.y, left.z - right.z)
    }
    
    func distance(vector: SCNVector3) -> Float {
        return (self - vector).length()
    }
}


