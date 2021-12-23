//  Created by Dominik Hauser on 22.12.21.
//  Copyright © 2021 dasdom. All rights reserved.
//

import SwiftUI

struct ToDoItemInputView: View {

  @ObservedObject var data: ToDoItemData
  @State var withDate = false

  var body: some View {
    TextField("Title", text: $data.title)
  }
}

struct ToDoItemInputView_Previews: PreviewProvider {
  static var previews: some View {
    ToDoItemInputView(data: ToDoItemData())
  }
}
