import UIKit
import DropDown

class ChordsViewController: UIViewController {

    @IBOutlet weak var chordCollectionView: UICollectionView!
    @IBOutlet weak var keyButton: UIBarButtonItem!
    @IBOutlet weak var variationButton: UIBarButtonItem!
    
    var stateController: StateController!
    
    var chordsData = [String]() {
        didSet {
            print(chordsData)
            
            //chordCollectionView.reloadData()
        }
    }
    
    fileprivate let keyDropDown = DropDown()
    fileprivate let variationDropDown = DropDown()
    
    fileprivate let guitar = GuitarChord()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: nil)
        
        chordCollectionView.delegate = self
        chordCollectionView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
  
    }
    

    
  }

extension ChordsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("is anything fucking working")
    }
}

extension ChordsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return chordsData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ChordCell = chordCollectionView.dequeReusableCell(forIndexPath: indexPath)
        
        let frame = CGRect(x: 0, y: 0, width: cell.frame.size.width, height: cell.frame.size.height)
        let chord: OCChordView = guitar.generateChordView(frame: frame, chord: chordsData[indexPath.row])
        cell.chordView.addSubview(chord)
        
        return cell
    }
}

