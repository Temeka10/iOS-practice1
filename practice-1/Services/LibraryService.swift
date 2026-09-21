//
//  LibraryService.swift
//  practice-1
//
//  Created by Artem Mandych on 21.09.2026.
//

import Foundation

// SOLID: Interface Segregation & Dependency Inversion
protocol LibraryServiceProtocol {
    func fetchBooks() -> [Book]
}

// SOLID: Liskov Substitution (Можемо підставити Mock замість Real)
class MockLibraryService: LibraryServiceProtocol {
    func fetchBooks() -> [Book] {
        // Використання Builder
        let book1 = BookBuilder()
            .setTitle("1984")
            .setAuthor("Джордж Оруелл")
            .setStatus(.finished)
            .build()
        
        // Використання Adapter
        let legacyData = LegacyBookData(name: "Кобзар", writerName: "Тарас Шевченко", isRead: false)
        let book2 = LegacyBookAdapter.adapt(legacyData)
        
        return [book1, book2]
    }
}
