//  Created by Dominik Hauser on 18.02.22.
//  Copyright © 2022 dasdom. All rights reserved.
//

import UIKit

class ViewControllerMock: UIViewController {

  var lastPresented: UIViewController?

  override func present(
    _ viewControllerToPresent: UIViewController,
    animated flag: Bool,
    completion: (() -> Void)? = nil) {

    lastPresented = viewControllerToPresent
    super.present(viewControllerToPresent,
                  animated: flag,
                  completion: completion)
  }
}
