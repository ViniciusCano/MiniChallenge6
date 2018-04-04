//
//  MenuViewController.swift
//  MiniChallenge06
//
//  Created by Vinícius Cano Santos on 03/04/2018.
//  Copyright © 2018 Vinícius Cano Santos. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //Set background image
        let background = UIImageView(frame: self.view.frame)
        background.image = UIImage(named: "Levels_Background")
        self.view.insertSubview(background, at: 0)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
