//  Created by Dominik Hauser on 10.12.21.
//  Copyright © 2021 dasdom. All rights reserved.
//

import UIKit
@testable import ToDo

class ToDoItemsListViewControllerProtocolMock:
  ToDoItemsListViewControllerProtocol {

  var selectToDoItemReceivedArguments:
  (viewController: UIViewController,
   item: ToDoItem)?

  func selectToDoItem(
    _ viewController: UIViewController,
    item: ToDoItem) {

      selectToDoItemReceivedArguments =
      (viewController, item)
    }
}
