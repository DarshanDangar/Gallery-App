//
//  ImageDataManager.swift
//  GalleryApp
//
//  Created by Darshan Dangar on 25/05/24.
//

import Foundation
import CoreData

class ImageDataManager: NSObject, ObservableObject {
    
    @Published var imageList: [Hit] = []
    
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "GalleryApp")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    func saveImages(data: [Hit]) {
        _ = data.compactMap({ data in
            let newImages = ImageData(context: container.viewContext)
            newImages.largeImageURL = data.largeImageURL
            do {
                try container.viewContext.save()
            } catch {
                // Handle errors gracefully, display error toast
                print(error.localizedDescription)
            }
        })
    }
    
    
}
