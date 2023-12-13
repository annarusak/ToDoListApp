import UIKit

class ToDoListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .grayBackgroundColor
        createTasksTableView()
        setupNavigationBar()
    }
    
    
    private func createTasksTableView() {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        tableView.separatorColor = .white
        tableView.separatorInset = .init(top: 0, left: 13, bottom: 0, right: 13)
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
        let newTaskVC = NewTaskViewController()
        newTaskVC.modalPresentationStyle = .overCurrentContext
        present(newTaskVC, animated: true, completion: nil)
    }
    
    // MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .clear
        var content = cell.defaultContentConfiguration()
        content.text = "My Task"
        content.textProperties.color = .white
        cell.contentConfiguration = content
        return cell
    }
    
    // MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }

}
