//
//  ContentView.swift
//  DragDrop
//
//  Created by 袁志健 on 2022/4/16.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack(spacing: 0) {
            
            TabBarView()
            
            VStack(alignment: .leading, spacing: 0) {
                HStack(spacing: 0) {
                    Text("看板")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .padding(.top, 32 + 24)
                
                DashboardTopBarView()
                    .padding(.top, 32)
                
                ScrollView(.horizontal) {
                    HStack {
                        TaskListView(todoStatus: .todo)
                        TaskListView(todoStatus: .doing)
                        TaskListView(todoStatus: .done)
                    }
                }.padding(.trailing, 32)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
              
        }
        .ignoresSafeArea()
        .background(Color("BackgroundColor"))
            
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(TodoList.sampleData())
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
