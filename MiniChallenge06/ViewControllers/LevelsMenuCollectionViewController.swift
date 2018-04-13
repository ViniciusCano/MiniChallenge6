//
//  LevelsMenuCollectionViewController.swift
//  MiniChallenge06
//
//  Created by Ricardo Sousa on 06/04/2018.
//  Copyright © 2018 Vinícius Cano Santos. All rights reserved.
//

import Foundation
import UIKit

private let reuseIdentifier = "LevelCell"

class LevelsMenuCollectionViewController: UICollectionViewController, PassSelectedLevelDelegate {
    
    override func viewDidLoad() {
        self.collectionView?.backgroundView = imageView
    }
    
    
    let imageView : UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named:"Levels_Background")
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! LevelCollectionViewCell
        
        // Configure the cell
        cell.delegate = self
        cell.config(number: indexPath.row + 1)
        
        return cell
    }
    
    func configureLevel(number: Int) {
        //TODO: Dismiss LevelsMenuCollectionViewController
        guard let gameVC = storyboard?.instantiateViewController(withIdentifier: "Stage") as? Stage else { return }
        
        switch number {
        case 1:
            gameVC.currentScene = Level1()
        default:
            return
        }
        
        self.show(gameVC, sender: self)
        
    }
    
    
}
