//
//  SessionManager.swift
//  GalleryApp
//
//  Created by Darshan Dangar on 25/05/24.
//

import Foundation

class SessionManager {
    
    private init() { }
    
    static let shared = SessionManager()
    
    @UserDefault("user", defaultValue: nil)
    var appUserData: Data?
    
    var appUser: User? {
        get {
            guard let appUserData else { return nil }
            return try? JSONDecoder().decode(User.self, from: appUserData)
        }
        set {
            appUserData = try? JSONEncoder().encode(newValue)
        }
    }
    
    @UserDefault("ImageData", defaultValue: nil)
    var ImageData: Data?
    
    var images: [Hit] {
        get {
            guard let ImageData else {return []}
            return try! JSONDecoder().decode([Hit].self, from: ImageData)
        }
        set {
            ImageData = try? JSONEncoder().encode(newValue)
        }
    }

}
