//
//  ChordViewCell.swift
//  Lazy Guitar
//
//  Created by Daniel Song on 10/9/16.
//  Copyright © 2016 Daniel Song. All rights reserved.
//

import UIKit


class ChordViewCell: UICollectionViewCell{
    @IBOutlet weak var chordView: OCChordView!

/*
    override var isSelected: Bool{
        didSet{
            chordView.layer.borderWidth = isSelected ? 10 : 0
        }
    }
  */
    /*
    override func awakeFromNib() {
        super.awakeFromNib()
        
        chordView.layer.borderColor = themeColor.cgColor
        isSelected = false
    }
    */
}
