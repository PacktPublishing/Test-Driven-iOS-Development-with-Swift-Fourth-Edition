//  Created by Dominik Hauser on 13.11.21.
//  Copyright © 2021 dasdom. All rights reserved.
//

import UIKit
import Combine

class ToDoItemsListViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!
  var toDoItemStore: ToDoItemStoreProtocol?
  let dateFormatter = DateFormatter()
  private var items: [ToDoItem] = []
  private var token: AnyCancellable?

  override func viewDidLoad() {
    super.viewDidLoad()

    tableView.dataSource = self

    token = toDoItemStore?.itemPublisher
      .sink(receiveValue: { [weak self] items in

        self?.items = items
    })

    tableView.register(
      ToDoItemCell.self,
      forCellReuseIdentifier: "ToDoItemCell"
    )
  }
}

extension ToDoItemsListViewController:
  UITableViewDataSource {

  func tableView(
    _ tableView: UITableView,
    numberOfRowsInSection section: Int) -> Int {

      return items.count
    }

  func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath) -> UITableViewCell {

      let cell = tableView.dequeueReusableCell(
        withIdentifier: "ToDoItemCell",
        for: indexPath
      ) as! ToDoItemCell

      let item = items[indexPath.row]
      cell.titleLabel.text = item.title
      if let timestamp = item.timestamp {
        let date = Date(timeIntervalSince1970: timestamp)
        cell.dateLabel.text = dateFormatter.string(from: date)
      }

      return cell
    }
}
