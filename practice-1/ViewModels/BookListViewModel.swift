//
//  BookListViewModel.swift
//  practice-1
//
//  Created by Artem Mandych on 21.09.2026.
//

import Foundation
import Combine
// SOLID: Single Responsibility (Керує лише підготовкою даних для View)
class BookListViewModel: ObservableObject {
    @Published var books: [Book] = []
    private let service: LibraryServiceProtocol
    
    init(service: LibraryServiceProtocol) {
        self.service = service
    }
    
    func loadBooks() {
        self.books = service.fetchBooks()
    }
    
    func addBook(_ book: Book) {
        service.addBook(book)
        loadBooks() // Оновлюємо список
    }
    
    func toggleFavorite(for bookId: UUID) {
        service.toggleFavorite(for: bookId)
        loadBooks()
    }
}
