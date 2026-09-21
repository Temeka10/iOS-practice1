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
    
    // Залежимо від абстракції (Dependency Inversion)
    private let service: LibraryServiceProtocol
    private let sortStrategy: SortStrategy
    
    init(service: LibraryServiceProtocol, sortStrategy: SortStrategy) {
        self.service = service
        self.sortStrategy = sortStrategy
    }
    
    func loadBooks() {
        let fetchedBooks = service.fetchBooks()
        // Використання патерну Strategy
        self.books = sortStrategy.sort(fetchedBooks)
    }
}
