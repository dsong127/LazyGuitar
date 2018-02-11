import UIKit

class ChordCell: UICollectionViewCell {
    
    @IBOutlet weak var chordView: OCChordView!
    let guitarChords = GuitarChord()
    
    var model: Model? {
        didSet {
            guard let model = model else { return }

            let cellFrame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
            let chordImage = model.chordImage(frame: cellFrame, chordName: model.chordName)
            
            chordImage.chordArray = model.chordArray
            chordImage.fingerArray = model.fingerArray
            chordImage.tuningArray = model.tuningArray
            
            chordView.addSubview(chordImage)
        }
    }

    /*
    override var isSelected: Bool{
        didSet{
            chordView.layer.borderWidth = isSelected ? 3 : 0
        }
    }
*/
    override func awakeFromNib() {
        super.awakeFromNib()
    
        //chordView.layer.borderColor = UIColor(red: 0.22, green: 0.22, blue: 0.46, alpha: 1.0).cgColor
        //isSelected = false
    }
}

extension ChordCell {
    struct Model {
        var chordName: String
        var chordArray: [String]
        var tuningArray: [String]
        var fingerArray: [String]
        
        func chordImage(frame: CGRect, chordName: String) -> OCChordView {
            let guitar = GuitarChord()
            return guitar.generateChordView(frame: frame, chord: chordName)
        }
        
        init(chord: Chord, index: Int){
            chordName = chord.chordName
            chordArray = chord.chordArray
            tuningArray = chord.tuningArray
            fingerArray = chord.fingerArray
        }
    }
}

extension ChordCell: ReusableView { }


