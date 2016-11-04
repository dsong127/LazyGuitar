//
//  CoreDataHelper.swift
//  Lazy Guitar
//
//  Created by Daniel Song on 11/3/16.
//  Copyright © 2016 Daniel Song. All rights reserved.
//

import UIKit
import CoreData

class CoreDataHelper: NSObject {

    class func insertManagedObject(className: String, managedObjectContext: NSManagedObjectContext) -> AnyObject {
        let managedObject = NSEntityDescription.insertNewObject(forEntityName: className, into: managedObjectContext) as NSManagedObject
        
        return managedObject
    }
    
    class func fetchEntities(className: String, managedObjectContext: NSManagedObjectContext, predicate: NSPredicate?) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: className)
        let entityDescription = NSEntityDescription.entity(forEntityName: className, in: managedObjectContext)
        
        fetchRequest.entity = entityDescription
        
        if predicate != nil {
            fetchRequest.predicate = predicate!
        }
        
        fetchRequest.returnsObjectsAsFaults = false
        
   
    }
    
}
