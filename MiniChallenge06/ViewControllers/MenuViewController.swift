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
    
    let transition = CATransition()
    
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
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
