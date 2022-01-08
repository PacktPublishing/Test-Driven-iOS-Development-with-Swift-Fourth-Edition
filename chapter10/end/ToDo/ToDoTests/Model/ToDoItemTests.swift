//  Created by Dominik Hauser on 01.10.21.
//  
//


import XCTest
@testable import ToDo

class ToDoItemTests: XCTestCase {

  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }

  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

  func test_init_whenGivenTitle_setsTitle() {
    let item = ToDoItem(title: "Dummy")
    XCTAssertEqual(item.title, "Dummy")
  }

  func test_init_whenGivenDescription_setsDescription() {
    let item = ToDoItem(title: "Dummy",
                        itemDescription: "Dummy Description")
    XCTAssertEqual(item.itemDescription, "Dummy Description")
  }

  func test_init_setsTimestamp() throws {
    let dummyTimestamp: TimeInterval = 42.0
    let item = ToDoItem(title: "Dummy",
                        timestamp: dummyTimestamp)

    let timestamp = try XCTUnwrap(item.timestamp)
    XCTAssertEqual(timestamp,
                   dummyTimestamp,
                   accuracy: 0.000_001)
  }

  func test_init_whenGivenLocation_setsLocation() {
    let dummyLocation = Location(name: "Dummy Name")
    let item = ToDoItem(title: "Dummy Title",
                        location: dummyLocation)

    XCTAssertEqual(item.location?.name,
                   dummyLocation.name)
  }
}
