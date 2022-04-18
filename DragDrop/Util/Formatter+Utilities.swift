//
//  Formatter.swift
//  DragDrop
//
//  Created by 袁志健 on 2022/4/17.
//

import Foundation

extension Formatter {
  static let dueDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.locale = .autoupdatingCurrent
    formatter.timeStyle = .none
    formatter.dateStyle = .short
    return formatter
  }()
}
