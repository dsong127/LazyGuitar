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
        cv = OCChordView()
        
        switch chord {
        case "C":
            cv.chordArray = [0, 1, 0, 2, 3, 0]
            cv.tuningArray = [ "O", "", "O", "", "", "X"]
        case "Cm":
            cv.chordArray = [3, 3, 5, 5, 4, 3]
        case "C7":
            cv.chordArray = [0, 3, 2, 3, 1, 0]
            cv.tuningArray = ["X", "", "", "", "", "O"]
        case "CM7":
            cv.chordArray = [0, 3, 2, 0, 0, 0]
            cv.tuningArray = ["X", "", "", "O", "O", "O"]
        case "Cm7":
            cv.chordArray = [3, 3, 5, 3, 4, 3]
        case "D":
            cv.chordArray = [0, 0, 0, 2, 3, 2]
            cv.tuningArray = ["X", "X", "O", "", "", ""]
        case "E":
            cv.chordArray = [0, 2, 2, 1, 0, 0]
        case "F":
            cv.chordArray = [1, 3, 3, 2, 1, 1]
        case "G":
            cv.chordArray = [3, 2, 0, 0, 0, 3]
        case "A":
            cv.chordArray = [0, 0, 3, 3, 3, 0]
        case "B":
            cv.chordArray = [2, 2, 4, 4, 4, 0]
        default:
            print("couldn't find \(chord)")
        }
        return cv
    }

    
    
}
