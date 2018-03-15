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

    var bomb = Bomb(radius: 0.2)
    
    //MARK:- Outlets and Actions
    @IBOutlet var sceneView: ARSCNView!
    
    //MARK:- Variables
    var mainPlane = SCNNode()
    
    //Control Variables
    var didSetPlane = false
    var didUpdatePlane = false
    
    //MARK:- Overrided Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupSceneView()
        
        //teste
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {        super.viewWillDisappear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK:- Functions
    func setupSceneView() {
        //Debug Options
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, .showBoundingBoxes, .showPhysicsShapes]
        
        //Base Bonfigurations
        sceneView.delegate = self
        sceneView.showsStatistics = true
     
        //Start world tracking for Plane Detection
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        sceneView.session.run(configuration)
    }
}

//MARK:- ARSCNViewDelegate
extension Stage {
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        if !didSetPlane {
            guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
            self.mainPlane = Plane(with: planeAnchor)
            node.addChildNode(mainPlane)
            
            self.didSetPlane = true
            
            let building = Building.init()
            sceneView.scene.rootNode.addChildNode(building)
            building.addFloor(floor: FloorNode(numberOfXBlocks: 10, numberOfZBlocks: 10))
            
            bomb.position = SCNVector3(x: 0.0, y: 0.0, z: 0.0)
            sceneView.scene.rootNode.addChildNode(bomb)
        }
    }
    
    // Update
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        if !didUpdatePlane && didSetPlane {
            self.mainPlane.geometry = SCNPlane(width: CGFloat.infinity, height: CGFloat.infinity)
            
            self.didUpdatePlane = true
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        bomb.explode(power: -500)
    }
    
}
