//  Created by Dominik Hauser on 30.12.21.
//  Copyright © 2021 dasdom. All rights reserved.
//

import Foundation
import CoreLocation

protocol APIClientProtocol {
  func coordinate(
    for: String,
    completion: @escaping (Coordinate?) -> Void)
}

protocol GeoCoderProtocol {
  func geocodeAddressString(
    _ addressString: String,
    completionHandler:
    @escaping CLGeocodeCompletionHandler)
}

protocol URLSessionProtocol {
  func data(for request: URLRequest,
            delegate: URLSessionTaskDelegate?)
  async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {}

extension CLGeocoder: GeoCoderProtocol {}

class APIClient: APIClientProtocol {

  lazy var geoCoder: GeoCoderProtocol
  = CLGeocoder()
  lazy var session: URLSessionProtocol
  = URLSession.shared

  func coordinate(
    for string: String,
    completion: @escaping (Coordinate?) -> Void) {
      geoCoder.geocodeAddressString(string) { placemarks, error in
        guard let clCoordinate = placemarks?.first?.location?.coordinate
        else {
          completion(nil)
          return
        }
        let coordinate = Coordinate(
          latitude: clCoordinate.latitude,
          longitude: clCoordinate.longitude)
        completion(coordinate)
      }
    }

  func toDoItems() async throws -> [ToDoItem] {
    guard let url =
            URL(string: "http://toodoo.app/items")
    else {
      return []
    }
    let request = URLRequest(url: url)
    let (data, _) = try await session.data(
      for: request,
         delegate: nil)
    let items = try JSONDecoder()
      .decode([ToDoItem].self, from: data)
    return items
  }
}
