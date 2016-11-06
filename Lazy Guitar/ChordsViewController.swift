//
//  ViewController.swift
//  Lazy Guitar
//
//  Created by Daniel Song on 10/5/16.
//  Copyright © 2016 Daniel Song. All rights reserved.
//

import UIKit
import CoreData

class ChordsViewController: UICollectionViewController {
    
    @IBOutlet weak var chordSelectButton: UIBarButtonItem!
    @IBOutlet weak var variationSelectButton: UIBarButtonItem!
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    @IBOutlet weak var selectButton: UIBarButtonItem!
    
    let chordDropDown = DropDown()
    let variationDropDown = DropDown()
    let guitarChords = GuitarChords()
    
    var headerTitle = String()
    
    var selectedChords = [ChordViewCell]()
    let editTextLabel = UILabel()
    var chordViewData = [OCChordView]()
    var chordNameData = [String]()
    
    var noteIndexPath = -1
    
    
    var selecting: Bool = false {
        didSet {
            collectionView?.allowsMultipleSelection = selecting
            collectionView?.selectItem(at: nil, animated: true, scrollPosition: UICollectionViewScrollPosition())
            selectedChords.removeAll(keepingCapacity: false)
            
            guard let selectButton = self.navigationItem.rightBarButtonItems?.first else {
                return
            }
            
            guard selecting else {
                navigationItem.setRightBarButtonItems([selectButton], animated: true)
                return
            }
            
            updateEditingChordCount()
            let editingDetailItem = UIBarButtonItem(customView: editTextLabel)
            navigationItem.setRightBarButtonItems([selectButton,editingDetailItem], animated: true)
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.hidesBarsOnSwipe = true
        self.collectionView?.backgroundView = UIImageView(image: #imageLiteral(resourceName: "background"))
    }
    
    override func viewWillAppear(_ animated: Bool) {

        //getData()
        collectionView?.reloadData()
   
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupChordSelectButton()
        setupVariationSelectButton()
      
    }
    

    //MARK: - Setup
    
    func setupChordSelectButton(){
        chordDropDown.anchorView = chordSelectButton
        chordDropDown.dataSource = ["C", "D", "E", "F", "G", "A", "B"]
        chordDropDown.topOffset = CGPoint(x: 0, y: -(chordDropDown.anchorView?.plainView.bounds.height)!)

        chordDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.chordSelectButton.title = item
            self.variationDropDown.dataSource = ["\(item)", "\(item)m", "\(item)7", "\(item)M7", "\(item)m7"]
            self.variationSelectButton.isEnabled = true
            self.variationDropDown.show()
        }
    }
    
    func setupVariationSelectButton(){
        
        variationDropDown.anchorView = variationSelectButton
        variationDropDown.bottomOffset = CGPoint(x: 0, y: (variationDropDown.anchorView?.plainView.bounds.height)!)
        
        variationDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.variationSelectButton.title = item
            self.chordViewData.append(self.guitarChords.generateChord(chord: item))
            self.collectionView!.insertItems(at: [IndexPath(row: self.chordViewData.count - 1, section: 0)])
            self.resetSelectButtons()
        }
    }
    
    //MARK: - UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return chordViewData.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChordCell", for: indexPath) as! ChordViewCell
        
