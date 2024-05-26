//
//  GalleryAppApp.swift
//  GalleryApp
//
//  Created by Darshan Dangar on 25/05/24.
//

import SwiftUI

@main
struct GalleryAppApp: App {
    
    private var imageManager = ImageDataManager()

    var body: some Scene {
        WindowGroup {
            SplashVC()
                .environmentObject(imageManager)
                .environment(\.managedObjectContext, imageManager.container.viewContext)
        }
    }
}
