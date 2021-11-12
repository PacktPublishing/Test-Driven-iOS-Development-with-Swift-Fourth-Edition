//  Created by Dominik Hauser on 08.10.21.
//  
//

import XCTest
@testable import ToDo
import Combine

class ToDoItemStoreTests: XCTestCase {

  var sut: ToDoItemStore!

  override func setUpWithError() throws {
    sut = ToDoItemStore(fileName: "dummy_store")
  }

  override func tearDownWithError() throws {
    sut = nil
    
    let url = FileManager.default
      .documentsURL(name: "dummy_store")

    try? FileManager.default.removeItem(at: url)
  }

  func test_add_shouldPublishChange() throws {
    let toDoItem = ToDoItem(title: "Dummy")
    let receivedItems = try wait(for: sut.itemPublisher) {
      sut.add(toDoItem)
    }

    XCTAssertEqual(receivedItems, [toDoItem])
  }

  func test_check_shouldPublishChangeInDoneItems() throws {
    let toDoItem = ToDoItem(title: "Dummy")
    sut.add(toDoItem)
    sut.add(ToDoItem(title: "Dummy 2"))

    let receivedItems = try wait(for: sut.itemPublisher) {
      sut.check(toDoItem)
    }

    let doneItems = receivedItems.filter({ $0.done })
    XCTAssertEqual(doneItems, [toDoItem])
  }

  func test_init_shouldLoadPreviousToDoItems() throws {
    var sut1: ToDoItemStore? =
      ToDoItemStore(fileName: "dummy_store")
    let publisherExpectation = expectation(
      description: "Wait for publisher in \(#file)"
    )

    let toDoItem = ToDoItem(title: "Dummy Title")
    sut1?.add(toDoItem)
    sut1 = nil
    let sut2 = ToDoItemStore(fileName: "dummy_store")
    var result: [ToDoItem]?
    let token = sut2.itemPublisher
      .sink { value in
        result = value
        publisherExpectation.fulfill()
      }

    wait(for: [publisherExpectation], timeout: 1)
    token.cancel()
    XCTAssertEqual(result, [toDoItem])
  }

  func test_init_whenItemIsChecked_shouldLoadPreviousToDoItems() throws {
    var sut1: ToDoItemStore? =
    ToDoItemStore(fileName: "dummy_store")
    let publisherExpectation = expectation(
      description: "Wait for publisher in \(#file)"
    )

    let toDoItem = ToDoItem(title: "Dummy Title")
    sut1?.add(toDoItem)
    sut1?.check(toDoItem)
    sut1 = nil
    let sut2 = ToDoItemStore(fileName: "dummy_store")
    var result: [ToDoItem]?
    let token = sut2.itemPublisher
      .sink { value in
        result = value
        publisherExpectation.fulfill()
      }

    wait(for: [publisherExpectation], timeout: 1)
    token.cancel()
    XCTAssertEqual(result?.first?.done, true)
  }
}

extension XCTestCase {
  func wait<T: Publisher>(
    for publisher: T,
    afterChange change: () -> Void,
    file: StaticString = #file,
    line: UInt = #line) throws
  -> T.Output where T.Failure == Never {

    let publisherExpectation = expectation(
      description: "Wait for publisher in \(#file)"
    )

    var result: T.Output?
    let token = publisher
      .dropFirst()
      .sink { value in
        result = value
        publisherExpectation.fulfill()
      }

    change()

    wait(for: [publisherExpectation], timeout: 1)
    token.cancel()

    let unwrappedResult = try XCTUnwrap(
      result,
      "Publisher did not publish any value",
      file: file,
      line: line
    )

    return unwrappedResult
  }
}
