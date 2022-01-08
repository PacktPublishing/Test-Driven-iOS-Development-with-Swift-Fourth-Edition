//  Created by Dominik Hauser on 14.11.21.
//  Copyright © 2021 dasdom. All rights reserved.
//

import Foundation
import Combine
@testable import ToDo

class ToDoItemStoreProtocolMock: ToDoItemStoreProtocol {
  var itemPublisher =
    CurrentValueSubject<[ToDoItem], Never>([])

  var checkLastCallArgument: ToDoItem?
  func check(_ item: ToDoItem) {
    checkLastCallArgument = item
  }
}
