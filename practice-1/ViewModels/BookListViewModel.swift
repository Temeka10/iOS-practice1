//
//  BookListViewModel.swift
//  practice-1
//
//  Created by Artem Mandych on 21.09.2026.
//

import Foundation
import Combine

// Стани нашого екрана
enum ViewState {
    case idle
    case loading
    case success
    case empty
    case error(String)
}

@MainActor // Оновлення UI завжди на головному потоці
class BookListViewModel: ObservableObject {
    @Published var books: [Book] = []
    @Published var state: ViewState = .idle
    
    private let service: LibraryServiceProtocol
    private let sortStrategy: SortStrategy
    
    init(service: LibraryServiceProtocol, sortStrategy: SortStrategy = TitleSortStrategy()) {
        self.service = service
        self.sortStrategy = sortStrategy
    }
    
    func loadBooks() {
        state = .loading // Показуємо лоадер
        
        // Запускаємо асинхронну задачу
        Task {
            do {
                let fetchedBooks = try await service.fetchBooks()
                
                if fetchedBooks.isEmpty {
                    self.state = .empty
                } else {
                    self.books = sortStrategy.sort(fetchedBooks)
                    self.state = .success
                }
            } catch {
                self.state = .error(error.localizedDescription)
            }
        }
    }
    
    func addBook(_ book: Book) {
        service.addBook(book)
        self.books.append(book)
    }
    
    func toggleFavorite(for bookId: UUID) {
        service.toggleFavorite(for: bookId)
        if let index = books.firstIndex(where: { $0.id == bookId }) {
            books[index].isFavorite.toggle()
        }
    }
}
