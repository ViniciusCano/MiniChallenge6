//
//  Plane.swift
//  MiniChallenge06
//
//  Created by Heitor Ishihara on 15/03/2018.
//  Copyright © 2018 Vinícius Cano Santos. All rights reserved.
//

import ARKit
import SceneKit

class Plane: SCNNode {
    var anchor: ARPlaneAnchor!
    var planeGeometry: SCNPlane!
    
    init(with anchor: ARPlaneAnchor) {
        super.init()
        self.anchor = anchor
        
        let width = CGFloat(anchor.extent.x)
        let heigth = CGFloat(anchor.extent.z)
        self.planeGeometry = SCNPlane(width: 30, height: 30)
        self.planeGeometry.materials.first?.diffuse.contents = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.5)
        
        let planeNode = SCNNode(geometry: self.planeGeometry)
        let x = CGFloat(anchor.center.x)
        let y = CGFloat(anchor.center.y)
        let z = CGFloat(anchor.center.z)
        
        planeNode.position = SCNVector3(x,y,z)
        planeNode.opacity = 0.5
        planeNode.physicsBody = SCNPhysicsBody(type: .kinematic, shape: SCNPhysicsShape(geometry: planeGeometry, options: nil))
        
        
        
        self.addChildNode(planeNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
