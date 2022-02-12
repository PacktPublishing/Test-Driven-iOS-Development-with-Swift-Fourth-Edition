//  Created by Dominik Hauser on 22.12.21.
//  Copyright © 2021 dasdom. All rights reserved.
//

import Foundation

class ToDoItemData: ObservableObject {
  @Published var title = ""
  @Published var date = Date()
  @Published var withDate = false
  @Published var itemDescription = ""
  @Published var locationName = ""
  @Published var addressString = ""
}
