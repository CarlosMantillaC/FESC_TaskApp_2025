//
//  TaskPresenterIntegrationTests.swift
//  TaskAppTests
//
//  Created by Gopenux on 21/09/25.
//

import XCTest
@testable import TaskApp

class TaskPresenterIntegrationTests: XCTestCase {
    
    var mockView: MockTaskView!
    var presenter: TaskPresenter!
    
    override func setUp() {
        super.setUp()
        mockView = MockTaskView()
        presenter = TaskPresenter(view: mockView)
    }
    
    override func tearDown() {
        presenter = nil
        mockView = nil
        super.tearDown()
    }
    
    func test_addTask_successfullyAddsTask() {
        presenter.addTask(title: "Comprar leche", description: "En el supermercado", priority: "high")
        
        XCTAssertNotNil(mockView.displayedTasks)
        XCTAssertEqual(mockView.displayedTasks?.count, 1)
        XCTAssertEqual(mockView.displayedTasks?.first?.title, "Comprar leche")
        XCTAssertEqual(mockView.displayedTasks?.first?.priority, .high)
        XCTAssertEqual(mockView.displayedTasks?.first?.state, .pending)
    }
    
    func test_addTask_emptyTitle_showsError() {
        presenter.addTask(title: "   ", description: nil, priority: "high")
        
        XCTAssertEqual(mockView.displayedError, "Título no puede ser vacio")
        XCTAssertNil(mockView.displayedTasks)
    }
    
    func test_addTask_invalidPriority_showsError() {
        presenter.addTask(title: "Tarea inválida", description: nil, priority: "urgent")
        
        XCTAssertEqual(mockView.displayedError, "Prioridad inválida")
        XCTAssertNil(mockView.displayedTasks)
    }
    
    func test_listTasks_filtersByPriority() {
        presenter.addTask(title: "Alta", description: nil, priority: "high")
        presenter.addTask(title: "Media", description: nil, priority: "medium")
        presenter.addTask(title: "Baja", description: nil, priority: "low")
        
        presenter.listTasks(filterByPriority: .high, filterByState: nil)
        
        XCTAssertEqual(mockView.displayedTasks?.count, 1)
        XCTAssertEqual(mockView.displayedTasks?.first?.priority, .high)
    }
    
    func test_completeTask_changesStateToCompleted() {
        presenter.addTask(title: "Terminar código", description: nil, priority: "medium")
        let taskID = mockView.displayedTasks!.first!.id
        
        presenter.completeTask(id: taskID)
        
        XCTAssertEqual(mockView.displayedTasks?.first?.state, .completed)
    }
    
    func test_completeTask_invalidID_showsError() {
        presenter.completeTask(id: UUID())
        
        XCTAssertEqual(mockView.displayedError, "Tarea no encontrada")
    }
    
    func test_deleteTask_removesTask() {
        presenter.addTask(title: "Borrar esto", description: nil, priority: "low")
        let taskID = mockView.displayedTasks!.first!.id
        
        presenter.deleteTask(id: taskID)
        
        XCTAssertEqual(mockView.displayedTasks?.count, 0)
    }
    
    func test_deleteTask_invalidID_showsError() {
        presenter.deleteTask(id: UUID())
        
        XCTAssertEqual(mockView.displayedError, "Tarea no encontrada")
    }
}
