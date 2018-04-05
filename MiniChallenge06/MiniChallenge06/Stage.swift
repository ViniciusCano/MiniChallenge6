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
    
    @IBOutlet weak var explosionButton: UIButton!
    @IBOutlet weak var bombLabel: UILabel!
    @IBOutlet weak var pauseView: UIView!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBAction func explosionButtonClicked(_ sender: Any) {
        if !isPaused {
            self.explodeBombs()
        }
    }
    
    @IBAction func pauseButtonClicked(_ sender: Any) {
        self.pauseView.isHidden = false
        self.isPaused = true
    }
    
    @IBAction func playButtonClicked(_ sender: Any) {
        self.pauseView.isHidden = true
        self.isPaused = false
    }
    
    @IBAction func menuButtonClicked(_ sender: Any) {
        self.dismiss(animated: true) {
            
        }
    }
    
    @IBAction func restartClicked(_ sender: Any) {
        //Matar a tela e construir de novo
    }
    
    //MARK:- Variables
    var mainPlane = SCNNode()
    
    var maxBombs = 3
    var bombs: [Bomb] = [] {
        didSet {
            self.bombLabel.text = String(maxBombs - bombs.count)

            if bombs.count > 0 {
                self.explosionButton.isEnabled = true                
            }
            
            if bombs.count >= maxBombs {
                self.didPlaceBombs = true
            }
        }
    }
    var score = 0 {
        didSet {
            self.scoreLabel.text = String(score / bombs.count)
        }
    }
    
    let building = Building()
    
    var planeContact: [SCNNode] = []
    
    //Control Variables
    var didSetPlane = false
    var didUpdatePlane = false
    
    var didSetBuilding = false
    
    var didPlaceBombs = false
    
    var isPaused = false
    
    
    //MARK:- Overrided Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupSceneView()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.setupHUD()

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
        
        if !isPaused {
            if !didSetBuilding {
                self.addBuilding(touch: tap)
            } else if bombs.count < maxBombs {
                self.placeBomb(touch: tap)
            }
        }
        
    }
    
    //MARK:- Functions
    func setupHUD() {
        self.bombLabel.text = String(maxBombs)
        self.scoreLabel.text = String(self.score)
        
        self.explosionButton.isEnabled = false

        self.pauseView.layer.cornerRadius = 10
        
    }
    
    func setupSceneView() {
        //Debug Options
        //sceneView.debugOptions = [.showPhysicsShapes]
        
        //Base Bonfigurations
        sceneView.delegate = self
        sceneView.showsStatistics = false
     
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
        self.building.addFloor(floor: ColumnFloorNode(coordinates: [(0, 0), (0, 4), (4, 0), (4, 4)]))
        self.building.addFloor(floor: FloorNode(numberOfXBlocks: 5, numberOfZBlocks: 5))
        self.building.addFloor(floor: ColumnFloorNode(coordinates: [(0, 0), (0, 4), (4, 0), (4, 4)]))
        self.building.addFloor(floor: FloorNode(numberOfXBlocks: 5, numberOfZBlocks: 5))
        self.building.addFloor(floor: ColumnFloorNode(coordinates: [(0, 0), (0, 4), (4, 0), (4, 4)]))
        self.building.addFloor(floor: FloorNode(numberOfXBlocks: 5, numberOfZBlocks: 5))
        self.building.addFloor(floor: ColumnFloorNode(coordinates: [(0, 0), (0, 4), (4, 0), (4, 4)]))
        self.building.addFloor(floor: FloorNode(numberOfXBlocks: 5, numberOfZBlocks: 5))
        self.building.addFloor(floor: ColumnFloorNode(coordinates: [(0, 0), (0, 4), (4, 0), (4, 4)]))
        self.building.addFloor(floor: FloorNode(numberOfXBlocks: 5, numberOfZBlocks: 5))
        self.building.addFloor(floor: ColumnFloorNode(coordinates: [(0, 0), (0, 4), (4, 0), (4, 4)]))
        self.building.addFloor(floor: FloorNode(numberOfXBlocks: 5, numberOfZBlocks: 5))
        self.building.addFloor(floor: ColumnFloorNode(coordinates: [(0, 0), (0, 4), (4, 0), (4, 4)]))
        self.building.addFloor(floor: FloorNode(numberOfXBlocks: 5, numberOfZBlocks: 5))
        self.building.addFloor(floor: ColumnFloorNode(coordinates: [(0, 0), (0, 4), (4, 0), (4, 4)]))
        self.building.addFloor(floor: FloorNode(numberOfXBlocks: 5, numberOfZBlocks: 5))
        self.building.addFloor(floor: ColumnFloorNode(coordinates: [(0, 0), (0, 4), (4, 0), (4, 4)]))
        self.building.addFloor(floor: FloorNode(numberOfXBlocks: 5, numberOfZBlocks: 5))
        
        self.building.position = SCNVector3.init(x, y + 0.2 / 2, z)
        
        sceneView.scene.rootNode.addChildNode(building)
        self.didSetBuilding = true
    }
    
    func placeBomb(touch: UITouch) {
        
        let direction = self.getUserVector().0
        let position = self.getUserVector().1
        let x = direction.x + position.x
        let y = direction.y + position.y
        let z = direction.z + position.z
        
        let bomb = Bomb(radius: 0.1)
        bomb.position = SCNVector3.init(x, y, z)
        sceneView.scene.rootNode.addChildNode(bomb)
        self.bombs.append(bomb)
        
        print(bombs)

    }
    
    func explodeBombs() {
        for bomb in bombs {
            self.score += self.building.activate(bomb: bomb)
            bomb.explode(power: 10)
        }
        self.explosionButton.isEnabled = false
    }
    
    func getUserVector() -> (SCNVector3, SCNVector3) { // (direction, position)
        if let frame = self.sceneView.session.currentFrame {
            let mat = SCNMatrix4(frame.camera.transform) // 4x4 transform matrix describing camera in world space
            let dir = SCNVector3(-1 * mat.m31, -1 * mat.m32, -1 * mat.m33) // orientation of camera in world space
            let pos = SCNVector3(mat.m41, mat.m42, mat.m43) // location of camera in world space
            
            return (dir, pos)
        }
        return (SCNVector3(0, 0, -1), SCNVector3(0, 0, -0.2))
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    func shouldAutorotate() -> Bool {
        return false
    }
    
    func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return [UIInterfaceOrientationMask.portrait ]
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
            
            mainPlane.physicsBody = SCNPhysicsBody(type: .kinematic, shape: SCNPhysicsShape(geometry: plane, options: nil))
            
            self.didUpdatePlane = true
        }
    }
}

extension Stage: SCNPhysicsContactDelegate {
    func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
        if contact.nodeA == mainPlane {
            planeContact.append(contact.nodeB)
        }
        if contact.nodeB == mainPlane {
            planeContact.append(contact.nodeA)
        }
    }
    
    func physicsWorld(_ world: SCNPhysicsWorld, didEnd contact: SCNPhysicsContact) {
        if contact.nodeA == mainPlane {
            planeContact.removeLast()
        }
        if contact.nodeB == mainPlane {
            planeContact.removeLast()
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

