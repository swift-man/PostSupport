//
//  CellLabelsModel.swift
//  PostSupport
//
//  Created by SwiftMan on 2021/09/15.
//

import Foundation

class CellLabelsModel {
  var title: String
  var url: String
  var timestamp: String
  
  init(title: String, url: String, timestamp: Date) {
    self.title = title
    self.url = url
    self.timestamp = itemFormatter.string(from: timestamp)
  }
  
  private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy.M.d hh:mm"
    return formatter
  }()
}
