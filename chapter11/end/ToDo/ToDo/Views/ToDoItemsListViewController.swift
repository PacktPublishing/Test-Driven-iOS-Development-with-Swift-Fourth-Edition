//  Created by Dominik Hauser on 13.11.21.
//  Copyright © 2021 dasdom. All rights reserved.
//

import UIKit
import Combine

protocol ToDoItemsListViewControllerProtocol {
  func selectToDoItem(
    _ viewController: UIViewController,
    item: ToDoItem)
  func addToDoItem(
    _ viewController: UIViewController)
}

enum Section {
  case todo
  case done
}

class ToDoItemsListViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!
  var toDoItemStore: ToDoItemStoreProtocol?
  let dateFormatter = DateFormatter()
  private var items: [ToDoItem] = []
  private var token: AnyCancellable?
  private var dataSource:
    UITableViewDiffableDataSource<Section, ToDoItem>?
  var delegate: ToDoItemsListViewControllerProtocol?

  override func viewDidLoad() {
    super.viewDidLoad()

    dateFormatter.dateStyle = .short

    dataSource =
    UITableViewDiffableDataSource<Section, ToDoItem>(
      tableView: tableView,
      cellProvider: { [weak self] tableView, indexPath, item in

        let cell = tableView.dequeueReusableCell(
          withIdentifier: "ToDoItemCell",
          for: indexPath
        ) as! ToDoItemCell

        cell.titleLabel.text = item.title
        if let timestamp = item.timestamp {
          let date = Date(timeIntervalSince1970: timestamp)
          cell.dateLabel.text = self?.dateFormatter
            .string(from: date)
        }
        cell.locationLabel.text = item.location?.name

        return cell
      })

    token = toDoItemStore?.itemPublisher
      .sink(receiveValue: { [weak self] items in

        self?.items = items
        self?.update(with: items)
    })

    tableView.register(
      ToDoItemCell.self,
      forCellReuseIdentifier: "ToDoItemCell"
    )

    tableView.delegate = self

    let addItem = UIBarButtonItem(barButtonSystemItem: .add,
                                  target: self,
                                  action: #selector(add(_:)))
    navigationItem.rightBarButtonItem = addItem
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    token = toDoItemStore?.itemPublisher
      .sink(receiveValue: { [weak self] items in
        self?.items = items
        self?.update(with: items)
      })
  }
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)

    token?.cancel()
  }

  private func update(with items: [ToDoItem]) {
    var snapshot =
    NSDiffableDataSourceSnapshot<Section, ToDoItem>()
    snapshot.appendSections([.todo, .done])
    snapshot.appendItems(
      items.filter({ false == $0.done }),
      toSection: .todo)
    snapshot.appendItems(
      items.filter({ $0.done }),
      toSection: .done)
    dataSource?.apply(snapshot)
  }

  @objc func add(_ sender: UIBarButtonItem) {
    delegate?.addToDoItem(self)
  }
}

extension ToDoItemsListViewController:
  UITableViewDelegate {

  func tableView(_ tableView: UITableView,
                 didSelectRowAt indexPath: IndexPath) {

    let item: ToDoItem
    switch indexPath.section {
      case 0:
        let filteredItems = items.filter({ false == $0.done })
        item = filteredItems[indexPath.row]
      default:
        let filteredItems = items.filter({ true == $0.done })
        item = filteredItems[indexPath.row]
    }

    delegate?.selectToDoItem(self, item: item)
  }
}
