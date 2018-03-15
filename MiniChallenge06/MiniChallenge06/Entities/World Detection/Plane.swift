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
        self.planeGeometry = SCNPlane(width: width, height: heigth)
        self.planeGeometry.materials.first?.diffuse.contents = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.5)
        
        let planeNode = SCNNode(geometry: self.planeGeometry)
        planeNode.simdPosition = float3(anchor.center.x, 0, anchor.center.z)
        planeNode.eulerAngles.x = -.pi/2
        planeNode.opacity = 0.5
        planeNode.physicsBody = SCNPhysicsBody(type: .static, shape: SCNPhysicsShape(geometry: planeGeometry, options: nil))
        
        
        self.addChildNode(planeNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
