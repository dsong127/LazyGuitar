//
//  ViewController.swift
//  Lazy Guitar
//
//  Created by Daniel Song on 10/5/16.
//  Copyright © 2016 Daniel Song. All rights reserved.
//

import UIKit


class ChordsViewController: UICollectionViewController {

    @IBOutlet weak var chordSelectButton: UIBarButtonItem!
    @IBOutlet weak var editButton: UIBarButtonItem!
    
    let dropDown1 = DropDown()
    
    var selectedChords = [UICollectionViewCell]()
    let editTextLabel = UILabel()
    var chordViewData = [OCChordView]()
    
    
  /*
    var selecting: Bool = false {
        didSet {
            collectionView?.allowsMultipleSelection = selecting
            collectionView?.selectItem(at: nil, animated: true, scrollPosition: UICollectionViewScrollPosition())
            selectedChords.removeAll(keepingCapacity: false)
            
            guard let editButton = self.navigationItem.rightBarButtonItems?.first else {
                return
            }
            
            guard selecting else {
                navigationItem.setRightBarButtonItems([editButton], animated: true)
                return
            }
            
            updateEditingChordCount()
            
            let editingDetailItem = UIBarButtonItem(customView: editTextLabel)
            navigationItem.setRightBarButtonItems([editButton,editingDetailItem], animated: true)
        }
    }
*/
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setupChordSelectButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - Setup
    
    func setupChordSelectButton(){
        
        dropDown1.anchorView = chordSelectButton
        dropDown1.dataSource = ["C", "D", "E"]
        dropDown1.bottomOffset = CGPoint(x: 0, y:(dropDown1.anchorView?.plainView.bounds.height)!)
   /*
        guard !selecting else{
            chordSelectButton.isEnabled = false
            return
        }
     */
       
        dropDown1.selectionAction = { [unowned self] (index: Int, item: String) in
            self.chordSelectButton.title = item
            
            self.chordViewData.append(self.generateChord(chord: item, frame: cellFrame))
            self.collectionView!.insertItems(at: [IndexPath(row: self.chordViewData.count - 1, section: 0)])
            print(self.chordViewData.count)
        }
    }
    
    //MARK: - UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return chordViewData.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChordCell", for: indexPath) as! ChordViewCell
        cell.chordView.addSubview(self.chordViewData[indexPath.row])
        return cell
    }
   /*
    override func collectionView(_ collectionView: UICollectionView,
                                 shouldSelectItemAt indexPath: IndexPath) -> Bool {
        guard !selecting else {
            return true
        }
        
        return false
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard selecting else {
            return
        }
        print("did select item")
        
        let selectedCell = [collectionView.cellForItem(at: indexPath)]
  
        //selectedChords.append(selectedCell)
        
        updateEditingChordCount()

    }
    
    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard selecting else{
            return
        }
    }
    
    func updateEditingChordCount(){
        editTextLabel.textColor = themeColor
        editTextLabel.text = "\(selectedChords.count) selected"
        editTextLabel.sizeToFit()
    }
  */
    func generateChord(chord: String, frame: CGRect) -> OCChordView {
        
        var cv: OCChordView!
        cv = OCChordView(frame: frame)
        
        switch chord {
        case "c", "C":
            cv.chordArray = [0, 1, 0, 2, 3, 0]
            cv.tuningArray = [ "", "", "", "", "", "X"]
        case "d", "D":
            cv.chordArray = [0, 0, 0, 2, 3, 2]
            cv.tuningArray = ["X", "X", "", "", "", ""]
        case "e", "E":
            cv.chordArray = [0, 2, 2, 1, 0, 0]
        default:
            print("meh")
        }
        return cv
    }

    //MARK: - Button Actions

    
    @IBAction func chordSelectButtonPressed(_ sender: AnyObject) {
        dropDown1.show()
    }
    
    @IBAction func editButtonPressed(_ sender: UIBarButtonItem) {
    /*
        guard cellCounter > 1 else {
            print("cell counter guard")
            return
        }
        
        guard !selectedChords.isEmpty else {
            selecting = !selecting
            return
        }
        
        guard selecting else  {
            return
        }
 */
        return
 }
 
 
}



