import Foundation
import CoreData


extension ChordView {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ChordView> {
        return NSFetchRequest<ChordView>(entityName: "ChordView");
    }

    @NSManaged public var chordName: [String]?

}
