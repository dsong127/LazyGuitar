import Foundation

class StorageController {
    fileprivate let documentsDirectoryURL = FileManager.default
        .urls(for: .documentDirectory, in: .userDomainMask)
        .first!
    
    fileprivate var notesFileURL: URL {
        return documentsDirectoryURL
            .appendingPathComponent("Notes")
            .appendingPathExtension("plist")
    }
    
    func save(_ notes: [Note]) {
        let notesPlist = notes.map { $0.plistRepresentation } as NSArray
        notesPlist.write(to: notesFileURL, atomically: true)
    }
    
    func fetchNotes() -> [Note] {
        guard let notesPlists = NSArray(contentsOf: notesFileURL) as? [[String: AnyObject]] else {
            return []
        }
        return notesPlists.map(Note.init(plist:))
    }
}
