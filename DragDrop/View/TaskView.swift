//
//  TaskView.swift
//  DragDrop
//
//  Created by 袁志健 on 2022/4/17.
//

import SwiftUI

struct TaskView: View {
    
    @EnvironmentObject private var todoList: TodoList
    var item: TodoItem

    var body: some View {
        VStack(alignment: .leading) {
            
            Image("\(item.image)")
                .resizable()
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            
            HStack(alignment: .center){
                Text("\(item.name)")
                    .fontWeight(.bold)
                    .lineLimit(/*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                Spacer()
                Image("more")
                    .renderingMode(.template)
                    .foregroundColor(Color.secondary)
                    .frame(width: 48)
            }
            .frame(height: 48)
            
            Text("这里是任务详情")
                .foregroundColor(Color.secondary)
                .padding(.top, 8)
            
            HStack(alignment: .center){
                
                Image("calendar")
                    .renderingMode(.template)
                    .foregroundColor(Color.secondary)
                Text(item.dueDate, formatter: .dueDateFormatter)
                    
                    .foregroundColor(Color.secondary)
                Spacer()
                HStack {
                    Image("HeadPortrait1")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32, height: 32)
                        .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    Image("HeadPortrait2")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32, height: 32)
                        .overlay(Circle().stroke(Color.white, lineWidth: 2))
                        .offset(x: -16)
                    
                    Circle()
                        .fill(Color.accentColor)
                        .frame(width: 32, height: 32)
                        .overlay(Circle().stroke(Color.white, lineWidth: 2))
                        .overlay(Text("+1").foregroundColor(Color.white))
                        .offset(x: -32)
                }
                .frame(width: 64)
            }
            .frame(height: 48)
            
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .onDrag {
            todoList.draggedItem = item
            todoList.draggedIdentifier = item.id
            return NSItemProvider(item: nil, typeIdentifier: item.id)
        }
        .onDrop(of: [item.id], delegate: MyDropDelegate(droppedItem: item, todoList: todoList))
        .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 4)
        .padding(16)
    }
}

struct MyDropDelegate : DropDelegate {
    
    let droppedItem: TodoItem
    let todoList: TodoList
    
    func validateDrop(info: DropInfo) -> Bool {
        print("MyDropDelegate - validateDrop() called")
        return true
    }
    
    func performDrop(info: DropInfo) -> Bool {
        print("MyDropDelegate - performDrop() called")
        return true
    }
    
    func dropEntered(info: DropInfo) {
        print("MyDropDelegate - dropEntered() called")
        print("\(droppedItem.name)")
                
        if droppedItem.todoStatus == todoList.draggedItem?.todoStatus {
            var items: [TodoItem]
            switch(droppedItem.todoStatus) {
            case .todo:
                items = todoList.todoItems
            case .doing:
                items = todoList.doingItems
            case .underReview:
                items = todoList.underReviewItems
            case .done:
                items = todoList.doneItems
            }
            
            let fromIndex = items.firstIndex { (item) -> Bool in
                return item.id == todoList.draggedItem?.id
            } ?? 0
            
            let toIndex = items.firstIndex { (item) -> Bool in
                return item.id == droppedItem.id
            } ?? 0
            
            if fromIndex != toIndex {
                withAnimation(.default) {
                    switch(droppedItem.todoStatus) {
                    case .todo:
                        todoList.todoItems.move(fromOffsets: IndexSet(integer: fromIndex), toOffset: toIndex > fromIndex ? toIndex + 1 : toIndex)
                    case .doing:
                        todoList.doingItems.move(fromOffsets: IndexSet(integer: fromIndex), toOffset: toIndex > fromIndex ? toIndex + 1 : toIndex)
                    case .underReview:
                        todoList.underReviewItems.move(fromOffsets: IndexSet(integer: fromIndex), toOffset: toIndex > fromIndex ? toIndex + 1 : toIndex)
                    case .done:
                        todoList.doneItems.move(fromOffsets: IndexSet(integer: fromIndex), toOffset: toIndex > fromIndex ? toIndex + 1 : toIndex)
                    }
                }
            }
        } else {
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
            switch(droppedItem.todoStatus) {
            case .todo:
                droppedItems = todoList.todoItems
            case .doing:
                droppedItems = todoList.doingItems
            case .underReview:
                droppedItems = todoList.underReviewItems
            case .done:
                droppedItems = todoList.doneItems
            }
            
            let insertIndex = droppedItems.firstIndex { (item) -> Bool in
                return item.id == droppedItem.id
            } ?? 0
            
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
                switch(droppedItem.todoStatus) {
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
        print("MyDropDelegate - dropUpdated() called")
        return DropProposal(operation: .move)
    }
    
    func dropExited(info: DropInfo) {
        print("MyDropDelegate - dropExited() called")
    }
    
}
