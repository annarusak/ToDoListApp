import UIKit

class ToDoListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var tasks = [ToDoListItem]()
    private lazy var tasksTableView = createTasksTableView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .grayBackgroundColor
        setupNavigationBar()
        
        tasksTableView.delegate = self
        tasksTableView.dataSource = self
        updateItemTableView()
        
        ToDoListItemManager.addOnListChangeDelegate(delegate: updateItemTableView)
    }
    
    
    private func createTasksTableView() -> UITableView {
        let tableView = UITableView()
        tableView.register(CheckboxTableViewCell.self, forCellReuseIdentifier: "CheckboxCell")
        view.addSubview(tableView)
        tableView.backgroundColor = .clear
        tableView.frame = view.bounds
        tableView.separatorColor = .white
        tableView.separatorInset = .init(top: 0, left: 13, bottom: 0, right: 13)
        return tableView
    }
    
    private func createRightBarButton() -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle("  Add Task  ", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18)
        button.layer.borderWidth = 2.5
        button.layer.borderColor = UIColor.blueDetailsColor.cgColor
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.backgroundColor = .clear
        button.setTitleColor(.blueDetailsColor, for: .normal)
        button.addTarget(self, action: #selector(didTapAdd), for: .touchUpInside)
        return button
    }
    
    private func setupNavigationBar() {
        title = "To Do List"
        navigationController?.navigationBar.barStyle = UIBarStyle.black
        navigationController?.navigationBar.tintColor = UIColor.white
        
        let customBarButtonItem = UIBarButtonItem(customView: createRightBarButton())
        navigationItem.rightBarButtonItem = customBarButtonItem
    }

    @objc private func didTapAdd() {
        let newTaskVC = ModalViewController()
        newTaskVC.modalPresentationStyle = .overCurrentContext
        present(newTaskVC, animated: true, completion: nil)
    }
    
    // MARK: - CoreData
    private func updateItemTableView() {
        tasks = ToDoListItemManager.getAllItems()
        tasksTableView.reloadData()
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let task = tasks[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckboxCell", for: indexPath) as! CheckboxTableViewCell
        cell.backgroundColor = .clear
        cell.label.text = task.taskName
        cell.label.textColor = .white
        cell.checkboxButton.isSelected = false
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let task = tasks[indexPath.row]

        let sheet = UIAlertController(title: "Choose option for your task", message: nil, preferredStyle: .actionSheet)
        
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        sheet.addAction(UIAlertAction(title: "Edit", style: .default, handler: { _ in
            let editTaskVC = ModalViewController(taskToUpdate: task)
            editTaskVC.modalPresentationStyle = .overCurrentContext
            self.present(editTaskVC, animated: true, completion: nil)
            print(task.taskName!)
        }))
        
        sheet.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
            ToDoListItemManager.deleteItem(item: task)
        }))
        
        present(sheet, animated: true, completion: nil)
    }
    
    // MARK:-  UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }

}
