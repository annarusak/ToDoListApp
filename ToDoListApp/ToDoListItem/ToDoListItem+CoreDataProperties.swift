import Foundation
import CoreData


extension ToDoListItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoListItem> {
        return NSFetchRequest<ToDoListItem>(entityName: "ToDoListItem")
    }

    @NSManaged public var taskName: String?
    @NSManaged public var createdAt: Date?

}

extension ToDoListItem : Identifiable {

}