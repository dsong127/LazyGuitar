import UIKit

class ChordsDataSource: NSObject {
    var chords: [Chord]
    
    init(chords: [Chord]) {
        self.chords = chords
    }
}

extension ChordsDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return chords.count
    }
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ChordCell = collectionView.dequeReusableCell(forIndexPath: indexPath)
        let chord = chords[indexPath.row]
        cell.model = ChordCell.Model(chord: chord, index: indexPath.row)
        
        return cell
    }
}
