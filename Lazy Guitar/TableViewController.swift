//
//  TableViewController.swift
//  Lazy Guitar
//
//  Created by Daniel Song on 10/21/16.
//  Copyright © 2016 Daniel Song. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {

    
    var noteArray = [[String : String]]()
    var selectedIndex = -1
    var noteTitles = NSMutableArray()
    
    var chordGenerator = GuitarChords()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getTableData()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noteTitles.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tableCell = tableView.dequeueReusableCell(withIdentifier: "TableCell")!
        //let note = noteTitles[(indexPath as NSIndexPath).row]
        
        tableCell.textLabel!.text = "test"
        return tableCell
    }
    
    @IBAction func addButtonPressed(_ sender: AnyObject) {
        self.selectedIndex = 0
        
        let alert = UIAlertController(title: "New Name",
                                      message: "Add a new name",
                                      preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save",
                                       style: .default,
                                       handler: { (action:UIAlertAction) -> Void in
                                        
                                        let textField = alert.textFields!.first
                                        self.saveTitle(textField!.text!)
                                        self.tableView.reloadData()
                                        self.performSegue(withIdentifier: "ShowEditorSegue", sender: nil)

        })
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default) { (action: UIAlertAction) -> Void in
        }
        
        
        alert.addTextField {
            (textField: UITextField) -> Void in
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert,
                animated: true,
                completion: nil)


    

    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.row
        performSegue(withIdentifier: "ShowEditorSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let chordsVC = segue.destination as! ChordsViewController
        chordsVC.noteIndexPath = selectedIndex

    }
    
    func saveTitle(_ name: String) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Title", in: context)

        let title = NSManagedObject(entity: entity!, insertInto: context)
        
        title.setValue(name, forKey: "titleName")
        
        do{
            try context.save()
        } catch let error as NSError{
            print("could not save \(error), \(error.userInfo)")
        }

        
    }
    
    
    func getTableData(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request: NSFetchRequest<Title> = Title.fetchRequest()
        noteTitles.removeAllObjects()
        
        do{
            let result = try context.fetch(request)
            if result.count > 0 {
                for item in result {
                    let chordTitleFetched = item.titleName
                    
                    let newDict:NSArray = [chordTitleFetched]
                    
                    noteTitles.add(newDict)
                }
            }
            
        } catch let error as NSError {
            print("could not get data \(error), \(error.userInfo)")
        }
    }
    
    
    



    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    

 

}
