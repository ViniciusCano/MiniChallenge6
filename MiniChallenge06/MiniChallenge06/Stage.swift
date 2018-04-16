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
    @IBOutlet weak var statusLabel: UILabel!
    
    //Constraints
    @IBOutlet weak var statusLabelTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var statusLabelLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var statusLabelTrailingConstraint: NSLayoutConstraint!
    
    //Game HUD
    @IBOutlet weak var bombLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var explosionButton: UIButton!
    @IBOutlet weak var pauseView: UIView!
    
    //END Game
    @IBOutlet weak var endView: UIView!
    @IBOutlet weak var endScoreLabel: UILabel!
    
    let levelsViewController = LevelsViewController()
    
    @IBAction func explosionButtonClicked(_ sender: Any) {
        if !isPaused {
            self.explodeBombs()
            
            self.endGame()
        }
    }
    
    @IBAction func pauseButtonClicked(_ sender: Any) {
        self.pauseView.popIn(fromScale: 1, damping: 1, velocity: 1, duration: 0.8, delay: 0, options: UIViewAnimationOptions(), completion: nil)
        self.isPaused = true
    }
    
    @IBAction func playButtonClicked(_ sender: Any) {
        self.pauseView.popOut(toScale: 0, pulseScale: 1, duration: 0.8, delay: 0, completion: nil)
        self.isPaused = false
    }
    
    @IBAction func menuButtonClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func restartClicked(_ sender: Any) {
        self.pauseView.popOut(toScale: 0, pulseScale: 1, duration: 0.8, delay: 0, completion: nil)
        
        self.maxBombs = 3
        for bomb in bombs {
            bomb.removeFromParentNode()
        }
        bombs.removeAll()
        
        self.score = 0
        
        self.building.removeFromParentNode()
        self.building = Building()
        guard let t = addBuildingTouch else { return }
        self.addBuilding(touch: t)
        
    }
    
    //MARK:- Variables
    var mainPlane = SCNNode()
    var building = Building()
    var addBuildingTouch: UITouch?
    var currentScene: GameScene?
    
    var planeContact: [SCNNode] = []
    
    var maxBombs = 3
    var bombs: [SCNNode] = [] {
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
            if score == 0 {
                self.scoreLabel.text = "0"
            } else {
                self.scoreLabel.text = String(score / bombs.count)
            }
        }
    }
    
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
        
        building = (currentScene?.building)!
        
        statusLabelTopConstraint.constant = view.frame.size.height * 0.2
        statusLabelLeadingConstraint.constant = view.frame.size.width * 0.05
        statusLabelTrailingConstraint.constant = view.frame.size.width * 0.05
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
                self.statusLabel.text = ""
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
        
        self.pauseView.popOut(toScale: 0, pulseScale: 0, duration: 0, delay: 0, completion: nil)
        self.pauseView.layer.cornerRadius = 10
        
        self.endView.popOut(toScale: 0, pulseScale: 0, duration: 0, delay: 0, completion: nil)
        self.endView.layer.cornerRadius = 10
        
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
        //Save touch for restart pourpose
        self.addBuildingTouch = touch
        
        //Add Building
        let tapLocation = touch.location(in: sceneView)
        let hitTestResults = sceneView.hitTest(tapLocation, types: .existingPlaneUsingExtent)
        
        guard let hitTestResult = hitTestResults.first else { return }
        let translation = hitTestResult.worldTransform.translation
        
        let x = translation.x
        let y = translation.y
        let z = translation.z
        
        
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
        
        let bombScene = SCNScene(named: "Bomb.scn", inDirectory: "art.scnassets", options: nil)
        let bomb = bombScene?.rootNode.childNode(withName: "Bomb", recursively: true)
        bomb?.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "Albedo.png")
        bomb?.geometry?.materials[1].diffuse.contents = UIImage(named: "Albedo.png")
        
        
        bomb?.position = SCNVector3.init(x, y, z)
        sceneView.scene.rootNode.addChildNode(bomb!)
        self.bombs.append(bomb!)
        
        print(bombs)
        
    }
    
    func explodeBombs() {
        for bomb in bombs {
            self.building.activate(bomb: bomb)
            
            let gravity = SCNPhysicsField.radialGravity()
            gravity.strength = -20
            gravity.falloffExponent = 0.5
            
            bomb.physicsField = gravity
            bomb.runAction(SCNAction.sequence([SCNAction.wait(duration: 2),SCNAction.run({ (node) in
                node.removeFromParentNode()
            })]))
            self.score += self.building.activate(bomb: bomb)
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
    
    func endGame() {
        self.building.runAction(SCNAction.sequence([
            SCNAction.wait(duration: 2),
            SCNAction.run({ (node) in
                DispatchQueue.main.async {
                    self.endScoreLabel.text = String(self.score)
                    self.endView.popIn(fromScale: 1, damping: 1, velocity: 1, duration: 0.8, delay: 0, options: UIViewAnimationOptions(), completion: nil)
                }
            })
            ]))
        
        if CurrentLevel.number == currentScene?.level {
            CurrentLevel.set(number: (currentScene?.level)! + 1)
        }
        
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
            
            DispatchQueue.main.async {
                self.statusLabel.text = "Toque na tela para adicionar um prédio"
            }
            
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
    }//
}

//Float4x4 Extension
extension float4x4 {
    var translation: float3 {
        let translation = self.columns.3
        return float3(translation.x, translation.y, translation.z)
    }
}

