//
//  DomainModels.swift
//  practice-1
//
//  Created by Artem Mandych on 21.09.2026.
//

import Foundation

enum ReadingStatus: String {
    case unread = "Не прочитано"
    case reading = "Читаю"
    case finished = "Прочитано"
}

struct Book: Identifiable {
    let id: UUID
    let title: String
    let author: String
    var status: ReadingStatus
    var publishedYear: Int?
}
