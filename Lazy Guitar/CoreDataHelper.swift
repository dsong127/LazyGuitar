/*******************
 *
 *  CoreData helper functions for fetching/saving/deleting data
 *
 ******************/

import UIKit
import CoreData

class CoreDataHelper: NSObject {

    class func insertManagedObject(entity: String, managedObjectContext: NSManagedObjectContext) -> AnyObject {
        let managedObject = NSEntityDescription.insertNewObject(forEntityName: entity, into: managedObjectContext) as NSManagedObject
        
        return managedObject
    }
    
    class func fetchEntities(entity: String, managedObjectContext: NSManagedObjectContext, predicate: NSPredicate?) -> [Any]  {
        
        var fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        var result = [Any]()
        
        if entity == "Title" {
            
            fetchRequest = Title.fetchRequest()
        }
        else{
            fetchRequest = ChordView.fetchRequest()
        }
        
        if predicate != nil {
            fetchRequest.predicate = predicate!
        }
        
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            try result = managedObjectContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("could not fetch \(error), \(error.userInfo)")
        }
        
        return result
    }

    class func deleteObject(managedObjectContext: NSManagedObjectContext) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ChordView")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try managedObjectContext.execute(deleteRequest)
        } catch let error as NSError {
            print(error)
        }
    }
    
    // Need to call this if you're deleting a row from the TableView
    
    class func deleteTableView(managedObjectContext: NSManagedObjectContext) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Title")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try managedObjectContext.execute(deleteRequest)
        } catch let error as NSError {
            print(error)
        }
        
        
    }

    
}
