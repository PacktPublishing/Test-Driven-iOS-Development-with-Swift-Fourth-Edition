//  Created by Dominik Hauser on 22.01.22.
//  Copyright © 2022 dasdom. All rights reserved.
//

import Foundation
@testable import ToDo

class URLSessionProtocolMock: URLSessionProtocol {

  var dataForDelegateReturnValue: (Data, URLResponse)?
  var dataForDelegateRequest: URLRequest?
  var dataForDelegateError: Error?

  func data(for request: URLRequest,
            delegate: URLSessionTaskDelegate?)
  async throws -> (Data, URLResponse) {

    if let error = dataForDelegateError {
      throw error
    }

    dataForDelegateRequest = request

    guard let dataForDelegateReturnValue =
            dataForDelegateReturnValue else {
              fatalError()
            }
    return dataForDelegateReturnValue
  }
}
