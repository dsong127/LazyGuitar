import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var mainTableView: UITableView!
    
    fileprivate var dataSource: NotesDataSource!
    var stateController: StateController!
  
    override func viewDidLoad() {
        super.viewDidLoad()
            
        // Setup TableView
        mainTableView.delegate = self
        mainTableView.estimatedRowHeight = UITableViewAutomaticDimension
        mainTableView.rowHeight = UITableViewAutomaticDimension
        
        // Remove line at the bottom of navigation bar
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        dataSource = NotesDataSource(notes: stateController.notes)
        mainTableView.dataSource = dataSource
        mainTableView.reloadData()
    }
    
    @IBAction func createNewNote(_ sender: Any) {
        let alert = UIAlertController(title: "New Note", message: "Add a new name", preferredStyle: .alert)
       
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: {(action:UIAlertAction) -> Void in
            let textField = alert.textFields!.first
            guard !(textField?.text == "") else { return }
            self.performSegue(withIdentifier: "CreateNoteSegue", sender: nil)
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (action: UIAlertAction) -> Void in }
        
        alert.addTextField(configurationHandler: {(textField: UITextField) in
            textField.addTarget(self, action: #selector(self.textFieldDidChange), for: .editingChanged)
        })
        alert.view.tintColor = UIColor.black
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        (alert.actions[0] as UIAlertAction).isEnabled = false
        
        present(alert, animated: true, completion: nil)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case "CreateNoteSegue":
            if let chordsVC = segue.destination as? ChordsViewController {
                chordsVC.stateController = stateController
                chordsVC.chordsData = []
            }
        case "ViewNoteSegue":
            if let chordsVC = segue.destination as? ChordsViewController,
                let selectedIndex = mainTableView.indexPathForSelectedRow {
                let note = dataSource.notes[selectedIndex.row]
                chordsVC.chordsData = note.chords
                chordsVC.stateController = stateController
            }
        default:
            print("No matching segue")
            break
        }
    }
}

//MARK: - TableView Delegate and DataSource

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        mainTableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "ViewNoteSegue", sender: nil)
    }
}
