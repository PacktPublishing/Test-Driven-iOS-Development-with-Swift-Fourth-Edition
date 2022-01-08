//  Created by Dominik Hauser on 30.12.21.
//  Copyright © 2021 dasdom. All rights reserved.
//

import Foundation

protocol APIClientProtocol {
  func coordinate(
    for: String,
    completion: (Coordinate?) -> Void)
}

class APIClient: APIClientProtocol {
  func coordinate(
    for: String,
    completion: (Coordinate?) -> Void) {

  }
}
