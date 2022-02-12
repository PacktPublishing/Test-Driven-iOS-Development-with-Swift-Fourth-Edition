//  Created by Dominik Hauser on 06.02.22.
//  Copyright © 2022 dasdom. All rights reserved.
//

import UIKit

protocol Coordinator {
  func start()
}

class AppCoordinator: Coordinator {

  private let window: UIWindow?
  private let viewController: UIViewController
  private let navigationController: UINavigationController

  init(window: UIWindow?,
       navigationController: UINavigationController =
       UINavigationController()) {

    self.window = window
    self.navigationController = navigationController

    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    viewController = storyboard.instantiateViewController(
      withIdentifier: "ToDoItemsListViewController")
  }

  func start() {
    navigationController.pushViewController(viewController,
                                            animated: false)
    window?.rootViewController = navigationController
  }
}
