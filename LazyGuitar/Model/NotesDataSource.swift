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
            tableView.displayEmptyTableViewMessage(message: "There are no notes to show 😩\n Use the button at the top to create one!")
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
}

