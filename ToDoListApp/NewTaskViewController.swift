import UIKit

class NewTaskViewController: UIViewController {
        
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
    
    private lazy var newTaskTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.placeholder = "Enter a new task"
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
    
    private lazy var addButton = createButton(title: "Add Task", fontSize: 18, cornerRadius: 12)
    private lazy var cancelButton = createButton(title: "X", fontSize: 14, cornerRadius: 15)
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupGesture()
        observeKeyboard()
        addButton.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(didTapCancelButton), for: .touchUpInside)
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
        modalTemplate.addSubview(addButton)
        modalTemplate.addSubview(priorityLabel)
        modalTemplate.addSubview(newTaskTextField)
        modalTemplate.addSubview(cancelButton)
        
        modalTemplate.translatesAutoresizingMaskIntoConstraints = false
        prioritySegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        addButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        priorityLabel.translatesAutoresizingMaskIntoConstraints = false
        newTaskTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            modalTemplate.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            modalTemplate.leftAnchor.constraint(equalTo: view.leftAnchor),
            modalTemplate.rightAnchor.constraint(equalTo: view.rightAnchor),
            modalTemplate.heightAnchor.constraint(equalToConstant: view.frame.height / 2.8),
            
            newTaskTextField.bottomAnchor.constraint(equalTo: modalTemplate.centerYAnchor, constant: 20),
            newTaskTextField.centerXAnchor.constraint(equalTo: modalTemplate.centerXAnchor),
            newTaskTextField.heightAnchor.constraint(equalToConstant: 55),
            newTaskTextField.widthAnchor.constraint(equalTo: modalTemplate.widthAnchor, multiplier: 0.85),
            
            prioritySegmentedControl.centerXAnchor.constraint(equalTo: modalTemplate.centerXAnchor),
            prioritySegmentedControl.bottomAnchor.constraint(equalTo: newTaskTextField.topAnchor, constant: -30),
            prioritySegmentedControl.widthAnchor.constraint(equalToConstant: 200),
            
            priorityLabel.centerXAnchor.constraint(equalTo: modalTemplate.centerXAnchor),
            priorityLabel.bottomAnchor.constraint(equalTo: prioritySegmentedControl.topAnchor, constant: -10),

            addButton.topAnchor.constraint(equalTo: newTaskTextField.bottomAnchor, constant: 20),
            addButton.centerXAnchor.constraint(equalTo: modalTemplate.centerXAnchor),
            addButton.heightAnchor.constraint(equalToConstant: 55),
            addButton.widthAnchor.constraint(equalTo: modalTemplate.widthAnchor, multiplier: 0.85),
            
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
        print("keyboardHeight: \(keyboardHeight)")
        
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
    
    @objc private func didTapAddButton() {
        print("Add Task")
    }
    
    @objc private func didTapCancelButton() {
        print("Cancel")
        self.dismiss(animated: true, completion: nil)
    }
    
}
