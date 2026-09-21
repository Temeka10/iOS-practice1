//
//  practice_1App.swift
//  practice-1
//
//  Created by Artem Mandych on 21.09.2026.
//

import SwiftUI

@main
struct practice_1: App {
    
    // Ініціалізація класу
    let myLibrary = Library()
    
    init() {
            runPracticalScenario()
        }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
    // Метод для демонстрації сценарію в консолі
    private func runPracticalScenario() {
        print("--- ПОЧАТОК СЦЕНАРІЮ (ПРАКТИЧНА 1) ---")
        
        // 1. Створення сутностей
        let book1 = Book(title: "1984", author: "Джордж Оруелл", status: .finished)
        let book2 = Book(title: "Кобзар", author: "Тарас Шевченко")
        let book3 = Book(title: "Дюна", author: "Френк Герберт", status: .reading)
        
        // 2. Додавання до колекції (класу Library)
        myLibrary.addBook(book1)
        myLibrary.addBook(book2)
        myLibrary.addBook(book3)
        
        // 3. Безпечне розгортання Optional (if let)
        let searchTitle = "1984"
        if let foundBook = myLibrary.findBook(by: searchTitle) {
            print("🔍 Знайдено: \(foundBook.summary)")
        } else {
            print("❌ Книгу '\(searchTitle)' не знайдено.")
        }
        
        // 4. Демонстрація фільтрації
        let finishedBooks = myLibrary.getFinishedBooks()
        print("📚 Прочитані книги (\(finishedBooks.count)):")
        for book in finishedBooks {
            print(" - \(book.title)")
        }
        print("--- КІНЕЦЬ СЦЕНАРІЮ ---")
    }
}
