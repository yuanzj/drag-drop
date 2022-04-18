//
//  DragDropApp.swift
//  DragDrop
//
//  Created by 袁志健 on 2022/4/16.
//

import SwiftUI

@main
struct DragDropApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(TodoList.sampleData())
        }
    }
}
