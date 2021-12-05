//  Created by Dominik Hauser on 01.10.21.
//  
//
  

import Foundation

struct ToDoItem: Equatable, Codable {
  let id: UUID
  let title: String
  let itemDescription: String?
  let timestamp: TimeInterval?
  let location: Location?
  var done = false

  init(title: String,
       itemDescription: String? = nil,
       timestamp: TimeInterval? = nil,
       location: Location? = nil) {

    self.id = UUID()
    self.title = title
    self.itemDescription = itemDescription
    self.timestamp = timestamp
    self.location = location
  }

  static func == (lhs: ToDoItem, rhs: ToDoItem) -> Bool {
    return lhs.id == rhs.id
  }
}

extension ToDoItem: Hashable {
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}
