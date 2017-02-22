import Foundation
import CoreData


extension Title {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Title> {
        return NSFetchRequest<Title>(entityName: "Title");
    }

    @NSManaged public var titleName: String?
    @NSManaged public var titleDate: NSDate?

}
