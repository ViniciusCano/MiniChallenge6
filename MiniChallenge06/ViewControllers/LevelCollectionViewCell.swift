import Foundation
import UIKit

protocol PassSelectedLevelDelegate {
    func configureLevel(number:Int)
}

class LevelCollectionViewCell: UICollectionViewCell {
    //MARK: - Outlets
    @IBOutlet weak var levelButton: UIButton!
    
    //MARK: - Atributes
    var number:Int = 0
    var delegate:PassSelectedLevelDelegate?
    
    func config(number: Int) {
        self.number = number
        self.levelButton.setTitle("", for: .normal)
        
        
        self.levelButton.setImage(UIImage(named: "Fase\(self.number)_Button"), for: .normal)
        
        
    }
    
    
    //MARK: - Actions
    @IBAction func levelButtonAction(_ sender: UIButton) {
        self.delegate?.configureLevel(number: self.number)
        CurrentLevel.currentPlayingLevel = self.number
    }

}
