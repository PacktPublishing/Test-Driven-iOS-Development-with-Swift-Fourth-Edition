//  Created by Dominik Hauser on 02.10.21.
//  
//

import Foundation
import CoreLocation

struct Location {
  let name: String
  let coordinate: CLLocationCoordinate2D?

  init(name: String,
       coordinate: CLLocationCoordinate2D? = nil) {

    self.name = name
    self.coordinate = coordinate
  }
}
