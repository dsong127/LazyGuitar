import UIKit
import Fretboard

class ChordCell: UICollectionViewCell {
    
    @IBOutlet weak var chordView: FretboardView!
    
    override var isSelected: Bool{
        didSet{
            chordView.layer.borderWidth = isSelected ? 3 : 0
            return
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        chordView.layer.borderColor = UIColor(red: 0.22, green: 0.22, blue: 0.46, alpha: 1.0).cgColor
        isSelected = false
    }
}

extension ChordCell: ReusableView { }

extension ChordCell: NibLoadableView{ }
