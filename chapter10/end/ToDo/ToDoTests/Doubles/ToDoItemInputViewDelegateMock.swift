//  Created by Dominik Hauser on 31.12.21.
//  Copyright © 2021 dasdom. All rights reserved.
//

import Foundation
@testable import ToDo

class ToDoItemInputViewDelegateMock:
  ToDoItemInputViewDelegate {

  var lastToDoItemData: ToDoItemData?
  var lastCoordinate: Coordinate?

  func addToDoItem(with data: ToDoItemData,
                   coordinate: Coordinate?) {

    lastToDoItemData = data
    lastCoordinate = coordinate
  }
}
