import UIKit

class NotesDataSource: NSObject {
    
    var notes: [Note]
    
    init(notes: [Note]) {
        self.notes = notes
    }
}

extension NotesDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard !notes.isEmpty else {
            tableView.displayEmptyTableViewMessage()
            return 0
        }
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MainCell = tableView.dequeReusableCell(forIndexPath: indexPath)
        let note = notes[indexPath.row]
        cell.model = MainCell.Model(note: note, index: indexPath.row)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            tableView.beginUpdates()
            notes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
            
            stateController.update(notes[indexPath.row])
            
            if notes.isEmpty {
                tableView.displayEmptyTableViewMessage()
                
            }
            
        }
    }
}

