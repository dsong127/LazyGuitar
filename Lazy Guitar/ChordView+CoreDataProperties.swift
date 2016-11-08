//
//  ChordView+CoreDataProperties.swift
//  Lazy Guitar
//
//  Created by Daniel Song on 11/7/16.
//  Copyright © 2016 Daniel Song. All rights reserved.
//

import Foundation
import CoreData


extension ChordView {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ChordView> {
        return NSFetchRequest<ChordView>(entityName: "ChordView");
    }

    @NSManaged public var chordName: [String]?

}
