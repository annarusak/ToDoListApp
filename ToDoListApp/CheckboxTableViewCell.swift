import UIKit

class CheckboxTableViewCell: UITableViewCell {
    
    let checkboxButton: UIButton = {
        let button = UIButton(type: .system)
        let buttonImage = UIImage(systemName: "circle")
        let selectedButtonImage = UIImage(systemName: "checkmark.circle.fill")
        button.setImage(buttonImage, for: .normal)
        button.setImage(selectedButtonImage, for: .selected)
        button.tintColor = .white
        button.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(checkboxTapped), for: .touchUpInside)
        return button
    }()

    let label = UILabel()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    

    private func setupUI() {
        contentView.addSubview(checkboxButton)
        contentView.addSubview(label)
        
        checkboxButton.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
        checkboxButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
        checkboxButton.widthAnchor.constraint(equalToConstant: 24),
        checkboxButton.heightAnchor.constraint(equalToConstant: 24),
        checkboxButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

        label.leadingAnchor.constraint(equalTo: checkboxButton.trailingAnchor, constant: 8),
        label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    @objc private func checkboxTapped() {
        print("CheckboxButton tapped")
        checkboxButton.isSelected = !checkboxButton.isSelected
    }
    
}
