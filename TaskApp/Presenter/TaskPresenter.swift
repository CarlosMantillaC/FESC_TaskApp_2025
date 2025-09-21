//
//  TaskPresenter.swift
//  TaskApp
//
//  Created by Gopenux on 21/09/25.
//

import Foundation

class TaskPresenter: TaskPresenterProtocol {
    private weak var view: TaskViewProtocol?
    private var tasks: [Task] = []
    
    init(view: TaskViewProtocol) {
        self.view = view
    }
    
    func addTask(title: String, description: String?, priority: String) {
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else {
            view?.showError("Título no puede ser vacio")
            return
        }
        
        guard let taskPriority = TaskPriority(rawValue: priority.lowercased()) else {
            view?.showError("Prioridad inválida")
            return
        }
        
        let newTask = Task(
            id: UUID(),
            title: title,
            description: description,
            priority: taskPriority,
            state: .pending
        )
        
        tasks.append(newTask)
        view?.showTasks(tasks)
    }
    
    func listTasks(filterByPriority: TaskPriority?, filterByState: TaskState?) {
        var filtered = tasks
        
        if let p = filterByPriority {
            filtered = filtered.filter { $0.priority == p }
        }
        if let s = filterByState {
            filtered = filtered.filter { $0.state == s }
        }
        
        view?.showTasks(filtered)
    }
    
    func completeTask(id: UUID) {
        guard let index = tasks.firstIndex(where: { $0.id == id }) else {
            view?.showError("Tarea no encontrada")
            return
        }
        tasks[index].state = .completed
        view?.showTasks(tasks)
    }
    
    func deleteTask(id: UUID) {
        guard let index = tasks.firstIndex(where: { $0.id == id }) else {
            view?.showError("Tarea no encontrada")
            return
        }
        tasks.remove(at: index)
        view?.showTasks(tasks)
    }
}
