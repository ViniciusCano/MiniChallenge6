//
//  LevelsViewController.swift
//  MiniChallenge06
//
//  Created by Vinícius Cano Santos on 03/04/2018.
//  Copyright © 2018 Vinícius Cano Santos. All rights reserved.
//

import UIKit

class LevelsViewController: UIViewController {
    
    //Declare constraints
    @IBOutlet weak var level1ButtonTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var level1ButtonLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var level1ButtonBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var level1ButtonTrailingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var level2ButtonTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var level2ButtonLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var level2ButtonBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var level2ButtonTrailingConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Set background image
        let background = UIImageView(frame: self.view.frame)
        background.image = UIImage(named: "Levels_Background")
        self.view.insertSubview(background, at: 0)
        
        //Constraints
        level1ButtonTopConstraint.constant = view.frame.size.height * 0.0929
        level1ButtonLeadingConstraint.constant = view.frame.size.width * 0.12
        level1ButtonBottomConstraint.constant = view.frame.size.height * 0.760
        level1ButtonTrailingConstraint.constant = view.frame.size.width * 0.624
        
        level2ButtonTopConstraint.constant = view.frame.size.height * 0.0929
        level2ButtonLeadingConstraint.constant = view.frame.size.width * 0.621
        level2ButtonBottomConstraint.constant = view.frame.size.height * 0.760
        level2ButtonTrailingConstraint.constant = view.frame.size.width * 0.122
        
        navigationController?.isNavigationBarHidden = false
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
