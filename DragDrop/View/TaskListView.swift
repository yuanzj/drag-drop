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
                
                VStack(spacing: 0) {
                    
                    ForEach(todos) { item in
                        TaskView(item: item)
                    }

                }
                .padding(.top, 16)
                
            }
            .frame(maxHeight: .infinity)
            .frame(width: 320)
            
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
            return todoList.activeItemIds
        case .doing:
            return todoList.doingItemIds
        case .underReview:
            return todoList.underReviewItemIds
        case .done:
            return todoList.doingItemIds
        }
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView(todoStatus: .todo)
            .environmentObject(TodoList.sampleData())
    }
}
