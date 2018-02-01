import UIKit
import Foundation

class ChordChartView: UIView {

    var chordArray: [String]?
    var tuningArray: [String]?
    var fingerArray: [String]?
    var chordName = ""
    var fillColor: UIColor?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        
        
        self.chordArray = nil
        self.tuningArray = nil
        self.fingerArray = nil
        self.chordName = "hi"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        if let chordArray = self.chordArray {
            var maxFret = 0
            var minFret = 15
            
            for fretNumber in chordArray {
                let fret: Int = Int(fretNumber)!
                
                if fret > 0 {
                    if fret > maxFret {
                        maxFret = fret
                    }
                    if fret < minFret {
                        minFret = fret
                    }
                }
            }
            
            let labelFont = UIFont(name: "HelveticaNeue-Bold", size: self.frame.size.height*0.08)
            
            var minDisplayFret = minFret
            var maxDisplayFret = maxFret + 1
            
            if minFret > 1 {
                minDisplayFret -= minDisplayFret
            }
            
            let fretDisplayDifference = maxDisplayFret - minDisplayFret
            
            
            var fretLineHeight: CGFloat = 1.0
            
            //Chord Name
    
            var namePositionYOrigin = self.frame.origin.y
            var nameHeight = self.frame.size.height*0.15
            
            //Nut
            var nutPositionYorigin: CGFloat = nameHeight*2
            var nutSize = (minDisplayFret == 1) ? self.frame.size.height*0.05 : fretLineHeight
            
            //Frets
            var fretBoardYOrigin = nutPositionYorigin + nutSize
            var stringHeight = self.bounds.size.height - fretBoardYOrigin*1.3
            var fretScreenYSpacing = stringHeight/CGFloat(fretDisplayDifference)
            var fretBoardXOrigin = self.bounds.size.height*0.2
            var varLabelXOrigin = 5.0
            var fretXWidth = self.bounds.width - fretBoardXOrigin*1.5
            
            //Strings
            var stringSpacing = fretXWidth/5.0
            var stringLabelYOrigin = nameHeight + 5.0
            var stringWidth = 1.0
            var circleRadius = min(stringSpacing, fretScreenYSpacing)*0.4
            
            //Draw Chord Name
            let nameRect = CGRect(x: 0, y: 0, width: self.frame.size.width, height: nameHeight)
            self.fillColor = UIColor.black
            UIRectFill(nameRect)
            let name:NSString

            // FONT ALGINIGNGING??
            
            
            
            
        }
    }

}
