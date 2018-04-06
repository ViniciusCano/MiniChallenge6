//
//  Bomb.swift
//  ARKitNanoChallenge
//
//  Created by Heitor Ishihara on 13/03/2018.
//  Copyright © 2018 Heitor Ishihara. All rights reserved.
//

import SceneKit

class Bomb: SCNNode {
    
    //MARK:- Attributes
    
    //MARK:- Initializer
    override init() {
        super.init()
        
    }
    
    init(radius: CGFloat) {
        super.init()
        
        let bombSphereGeometry = SCNSphere(radius: radius)
        self.geometry = bombSphereGeometry
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Functions
    func explode() {
        let gravity = SCNPhysicsField.radialGravity()
        gravity.strength = -10000
        gravity.falloffExponent = 0.5
        
        self.physicsField = gravity
        self.removeFromParentNode()
    }
    
    func explode(power: CGFloat) {
        let gravity = SCNPhysicsField.radialGravity()
        gravity.strength = -power
        gravity.falloffExponent = 0.5

        self.physicsField = gravity
        self.runAction(SCNAction.sequence([SCNAction.wait(duration: 0.2),SCNAction.run({ (node) in
            node.removeFromParentNode()
        })]))
        
    }

    
    
}
