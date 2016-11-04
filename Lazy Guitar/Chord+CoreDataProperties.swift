//
//  Chord+CoreDataProperties.swift
//  Lazy Guitar
//
//  Created by Daniel Song on 11/3/16.
//  Copyright © 2016 Daniel Song. All rights reserved.
//

import Foundation
import CoreData


extension Chord {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Chord> {
        return NSFetchRequest<Chord>(entityName: "Chord");
    }

    @NSManaged public var chordName: NSObject?
    @NSManaged public var noteTitle: String?
    @NSManaged public var title: Title?

}
