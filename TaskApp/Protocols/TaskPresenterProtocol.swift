//
//  TaskPresenterProtocol.swift
//  TaskApp
//
//  Created by Gopenux on 21/09/25.
//

import Foundation

protocol TaskPresenterProtocol {
    func addTask(title: String, description: String?, priority: String)
    func listTasks(filterByPriority: TaskPriority?, filterByState: TaskState?)
    func completeTask(id: UUID)
    func deleteTask(id: UUID)
}
