//  Created by Dominik Hauser on 13.08.21.
//  
//

import XCTest
@testable import FirstDemo
import SwiftUI

class FirstDemoTests: XCTestCase {

  var blogger: Blogger!

  override func setUpWithError() throws {
    blogger = Blogger()
  }

  override func tearDownWithError() throws {
    blogger = nil
  }

  func test_numberOfVowels_whenGivenDominik_shouldReturn3() {
    let viewController = ViewController()

    let result = viewController.numberOfVowels(in: "Dominik")

    XCTAssertEqual(result, 3,
                   "Expected 3 vowels in 'Dominik' but got \(result)")
  }

  func test_makeHeadline_shouldCapitalisePassedInString() {
    let input = "the Accessibility inspector"

    let result = blogger.makeHeadline(from: input)

    let expected = "The Accessibility Inspector"
    XCTAssertEqual(result, expected)
  }

  func test_makeHeadline_shouldCapitalisePassedInString_2() {
    let input = "The contextual action menu"

    let result = blogger.makeHeadline(from: input)

    let expected = "The Contextual Action Menu"
    XCTAssertEqual(result, expected)
  }
}

func DDHAssertEqual<A: Equatable, B: Equatable>(
  _ first: [A:B],
  _ second: [A:B],
  file: StaticString = #filePath,
  line: UInt = #line) {

    if first == second {
      return
    }

    for key in first.keys {

      if first[key] != second[key] {
        let value1 = String(describing: first[key]!)
        let value2 = String(describing: second[key]!)
        let keyValue1 = "\"\(key)\": \(value1)"
        let keyValue2 = "\"\(key)\": \(value2)"
        let message = "\(keyValue1) is not equal to \(keyValue2)"
        XCTFail(message, file: file, line: line)
        return
      }
    }
  }
