//  Created by Dominik Hauser on 15.01.22.
//  Copyright © 2022 dasdom. All rights reserved.
//

import Foundation
@testable import ToDo
import CoreLocation

class GeoCoderProtocolMock: GeoCoderProtocol {

  var geocodeAddressString: String?
  var completionHandler: CLGeocodeCompletionHandler?

  func geocodeAddressString(
    _ addressString: String,
    completionHandler:
    @escaping CLGeocodeCompletionHandler) {

      geocodeAddressString = addressString
      self.completionHandler = completionHandler
  }
}
