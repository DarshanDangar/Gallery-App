//
//  User.swift
//  GalleryApp
//
//  Created by Darshan Dangar on 25/05/24.
//

import Foundation

struct User: Codable {
    var userId: String?
    var name: String?
    var email: String?
    var givenName: String?
    var profilePicUrl: URL?
}
