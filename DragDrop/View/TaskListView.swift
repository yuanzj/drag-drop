//
//  TaskListView.swift
//  DragDrop
//
//  Created by 袁志健 on 2022/4/17.
//

import SwiftUI

struct TaskListView: View {
    
    @EnvironmentObject private var todoList: TodoList
    
    var todoStatus: TodoStatus
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                RoundedRectangle(cornerRadius: 8, style: .continuous).fill(headerColor)
                    .frame(width: 20, height: 20)
                Text(headerName)
                    .fontWeight(.bold)
                Image("add")
                    .renderingMode(.template)
                    .foregroundColor(Color.secondary)
            }.padding(.leading, 16)
            
            ScrollView(.vertical, showsIndicators: false)  {
                
                if todos.count > 0 {
                    VStack(spacing: 0) {
                        
                        ForEach(todos) { item in
                            TaskView(item: item)
                        }

                    }
                    .padding(.top, 16)
                } else {
                    // 修复drop不生效问题
                    Color.clear
                        .frame(width: 320, height: 320)
                }
               
            }
            .frame(maxHeight: .infinity)
            .frame(width: 320)
            .onDrop(of: [TodoList.typeIdentifier], delegate: AddDropDelegate(todoStatus: todoStatus, todoList: todoList))
        }
        .padding(.vertical, 32)
        
    }
    
    var headerColor: Color {
        switch(todoStatus) {
        case .todo:
            return  Color("ToDoColor")
        case .doing:
            return  Color("Doing")
        case .underReview:
            return Color("UnderReview")
        case .done:
            return  Color("Done")
        }
    }
    
    var headerName: String {
        switch(todoStatus) {
        case .todo:
            return "待处理"
        case .doing:
            return "处理中"
        case .underReview:
            return "待审核"
        case .done:
            return "已完成"
        }
    }
    
    var todos: [TodoItem] {
        switch(todoStatus) {
        case .todo:
            return todoList.todoItems
        case .doing:
            return todoList.doingItems
        case .underReview:
            return todoList.underReviewItems
        case .done:
            return todoList.doneItems
        }
    }
}


struct AddDropDelegate : DropDelegate {
    
    let todoStatus: TodoStatus
    let todoList: TodoList
    
    func validateDrop(info: DropInfo) -> Bool {
        print("AddDropDelegate - validateDrop() called")
        return true
    }
    
    func performDrop(info: DropInfo) -> Bool {
        print("AddDropDelegate - performDrop() called")
        return true
    }
    
    func dropEntered(info: DropInfo) {
        print("AddDropDelegate - dropEntered() called")
        
        
        
        if todoStatus != todoList.draggedItem?.todoStatus {
            var draggedItems: [TodoItem]
            switch(todoList.draggedItem!.todoStatus) {
            case .todo:
                draggedItems = todoList.todoItems
            case .doing:
                draggedItems = todoList.doingItems
            case .underReview:
                draggedItems = todoList.underReviewItems
            case .done:
                draggedItems = todoList.doneItems
            }
            
            let deleteIndex = draggedItems.firstIndex { (item) -> Bool in
                return item.id == todoList.draggedItem?.id
            } ?? 0
            
            var droppedItems: [TodoItem]
            switch(todoStatus) {
            case .todo:
                droppedItems = todoList.todoItems
            case .doing:
                droppedItems = todoList.doingItems
            case .underReview:
                droppedItems = todoList.underReviewItems
            case .done:
                droppedItems = todoList.doneItems
            }
            
            let insertIndex = droppedItems.count  == 0 ? 0 : droppedItems.count
           
            withAnimation(.default) {
                // 删除
                switch(todoList.draggedItem!.todoStatus) {
                case .todo:
                    todoList.todoItems.remove(at: deleteIndex)
                case .doing:
                    todoList.doingItems.remove(at: deleteIndex)
                case .underReview:
                    todoList.underReviewItems.remove(at: deleteIndex)
                case .done:
                    todoList.doneItems.remove(at: deleteIndex)
                    
                }
                
                // 新增
                switch(todoStatus) {
                case .todo:
                    todoList.draggedItem?.todoStatus = .todo
                    todoList.todoItems.insert(todoList.draggedItem!, at: insertIndex)
                case .doing:
                    todoList.draggedItem?.todoStatus = .doing
                    todoList.doingItems.insert(todoList.draggedItem!, at: insertIndex)
                case .underReview:
                    todoList.draggedItem?.todoStatus = .underReview
                    todoList.underReviewItems.insert(todoList.draggedItem!, at: insertIndex)
                case .done:
                    todoList.draggedItem?.todoStatus = .done
                    todoList.doneItems.insert(todoList.draggedItem!, at: insertIndex)
                }
                
            }
        }
    }
    
    func dropUpdated(info: DropInfo) -> DropProposal? {
        print("AddDropDelegate - dropUpdated() called")
        return DropProposal(operation: .move)
    }
    
    func dropExited(info: DropInfo) {
        print("AddDropDelegate - dropExited() called")
    }
    
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView(todoStatus: .todo)
            .environmentObject(TodoList.sampleData())
    }
}
