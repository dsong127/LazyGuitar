/********
 *
 *  This class helps with generating chord information using OCChordView
 *
 *************/

import Foundation

class ChordInfo {

    var chordArray: [Int]
    var tuningArray: [String]
    var chordName: String
    
    init(chord: String) {
        switch chord {
        // C Chords
        case "C":
            self.chordArray = [0, 1, 0, 2, 3, 0]
            self.tuningArray = [ "O", "", "O", "", "", "X"]
            self.chordName = chord
        case "Cm":
            self.chordArray = [3, 3, 5, 5, 4, 3]
            self.tuningArray = ["", "", "", "", "", ""]

            self.chordName = chord
        case "C7":
            self.chordArray = [0, 3, 2, 3, 1, 0]
            self.tuningArray = ["X", "", "", "", "", "O"]
            self.chordName = chord
        case "CM7":
            self.chordArray = [0, 3, 2, 0, 0, 0]
            self.tuningArray = ["X", "", "", "O", "O", "O"]
            self.chordName = chord
        case "Cm7":
            self.chordArray = [3, 3, 5, 3, 4, 3]
            self.tuningArray = ["", "", "", "", "", ""]
            self.chordName = chord
        // D Chords
        case "D":
            self.chordArray = [0, 0, 0, 2, 3, 2]
            self.tuningArray = ["X", "X", "O", "", "", ""]
            self.chordName = chord
        case "Dm":
            self.chordArray = [1, 3, 2, 0, 0, 0]
            self.tuningArray = ["", "", "", "O", "O", "X"]
            self.chordName = chord
        case "D7":
            self.chordArray = [3, 1, 3, 0, 0, 0]
            self.tuningArray = ["", "", "", "O", "O", "X"]
            self.chordName = chord
        case "DM7":
            self.chordArray = [1, 1, 1, 0, 0, 0]
            self.tuningArray = ["", "", "", "O", "O", "X"]
            self.chordName = chord
        case "Dm7":
            self.chordArray = [1, 1, 2, 0, 0, 0]
            self.tuningArray = ["", "", "", "O", "O", "X"]
            self.chordName = chord
        // E Chords
        case "E":
            self.chordArray = [0, 2, 2, 1, 0, 0]
            self.tuningArray = ["O", "", "", "", "O", "O"]
            self.chordName = chord
        case "Em":
            self.chordArray = [0, 2, 2, 0, 0, 0]
            self.tuningArray = ["O", "", "", "O", "O", "O"]
            self.chordName = chord
        case "E7":
            self.chordArray = [0, 2, 0, 1, 0, 0]
            self.tuningArray = ["O", "", "O", "", "O", "O"]
            self.chordName = chord
        case "EM7":
            self.chordArray = [0, 2, 1, 1, 0, 0]
            self.tuningArray = ["O", "", "", "", "O", "O"]
            self.chordName = chord
        case "Em7":
            self.chordArray = [0, 2, 0, 0, 0, 0]
            self.tuningArray = ["O", "", "O", "O", "O", "O"]
            self.chordName = chord
        // F Chords
        case "F":
            self.chordArray = [1, 3, 3, 2, 1, 1]
            self.tuningArray = ["", "", "", "", "", ""]
            self.chordName = chord
        case "Fm":
            self.chordArray = [1, 2, 2, 1, 1, 1]
            self.tuningArray = ["", "", "", "", "", ""]
            self.chordName = chord
        case "F7":
            self.chordArray = [1, 3, 1, 2, 1, 1]
            self.tuningArray = ["", "", "", "", "", ""]
            self.chordName = chord
        case "FM7":
            self.chordArray = [0, 0, 3, 2, 1, 0]
            self.tuningArray = ["O", "X", "", "", "", "O"]
            self.chordName = chord
        case "Fm7":
            self.chordArray = [1, 3, 1, 1, 1, 1]
            self.tuningArray = ["", "", "", "", "", ""]

            self.chordName = chord
        // G Chords
        case "G":
            self.chordArray = [3, 2, 0, 0, 0, 3]
            self.tuningArray = ["", "", "", "", "", ""]

            self.chordName = chord
        case "Gm":
            self.chordArray = [3, 5, 5, 3, 3, 3]
            self.tuningArray = ["", "", "", "", "", ""]

            self.chordName = chord
        case "G7":
            self.chordArray = [3, 2, 0, 0, 0, 1]
            self.tuningArray = ["", "", "O", "O", "O", ""]
            self.chordName = chord
        case "GM7":
            self.chordArray = [3, 2, 0, 0, 0, 1]
            self.tuningArray = ["", "", "O", "O", "O", ""]
            self.chordName = chord
        case "Gm7":
            self.chordArray = [3, 5, 3, 3, 3, 3]
            self.tuningArray = ["", "", "", "", "", ""]

            self.chordName = chord
        // A Chords
        case "A":
            self.chordArray = [0, 0, 3, 3, 3, 0]
            self.tuningArray = ["O", "O", "", "", "", "O"]
            self.chordName = chord
        case "Am":
            self.chordArray = [0, 0, 2, 2, 1, 0]
            self.tuningArray = ["O", "O", "", "", "", "O"]
            self.chordName = chord
        case "A7":
            self.chordArray = [0, 0, 2, 0, 2, 0]
            self.tuningArray = ["O", "O", "", "O", "", "O"]
            self.chordName = chord
        case "AM7":
            self.chordArray = [0, 0, 2, 1, 2, 0]
            self.tuningArray = ["O", "O", "", "", "", "O"]
            self.chordName = chord
        case "Am7":
            self.chordArray = [0, 0, 2, 0, 1, 0]
            self.tuningArray = ["O", "O", "", "O", "", "O"]
            self.chordName = chord
        // B Chords
        case "B":
            self.chordArray = [2, 2, 4, 4, 4, 2]
            self.tuningArray = ["", "", "", "", "", ""]
            self.chordName = chord
        case "Bm":
            self.chordArray = [2, 2, 4, 4, 3, 2]
            self.tuningArray = ["", "", "", "", "", ""]
            self.chordName = chord
        case "B7":
            self.chordArray = [0, 2, 1, 2, 0, 2]
            self.tuningArray = ["X", "", "", "", "O", ""]
            self.chordName = chord
        case "BM7":
            self.chordArray = [2, 2, 4, 3, 4, 2]
            self.tuningArray = ["", "", "", "", "", ""]
            self.chordName = chord
            
        case "Bm7":
            self.chordArray = [2, 2, 4, 2, 3, 2]
            self.tuningArray = ["", "", "", "", "", ""]
            self.chordName = chord
        default:
            self.chordArray = [0, 0, 0, 0, 0, 0]
            self.chordName = "Error: Invalid chord"
            self.tuningArray = ["", "", "", "", "", ""]
        }
    }
}
