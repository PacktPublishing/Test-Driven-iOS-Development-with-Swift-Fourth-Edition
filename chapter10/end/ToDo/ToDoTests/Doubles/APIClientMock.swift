//  Created by Dominik Hauser on 30.12.21.
//  Copyright © 2021 dasdom. All rights reserved.
//

import Foundation
@testable import ToDo

class APIClientMock: APIClientProtocol {

  var coordinateAddress: String?
  var coordinateReturnValue: Coordinate?

  func coordinate(
    for address: String,
    completion: (Coordinate?) -> Void) {

      coordinateAddress = address
      completion(coordinateReturnValue)
  }
}
