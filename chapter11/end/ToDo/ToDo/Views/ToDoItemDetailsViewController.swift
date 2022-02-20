//  Created by Dominik Hauser on 12.12.21.
//  Copyright © 2021 dasdom. All rights reserved.
//

import UIKit
import MapKit

class ToDoItemDetailsViewController: UIViewController {
  @IBOutlet var titleLabel: UILabel!
  @IBOutlet var dateLabel: UILabel!
  @IBOutlet var locationLabel: UILabel!
  @IBOutlet var descriptionLabel: UILabel!
  @IBOutlet var mapView: MKMapView!
  @IBOutlet var doneButton: UIButton!
  let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    return formatter
  }()
  var toDoItemStore: ToDoItemStoreProtocol?
  var toDoItem: ToDoItem? {
    didSet {
      titleLabel.text = toDoItem?.title
      if let timestamp = toDoItem?.timestamp {
        dateLabel.text = dateFormatter.string(
          from: Date(timeIntervalSince1970: timestamp))
      }
      locationLabel.text = toDoItem?.location?.name
      descriptionLabel.text = toDoItem?.itemDescription

      if let coorinate = toDoItem?.location?.coordinate {
        mapView.setCenter(
          CLLocationCoordinate2D(
            latitude: coorinate.latitude,
            longitude: coorinate.longitude),
          animated: false)
      }

      doneButton.isEnabled = (toDoItem?.done == false)
    }
  }

  @IBAction func checkItem(_ sender: UIButton) {
    if let toDoItem = toDoItem {
      toDoItemStore?.check(toDoItem)

      navigationController?.popViewController(animated: true)
    }
  }
}
