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

    var moc:NSManagedObjectContext!
    var selectedIndex = -1
    var noteTitles = [Title]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext


        loadData()
        self.tableView.reloadData()

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
        
        tableCell.textLabel!.text = noteTitles[indexPath.row].titleName
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
                                        let title = CoreDataHelper.insertManagedObject(entity: "Title", managedObjectContext: self.moc) as! Title
                                    
                                        title.titleName = textField?.text
                                        
                                        do{
                                            try self.moc.save()
                                        } catch let error as NSError {
                                            print("could not save \(error), \(error.userInfo)")

                                        }
                                        self.loadData()
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
   
    
    func loadData() {
        noteTitles = []
        noteTitles = CoreDataHelper.fetchEntities(entity: "Title", managedObjectContext: self.moc, predicate: nil) as! [Title]
        
        
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let managedObject:NSManagedObject = noteTitles[indexPath.row]
        
        if editingStyle == .delete {
            // Delete the row from the data source
            self.moc.delete(managedObject)
            loadData()
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            self.tableView.reloadData()

        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

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
