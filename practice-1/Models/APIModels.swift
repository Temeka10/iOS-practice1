//
//  APIModels.swift
//  practice-1
//
//  Created by Artem Mandych on 23.09.2026.
//

import Foundation

// Моделі для декодування JSON з Open Library API
struct OpenLibraryResponse: Decodable {
    let docs: [OpenLibraryBook]
}

struct OpenLibraryBook: Decodable {
    let title: String
    let author_name: [String]?
    let first_publish_year: Int?
}
