import UIKit
import DropDown

class ChordsViewController: UIViewController {

    @IBOutlet weak var chordCollectionView: UICollectionView!
    @IBOutlet weak var keyButton: UIBarButtonItem!
    @IBOutlet weak var variationButton: UIBarButtonItem!
    @IBOutlet weak var selectButton: UIBarButtonItem!
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    
    //weak var delegate: ChordsViewControllerDelegate?
    
    var stateController: StateController!
    fileprivate var chordsDataSource: ChordsDataSource!
    var note: Note!
    
    //Initialize dropdown menus
    let keyDropDown = DropDown()
    let varDropDown = DropDown()
    
    var selectedChords = [ChordCell]()
    let editTextLabel = UILabel()

    var selecting: Bool = false {
        didSet {
            selectButtonName(selecting)
            chordCollectionView.allowsMultipleSelection = selecting
            chordCollectionView.selectItem(at: nil, animated: true, scrollPosition: UICollectionViewScrollPosition())
            selectedChords.removeAll(keepingCapacity: false)
            
            guard let selectButton = self.navigationItem.rightBarButtonItems?.first else { return }
            guard selecting else {
                navigationItem.setRightBarButtonItems([selectButton], animated: true)
                return
            }
            
            updateEditingChordCount()
            let editingDetailItem = UIBarButtonItem(customView: editTextLabel)
            navigationItem.setRightBarButtonItems([selectButton,editingDetailItem], animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.handleLongGesture(gesture:)))
        //self.chordCollectionView.addGestureRecognizer(longPressGesture)
        navigationItem.title = note.noteName
        chordCollectionView.delegate = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    
        //Load from stored data and load into collectionview data source
        chordsDataSource = ChordsDataSource(chords: note.chords)
        chordCollectionView.dataSource = chordsDataSource
        chordCollectionView.reloadData()
        
        setupKeyButton()
        setupVariationButton()
    }

    func setupKeyButton(){
        keyDropDown.anchorView = keyButton
        keyDropDown.dataSource = ["C", "D", "E", "F", "G", "A", "B"]
        keyDropDown.topOffset = CGPoint(x: 0, y: -(keyDropDown.anchorView?.plainView.bounds.height)!)
        keyDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.keyButton.title = item
            self.varDropDown.dataSource = ["\(item)", "\(item)m", "\(item)7", "\(item)M7", "\(item)m7"]
            self.keyButton.isEnabled = true
            self.varDropDown.show()
        }
    }
    
    func setupVariationButton(){
        varDropDown.anchorView = variationButton
        varDropDown.topOffset = CGPoint(x: 0, y: -(varDropDown.anchorView?.plainView.bounds.height)!)
        varDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.variationButton.title = item
            
            //Create new Chord
            let info = ChordInfo(chord: item)
            let newChord = Chord(chordName: info.chordName, chordArray: info.chordArray, tuningArray: info.tuningArray, fingerArray: [0,0,0,0,0,0,])
            
            //Add new Chord and update data
            self.note.chords.append(newChord)
            self.chordsDataSource.chords.append(newChord)
            self.stateController.update(self.note)
            self.chordCollectionView.dataSource = self.chordsDataSource
            
            //Insert new Chord in collection view
            let indexPath = IndexPath(item: self.chordsDataSource.chords.count-1, section: 0)
        
            self.chordCollectionView.insertItems(at: [indexPath])
            
            //Reset dropdown buttons
            self.resetSelectButtons()
        }
    }
    
    func resetSelectButtons() {
        keyButton.title = "Key"
        variationButton.title = "Var"
        variationButton.isEnabled = false
    }
    
    func updateEditingChordCount(){
        editTextLabel.textColor = UIColor.white
        editTextLabel.text = "\(selectedChords.count) selected"
        editTextLabel.sizeToFit()
    }
    
    func selectButtonName(_: Bool) {
        if selecting {
            selectButton.title = "Cancel"
        }
        else {
            selectButton.title = "Select"
        }
    }
 /*
    @objc func handleLongGesture(gesture: UILongPressGestureRecognizer) {
        switch(gesture.state) {
        case .began:
            guard let selectedIndexPath = self.chordCollectionView.indexPathForItem(at: gesture.location(in: self.chordCollectionView)) else { break }
            self.chordCollectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
        case .changed:
            self.chordCollectionView.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view!))
        case .ended:
            print("did end")
            self.chordCollectionView.endInteractiveMovement()
        default:
            self.chordCollectionView.cancelInteractiveMovement()
        }
    }
    */
    
    @IBAction func selectButtonPressed(_ sender: Any) {
        guard chordsDataSource.chords.count > 0 else { return }
        
        selecting = !selecting
        deleteButton.isEnabled = selecting ? true : false
        guard selecting else  { return }
        return
    }
    
    @IBAction func deleteButtonPressed(_ sender: Any) {
        guard !selectedChords.isEmpty else { return }
        
        let selectedIndexPaths: [IndexPath] = self.chordCollectionView.indexPathsForSelectedItems!
        
        //Find all the selected chords that are to be deleted
        var newChordsData = [Chord]()
        for i in 0..<self.chordsDataSource.chords.count{
            var found: Bool = false
            for indexPath in selectedIndexPaths{
                if indexPath.row == i {
                    found = true
                    break
                }
            }
            if found == false{
                newChordsData.append(self.chordsDataSource.chords[i])
            }
        }
        
        self.note.chords = newChordsData
        self.chordsDataSource.chords = newChordsData
        self.chordCollectionView.deleteItems(at: selectedIndexPaths)
        
        // Update StateController
        self.stateController.update(self.note)
        
        selecting = false
        selectButtonName(selecting)
        deleteButton.isEnabled = false
    }
    
    @IBAction func keyButtonPressed(_ sender: Any) {
        keyDropDown.show()
    }
    
    @IBAction func varButtonPressed(_ sender: Any) {
        varDropDown.show()
    }
}

extension ChordsViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView,
                        shouldSelectItemAt indexPath: IndexPath) -> Bool {
        guard !selecting else { return true }
        return false
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard selecting else { return }
        
        let selectedChord = collectionView.cellForItem(at: indexPath)!
        selectedChords.append(selectedChord as! ChordCell)
        updateEditingChordCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard selecting else { return }
        
        let selectedChord = collectionView.cellForItem(at: indexPath)
        if let index = selectedChords.index(of: selectedChord as! ChordCell){
            selectedChords.remove(at: index)
            updateEditingChordCount()
        }
    }
    /*
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let temp = chordsDataSource.chords[sourceIndexPath.row]
        chordsDataSource.chords[sourceIndexPath.row] = chordsDataSource.chords[destinationIndexPath.row]
        chordsDataSource.chords[destinationIndexPath.row] = temp
    }
 */
}
