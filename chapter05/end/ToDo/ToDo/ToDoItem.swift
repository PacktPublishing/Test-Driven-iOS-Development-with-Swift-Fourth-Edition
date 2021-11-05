//  Created by Dominik Hauser on 01.10.21.
//  
//
  

import Foundation

struct ToDoItem: Equatable {
  let id: UUID
  let title: String
  let itemDescription: String?
  let timestamp: TimeInterval?
  let location: Location?

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
}
