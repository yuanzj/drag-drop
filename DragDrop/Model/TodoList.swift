//
//  TodoList.swift
//  DragDrop
//
//  Created by 袁志健 on 2022/4/17.
//

import Foundation
import SwiftUI


class TodoList: ObservableObject {
    
    static let typeIdentifier = "cn.duoweibiaoge.drag_drop.item"
    
    @Published  var todoItems: [TodoItem] = []
    @Published  var doingItems: [TodoItem] = []
    @Published  var underReviewItems: [TodoItem] = []
    @Published  var doneItems: [TodoItem] = []
    
    @Published var draggedItem: TodoItem?
    
    func addTodo(withImage image: String, withName name: String, dueDate: Date, todoStatus: TodoStatus = .todo) {
        let item = TodoItem(image: image, name: name, dueDate: dueDate, todoStatus: todoStatus)
        
        switch(todoStatus) {
        case .todo:
            todoItems.append(item)
        case .doing:
            doingItems.append(item)
        case .underReview:
            underReviewItems.append(item)
        case .done:
            doneItems.append(item)
        }
        
    }
    
    static func sampleData() -> TodoList {
        let sample = TodoList()
        
        let today = Date()
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: today) ?? today.addingTimeInterval(60 * 60 * 24)
        
        sample.addTodo(withImage: "image1", withName: "实现Drap&Drop功能", dueDate: today)
        sample.addTodo(withImage: "image2", withName: "录制SwiftUI视频", dueDate: today)
        sample.addTodo(withImage: "image3", withName: "完成自有产品设计", dueDate: tomorrow)
        sample.addTodo(withImage: "image1", withName: "设计后端架构", dueDate: tomorrow)
        sample.addTodo(withImage: "image2", withName: "定制开发", dueDate: today, todoStatus: .doing)
        
        return sample
    }
}
