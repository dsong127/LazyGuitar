import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var mainTableView: UITableView!
    
    var noteData: [String] = ["test1", "test2", "test3"]
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainTableView.backgroundColor = .white
        
        // Setup TableView
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.estimatedRowHeight = UITableViewAutomaticDimension
        mainTableView.rowHeight = UITableViewAutomaticDimension
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
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
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        mainTableView.deselectRow(at: indexPath, animated: true)
    }
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
        let cell: MainCell = mainTableView.dequeReusableCell(forIndexPath: indexPath)
        return cell
    }
}
