//
//  APIConfig.swift
//  Dragon Ride
//
//  Created by troquer on 7/18/21.
//  Copyright © 2021 Andrés A. All rights reserved.
//

import Foundation

enum RESTMethod: String {
    case get = "get"
    case post = "post"
}
protocol Target {
    var path: String {get}
}
enum DragonsTarget: Target {
    case current
    case rideDetails(Int)
    
    var path: String {
        switch self {
        case .current:
            return ""
        case let .rideDetails(id):
            return "detail/\(id)/"
        }
    }
    
    func makeURL() -> URL? {
        var urlComponents = APIConfig.baseURL
        urlComponents.path = self.path
        guard let url = urlComponents.url else {
            print("Error create url")
            return nil
        }
        return url
    }
    
}

final class APIConfig {
    
    static let host = Environment.baseURL
    static let scheme = "http"
    
    static var baseURL: URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        return urlComponents
    }
}

extension URLComponents {
    mutating func setQueryItems<T: LosslessStringConvertible>(with parameters: [String: T]) {
        self.queryItems = parameters.map { URLQueryItem(name: $0.key, value: String($0.value)) }
    }
}

