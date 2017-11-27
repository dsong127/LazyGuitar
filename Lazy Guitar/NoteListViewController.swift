import UIKit
import CoreData

class NoteListViewController: UITableViewController {
    
    var moc:NSManagedObjectContext!
    var noteTitles = [Title]()
    var chordArray = [ChordView]()
    var selectedIndex = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        loadData()
        self.tableView.reloadData()
        super.viewWillAppear(animated)
        
        guard !noteTitles.isEmpty else {
            displayEmptyData(message: "There are no item to show!", on: self)
            return
        }
        self.tableView.backgroundView = nil
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        setEditing(false, animated: false)
        super.viewWillAppear(animated)
    }
 
    override func viewDidLayoutSubviews() {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        super.viewDidLayoutSubviews()
    }
    
    
    override func setEditing(_ editing: Bool, animated: Bool) {
            super.setEditing(editing, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noteTitles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         let tableCell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath) as! NoteTableViewCell

        tableCell.titleLabel!.text = noteTitles[indexPath.row].titleName
        tableCell.dayLabel.text = noteTitles[indexPath.row].titleDate?.dayOfTheWeek()
        tableCell.dateLabel.text = noteTitles[indexPath.row].titleDate?.mediumStyleDate()
        
        tableCell.dateContainer.layer.borderWidth = 3
        tableCell.dateContainer.layer.borderColor = UIColor.themeColor.cgColor
        
        
        tableCell.dateLabel.sizeToFit()


        return tableCell
    }

    
    @IBAction func addButtonPressed(_ sender: AnyObject) {
        selectedIndex = noteTitles.count
        let alert = UIAlertController(title: "New Note",
                                      message: "Add a new name",
                                      preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save",
                                       style: .default,
                                       handler: { (action:UIAlertAction) -> Void in
                                        
                                        
                                        let textField = alert.textFields!.first
                                        
                                        guard !(textField?.text == "") else {
                                            
                                            return
                                        }
                                        
                                        let noteDate = NSDate()
                                        
                                        
                                        let title = CoreDataHelper.insertManagedObject(entity: "Title", managedObjectContext: self.moc) as! Title
                                        
                                        let chord = CoreDataHelper.insertManagedObject(entity: "ChordView", managedObjectContext: self.moc) as! ChordView
                                        
                                        chord.chordName = [String]()
                                        
                                        title.titleName = textField?.text
                                        title.titleDate = noteDate
                                        
                                        do{
                                            try self.moc.save()
                                        } catch let error as NSError {
                                            print("could not save \(error), \(error.userInfo)")
                                            
                                        }
                                        self.loadData()
                                        self.tableView.reloadData()
                                        
                                        self.performSegue(withIdentifier: "ShowEditorSegue", sender: nil)
                                        
        })
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default) { (action: UIAlertAction) -> Void in
        }
        
        alert.addTextField(configurationHandler: {(textField: UITextField) in
            textField.addTarget(self, action: #selector(self.textFieldDidChange),
                                for: .editingChanged)
            
        })
        
        alert.view.tintColor = UIColor(red: 230/255.0, green: 52/255.0, blue: 33/255.0, alpha: 0.7)
        alert.addAction(cancelAction)
        alert.addAction(saveAction)
        
        (alert.actions[1] as UIAlertAction).isEnabled = false
        
        present(alert,
                animated: true,
                completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.row
        performSegue(withIdentifier: "ShowEditorSegue", sender: nil)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let managedObject = noteTitles[indexPath.row]
        
        if editingStyle == .delete {
            self.moc.delete(managedObject)
            deleteNoteContents(atIndex: indexPath.row)
            loadData()
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            tableView.reloadData()
            
            if self.tableView.numberOfRows(inSection: 0) == 0 {
                self.setEditing(false, animated: true)
            }
            
            guard !noteTitles.isEmpty else {
                displayEmptyData(message: "There are no item to show!", on: self)
                return
            }
            self.tableView.backgroundView = nil
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        
        let itemToMove = noteTitles[fromIndexPath.row]
        noteTitles.remove(at: fromIndexPath.row)
        noteTitles.insert(itemToMove, at: fromIndexPath.row)
        do {
            try self.moc.save()
        } catch let error as NSError {
            print("could not save \(error), \(error.userInfo)")
        }
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowEditorSegue" {
            let chordsVC = segue.destination as! ChordsViewController
            chordsVC.noteIndexPath = selectedIndex
            chordsVC.headerTitle = noteTitles[selectedIndex].titleName!
        }
    }
    
    func initUI() {
        isEditing = false
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        editButtonItem.tintColor = UIColor.white
        self.navigationController?.toolbar.clipsToBounds = true
        tableView.backgroundColor = UIColor(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1.0)
    }
    
    func loadData() {
        noteTitles = []
        noteTitles = CoreDataHelper.fetchEntities(entity: "Title", managedObjectContext: self.moc, predicate: nil) as! [Title]
        
        //keep track of the chords to check if there are any existing chords for the deleted note
        chordArray = []
        chordArray = CoreDataHelper.fetchEntities(entity: "ChordView", managedObjectContext: self.moc, predicate: nil) as! [ChordView]
    }
    
    
    func deleteNoteContents(atIndex: Int) {
        //check if there are chord data to delete
        guard !chordArray.isEmpty else {
            return
        }
        
        let managedObjectChord:NSManagedObject = chordArray[atIndex]
        
        self.moc.delete(managedObjectChord)
    }
    
    @objc func textFieldDidChange(sender: AnyObject) {
        let tf = sender as! UITextField
        var resp: UIResponder = tf
        while !(resp is UIAlertController) {
            resp = resp.next!
        }
        let alert = resp as! UIAlertController
        (alert.actions[1] as UIAlertAction).isEnabled = (tf.text != "")
    }
}
