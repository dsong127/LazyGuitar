import UIKit

class ChordCell: UICollectionViewCell {
    
    @IBOutlet weak var cellView: UIView!
    
    var model: Model? {
        didSet {
            guard let model = model else { return }

            let cellFrame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
            let chordView = OCChordView(frame: cellFrame)
            
            chordView.chordName = model.chordName
            chordView.chordArray = model.chordArray
            chordView.fingerArray = model.fingerArray
            chordView.tuningArray = model.tuningArray
            
            cellView.addSubview(chordView)
        }
    }
 
    override var isSelected: Bool{
        didSet{
            cellView.layer.borderWidth = isSelected ? 3 : 0
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        cellView.layer.borderColor = UIColor.themeColor().cgColor
        isSelected = false
    }
}
extension ChordCell {
    struct Model {
        var chordName: String
        var chordArray: [Int]
        var tuningArray: [String]
        var fingerArray: [Int]
        
        init(chord: Chord, index: Int){
            chordName = chord.chordName
            chordArray = chord.chordArray
            tuningArray = chord.tuningArray
            fingerArray = chord.fingerArray
        }
    }
}
 
extension ChordCell: ReusableView { }
