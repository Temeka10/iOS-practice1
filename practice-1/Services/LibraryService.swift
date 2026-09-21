//
//  LibraryService.swift
//  practice-1
//
//  Created by Artem Mandych on 21.09.2026.
//

import Foundation

protocol LibraryServiceProtocol {
    func fetchBooks() -> [Book]
    func addBook(_ book: Book)
    func toggleFavorite(for id: UUID)
}

class MockLibraryService: LibraryServiceProtocol {
    // Зберігаємо стан у пам'яті під час роботи застосунку
    private var books: [Book] = [
        Book(id: UUID(), title: "1984", author: "Джордж Оруелл", status: .finished),
        Book(id: UUID(), title: "Кобзар", author: "Тарас Шевченко", status: .unread)
    ]
    
    func fetchBooks() -> [Book] { return books }
    
    func addBook(_ book: Book) { books.append(book) }
    
    func toggleFavorite(for id: UUID) {
        if let index = books.firstIndex(where: { $0.id == id }) {
            books[index].isFavorite.toggle()
        }
    }
}
