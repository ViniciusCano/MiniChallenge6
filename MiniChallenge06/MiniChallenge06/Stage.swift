//
//  ViewController.swift
//  MiniChallenge06
//
//  Created by Vinícius Cano Santos on 15/03/2018.
//  Copyright © 2018 Vinícius Cano Santos. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class Stage: UIViewController, ARSCNViewDelegate {

    
    //MARK:- Outlets and Actions
    @IBOutlet var sceneView: ARSCNView!
    
    //MARK:- Variables
    var mainPlane = SCNNode()
    var bomb = Bomb(radius: 0.1)
    let building = Building()
    
    //Control Variables
    var didSetPlane = false
    var didUpdatePlane = false
    
    var didSetBuilding = false
    
    
    //MARK:- Overrided Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupSceneView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let tap = touches.first else { return }
        
        if !didSetBuilding {
            self.addBuilding(touch: tap)
        } else {
            self.bomb.explode(power: 20)
        }
    }
    
    //MARK:- Functions
    func setupSceneView() {
        //Debug Options
        sceneView.debugOptions = [.showPhysicsShapes]
        
        //Base Bonfigurations
        sceneView.delegate = self
        sceneView.showsStatistics = true
     
        //Start world tracking for Plane Detection
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        sceneView.session.run(configuration)
    }
    
    func addBuilding(touch: UITouch) {
        
        //Add Building
        let tapLocation = touch.location(in: sceneView)
        let hitTestResults = sceneView.hitTest(tapLocation, types: .existingPlaneUsingExtent)
        
        guard let hitTestResult = hitTestResults.first else { return }
        let translation = hitTestResult.worldTransform.translation
        
        let x = translation.x
        let y = translation.y
        let z = translation.z
        
        self.building.addFloor(floor: ColumnFloorNode(coordinates: [(0, 0), (0, 4), (4, 0), (4, 4)]))
        self.building.addFloor(floor: FloorNode(numberOfXBlocks: 5, numberOfZBlocks: 5))
        self.building.addFloor(floor: ColumnFloorNode(coordinates: [(0, 0), (0, 4), (4, 0), (4, 4)]))
        self.building.addFloor(floor: FloorNode(numberOfXBlocks: 5, numberOfZBlocks: 5))
        self.building.addFloor(floor: ColumnFloorNode(coordinates: [(0, 0), (0, 4), (4, 0), (4, 4)]))
        self.building.addFloor(floor: FloorNode(numberOfXBlocks: 5, numberOfZBlocks: 5))
        self.building.addFloor(floor: ColumnFloorNode(coordinates: [(0, 0), (0, 4), (4, 0), (4, 4)]))
        self.building.addFloor(floor: FloorNode(numberOfXBlocks: 5, numberOfZBlocks: 5))
        
        
        self.building.position = SCNVector3.init(x, y + 0.1, z)
        self.building.activate()
        
        sceneView.scene.rootNode.addChildNode(building)
        self.didSetBuilding = true
        
        //Add Bomb (Test)
        self.bomb.position = SCNVector3.init(x + 0.2, y + 0.2, z)
        sceneView.scene.rootNode.addChildNode(bomb)
        
    }
}

//MARK:- ARSCNViewDelegate
extension Stage {
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        if !didSetPlane {
            //Add Plane
            guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
            self.mainPlane = Plane(with: planeAnchor)
            self.mainPlane.eulerAngles.x = -.pi / 2
            node.addChildNode(mainPlane)
            
            self.didSetPlane = true
        }
    }
    
    //Update
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        if !didUpdatePlane && didSetPlane {
            guard let planeAnchor = anchor as?  ARPlaneAnchor,
                let plane = mainPlane.childNodes.first?.geometry as? SCNPlane
                else { return }
            
            let width = CGFloat(planeAnchor.extent.x)
            let height = CGFloat(planeAnchor.extent.z)
            plane.width = 30
            plane.height = 30
            
            let x = CGFloat(planeAnchor.center.x)
            let y = CGFloat(planeAnchor.center.y)
            let z = CGFloat(planeAnchor.center.z)
            
            mainPlane.position = SCNVector3(x, y, z)
            
            mainPlane.physicsBody = SCNPhysicsBody(type: .static, shape: SCNPhysicsShape(geometry: plane, options: nil))
            
            self.didUpdatePlane = true
        }
    }
}

//Float4x4 Extension
extension float4x4 {
    var translation: float3 {
        let translation = self.columns.3
        return float3(translation.x, translation.y, translation.z)
    }
}

