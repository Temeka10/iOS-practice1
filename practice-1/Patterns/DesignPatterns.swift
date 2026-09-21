//
//  DesignPatterns.swift
//  practice-1
//
//  Created by Artem Mandych on 21.09.2026.
//

import Foundation

// MARK: - 1. Породжувальний патерн: Builder
class BookBuilder {
    private var title: String = "Невідомо"
    private var author: String = "Невідомо"
    private var status: ReadingStatus = .unread
    private var publishedYear: Int?
    
    func setTitle(_ title: String) -> BookBuilder { self.title = title; return self }
    func setAuthor(_ author: String) -> BookBuilder { self.author = author; return self }
    func setStatus(_ status: ReadingStatus) -> BookBuilder { self.status = status; return self }
    func setYear(_ year: Int) -> BookBuilder { self.publishedYear = year; return self }
    
    func build() -> Book {
        return Book(id: UUID(), title: title, author: author, status: status, publishedYear: publishedYear)
    }
}

// MARK: - 2. Структурний патерн: Adapter
struct LegacyBookData {
    let name: String
    let writerName: String
    let isRead: Bool
}

class LegacyBookAdapter {
    static func adapt(_ legacy: LegacyBookData) -> Book {
        return BookBuilder()
            .setTitle(legacy.name)
            .setAuthor(legacy.writerName)
            .setStatus(legacy.isRead ? .finished : .unread)
            .build()
    }
}

// MARK: - 3. Поведінковий патерн: Strategy
protocol SortStrategy {
    func sort(_ books: [Book]) -> [Book]
}

struct TitleSortStrategy: SortStrategy {
    func sort(_ books: [Book]) -> [Book] {
        return books.sorted { $0.title < $1.title }
    }
}
