//  Created by Dominik Hauser on 06.02.22.
//  Copyright © 2022 dasdom. All rights reserved.
//

import UIKit
import SwiftUI

protocol Coordinator {
  func start()
}

class AppCoordinator: Coordinator {

  private let window: UIWindow?
  private let viewController: UIViewController
  private let navigationController: UINavigationController
  let toDoItemStore: ToDoItemStore

  init(window: UIWindow?,
       navigationController: UINavigationController =
       UINavigationController(),
       toDoItemStore: ToDoItemStore = ToDoItemStore()) {

    self.window = window
    self.navigationController = navigationController
    self.toDoItemStore = toDoItemStore

    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    viewController = storyboard.instantiateViewController(
      withIdentifier: "ToDoItemsListViewController")
  }

  func start() {
    navigationController.pushViewController(viewController,
                                            animated: false)
    window?.rootViewController = navigationController

    if let listViewController =
        viewController as? ToDoItemsListViewController {

      listViewController.delegate = self
      listViewController.toDoItemStore = toDoItemStore
    }
  }
}

extension AppCoordinator:
  ToDoItemsListViewControllerProtocol {
  func selectToDoItem(_ viewController: UIViewController,
                      item: ToDoItem) {

    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    guard let next = storyboard.instantiateViewController(
      withIdentifier: "ToDoItemDetailsViewController")
            as? ToDoItemDetailsViewController else {
              return
            }

    next.loadViewIfNeeded()
    next.toDoItem = item
    next.toDoItemStore = toDoItemStore

    navigationController.pushViewController(next,
                                            animated: true)
  }

  func addToDoItem(_ viewController: UIViewController) {
    let data = ToDoItemData()
    let next = UIHostingController(
      rootView: ToDoItemInputView(data: data,
                                  apiClient: APIClient(),
                                  delegate: self))

    viewController.present(next, animated: true)
  }
}

extension AppCoordinator: ToDoItemInputViewDelegate {
  func addToDoItem(with item: ToDoItemData,
                   coordinate: Coordinate?) {

    let location = Location(name: item.locationName,
                            coordinate: coordinate)
    let toDoItem = ToDoItem(
      title: item.title,
      itemDescription: item.itemDescription,
      timestamp: item.date.timeIntervalSince1970,
      location: location)

    toDoItemStore.add(toDoItem)

    navigationController.dismiss(animated: true)
  }
}
