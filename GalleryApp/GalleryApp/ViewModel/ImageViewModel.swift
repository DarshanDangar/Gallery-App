//
//  ImageViewModel.swift
//  GalleryApp
//
//  Created by Darshan Dangar on 25/05/24.
//

import Foundation
import CoreData

class ImageViewModel: ObservableObject {
    
    @Published var images: GalleryResponse?
    
    func getImagesApi(request: GalleryRequest? = nil) {
        WebService.getResponseFromServer(method: .get, endPoint: .image, requestModel: request, responseModel: GalleryResponse.self) { status, message, response in
            if status == true {
                if request?.page == 1 {
                    self.images = response
                    SessionManager.shared.images = response?.hits ?? []
                } else {
                    self.images?.hits?.append(contentsOf: response?.hits ?? [])
                    SessionManager.shared.images.append(contentsOf: response?.hits ?? [])
                }
            }
        }
        
    }
    
}

extension ImageViewModel {
//    func addImages() {
//        _ = images?.hits?.compactMap({ data in
//            let newImages = ImageData(context: viewContext)
//            newImages.largeImageURL = data.largeImageURL
//            do {
//                try viewContext.save()
//            } catch {
//                // Handle errors gracefully, display error toast
//                print(error.localizedDescription)
//            }
//        })
//        
//    }
}
