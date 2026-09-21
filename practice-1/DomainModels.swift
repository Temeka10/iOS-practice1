//
//  DomainModels.swift
//  practice-1
//
//  Created by Artem Mandych on 21.09.2026.
//

import Foundation

// MARK: - Protocol
protocol Summarizable {
    var summary: String { get }
}

// MARK: - Enum
enum ReadingStatus: String {
    case unread = "Не прочитано"
    case reading = "Читаю"
    case finished = "Прочитано"
}

// MARK: - Struct
struct Book: Summarizable {
    let id: UUID // let (константа)
    let title: String
    let author: String
    var status: ReadingStatus // var (змінна, бо статус може змінюватись)
    
    // Ініціалізатор (init)
    init(title: String, author: String, status: ReadingStatus = .unread) {
        self.id = UUID()
        self.title = title
        self.author = author
        self.status = status
    }
    
    // Реалізація протоколу
    var summary: String {
        return "Книга: '\(title)' авторства \(author). Статус: \(status.rawValue)"
    }
}

// MARK: - Class
class Library {
    // Колекція (Масив)
    var books: [Book]
    
    init() {
        self.books = []
    }
    
    // Метод додавання
    func addBook(_ book: Book) {
        books.append(book)
        print("✅ Додано книгу: \(book.title)")
    }
    
    // Метод пошуку з Optional (повертає Book або nil)
    func findBook(by title: String) -> Book? {
        // Використання циклу та умовної конструкції
        for book in books {
            if book.title.lowercased() == title.lowercased() {
                return book
            }
        }
        return nil
    }
    
    // Фільтрація колекції
    func getFinishedBooks() -> [Book] {
        return books.filter { $0.status == .finished }
    }
}
