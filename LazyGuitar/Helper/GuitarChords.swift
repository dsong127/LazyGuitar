/********
 *
 *  This class helps with generating chord views using OCChordView
 *
 *************/

import Foundation

class GuitarChord {
    
    func generateChordView(frame: CGRect, chord: String) -> OCChordView {

        let cv = OCChordView(frame: frame)
                
        switch chord {
        // C Chords
        case "C":
            cv.chordArray = [0, 1, 0, 2, 3, 0]
            cv.tuningArray = [ "O", "", "O", "", "", "X"]
            cv.chordName = chord
        case "Cm":
            cv.chordArray = [3, 3, 5, 5, 4, 3]
            cv.chordName = chord
        case "C7":
            cv.chordArray = [0, 3, 2, 3, 1, 0]
            cv.tuningArray = ["X", "", "", "", "", "O"]
            cv.chordName = chord
        case "CM7":
            cv.chordArray = [0, 3, 2, 0, 0, 0]
            cv.tuningArray = ["X", "", "", "O", "O", "O"]
            cv.chordName = chord
        case "Cm7":
            cv.chordArray = [3, 3, 5, 3, 4, 3]
            cv.chordName = chord
        // D Chords
        case "D":
            cv.chordArray = [0, 0, 0, 2, 3, 2]
            cv.tuningArray = ["X", "X", "O", "", "", ""]
            cv.chordName = chord
        case "Dm":
            cv.chordArray = [1, 3, 2, 0, 0, 0]
            cv.tuningArray = ["", "", "", "O", "O", "X"]
            cv.chordName = chord
        case "D7":
            cv.chordArray = [3, 1, 3, 0, 0, 0]
            cv.tuningArray = ["", "", "", "O", "O", "X"]
            cv.chordName = chord
        case "DM7":
            cv.chordArray = [1, 1, 1, 0, 0, 0]
            cv.tuningArray = ["", "", "", "O", "O", "X"]
            cv.chordName = chord
        case "Dm7":
            cv.chordArray = [1, 1, 2, 0, 0, 0]
            cv.tuningArray = ["", "", "", "O", "O", "X"]
            cv.chordName = chord
        // E Chords
        case "E":
            cv.chordArray = [0, 2, 2, 1, 0, 0]
            cv.tuningArray = ["O", "", "", "", "O", "O"]
            cv.chordName = chord
        case "Em":
            cv.chordArray = [0, 2, 2, 0, 0, 0]
            cv.tuningArray = ["O", "", "", "O", "O", "O"]
            cv.chordName = chord
        case "E7":
            cv.chordArray = [0, 2, 0, 1, 0, 0]
            cv.tuningArray = ["O", "", "O", "", "O", "O"]
            cv.chordName = chord
        case "EM7":
            cv.chordArray = [0, 2, 1, 1, 0, 0]
            cv.tuningArray = ["O", "", "", "", "O", "O"]
            cv.chordName = chord
        case "Em7":
            cv.chordArray = [0, 2, 0, 0, 0, 0]
            cv.tuningArray = ["O", "", "O", "O", "O", "O"]
            cv.chordName = chord
        // F Chords
        case "F":
            cv.chordArray = [1, 3, 3, 2, 1, 1]
            cv.chordName = chord
        case "Fm":
            cv.chordArray = [1, 2, 2, 1, 1, 1]
            cv.chordName = chord
        case "F7":
            cv.chordArray = [1, 3, 1, 2, 1, 1]
            cv.chordName = chord
        case "FM7":
            cv.chordArray = [0, 0, 3, 2, 1, 0]
            cv.tuningArray = ["O", "X", "", "", "", "O"]
            cv.chordName = chord
        case "Fm7":
            cv.chordArray = [1, 3, 1, 1, 1, 1]
            cv.chordName = chord
        // G Chords
        case "G":
            cv.chordArray = [3, 2, 0, 0, 0, 3]
            cv.chordName = chord
        case "Gm":
            cv.chordArray = [3, 5, 5, 3, 3, 3]
            cv.chordName = chord
        case "G7":
            cv.chordArray = [3, 2, 0, 0, 0, 1]
            cv.tuningArray = ["", "", "O", "O", "O", ""]
            cv.chordName = chord
        case "GM7":
            cv.chordArray = [3, 2, 0, 0, 0, 1]
            cv.tuningArray = ["", "", "O", "O", "O", ""]
            cv.chordName = chord
        case "Gm7":
            cv.chordArray = [3, 5, 3, 3, 3, 3]
            cv.chordName = chord
        // A Chords
        case "A":
            cv.chordArray = [0, 0, 3, 3, 3, 0]
            cv.tuningArray = ["O", "O", "", "", "", "O"]
            cv.chordName = chord
        case "Am":
            cv.chordArray = [0, 0, 2, 2, 1, 0]
            cv.tuningArray = ["O", "O", "", "", "", "O"]
            cv.chordName = chord
        case "A7":
            cv.chordArray = [0, 0, 2, 0, 2, 0]
            cv.tuningArray = ["O", "O", "", "O", "", "O"]
            cv.chordName = chord
        case "AM7":
            cv.chordArray = [0, 0, 2, 1, 2, 0]
            cv.tuningArray = ["O", "O", "", "", "", "O"]
            cv.chordName = chord
        case "Am7":
            cv.chordArray = [0, 0, 2, 0, 1, 0]
            cv.tuningArray = ["O", "O", "", "O", "", "O"]
            cv.chordName = chord
        // B Chords
        case "B":
            cv.chordArray = [2, 2, 4, 4, 4, 2]
            cv.chordName = chord
        case "Bm":
            cv.chordArray = [2, 2, 4, 4, 3, 2]
            cv.chordName = chord
        case "B7":
            cv.chordArray = [0, 2, 1, 2, 0, 2]
            cv.tuningArray = ["X", "", "", "", "O", ""]
            cv.chordName = chord
        case "BM7":
            cv.chordArray = [2, 2, 4, 3, 4, 2]
            cv.chordName = chord
        case "Bm7":
            cv.chordArray = [2, 2, 4, 2, 3, 2]
            cv.chordName = chord
        default:
            print("couldn't find \(chord)")
        }
        return cv
    }
    

}
 
