import UIKit
import DropDown

class ChordsViewController: UIViewController {

    @IBOutlet weak var chordCollectionView: UICollectionView!
    @IBOutlet weak var keyButton: UIBarButtonItem!
    @IBOutlet weak var variationButton: UIBarButtonItem!
    
    var stateController: StateController!
    fileprivate var chordsDataSource: ChordsDataSource!
    var note: Note!
    
    let keyDropDown = DropDown()
    let variationDropDown = DropDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: nil)
        
        navigationItem.title = note.noteName
        
        chordCollectionView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    
        chordsDataSource = ChordsDataSource(chords: note.chords)
        chordCollectionView.dataSource = chordsDataSource
        chordCollectionView.reloadData()
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


