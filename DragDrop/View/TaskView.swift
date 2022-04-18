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
            NSItemProvider(item: nil, typeIdentifier: item.id)
        }
        .shadow(color: Color.black.opacity(0.3), radius: 8, x: 0, y: 4)
        .padding(16)
    }
}
