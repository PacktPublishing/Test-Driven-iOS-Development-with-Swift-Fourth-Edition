//  Created by Dominik Hauser on 06.11.21.
//  
//

import Foundation

extension FileManager {
  func documentsURL(name: String) -> URL {
    guard let documentsURL = urls(for: .documentDirectory,
                                     in: .userDomainMask).first else {
      fatalError()
    }
    return documentsURL.appendingPathComponent(name)
  }
}
