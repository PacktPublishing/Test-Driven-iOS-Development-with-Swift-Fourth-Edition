//  Created by Dominik Hauser on 08.10.21.
//  
//

import Foundation
import Combine

protocol ToDoItemStoreProtocol {
  var itemPublisher:
    CurrentValueSubject<[ToDoItem], Never>
      { get set }
  func check(_: ToDoItem)
}

class ToDoItemStore: ToDoItemStoreProtocol {
  var itemPublisher =
    CurrentValueSubject<[ToDoItem], Never>([])
  private var items: [ToDoItem] = [] {
    didSet {
      itemPublisher.send(items)
    }
  }
  private let fileName: String

  init(fileName: String = "todoitems") {
    self.fileName = fileName
    loadItems()
  }

  func add(_ item: ToDoItem) {
    items.append(item)
    saveItems()
  }

  func check(_ item: ToDoItem) {
    var mutableItem = item
    mutableItem.done = true
    if let index = items.firstIndex(of: item) {
      items[index] = mutableItem
      saveItems()
    }
  }

  private func saveItems() {
    let url = FileManager.default
      .documentsURL(name: fileName)

    do {
      let data = try JSONEncoder().encode(items)
      try data.write(to: url)
    } catch {
      print("error: \(error)")
    }
  }

  private func loadItems() {
    let url = FileManager.default
      .documentsURL(name: fileName)

    do {
      let data = try Data(contentsOf: url)
      items = try JSONDecoder()
        .decode([ToDoItem].self, from: data)
    } catch {
      print("error: \(error)")
    }
  }
}
