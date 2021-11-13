//  Created by Dominik Hauser on 13.11.21.
//  
//

import XCTest
@testable import ToDo

class ToDoItemsListViewControllerTests: XCTestCase {

  var sut: ToDoItemsListViewController!

  override func setUpWithError() throws {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    sut = try XCTUnwrap(
      storyboard.instantiateInitialViewController()
      as? ToDoItemsListViewController
    )
    sut.loadViewIfNeeded()
  }

  override func tearDownWithError() throws {
    sut = nil
  }

  func test_shouldHaveTableView() {
    XCTAssertTrue(sut.tableView.isDescendant(of: sut.view))
  }
}
