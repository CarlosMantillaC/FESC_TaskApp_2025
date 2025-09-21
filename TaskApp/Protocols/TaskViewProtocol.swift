//
//  TaskViewProtocol.swift
//  TaskApp
//
//  Created by Gopenux on 21/09/25.
//

protocol TaskViewProtocol: AnyObject {
    func showTasks(_ tasks: [Task])
    func showError(_ message: String)
}
