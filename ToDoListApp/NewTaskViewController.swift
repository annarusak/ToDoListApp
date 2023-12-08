import UIKit

class NewTaskViewController: UIViewController {
    
    private lazy var prioritySegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Low", "Medium", "High"])
        segmentedControl.selectedSegmentIndex = 1
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
        return segmentedControl
    }()
    
    private lazy var newTaskTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.placeholder = "Add new task"
        textField.backgroundColor = .secondarySystemBackground
        textField.layer.cornerRadius = 12
        textField.returnKeyType = .done
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.leftViewMode = .always
        return textField
    }()
    
    private lazy var priorityLabel: UILabel = {
        let label = UILabel()
        label.text = "Choose task priority"
        label.textColor = .black
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var addButton = createButton(title: "Add Task", backgroundColor: .green)
    private lazy var cancelButton = createButton(title: "Cancel", backgroundColor: .red)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        addButton.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(didTapCancelButton), for: .touchUpInside)
    }
    
    
    private func createButton(title: String, backgroundColor: UIColor) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.backgroundColor = backgroundColor
        button.setTitleColor(.black, for: .normal)
        return button
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        
        view.addSubview(prioritySegmentedControl)
        view.addSubview(addButton)
        view.addSubview(cancelButton)
        view.addSubview(priorityLabel)
        view.addSubview(newTaskTextField)
        
        prioritySegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        addButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        priorityLabel.translatesAutoresizingMaskIntoConstraints = false
        newTaskTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            newTaskTextField.bottomAnchor.constraint(equalTo: view.centerYAnchor),
            newTaskTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            newTaskTextField.heightAnchor.constraint(equalToConstant: 55),
            newTaskTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            prioritySegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            prioritySegmentedControl.bottomAnchor.constraint(equalTo: newTaskTextField.topAnchor, constant: -30),
            prioritySegmentedControl.widthAnchor.constraint(equalToConstant: 200),
            
            priorityLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            priorityLabel.bottomAnchor.constraint(equalTo: prioritySegmentedControl.topAnchor, constant: -10),

            addButton.topAnchor.constraint(equalTo: newTaskTextField.bottomAnchor, constant: 20),
            addButton.leftAnchor.constraint(equalTo: newTaskTextField.leftAnchor),
            addButton.heightAnchor.constraint(equalToConstant: 55),
            addButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.40),

            cancelButton.topAnchor.constraint(equalTo: addButton.topAnchor),
            cancelButton.rightAnchor.constraint(equalTo: newTaskTextField.rightAnchor),
            cancelButton.heightAnchor.constraint(equalToConstant: 55),
            cancelButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.40)
        ])
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
    
    @objc private func didTapAddButton() {
        print("Add Task")
    }
    
    @objc private func didTapCancelButton() {
        print("Cancel")
    }
    
}