        let bannerView = setupChordBannerView(bannerWidth: cell.bounds.width, chord: variationSelectButton.title!)
        cell.chordView.addSubview(bannerView)
        cell.chordView.insertSubview(self.chordViewData[indexPath.row], belowSubview: bannerView)
 
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "HeaderView", for: indexPath) as! TitleCollectionHeaderView
        
        header.headerLabel.text = headerTitle
        header.headerLabel.textColor = UIColor.white
        
        header.backgroundColor = themeColor
        header.headerLabel.sizeToFit()
        
        return header        
    }
    
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
    
        let selectedChord = collectionView.cellForItem(at: indexPath)!
        selectedChords.append(selectedChord as! ChordViewCell)
        updateEditingChordCount()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard selecting else{
            return
        }
        
        let selectedChord = collectionView.cellForItem(at: indexPath)
        if let index = selectedChords.index(of: selectedChord as! ChordViewCell){
            selectedChords.remove(at: index)
    
            updateEditingChordCount()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let temp = chordViewData[sourceIndexPath.row]
        chordViewData[sourceIndexPath.row] = chordViewData[destinationIndexPath.row]
        chordViewData[destinationIndexPath.row] = temp
    }
    
    //MARK: - Button Actions
    
    @IBAction func chordSelectButtonPressed(_ sender: AnyObject) {
        chordDropDown.show()
    }
    @IBAction func variationButtonPressed(_ sender: AnyObject) {
        variationDropDown.show()
    }
    
    @IBAction func selectButtonPressed(_ sender: UIBarButtonItem) {
        guard chordViewData.count > 0 else {
            return
        }
        
        selecting = !selecting
        selectButtonName(selecting)
        
        deleteButton.isEnabled = selecting ? true : false
        
        guard selecting else  {
            return
        }
        return
    }
    @IBAction func deleteButtonPressed(_ sender: AnyObject) {
        
        guard !selectedChords.isEmpty else{
            return
        }
        
        let selectedIndexPaths: [IndexPath] = self.collectionView!.indexPathsForSelectedItems!
        
        var newChordViewData = [OCChordView]()
        for i in 0..<self.chordViewData.count{
            var found: Bool = false
            for indexPath in selectedIndexPaths{
                if indexPath.row == i {
                    found = true
                    break
                }
            }
            if found == false{
                newChordViewData.append(self.chordViewData[i])
            }
        }
        
        self.chordViewData = newChordViewData
        self.collectionView!.deleteItems(at: selectedIndexPaths)
        
        selectButton.title = "Select"
        deleteButton.isEnabled = false
        selecting = !selecting
        
    }
   
    
    @IBAction func backButtonPressed(_ sender: AnyObject) {
        //deleteData()
        //saveChords()
        _ = navigationController?.popViewController(animated: true)
    }
    
}

extension ChordsViewController {
    
    func updateEditingChordCount(){
        editTextLabel.textColor = themeColor
        editTextLabel.text = "\(selectedChords.count) selected"
        editTextLabel.sizeToFit()
    }
    
    func resetSelectButtons() {
        chordSelectButton.title = "Key"
        variationSelectButton.title = "select"
        variationSelectButton.isEnabled = false
    }
    
    func selectButtonName(_: Bool) {
        if selecting {
            selectButton.title = "Cancel"
        }
        else {
            selectButton.title = "Select"
        }
    }
    
    func dismissVC() {
        _ = self.navigationController?.popViewController(animated: true)
    }
/*
    func saveChords() {
      /*
        guard !chordViewData.isEmpty else {
            print("chordViewData is empty!")
            return
        }
        */
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Chord", in: context)

        
        let newChords = NSManagedObject(entity: entity!, insertInto: context)
        
        
        chordNameData = []
        for item in 0..<chordViewData.count {
            chordNameData.append(chordViewData[item].chordName)
        }
        
        
        newChords.setValue(chordNameData, forKey: "chordName")
        newChords.setValue(headerTitle, forKey: "noteTitle")
        
        do {
            try context.save()
            
        
            
        } catch let error as NSError {
            print("could not save \(error), \(error.userInfo)")
        }
    }


    
    func getData() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request: NSFetchRequest<Chord> = Chord.fetchRequest()

        
        chordNameData = []
        
        do {
            let result = try context.fetch(request)
            
            for item in result {
                
                chordViewData = []
                chordNameData = item.value(forKey: "chordName") as! [String]
                print("saved title: \(item.value(forKey: "noteTitle"))")
            }
            print("chordNameData retrieved: \(chordNameData.count)")
            
        } catch let error as NSError {
            print("could not get data \(error), \(error.userInfo)")
        }
        
        for name in chordNameData {
            chordViewData.append(self.guitarChords.generateChord(chord: name))
        }
    }

    
    
    func deleteData() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request: NSFetchRequest<Chord> = Chord.fetchRequest()

        do {
            let result = try context.fetch(request)
            print("number of elements in result after fetch: \(result.count)")
            for item in result {
                context.delete(item)
            }

        } catch let error as NSError {
            print("could not delete data \(error), \(error.userInfo)")
        }
    }
    */

    func setupChordBannerView(bannerWidth: CGFloat, chord: String) -> UIView{
        let banner = UIView()
        
        banner.frame = CGRect(x: 0, y: 0, width: bannerWidth, height: 20)
        banner.backgroundColor = themeColor
        
        let bannerLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 30, height: 15))
        bannerLabel.textColor = UIColor.white
        bannerLabel.text = "\(chord)"
   
        bannerLabel.sizeToFit()
        bannerLabel.center = banner.center
        banner.addSubview(bannerLabel)
        
        return banner
    }
}
