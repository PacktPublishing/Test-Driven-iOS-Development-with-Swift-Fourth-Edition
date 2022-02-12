//  Created by Dominik Hauser on 06.02.22.
//  Copyright © 2022 dasdom. All rights reserved.
//

import XCTest
@testable import ToDo

class AppSetupTests: XCTestCase {

  func test_application_shouldSetupRoot() throws {
    let application = UIApplication.shared
    let scene = application.connectedScenes.first
    as? UIWindowScene
    let root = scene?.windows.first?.rootViewController

    let nav = try XCTUnwrap(root as? UINavigationController)
    XCTAssert(nav.topViewController
              is ToDoItemsListViewController)
  }
}
