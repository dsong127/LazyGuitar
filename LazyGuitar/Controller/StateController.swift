import Foundation

class StateController {
    fileprivate let storageController: StorageController
    fileprivate(set) var notes: [Note]
    
    init(storageController: StorageController) {
        self.storageController = storageController
        self.notes = storageController.fetchNotes()
    }
    
    func add(_ note: Note) {
        notes.insert(note, at: 0)
        storageController.save(notes)
    }
    
    func deleteNote(at index: Int) {
        notes.remove(at: index)
        storageController.save(notes)
    }
    
    //Update already existing note
    func update(_ note: Note) {
        for (index, storedNote) in notes.enumerated() {
            guard storedNote.dateCreated == note.dateCreated else {
                continue
            }
            notes[index] = note
            storageController.save(notes)
            break
        }
    }
}
