//
//  LibraryService.swift
//  practice-1
//
//  Created by Artem Mandych on 21.09.2026.
//

import Foundation

protocol LibraryServiceProtocol {
    // Тепер отримання даних асинхронне і може викинути помилку (throws)
    func fetchBooks() async throws -> [Book]
    
    func addBook(_ book: Book)
    func toggleFavorite(for id: UUID)
}

class RemoteLibraryService: LibraryServiceProtocol {
    private var localBooks: [Book] = []
    
    func fetchBooks() async throws -> [Book] {
        // 1. Формуємо URL (Шукаємо книги про iOS)
        guard let url = URL(string: "https://openlibrary.org/search.json?q=ios+development&limit=10") else {
            throw NetworkError.invalidURL
        }
        
        do {
            // 2. Виконуємо запит
            let (data, response) = try await URLSession.shared.data(from: url)
            
            // 3. Перевіряємо HTTP-статус
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.invalidResponse(0)
            }
            guard (200...299).contains(httpResponse.statusCode) else {
                throw NetworkError.invalidResponse(httpResponse.statusCode)
            }
            
            // 4. Декодуємо дані (Decodable)
            let decodedResponse = try JSONDecoder().decode(OpenLibraryResponse.self, from: data)
            
            // 5. Перетворюємо DTO на наші доменні моделі (Adapter Pattern)
            let books = decodedResponse.docs.map {
                Book(id: UUID(),
                     title: $0.title,
                     author: $0.author_name?.first ?? "Невідомий автор",
                     status: .unread,
                     publishedYear: $0.first_publish_year)
            }
            
            self.localBooks = books
            return books
            
        } catch let error as DecodingError {
            throw NetworkError.decodingError(error)
        } catch let error as NetworkError {
            throw error
        } catch {
            throw NetworkError.transportError(error)
        }
    }
    
    func addBook(_ book: Book) { localBooks.append(book) }
    
    func toggleFavorite(for id: UUID) {
        if let index = localBooks.firstIndex(where: { $0.id == id }) {
            localBooks[index].isFavorite.toggle()
        }
    }
}

// MOCK-СЕРВІС (Для тестування негативних сценаріїв)
class MockFailingLibraryService: LibraryServiceProtocol {
    func fetchBooks() async throws -> [Book] {
        // Імітуємо затримку мережі в 1 секунду
        try await Task.sleep(nanoseconds: 1_000_000_000)
        // Штучно викликаємо помилку сервера
        throw NetworkError.invalidResponse(500)
        
    }
    func addBook(_ book: Book) {}
    func toggleFavorite(for id: UUID) {}
}
