//
//  AppEnvironment.swift
//  GalleryApp
//
//  Created by Darshan Dangar on 25/05/24.
//

import Foundation

enum AppEnvironment: String {
    case baseURL = "https://pixabay.com/api/"
}

enum APIType: String {
    case image = ""
}

enum ApiMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
}

extension Encodable {
    var asData: Data? {
        return try? JSONEncoder().encode(self)
    }
}
