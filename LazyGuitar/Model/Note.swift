import Foundation

struct Note {
    var noteName: String
    var chords: [Chord]
    var dateCreated: Date
}

extension Note {
    var plistRepresentation: [String : AnyObject] {
        return [
            "noteName" : noteName as AnyObject,
            "chords" : chords.map { $0.plistRepresentation } as AnyObject,
            "dateCreated" : dateCreated as AnyObject,
        ]
    }
    
    init(plist: [String : AnyObject]) {
        noteName = plist["noteName"] as! String
        chords = (plist["chords"] as! [[String : AnyObject]]).map(Chord.init(plist:))
        dateCreated = plist["dateCreated"] as! Date
    }
}

