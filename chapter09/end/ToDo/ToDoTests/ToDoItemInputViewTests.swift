//  Created by Dominik Hauser on 22.12.21.
//  Copyright © 2021 dasdom. All rights reserved.
//

import XCTest
@testable import ToDo
import ViewInspector

extension ToDoItemInputView: Inspectable {}

class ToDoItemInputViewTests: XCTestCase {

  var sut: ToDoItemInputView!
  var toDoItemData: ToDoItemData!

  override func setUpWithError() throws {
    toDoItemData = ToDoItemData()
    sut = ToDoItemInputView(data: toDoItemData)
  }

  override func tearDownWithError() throws {
    sut = nil
    toDoItemData = nil
  }

  func test_shouldAllowTitleInput() throws {
    let expected = "dummy title"
    try sut
      .inspect()
      .find(ViewType.TextField.self)
      .setInput(expected)

    let input = toDoItemData.title

    XCTAssertEqual(input, expected)
  }

  func test_shouldAllowDateInput() throws {
    let expected = Date()
    try sut
      .inspect()
      .find(ViewType.DatePicker.self)
      .select(date: expected)

    let input = toDoItemData.date

    XCTAssertEqual(input, expected)
  }
}
