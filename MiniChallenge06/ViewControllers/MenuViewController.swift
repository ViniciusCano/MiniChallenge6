//
//  MenuViewController.swift
//  MiniChallenge06
//
//  Created by Vinícius Cano Santos on 03/04/2018.
//  Copyright © 2018 Vinícius Cano Santos. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    //Declare constraints
    @IBOutlet weak var playButtonTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var playButtonLeadingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var logoImageTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var logoImageLeadingConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Set background image
        let background = UIImageView(frame: self.view.frame)
        background.image = UIImage(named: "Levels_Background")
        self.view.insertSubview(background, at: 0)
        
        //Constraints
        playButtonTopConstraint.constant = view.frame.size.height * 0.776
        playButtonLeadingConstraint.constant = view.frame.size.width * 0.165
        
        logoImageTopConstraint.constant = view.frame.size.height * 0.191
        logoImageLeadingConstraint.constant = view.frame.size.width * 0.078
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
