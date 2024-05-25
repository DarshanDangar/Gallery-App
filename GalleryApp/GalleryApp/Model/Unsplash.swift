//
//  Unsplash.swift
//  GalleryApp
//
//  Created by Darshan Dangar on 25/05/24.
//

import Foundation

// MARK: - UnsplashResponse
struct UnsplashResponse: Codable {
    let total, totalPages: Int?
    let results: [UnsplashResult]?

    enum CodingKeys: String, CodingKey {
        case total
        case totalPages = "total_pages"
        case results
    }
}

// MARK: - UnsplashResult
struct UnsplashResult: Codable {
    let id: String?
    let createdAt: String?
    let width, height: Int?
    let color, blurHash: String?
    let likes: Int?
    let likedByUser: Bool?
    let description: String?
    let urls: Urls?

    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case width, height, color
        case blurHash = "blur_hash"
        case likes
        case likedByUser = "liked_by_user"
        case description
        case urls
    }
}

// MARK: - Urls
struct Urls: Codable {
    let raw, full, regular, small: String?
    let thumb: String?
}

// MARK: - ProfileImage

struct ProfileImage: Codable {
  let small: URL
  let medium: URL
  let large: URL

  // MARK: - Decodable Keys

  enum CodingKeys: String, CodingKey {
    case small
    case medium
    case large
  }
}

// MARK: - UserLinks

struct UserLinks: Codable {
  let selfLink: String?
  let html: String?
  let photos: String?
  let likes: String?
  let portfolio: String?

  // MARK: - Decodable Keys

  enum CodingKeys: String, CodingKey {
    case selfLink = "self"
    case html
    case photos
    case likes
    case portfolio
  }
}

// MARK: - Urls

struct URLSS: Codable {
  let raw: URL
  let full: URL
  let regular: URL
  let small: URL
  let thumb: URL

  // MARK: - Decodable Keys

  enum CodingKeys: String, CodingKey {
    case raw
    case full
    case regular
    case small
    case thumb
  }
}

// MARK: - PhotoLinks

struct PhotoLinks: Codable {
  let selfLink: URL
  let html: URL
  let download: URL
  let downloadLocation: URL

  // MARK: - Decodable Keys

  enum CodingKeys: String, CodingKey {
    case selfLink = "self"
    case html
    case download
    case downloadLocation = "download_location"
  }
}

struct GalleryResponse: Codable, Identifiable {
    var id: UUID? = UUID()
    var total, totalHits: Int?
    var hits: [Hit]?
}

// MARK: - Hit
struct Hit: Codable, Identifiable, Equatable {
    var id: Int?
    var pageURL: String?
    var type: String?
    var tags: String?
    var previewURL: String?
    var previewWidth, previewHeight: Int?
    var webformatURL: String?
    var webformatWidth, webformatHeight: Int?
    var largeImageURL: String?
    var imageWidth, imageHeight, imageSize, views: Int?
    var downloads, collections, likes, comments: Int?
    var userID: Int?
    var user: String?
    var userImageURL: String?

    enum CodingKeys: String, CodingKey {
        case id, pageURL, type, tags, previewURL, previewWidth, previewHeight, webformatURL, webformatWidth, webformatHeight, largeImageURL, imageWidth, imageHeight, imageSize, views, downloads, collections, likes, comments
        case userID = "user_id"
        case user, userImageURL
    }
}

class GalleryRequest: Codable {
    var key = "43830858-6be145f2983ce27ed6d3ef30d"
    var page = 1
}
