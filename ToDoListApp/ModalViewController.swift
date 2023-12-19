import UIKit

class ModalViewController: UIViewController {
    
    var taskItemToUpdate: ToDoListItem?
    
    enum typeOfModalController {
        case newTask
        case editTask
    }
    
    private lazy var backgroundView: UIView = {
        let backView = UIView(frame: view.frame)
        backView.backgroundColor = UIColor(white: 0, alpha: 0.4)
        return backView
    }()
    
    private lazy var modalTemplate: UIView = {
        let backView = UIView()
        backView.backgroundColor = .grayBackgroundColor
        backView.layer.cornerRadius = 25
        return backView
    }()
    
    private lazy var prioritySegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Low", "Medium", "High"])
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
        segmentedControl.selectedSegmentIndex = 1
        segmentedControl.backgroundColor = UIColor(white: 1, alpha: 0.5)
        segmentedControl.selectedSegmentTintColor = .blueDetailsColor
        return segmentedControl
    }()
    
    private lazy var taskTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.placeholder = ""
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 12
        textField.keyboardType = .default
        textField.returnKeyType = .done
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftView = leftPaddingView
        textField.leftViewMode = .always
        return textField
    }()
    
    private lazy var priorityLabel: UILabel = {
        let label = UILabel()
        label.text = "Choose task priority"
        label.textColor = .white
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    private lazy var saveTaskButton = createButton(title: "", fontSize: 18, cornerRadius: 12)
    private lazy var cancelButton = createButton(title: "X", fontSize: 14, cornerRadius: 15)
        
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        setupUI()
        setupGesture()
        observeKeyboard()
        
        taskTextField.placeholder = "Enter a new task"
        saveTaskButton.setTitle("Add task", for: .normal)
        
        cancelButton.addTarget(self, action: #selector(didTapCancelButton), for: .touchUpInside)
        saveTaskButton.addTarget(self, action: #selector(didTapSaveTaskButton), for: .touchUpInside)
    }
    
    init(taskToUpdate: ToDoListItem) {
        super.init(nibName: nil, bundle: nil)
        
        taskItemToUpdate = taskToUpdate
        
        setupUI()
        setupGesture()
        observeKeyboard()
        
        taskTextField.placeholder = "Edit your task"
        taskTextField.text = taskItemToUpdate?.taskName
        saveTaskButton.setTitle("Save", for: .normal)
        
        cancelButton.addTarget(self, action: #selector(didTapCancelButton), for: .touchUpInside)
        saveTaskButton.addTarget(self, action: #selector(didTapSaveTaskButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func createButton(title: String, fontSize: CGFloat, cornerRadius: CGFloat) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: fontSize)
        button.layer.borderWidth = 2.5
        button.layer.borderColor = UIColor.blueDetailsColor.cgColor
        button.layer.cornerRadius = cornerRadius
        button.layer.masksToBounds = true
        button.backgroundColor = .clear
        button.setTitleColor(.blueDetailsColor, for: .normal)
        return button
    }
    
    private func setupUI() {
        view.backgroundColor = .clear
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        view.layer.isOpaque = false
        
        view.addSubview(backgroundView)
        view.addSubview(modalTemplate)
        modalTemplate.addSubview(prioritySegmentedControl)
        modalTemplate.addSubview(saveTaskButton)
        modalTemplate.addSubview(priorityLabel)
        modalTemplate.addSubview(taskTextField)
        modalTemplate.addSubview(cancelButton)
        
        modalTemplate.translatesAutoresizingMaskIntoConstraints = false
        prioritySegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        saveTaskButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        priorityLabel.translatesAutoresizingMaskIntoConstraints = false
        taskTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            modalTemplate.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            modalTemplate.leftAnchor.constraint(equalTo: view.leftAnchor),
            modalTemplate.rightAnchor.constraint(equalTo: view.rightAnchor),
            modalTemplate.heightAnchor.constraint(equalToConstant: view.frame.height / 2.8),
            
            taskTextField.bottomAnchor.constraint(equalTo: modalTemplate.centerYAnchor, constant: 20),
            taskTextField.centerXAnchor.constraint(equalTo: modalTemplate.centerXAnchor),
            taskTextField.heightAnchor.constraint(equalToConstant: 55),
            taskTextField.widthAnchor.constraint(equalTo: modalTemplate.widthAnchor, multiplier: 0.85),
            
            prioritySegmentedControl.centerXAnchor.constraint(equalTo: modalTemplate.centerXAnchor),
            prioritySegmentedControl.bottomAnchor.constraint(equalTo: taskTextField.topAnchor, constant: -30),
            prioritySegmentedControl.widthAnchor.constraint(equalToConstant: 200),
            
            priorityLabel.centerXAnchor.constraint(equalTo: modalTemplate.centerXAnchor),
            priorityLabel.bottomAnchor.constraint(equalTo: prioritySegmentedControl.topAnchor, constant: -10),

            saveTaskButton.topAnchor.constraint(equalTo: taskTextField.bottomAnchor, constant: 20),
            saveTaskButton.centerXAnchor.constraint(equalTo: modalTemplate.centerXAnchor),
            saveTaskButton.heightAnchor.constraint(equalToConstant: 55),
            saveTaskButton.widthAnchor.constraint(equalTo: modalTemplate.widthAnchor, multiplier: 0.85),
            
            cancelButton.centerYAnchor.constraint(equalTo: modalTemplate.topAnchor, constant: 30),
            cancelButton.centerXAnchor.constraint(equalTo: modalTemplate.rightAnchor, constant: -30),
            cancelButton.heightAnchor.constraint(equalToConstant: 30),
            cancelButton.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissModalViewController))
        view.addGestureRecognizer(tapGesture)
    }
    
    private func observeKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        let keyboardHeight = getKeyboardHeight(notification: notification)        
        modalTemplate.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -keyboardHeight + 30).isActive = true
    }
    
    private func getKeyboardHeight(notification: Notification) -> CGFloat {
        guard let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height else { return 0 }
        return keyboardHeight
    }
    
    @objc private func dismissModalViewController() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            print("Low")
            break
        case 1:
            print("Medium")
            break
        case 2:
            print("High")
            break
        default:
            break
        }
    }
    
    @objc private func didTapSaveTaskButton() {
        if (taskItemToUpdate != nil) {
            print("Update Task")
            guard let taskItemToUpdate = taskItemToUpdate else { return }
            guard let newTaskName = taskTextField.text, !newTaskName.isEmpty else { return }
            ToDoListItemManager.updateItem(item: taskItemToUpdate, newName: newTaskName, newPriority: definePriority())
        } else {
            print("Create Task")
            guard let textField = taskTextField.text, !textField.isEmpty else { return }
            ToDoListItemManager.createItem(name: textField, priority: definePriority())
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapCancelButton() {
        print("Cancel")
        self.dismiss(animated: true, completion: nil)
    }
    
    private func definePriority() -> String {
        let selectedPriority = prioritySegmentedControl.selectedSegmentIndex
        switch selectedPriority {
        case 0:
            return TaskPriority.low.rawValue
        case 1:
            return TaskPriority.medium.rawValue
        case 2:
            return TaskPriority.high.rawValue
        default:
            return ""
        }
    }
    
}
