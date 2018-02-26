import Foundation

class StorageController {
    fileprivate let documentsDirectoryURL = FileManager.default
        .urls(for: .documentDirectory, in: .userDomainMask)
        .first!
    
    fileprivate var notesFileURL: URL {
        print(documentsDirectoryURL)
        return documentsDirectoryURL
            .appendingPathComponent("Notes")
            .appendingPathExtension("plist")
    }
    
    func save(_ notes: [Note]) {
        let notesPlist = notes.map { $0.plistRepresentation } as NSArray
        notesPlist.write(to: notesFileURL, atomically: true)
    }
    /*
    func deleteNote(at indexPath: Int) {
        guard var notesPlists = NSArray(contentsOf: notesFileURL) as? [[String: AnyObject]] else {
            print("Error loading from plist")
            return
        }
        notesPlists.remove(at: indexPath)
    }
    */
    func fetchNotes() -> [Note] {
        guard let notesPlists = NSArray(contentsOf: notesFileURL) as? [[String: AnyObject]] else {
            return []
        }
        return notesPlists.map(Note.init(plist:))
    }
}
