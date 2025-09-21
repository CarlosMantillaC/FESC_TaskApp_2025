//
//  AddTaskViewController.swift
//  TaskApp
//
//  Created by Gopenux on 21/09/25.
//

import UIKit

class AddTaskViewController: UIViewController {
    
    private var presenter: TaskPresenterProtocol
    
    private let titleField = UITextField()
    private let descriptionField = UITextField()
    private let prioritySegmented = UISegmentedControl(items: ["Alta", "Media", "Baja"])
    
    init(presenter: TaskPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) { fatalError() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Nueva tarea"
        view.backgroundColor = .systemBackground
        setupUI()
    }
    
    private func setupUI() {
        titleField.placeholder = "Título"
        titleField.borderStyle = .roundedRect
        
        descriptionField.placeholder = "Descripción (opcional)"
        descriptionField.borderStyle = .roundedRect
        
        prioritySegmented.selectedSegmentIndex = 1
        
        let button = UIButton(type: .system)
        button.setTitle("Guardar", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.addTarget(self, action: #selector(saveTask), for: .touchUpInside)
        
        let stack = UIStackView(arrangedSubviews: [titleField, descriptionField, prioritySegmented, button])
        stack.axis = .vertical
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    @objc private func saveTask() {
        let title = titleField.text ?? ""
        let description = descriptionField.text
        let priority: String
        switch prioritySegmented.selectedSegmentIndex {
        case 0: priority = "high"
        case 1: priority = "medium"
        case 2: priority = "low"
        default: priority = "medium"
        }
        
        presenter.addTask(title: title, description: description, priority: priority)
        navigationController?.popViewController(animated: true)
    }
}
