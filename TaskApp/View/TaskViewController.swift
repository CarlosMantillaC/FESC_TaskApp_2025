//
//  TaskViewController.swift
//  TaskApp
//
//  Created by Gopenux on 21/09/25.
//

import UIKit

class TaskViewController: UIViewController, TaskViewProtocol {
    
    private var presenter: TaskPresenterProtocol!
    private var tasks: [Task] = []
    
    private let tableView = UITableView()
    private let filterSegmented = UISegmentedControl(items: ["Todas", "Alta", "Media", "Baja"])
    private let stateSegmented = UISegmentedControl(items: ["Todas", "Pendientes", "Completadas"])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Tareas"
        view.backgroundColor = .systemBackground
        
        presenter = TaskPresenter(view: self)
        
        setupUI()
    }
    
    private func setupUI() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addTask)
        )
        
        filterSegmented.selectedSegmentIndex = 0
        filterSegmented.addTarget(self, action: #selector(applyFilters), for: .valueChanged)
        
        stateSegmented.selectedSegmentIndex = 0
        stateSegmented.addTarget(self, action: #selector(applyFilters), for: .valueChanged)
        
        let stack = UIStackView(arrangedSubviews: [filterSegmented, stateSegmented])
        stack.axis = .vertical
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stack)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            
            tableView.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc private func addTask() {
        let vc = AddTaskViewController(presenter: presenter)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func applyFilters() {
        var priority: TaskPriority? = nil
        var state: TaskState? = nil
        
        switch filterSegmented.selectedSegmentIndex {
        case 1: priority = .high
        case 2: priority = .medium
        case 3: priority = .low
        default: break
        }
        
        switch stateSegmented.selectedSegmentIndex {
        case 1: state = .pending
        case 2: state = .completed
        default: break
        }
        
        presenter.listTasks(filterByPriority: priority, filterByState: state)
    }
    
    func showTasks(_ tasks: [Task]) {
        self.tasks = tasks
        tableView.reloadData()
    }
    
    func showError(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: .default))
        present(alert, animated: true)
    }
}

extension TaskViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        let task = tasks[indexPath.row]
        
        cell.textLabel?.text = "\(task.title) [\(task.priority.rawValue.capitalized)]"
        cell.detailTextLabel?.text = "\(task.state.rawValue.capitalized) – desliza para más opciones"
        cell.detailTextLabel?.textColor = .secondaryLabel
        
        cell.accessoryView = UIImageView(image: UIImage(systemName: "ellipsis"))
        cell.accessoryView?.tintColor = .systemGray
        
        return cell
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let complete = UIContextualAction(style: .normal, title: "Completar") { _, _, done in
            self.presenter.completeTask(id: self.tasks[indexPath.row].id)
            done(true)
        }
        complete.backgroundColor = .systemGreen
        
        let delete = UIContextualAction(style: .destructive, title: "Eliminar") { _, _, done in
            self.presenter.deleteTask(id: self.tasks[indexPath.row].id)
            done(true)
        }
        
        return UISwipeActionsConfiguration(actions: [delete, complete])
    }
}
