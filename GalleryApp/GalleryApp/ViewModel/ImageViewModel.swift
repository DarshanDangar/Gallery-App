//
//  ImageViewModel.swift
//  GalleryApp
//
//  Created by Darshan Dangar on 25/05/24.
//

import Foundation

class ImageViewModel: ObservableObject {
    
    @Published var images: GalleryResponse?
    
    func getImagesApi(request: GalleryRequest? = nil) {
        WebService.getResponseFromServer(method: .get, endPoint: .image, requestModel: request, responseModel: GalleryResponse.self) { status, message, response in
            if status == true {
                if request?.page == 1 {
                    self.images = response
                } else {
                    self.images?.hits?.append(contentsOf: response?.hits ?? [])
                }
            }
        }
        
    }
    
}
