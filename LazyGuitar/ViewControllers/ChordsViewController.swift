import UIKit
import DropDown

class ChordsViewController: UIViewController {

    @IBOutlet weak var chordCollectionView: UICollectionView!
    @IBOutlet weak var keyButton: UIBarButtonItem!
    @IBOutlet weak var variationButton: UIBarButtonItem!
    
    var stateController: StateController!
    fileprivate var chordsDataSource: ChordsDataSource!
    var chord: Chord!
    
    let keyDropDown = DropDown()
    let variationDropDown = DropDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: nil)
        
        chordCollectionView.delegate = self
        chordCollectionView.dataSource = chordsDataSource
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
  
    }
    
}

extension ChordsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("did select")
    }
}


