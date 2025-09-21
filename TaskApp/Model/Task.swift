//
//  Task.swift
//  TaskApp
//
//  Created by Gopenux on 21/09/25.
//

import Foundation

enum TaskPriority: String, CaseIterable {
    case high, medium, low
}

enum TaskState: String {
    case pending, completed
}

struct Task {
    let id: UUID
    let title: String
    let description: String?
    let priority: TaskPriority
    var state: TaskState
}
