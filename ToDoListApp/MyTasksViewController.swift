import UIKit

class MyTasksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let backgroundColor = UIColor(red: 234/255, green: 206/255, blue: 187/255, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "My Tasks"
        view.backgroundColor = backgroundColor
        createTasksTableView()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
    }
    
    private func createTasksTableView() {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        tableView.separatorInset = .init(top: 0, left: 13, bottom: 0, right: 13)
    }

    @objc private func didTapAdd() {
        let modalVC = NewTaskViewController()
        modalVC.modalPresentationStyle = .custom
        modalVC.transitioningDelegate = self

        present(modalVC, animated: true, completion: nil)
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
        cell.contentConfiguration = content
        return cell
    }
    
    // MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }

}


extension MyTasksViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return PresentationModalController(presentedViewController: presented, presenting: presenting)
    }
}
