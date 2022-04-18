//
//  TaskItem.swift
//  DragDrop
//
//  Created by 袁志健 on 2022/4/17.
//

import Foundation

enum TodoStatus {
    case todo
    case doing
    case underReview
    case done
}

struct TodoItem: Identifiable {
    let id: String = UUID().uuidString
    var image: String
    var name: String
    var dueDate: Date
    var todoStatus: TodoStatus
}
