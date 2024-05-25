//
//  WebService.swift
//  GalleryApp
//
//  Created by Darshan Dangar on 25/05/24.
//

import Foundation
import Combine

struct EmptyCodable: Codable {
//    44065942-9c4f4af44fa984d6b39cc5e6a
}

//class UnsplashAPIClient {
//  private let baseUrl = URL(string: "https://api.unsplash.com/")!
//  private let accessKey: String // Replace with your Unsplash access key
//
//  init(accessKey: String) {
//    self.accessKey = accessKey
//  }
//
//  func getPhotos(query: String) -> AnyPublisher<[Photo], Error> {
//    let url = baseUrl.appendingPathComponent("search/photos")
//    var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
//    components.queryItems = [
//      URLQueryItem(name: "client_id", value: accessKey),
//      URLQueryItem(name: "query", value: query),
//    ]
//
//    return URLSession.shared.dataTaskPublisher(for: components.url!)
//      .map { $0.data }
//      .decode(type: [Photo].self, decoder: JSONDecoder())
//      .eraseToAnyPublisher()
//  }
//}

class WebService {
    
    class func getResponseFromServer<E: Codable, C: Codable>(method: ApiMethod, endPoint: APIType, requestModel: E? = nil, responseModel: C.Type, _ completion: @escaping ((_ status: Bool, _ message: String?, _ response: C?) -> Void)) {
        guard var url = URL(string: AppEnvironment.baseURL.rawValue + endPoint.rawValue) else {
            completion(false, "Invalid url", nil)
            return
        }
        
        if method == .get {
            if let data = requestModel?.asData, let paramDict = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
                if let urlWithParam = url.appendingQueryParameters(paramDict) {
                    url = urlWithParam
                }
            }
        }
        let apiRequest = URLRequest(url: url)
        print("API Request", apiRequest)
        
        if !Reachability.isConnectedToNetwork() {
            print(self, "No Internet")
            return
        }
        
        URLSession.shared.dataTask(with: apiRequest) { data, response, error in
            DispatchQueue.main.async {
                guard error == nil else {
                    completion(false, error?.localizedDescription, nil)
                    return
                }
                
                print("Received Data:")
                if let stringData = String(data: data ?? Data(), encoding: .utf8) {
                        print(stringData) // Print as string
                      } else {
                        print(data) // Print raw data bytes (fallback)
                      }
                
                print(try? JSONDecoder().decode(C.self, from: data ?? Data()) )
                
                guard let data else {
                    completion(false, "Data not found", nil)
                    return
                }
                
                guard let object = try? JSONDecoder().decode(C.self, from: data) else {
                    completion(false, "Data not parse", nil)
                    return
                }
                                
                completion(true, "Success", object)
            }
        }.resume()
    }
    
}

extension URL {
    
    func appendingQueryParameters(_ parameters: [String: Any]) -> URL? {
        guard var components = URLComponents(url: self, resolvingAgainstBaseURL: true) else {
            return nil
        }

        components.queryItems = parameters.map { key, value in
            URLQueryItem(name: key, value: "\(value)")
        }

        return components.url
    }
    
}

