//
//  ChordGenerator.swift
//  Lazy Guitar
//
//  Created by Daniel Song on 10/15/16.
//  Copyright © 2016 Daniel Song. All rights reserved.
//

import Foundation

class GuitarChords {
    
    func generateChord(chord: String) -> OCChordView {
        
        var cv: OCChordView!
        
        cv = OCChordView(frame: CGRect(x: 0, y: 0, width: 147, height: 152))
        
            
        switch chord {
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
        case "D":
            cv.chordArray = [0, 0, 0, 2, 3, 2]
            cv.tuningArray = ["X", "X", "O", "", "", ""]
            cv.chordName = chord
        case "E":
            cv.chordArray = [0, 2, 2, 1, 0, 0]
            cv.chordName = chord
        case "F":
            cv.chordArray = [1, 3, 3, 2, 1, 1]
            cv.chordName = chord
        case "G":
            cv.chordArray = [3, 2, 0, 0, 0, 3]
            cv.chordName = chord
        case "A":
            cv.chordArray = [0, 0, 3, 3, 3, 0]
            cv.chordName = chord
        case "B":
            cv.chordArray = [2, 2, 4, 4, 4, 0]
            cv.chordName = chord
        default:
            print("couldn't find \(chord)")
        }
        return cv
    }
    
    
}
