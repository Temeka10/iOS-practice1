//
//  DomainModels.swift
//  practice-1
//
//  Created by Artem Mandych on 21.09.2026.
//

import Foundation

import Foundation

enum ReadingStatus: String, CaseIterable, Hashable {
    case unread = "Не прочитано"
    case reading = "Читаю"
    case finished = "Прочитано"
}

// Додали Hashable та isFavorite (для анімації)
struct Book: Identifiable, Hashable {
    let id: UUID
    var title: String
    var author: String
    var status: ReadingStatus
    var publishedYear: Int?
    var isFavorite: Bool = false
}
