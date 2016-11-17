import UIKit
import CoreData

final class ChordsViewController: UICollectionViewController {
    
    @IBOutlet weak var chordSelectButton: UIBarButtonItem!
    @IBOutlet weak var variationSelectButton: UIBarButtonItem!
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    @IBOutlet weak var selectButton: UIBarButtonItem!
    
    let chordDropDown = DropDown()
    let variationDropDown = DropDown()
    let guitarChords = GuitarChords()
    
    var headerTitle = String()
    
    var selectedChords = [ChordViewCell]()
    let editTextLabel = UILabel()
    
    var changeMade: Bool = false
  
    var chordViewData = [OCChordView](){
        didSet {
            changeMade = true
        }
    }
    var chordNameData = [String]()

    var moc:NSManagedObjectContext!
    
    var noteIndexPath = -1
    
    
    var selecting: Bool = false {
        didSet {
            collectionView?.allowsMultipleSelection = selecting
            collectionView?.selectItem(at: nil, animated: true, scrollPosition: UICollectionViewScrollPosition())
            selectedChords.removeAll(keepingCapacity: false)
            
            guard let selectButton = self.navigationItem.rightBarButtonItems?.first else {
                return
            }
            
            guard selecting else {
                navigationItem.setRightBarButtonItems([selectButton], animated: true)
                return
            }
            
            updateEditingChordCount()
            let editingDetailItem = UIBarButtonItem(customView: editTextLabel)
            navigationItem.setRightBarButtonItems([selectButton,editingDetailItem], animated: true)
            
            self.navigationController?.hidesBarsOnTap = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        loadChords()
        self.navigationController?.hidesBarsOnTap = true
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.hidesBarsOnTap = false
        super.viewWillDisappear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupChordSelectButton()
        setupVariationSelectButton()
        changeMade = false
    }
    
    //MARK: - Setup
    
    func setupChordSelectButton(){
        chordDropDown.anchorView = chordSelectButton
        chordDropDown.dataSource = ["C", "D", "E", "F", "G", "A", "B"]
        chordDropDown.topOffset = CGPoint(x: 0, y: -(chordDropDown.anchorView?.plainView.bounds.height)!)

        chordDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.chordSelectButton.title = item
            self.variationDropDown.dataSource = ["\(item)", "\(item)m", "\(item)7", "\(item)M7", "\(item)m7"]
            self.variationSelectButton.isEnabled = true
            self.variationDropDown.show()
        }
    }
    
    func setupVariationSelectButton(){
        
        variationDropDown.anchorView = variationSelectButton
        variationDropDown.topOffset = CGPoint(x: 0, y: -(variationDropDown.anchorView?.plainView.bounds.height)!)
        
        variationDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.variationSelectButton.title = item
            self.chordViewData.append(self.guitarChords.generateChord(chord: item))
            self.collectionView!.insertItems(at: [IndexPath(row: self.chordViewData.count - 1, section: 0)])
            self.resetSelectButtons()
        }
    }
    
    //MARK: - UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return chordViewData.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChordCell", for: indexPath) as! ChordViewCell
        
        cell.chordView.addSubview(chordViewData[indexPath.row])
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "HeaderView", for: indexPath) as! TitleCollectionHeaderView
        
        header.headerLabel.text = headerTitle
        header.headerLabel.clipsToBounds = true
        header.headerLabel.sizeToFit()
        
        return header        
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 shouldSelectItemAt indexPath: IndexPath) -> Bool {
        guard !selecting else {
            return true
        }
        return false
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard selecting else {
            return
        }
    
        let selectedChord = collectionView.cellForItem(at: indexPath)!
        selectedChords.append(selectedChord as! ChordViewCell)
        updateEditingChordCount()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard selecting else{
            return
        }
        
        let selectedChord = collectionView.cellForItem(at: indexPath)
        if let index = selectedChords.index(of: selectedChord as! ChordViewCell){
            selectedChords.remove(at: index)
    
            updateEditingChordCount()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let temp = chordViewData[sourceIndexPath.row]
        chordViewData[sourceIndexPath.row] = chordViewData[destinationIndexPath.row]
        chordViewData[destinationIndexPath.row] = temp
    }
    
    //MARK: - Button Actions
    
    @IBAction func chordSelectButtonPressed(_ sender: AnyObject) {
        chordDropDown.show()
    }
    @IBAction func variationButtonPressed(_ sender: AnyObject) {
        variationDropDown.show()
    }
    
    @IBAction func selectButtonPressed(_ sender: UIBarButtonItem) {
        guard chordViewData.count > 0 else {
            return
        }
        
        selecting = !selecting
        selectButtonName(selecting)
        
        deleteButton.isEnabled = selecting ? true : false
        self.navigationController?.hidesBarsOnTap = selecting ? false : true

        guard selecting else  {
            return
        }
        return
    }
    @IBAction func deleteButtonPressed(_ sender: AnyObject) {
        
        guard !selectedChords.isEmpty else{
            return
        }
        
        let selectedIndexPaths: [IndexPath] = self.collectionView!.indexPathsForSelectedItems!
        
        //Find all the selected chords that are to be deleted
        var newChordViewData = [OCChordView]()
        for i in 0..<self.chordViewData.count{
            var found: Bool = false
            for indexPath in selectedIndexPaths{
                if indexPath.row == i {
                    found = true
                    break
                }
            }
            if found == false{
                newChordViewData.append(self.chordViewData[i])
            }
        }
        
        self.chordViewData = newChordViewData
        self.collectionView!.deleteItems(at: selectedIndexPaths)

        selectButton.title = "Select"
        deleteButton.isEnabled = false
        
        selecting = false
        self.navigationController?.hidesBarsOnTap = true

    }
   
    @IBAction func backButtonPressed(_ sender: AnyObject) {
        selecting = false
        saveChords()
        dismissVC()
    }
}

extension ChordsViewController {
    
    func updateEditingChordCount(){
        editTextLabel.textColor = UIColor.white
        editTextLabel.text = "\(selectedChords.count) selected"
        editTextLabel.sizeToFit()
    }
    
    func resetSelectButtons() {
        chordSelectButton.title = "Key"
        variationSelectButton.title = "select"
        variationSelectButton.isEnabled = false
    }
    
    func selectButtonName(_: Bool) {
        if selecting {
            selectButton.title = "Cancel"
        }
        else {
            selectButton.title = "Select"
        }
    }
    
    func dismissVC() {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func saveChords() {
        
        //Check if there has been any changes made
        guard changeMade else {
            return
        }
        
        chordNameData = []
        
        //get names of all the chords into chordNameData
        for item in 0..<chordViewData.count {
            chordNameData.append(chordViewData[item].chordName)
        }
        
        let fetchedData = CoreDataHelper.fetchEntities(entity: "ChordView", managedObjectContext: self.moc, predicate: nil) as! [ChordView]
        //replace chordNameData with new one
        fetchedData[noteIndexPath].chordName! = chordNameData
        
        do {
            try self.moc.save()
        } catch let error as NSError {
            print ("couldn't save \(error), \(error.userInfo)")
        }
    }
    
    func loadChords() {
        chordNameData = []
        chordViewData = []
        
        let fetchedData = CoreDataHelper.fetchEntities(entity: "ChordView", managedObjectContext: self.moc, predicate: nil) as! [ChordView]
        
        guard !fetchedData.isEmpty else {
            print("nothing to load")
            return
        }
        
        chordNameData = fetchedData[noteIndexPath].chordName!
        
        for name in chordNameData {
            chordViewData.append(guitarChords.generateChord(chord: name))
        }
    }
    
  }
