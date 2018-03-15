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
    
    //Control Variables
    var didSetPlane = false
    
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
    
    //MARK:- Functions
    func setupSceneView() {
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
            self.mainPlane = Plane(with: anchor as! ARPlaneAnchor)
            node.addChildNode(mainPlane)
        }
    }
}
