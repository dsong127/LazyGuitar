import UIKit

class ChordsViewController: UIViewController {

    @IBOutlet weak var chordCollectionView: UICollectionView!
    var chordsData = ["String"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

extension ChordsViewController: UICollectionViewDelegateFlowLayout {
    
}

extension ChordsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return chordsData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ChordCell = chordCollectionView.dequeReusableCell(forIndexPath: indexPath)
        
        return cell
    }
}

