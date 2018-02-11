import Foundation

struct Chord {
    var chordName: String
    var chordArray: [String]
    var tuningArray: [String]
    var fingerArray: [String]
}

extension Chord {
    var plistRepresentation: [String : AnyObject] {
        return [
            "chordName" : chordName as AnyObject,
            "chordArray" : chordArray as AnyObject,
            "tuningArray" : tuningArray as AnyObject,
            "fingerArray" : fingerArray as AnyObject
        ]
    }
        
    init(plist: [String : AnyObject]) {
        chordName = plist["chordName"] as! String
        chordArray = plist["chordArray"] as! [String]
        tuningArray = plist["tuningArray"] as! [String]
        fingerArray = plist["fingerArray"] as! [String]
    }
}
