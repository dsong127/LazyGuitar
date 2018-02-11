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
            "chords" : noteName as AnyObject,
            "dateCreated" : dateCreated as AnyObject,
        ]
    }
    
    init(plist: [String : AnyObject]) {
        noteName = plist["noteName"] as! String
        chords = [(plist["chords"] as! Chord)]
        dateCreated = plist["dateCreated"] as! Date
    }
}

