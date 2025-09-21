//
//  MockTaskView.swift
//  TaskAppTests
//
//  Created by Gopenux on 21/09/25.
//

import XCTest
@testable import TaskApp

class MockTaskView: TaskViewProtocol {
    var displayedTasks: [Task]?
    var displayedError: String?
    
    func showTasks(_ tasks: [Task]) {
        displayedTasks = tasks
    }
    
    func showError(_ message: String) {
        displayedError = message
    }
}
