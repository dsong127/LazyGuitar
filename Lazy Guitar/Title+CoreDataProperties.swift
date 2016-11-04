//
//  Title+CoreDataProperties.swift
//  Lazy Guitar
//
//  Created by Daniel Song on 11/3/16.
//  Copyright © 2016 Daniel Song. All rights reserved.
//

import Foundation
import CoreData


extension Title {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Title> {
        return NSFetchRequest<Title>(entityName: "Title");
    }

    @NSManaged public var titleName: String?
    @NSManaged public var chord: Chord?

}
