import Foundation

struct Chord {
    var chordName: String
    var chordArray: [Int]
    var tuningArray: [String]
    var fingerArray: [Int]
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
        chordArray = plist["chordArray"] as! [Int]
        tuningArray = plist["tuningArray"] as! [String]
        fingerArray = plist["fingerArray"] as! [Int]
    }
}
