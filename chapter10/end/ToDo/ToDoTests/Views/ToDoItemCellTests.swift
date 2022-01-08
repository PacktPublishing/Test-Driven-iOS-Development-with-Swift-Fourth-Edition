//  Created by Dominik Hauser on 28.11.21.
//  Copyright © 2021 dasdom. All rights reserved.
//

import XCTest
@testable import ToDo

class ToDoItemCellTests: XCTestCase {

  var sut: ToDoItemCell!

  override func setUpWithError() throws {
    sut = ToDoItemCell()
  }

  override func tearDownWithError() throws {
    sut = nil
  }

  func test_hasTitleLabelSubview() {
    let subview = sut.titleLabel
    XCTAssertTrue(subview.isDescendant(of: sut.contentView))
  }

  func test_hasDateLabelSubview() {
    let subview = sut.dateLabel
    XCTAssertTrue(subview.isDescendant(of: sut.contentView))
  }

  func test_hasLocationLabelSubview() {
    let subview = sut.locationLabel
    XCTAssertTrue(subview.isDescendant(of: sut.contentView))
  }
}
