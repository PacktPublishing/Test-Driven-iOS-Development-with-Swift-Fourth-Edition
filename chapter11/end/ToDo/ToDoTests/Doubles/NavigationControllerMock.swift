//  Created by Dominik Hauser on 12.02.22.
//  Copyright © 2022 dasdom. All rights reserved.
//

import UIKit

class NavigationControllerMock: UINavigationController {
  var lastPushedViewController: UIViewController?

  override func pushViewController(
    _ viewController: UIViewController,
    animated: Bool) {

      lastPushedViewController = viewController
      super.pushViewController(viewController,
                               animated: animated)
    }

  var popViewControllerCount = 0

  override func popViewController(animated: Bool) -> UIViewController? {
    popViewControllerCount += 1
    return super.popViewController(animated: animated)
  }

  var dismissCallCount = 0

  override func dismiss(animated flag: Bool,
                        completion: (() -> Void)? = nil) {
    dismissCallCount += 1
    super.dismiss(animated: flag,
                  completion: completion)
  }
}
