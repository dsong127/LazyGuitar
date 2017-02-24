import UIKit


class ChordViewCell: UICollectionViewCell{
    @IBOutlet weak var chordView: OCChordView!

    
    // Creates border when a chord is selected
    override var isSelected: Bool{
        didSet{
            chordView.layer.borderWidth = isSelected ? 3 : 0
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        chordView.layer.borderColor = UIColor(red: 0.22, green: 0.22, blue: 0.46, alpha: 1.0).cgColor
        isSelected = false
    }
}
