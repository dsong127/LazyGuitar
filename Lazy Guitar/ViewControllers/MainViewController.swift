import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var mainTableView: UITableView!
    
    //var noteData: [String] = ["test1", "test2", "test3"]
    var noteData = [String]()
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup TableView
        mainTableView.delegate = self
        mainTableView.dataSource = self
        
    }
    
    @IBAction func createNewNote(_ sender: Any) {
        performSegue(withIdentifier: "ViewNoteSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("seguegin")
    }
    
}

//MARK: - TableView Delegate and DataSource

extension MainViewController: UITableViewDelegate {
    
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard !noteData.isEmpty else {
            mainTableView.displayEmptyTableViewMessage(message: "There are no notes to show 😩\n Press the + button to create some!", onVC: self)
            return 0
        }
        
        return noteData.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
        cell.textLabel!.text = noteData[indexPath.row]
        
        return cell
    }
}
