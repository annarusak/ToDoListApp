import UIKit

class ToDoListItemManager {
    
    static private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    static private var onListChangeDelegate: (() -> ())?
    
    static func addOnListChangeDelegate(delegate: @escaping () -> ()) {
        onListChangeDelegate = delegate
    }
    
    static func getAllItems() -> [ToDoListItem] {
        var tasks = [ToDoListItem]()
        do {
            tasks = try context.fetch(ToDoListItem.fetchRequest())
        } catch {
            print(error.localizedDescription)
        }
        return tasks
    }
    
    static func createItem(name: String, priority: String) {
        let newItem = ToDoListItem(context: context)
        newItem.taskName = name
        newItem.createdAt = Date()
        newItem.priority = priority
        do {
            try context.save()
            onListChangeDelegate?()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    static func deleteItem(item: ToDoListItem) {
        context.delete(item)
        do {
            try context.save()
            onListChangeDelegate?()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    static func updateItem(item: ToDoListItem, newName: String, newPriority: String) {
        item.taskName = newName
        do {
            try context.save()
            onListChangeDelegate?()
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
